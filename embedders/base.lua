--
-- Base abstract embedder class
--
-- License: MIT (c) 2023 Omikhleia
--
local embedder = pl.class()
embedder._name = "embedders.base"

function embedder.conversionCommand(_, _)
  SU.error("Abstract function conversionCommand called", true)
  -- This method MUST be subclassed.
  -- It takes an 'options' table (from the \embed command).
  -- It shall return:
  --  - a conversion command to PNG, with %SOURCE an %TARGET as placeholders
  --    for file names;
  --  - optionally, the target width and/or height based on the input options
  --    and/or any default the conversion uses.
  --    (handy for cases when these are adjusted and/or the ouput image does
  --    specify its resolution, etc.)
end

function embedder.preambleContent(_, _)
  -- For optional subclassing
  -- It takes an 'options' table (from the \embed command).
  -- Return a string for content that must be added, if need be, before
  -- processing the content.
  -- Otherwise return nothing (nil).
end

embedder.documentation = [[\begin{document}
Abstract class \autodoc:package{embedders.base} is not supposed to be used
directly.
\end{document}]]

return embedder
