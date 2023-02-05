--
-- Generic format embedder package for SILE.
--
-- It provide a general mean for using "embedders" for raw inline content
-- or an external source file, performing a conversion to generate an image
-- for inclusion in the document.
--
-- License: MIT (c) 2023 Omikhleia
--
local base = require("packages.base")
local lfs = require('lfs')
local zlib = require("zlib")

local package = pl.class(base)
package._name = "embedders"

-- DYNAMIC (ON-DEMAND) EMBEDDER LOADER

-- Loads and instantiate embedders
local function embedders ()
  return setmetatable({}, {
    __index = function (self, key)
      SU.debug("embedders", "Loading embedder for", key)
      local ok, embedder = pcall(require, ("embedders.%s"):format(key))
      if not ok then
        return nil
      end
      self[key] = embedder()
      return self[key]
    end
  })
end

-- PATH UTILITIES

-- Returns a file under the "embedded" subfolder besides the master document.
local function handlePath (filename)
  local basename = pl.path.basename(filename)
  if not basename then SU.error("Cannot extract base name from "..filename) end
  local dir = pl.path.join(pl.path.dirname(SILE.masterFilename), "embedded")
  if not pl.path.exists(dir) then
    pl.path.mkdir(dir)
  end
  return pl.path.join(dir, basename)
end

-- Builds a file name for raw text content.
-- The file name will be based on the master file name and includes a hash
-- from the command and raw text, for caching.
local function targetNameFromRaw (rawtext, command)
  local source = pl.path.basename(SILE.masterFilename)
  local basename = handlePath(source)
  local hash = string.format("%x", zlib.crc32()(command))
    .. "_" .. string.format("%x", zlib.crc32()(rawtext))
  local target = basename .. "_" .. hash
  return target
end

-- Builds a file name for source file content.
-- The file name will be based on the source file name and includes a hash
-- from the command, for caching.
local function targetNameFromSource (source, command)
  local basename = handlePath(source)
  local hash = string.format("%x", zlib.crc32()(command))
  local target = basename .. "_" .. hash
  return target
end

-- Executes 'commmand', where $SOURCE and $TARGET are replaced with
-- the filename passed as arguments.
local function shellEscapeCommand (command, source, target)
  local sourceTime = lfs.attributes(source, "modification")

  if (sourceTime == nil) then
    SU.error("Source file '"..source.."' not found")
  end

  local targetTime = lfs.attributes(target, "modification")
  if targetTime ~= nil and targetTime >= sourceTime then
    return SU.debug("embedders", "Source file already converted", source)
  end

  local commandline = string.gsub(command, "%$(%w+)", {
    SOURCE = source,
    TARGET = target
  })

  local result = os.execute(commandline)
  if type(result) ~= "boolean" then result = (result == 0) end
  if result then
    SU.debug("embedders", "Converted", source, "to", target)
  else
    SU.error("Conversion failure")
  end
end

-- PACKAGE

function package:_init (_)
  base._init(self)
  self.class:loadPackage("image")

  SILE.scratch.embedders = SILE.scratch.embedders or embedders()
end

function package:registerCommands ()
  self:registerCommand("embed", function(options, content)
    if SU.hasContent(content) then SU.error("Embedder command doesn't expect content") end
    local source = SU.required(options, "src", "embedders")
    source = SILE.resolveFile(source) or SU.error("Couldn't find file " .. source)

    local format = options.format
    if not format then
      -- Try to guess format from file extension ".xxx" as "xxx"
      format = pl.path.extension(source):sub(2)
    end

    local owner = SILE.scratch.embedders[format]
    if not owner then
      SU.error("Unknown embedder format '"..format.."'")
    end
    local command, width, height = owner:conversionCommand(options)

    local target
    local preamble = owner:preambleContent(options)
    if preamble then
      -- We need to add a preamble, so read the source, prepend the preamble,
      -- write it again/
      local fd, err = io.open(source, "r")
      if not fd then return SU.error(err) end
      local raw = fd:read("*all")
      fd:close()

      local data = raw .. (preamble or "")

      local targetBase = targetNameFromRaw(data, command)
      source = targetBase .. "." .. format
      target = targetBase .. ".png"
      local already = pl.path.exists(source)
      if already then
        SU.debug("embedders", "Existing identical content", source)
      else
        SU.debug("embedders", "Saving content to", source)
        fd, err = io.open(source, "w")
        if not fd then return SU.error(err) end
        fd:write(data)
        fd:flush()
        fd:close()
      end
    else
      -- We don't need a preamble so can use the source file directly.
      target = targetNameFromSource(source, command) .. ".png"
    end

    shellEscapeCommand(command, source, target)

    SILE.call("img", {
      src = target,
      width = width,
      height = height,
    })
  end)

  self:registerCommand("embedder-documentation", function(_, content)
    local format = content[1]
    local owner = SILE.scratch.embedders[format]
    if not owner then
      SU.error("Unknown embedder format '"..format.."'")
    end
    local doc = owner.documentation
    if not doc then
      SU.error("Embedder '"..format.."' does not seem to have a documentation")
    end
    SILE.processString(doc)
  end)
end

function package:registerRawHandlers ()
  self.class:registerRawHandler("embed", function(options, content)
    local format = SU.required(options, "format", "embedders")
    local owner = SILE.scratch.embedders[format]
    if not owner then
      SU.error("Unknown embedder format '"..format.."'")
    end
    local command, width, height = owner:conversionCommand(options)

    local preamble = owner:preambleContent(options)
    local data = content[1] .. (preamble or "")

    local targetBase = targetNameFromRaw(data, command)
    local source = targetBase .. "." .. format
    local target = targetBase .. ".png"

    local already = pl.path.exists(source)
    if already then
      SU.debug("embedders", "Existing identical raw content", source)
    else
      SU.debug("embedders", "Saving raw content to", source)
      local fd, err = io.open(source, "w")
      if not fd then return SU.error(err) end
      fd:write(data)
      fd:flush()
      fd:close()
    end

    shellEscapeCommand(command, source, target)

    SILE.call("img", {
      src = target,
      width= width,
      height= height,
    })
  end)
end

package.documentation =[[\begin{document}
The \autodoc:package{embedders} package is a general framework for embedding
images from textual representations, performing their conversion
via shell commands.

As with anything that relies on invoking external programs on your host system,
please be aware of possible security concerns. Be very cautious with the
source of the elements you include in your documents!

The package defines a single main command:

\autodoc:command{\embed[src=<filename>, format=<string>]}

The format name is optional (derived from the file extension when absent),
and refers to an “embedder” module, responsible for handling that specific
format. Additional options might be passed, and used by embedder implementations.
Refer to their respective documentation.

The package also defines a \code{raw} environment going by same
name (i.e. \autodoc:parameter{type=embed}), for including
raw elements directly in your SILE document.
It accepts the same options (but the source file name, obviously).

Converted elements are placed in an “embedded” directory located besides
your main master document. It is used as a “cache”, to avoid converting
again elements that have already been converted. You may of course delete
its contents, to ensure a full re-generation.

The package comes with a few pre-defined embedders, but more may easily
be added to the framework.

Additionally, the \autodoc:command{\embedder-documentation{<format>}} command
ouputs the documentation for a given embedder (for use, quite obviously, in
some manual, such as this one).

\end{document}]]

return package
