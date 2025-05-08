--
-- LilyPond (musical notation) embedder for SILE.
--
-- License: MIT
-- Copyright (C) 2023-2025 Omikhleia / Didier Willis
--
local base = require("packages.embedders")
local embedder = pl.class(base)
embedder._name = "embedders.lilypond"

function embedder:preambleContent (options)
  local staffsize = options.staffsize and SU.cast("measurement", options.staffsize)
    or SILE.settings:get("document.baselineskip").height
  local indent = options.indent and SU.cast("measurement", options.indent) or SILE.types.measurement()
  local linewidth = options.width and SU.cast("measurement", options.width) or SILE.types.measurement("100%lw")
  local curindent = SILE.settings:get("current.parindent")
  if curindent then
    linewidth = linewidth:absolute() - curindent.width:absolute()
  end
  local raggedright = SU.boolean(options.raggedright, false) and "##t" or "##f"
  local raggedlast = SU.boolean(options.raggedlast, true) and "##t" or "##f"

  local preamble = string.format(
[[#(set-global-staff-size %f)
\paper {
  paper-width=%f\pt
  indent=%f\pt
  short-indent=0\pt
  right-margin=0\pt
]], staffsize:tonumber(), linewidth:tonumber(), indent:tonumber())

  -- These are absent by default if not set, as LilyPond has its own different
  -- logic depending on the number of systems in the score.
  if options.raggedright ~= nil then
    preamble = preamble .. string.format([[
  ragged-right=%s
]], raggedright)
  end
  if options.raggedlast ~= nil then
    preamble = preamble .. string.format([[
  ragged-last=%s
]], raggedlast)
  end

  preamble = preamble .. [[
  oddFooterMarkup=##f
  oddHeaderMarkup=##f
  bookTitleMarkup=##f
  scoreTitleMarkup=##f
}
]]
  return preamble
end

function embedder:conversionCommand (options)
  local resolution = SU.cast("integer", options.resolution)
  local dpi = string.format("-dresolution=%f", resolution)

  -- Build lilypond conversion command
  local command = table.concat({
    "lilypond",
    "--silent",
    "--output=xxxx", -- HACK
    dpi,
    "--png",
    "-dcrop",
    "$SOURCE",
    "; rm xxxx.png; mv xxxx.cropped.png", "$TARGET" -- HACK
  }, " ")

  return command, nil, nil
end

embedder.documentation = [[\begin{document}
The \strong{lilypond} embedder supports the LilyPond musical notation.
The package requires the LilyPond software to be installed on your host system,
as it invokes it to perform the necessary conversions\footnote{For security concerns,
please note that the LilyPond language can include arbitrary code. If you grabbed some LilyPond
score on the Internet, be cautious regarding what it does.}.

The supported options are the following:

\begin{itemize}
\item{\autodoc:parameter{width=<dimen>} can be set to specify the intended maximum width
of the score. It defaults to the full line width.}
\item{\autodoc:parameter{indent=<dimen>} is the indentation of the first staff. It defaults to 0.}
\item{\autodoc:parameter{staffsize=<dimen>} is the size of the staves. It defaults to the
current base line skip, just because.}
\item{\autodoc:parameter{raggedright=<boolean>} is absent by default,
leaving Lilypond apply its usual logic, whether systems end at their natural horizontal
length or fill the line width.}
\item{\autodoc:parameter{raggedlast=<boolean>} is absent by default,
leaving Lilypond apply its usual logic, whether the last system in the score ends at
its natural horizontal length or fills the line width.}
\end{itemize}

Note that the output is generated as a single cropped image, disregarding pages.
This might not be suitable, therefore, for long pieces of music.

Here is an example score with default options, for illustration.

\begin[type=embed, format=lilypond]{raw}
\version "2.24.0"
\relative {
  \clef "bass"
  \time 3/4
  \tempo "Andante" 4 = 120
  c,2 e8 c'
  g'2.
  f4 e d
  c4 c, r
}
\end{raw}

\end{document}]]

return embedder
