--
-- DOT graph language (Graphviz) embedder.
--
-- License: GPL-3.0-or-later
--
-- Copyright (C) 2023-2025 Didier Willis
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.
--
local base = require("embedders.base")
local embedder = pl.class(base)
embedder._name = "embedders.dot"

function embedder:conversionCommand (options)
  local resolution = SU.cast("integer", options.resolution)
  local width = options.width and SILE.types.measurement(options.width):tonumber()
  local height = options.height and SILE.types.measurement(options.height):tonumber()
  local layout = options.layout
  local fontoverride = SU.boolean(options.fontoverride, true)

  -- Build graphviz command-line options
  local size
  if width and height then
    -- maximum width and height (in inches), expand to fill
    size = string.format("-Gsize=%f,%f -Gratio=fill", width / 72, height / 72)
  else
    local actualwidth = width or SILE.types.measurement("100%fw"):tonumber()
    local fh = SILE.types.measurement("100%fh"):tonumber()
    if fh == 0 then
      -- There are cases where the frame height is unknown (e.g. in a parbox,
      -- or in a footnote-like context):
      -- Fallback to the frame width (HACK, but better than nothing)
      fh = SILE.types.measurement("100%fw"):tonumber()
    end
    local actualheight = height or fh

    if width or height then
      -- minimum width and height (in inches)
      size = string.format("-Gsize=%f,%f!", actualwidth / 72, actualheight / 72)
    else
      -- enforce the maximum width:
      -- graphviz can use a dpi resolution, but does not set it in the image
      -- data (well, this may depend on the used renderer), so we cannot use
      -- the image 'natural' size afterwards.
      width = actualwidth
      -- maximum width and height (in inches)
      size = string.format("-Gsize=%f,%f", actualwidth / 72, actualheight / 72)
    end
  end
  local dpi = string.format("-Gdpi=%f", resolution)

  -- Build graphviz conversion command
  local command = table.concat({
    "dot",
    "-Tpng", dpi,
    size,
    "$SOURCE",
    "-o $TARGET",
  }, " ")
  if layout then
    command = command .. string.format(" -K%s", layout)
  end
  if fontoverride then
    local family = SILE.settings:get("font.family")
    local gfontname = string.format("-Gfontname=\"%s\"", family)
    local nfontname = string.format("-Nfontname=\"%s\"", family)
    local efontname = string.format("-Efontname=\"%s\"", family)

    command = table.concat({
      command,
      gfontname,
      nfontname,
      efontname
    }, " ")
  end

  return command, width, height
end

embedder.documentation = [[\begin{document}
The \strong{dot} embedder supports the Graphviz DOT graph language.
It requires the Graphviz collection of tools to be installed on your host system,
as it invokes the \code{dot} program to perform the necessary conversion.

The supported options are the following:

\begin{itemize}
\item{\autodoc:parameter{width=<dimen>} and/or \autodoc:parameter{height=<dimen>} can be set to specify
the intended dimension(s) of the graph.}
\item{\autodoc:parameter{layout=<string>} is an optional parameter that instructs the converter
to use the corresponding Graphviz layout engine (such as \code{neato}, \code{fdp}, \code{twopi}, etc.),
overriding the default \code{dot} layout.}
\item{\autodoc:parameter{fontoverride=<boolean>} defaults to true and instructs the converter
to use the current document font family for the graph (and all its nodes and edges), overriding
the default settings.}
\end{itemize}

Here is, for instance, the exact same graph data represented with the \code{dot} and
\code{neato} layout engines respectively.

\begin{center}
\begin[type=embed, format=dot, width=60%fw, layout=dot]{raw}
graph {
	node [fillcolor="lightskyblue:darkcyan" style=filled gradientangle=270]
  a -- { b d };
	b -- { c e };
	c -- { f g h i };
	e -- { j k l m n o };
}
\end{raw}
\begin[type=embed, format=dot, height=30%fw, layout=neato]{raw}
graph {
	node [fillcolor="lightskyblue:darkcyan" style=filled gradientangle=270]
  a -- { b d };
	b -- { c e };
	c -- { f g h i };
	e -- { j k l m n o };
}
\end{raw}
\end{center}

\end{document}]]

return embedder
