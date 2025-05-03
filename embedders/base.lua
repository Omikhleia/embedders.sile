--
-- Base abstract embedder class
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
local embedder = pl.class()
embedder._name = "embedders.base"

function embedder:conversionCommand (_)
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

function embedder:preambleContent (_)
  -- For optional subclassing.
  -- It takes an 'options' table (from the \embed command).
  -- Return a string for content that must be added, if need be, before
  -- processing the content.
  -- Otherwise return nothing (nil).
end

embedder.documentation = [[\begin{document}
Abstract class \autodoc:package{embedders.base} is not supposed to be used directly.
\end{document}]]

return embedder
