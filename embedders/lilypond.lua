--
-- LilyPond (musical notation) embedder for SILE.
--
-- License: MIT (c) 2023 Omikhleia
--
local base = require("packages.embedders")
local embedder = pl.class(base)
embedder._name = "embedders.lilypond"

function embedder.preambleContent(_, options)
  local staffsize = options.staffsize and SU.cast("measurement", options.staffsize)
    or SILE.settings:get("document.baselineskip").height
  local indent = options.indent and SU.cast("measurement", options.indent) or SILE.measurement()
  local linewidth = options.width and SU.cast("measurement", options.width) or SILE.measurement("100%lw")
  local curindent = SILE.settings:get("current.parindent")
  if curindent then
    linewidth = linewidth:absolute() - curindent.width:absolute()
  end

  local preamble = string.format(
[[#(set-global-staff-size %f)
\paper {
  line-width=%f\pt
  indent=%f\pt
  oddFooterMarkup=#f
  oddHeaderMarkup=#f
  bookTitleMarkup=#f
  scoreTitleMarkup=#f
}]], staffsize:tonumber(), linewidth:tonumber(), indent:tonumber())
  return preamble
end

function embedder.conversionCommand(_, options)
  local resolution = SU.cast("integer", options.resolution or 300)
  local dpi = string.format("-dresolution=%f", resolution)

  -- Build lilypond conversion command
  local command = table.concat({
    "lilypond",
    "--silent",
    "--output=xxxx", -- HACK
    dpi,
    "--png",
    "-dcrop",
    "-dno-use-paper-size-for-page",
    "$SOURCE",
    "; rm xxxx.png; mv xxxx.cropped.png", "$TARGET" -- HACK
  }, " ")

  return command, nil, nil
end

embedder.documentation = [[\begin{document}
The \strong{lilypond} embedder supports for the LilyPond musical notation.
The package requires the LilyPond software to be installed on your host system,
as it invokes it to perform the necessary conversions\footnote{For security concerns,
please note that the LilyPond language can include abitrary code. If you grabbed some LilyPond
score on the Internet, be cautious regarding what it does.}.

\begin{itemize}
\item{\autodoc:parameter{width=<dimen>} can be set to specify the intended width
of the graph. It defaults to the full line width, and is a maximum size for wrapping,
as the output is cropped (see below).}
\item{\autodoc:parameter{indent=<dimen>} is the indentation of the first staff. It defaults to 0.}
\item{\autodoc:parameter{staffsize=<dimen>} is the size of the staves. It defaults to the
current base line skip, just because.}
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
\par

% Also mention the security concern with LilyPond
% Reminder if running a docker image of SILE...
% docker run -it --volume "$(pwd):/data" --user "$(id -u):$(id -g)" --security-opt seccomp=unconfined sile

\end{document}]]

return embedder
