\version "2.20.0"
\layout {
  \context {
    \Score
    skipBars = ##t
    autoBeaming = ##f
  }
}
PartPOneVoiceOne =  {
  \clef "treble" \key c \major \time 5/4 | % 1
  \stemUp e'4 \stemDown b''8 [ \stemDown c'''8 ] \stemDown e''4
  \stemUp g'2 | % 2
  \stemUp c'4 \stemDown g''8 [ \stemDown b''8 ] \stemDown b'4 \stemUp
  e'2 | % 3
  \stemDown c'''8 [ \stemDown b''8 ] \stemDown e''8 [ \stemDown e''16
  \stemDown b''16 ] \stemDown c'''8 [ \stemDown fis''8 ] \stemDown c''8
  ~ [ \stemDown c''8 ] \stemDown b''4 | % 4
  \stemDown b'4 \stemDown b''8 [ \stemDown c'''8 ] \stemDown e''4
  \stemUp g'2 | % 5
  \stemDown c'''8 [ \stemDown g''8 ] \stemDown e''8 [ \stemDown e''16
  \stemDown b''16 ] \stemDown c'''8 [ \stemDown fis''8 ] \stemDown c''8
  ~ [ \stemDown c''8 ] \stemDown g''4 | % 6
  \stemUp c'8 r8 \stemDown g''8 [ \stemDown b''8 \stemDown b'8 ] r8
  \stemUp e'2 | % 7
  \stemDown c'''8 [ \stemDown b''8 ] \stemDown e''8 [ \stemDown e''16
  \stemDown b''16 ] \stemDown c'''8 [ \stemDown fis''8 ] \stemDown c''8
  ~ [ \stemDown c''8 ] \stemDown b''4 | % 8
  \stemDown b'8 r8 \stemDown b''8 [ \stemDown c'''8 \stemDown e''8 ] r8
  \stemUp g'2 | % 9
  \stemDown e'8 [ \stemDown g''8 ] \stemDown e''8 [ \stemDown e''16
  \stemDown b''16 ] \stemDown c'''8 [ \stemDown fis''8 ] \stemDown c''8
  ~ [ \stemDown c''8 ] \stemDown g''4 \bar "|."
}

PartPOneVoiceFive =  {
  \clef "bass" \key c \major \time 5/4 \stemUp e,4 \stemDown b8 [
  \stemDown c'8 ] \stemDown e4 \stemUp g,2 \stemUp c,4 \stemDown g8 [
  \stemDown b8 ] \stemUp b,4 \stemUp e,2 R4*5 \stemUp b,4 \stemDown b8
  [ \stemDown c'8 ] \stemDown e4 \stemUp g,2 R4*5 \stemUp c,8 r8
  \stemDown g8 [ \stemDown b8 \stemDown b,8 ] r8 \stemUp e,2 \stemDown
  c'8 [ \stemDown b8 ] \stemDown e8 [ \stemDown e16 \stemDown b16 ]
  \stemDown c'8 [ \stemDown fis8 ] \stemUp c8 ~ [ \stemUp c8 ]
  \stemDown b4 \stemUp b,8 r8 \stemDown b8 [ \stemDown c'8 \stemDown e8
  ] r8 \stemUp g,2 \stemUp e,8 [ \stemUp g8 ] \stemDown e8 [ \stemDown
  e16 \stemDown b16 ] \stemDown c'8 [ \stemDown fis8 ] \stemUp c8 ~ [
  \stemUp c8 ] \stemDown g4 \bar "|."
}

PartPTwoVoiceOne =  {
  \clef "treble" \key c \major \time 5/4 | % 1
  R4*25 | % 6
  \stemUp c'4 \stemDown g''8 [ \stemDown b''8 ] \stemDown b'4 \stemUp
  e'2 | % 7
  \stemDown c'''8 [ \stemDown b''8 ] \stemDown e''8 [ \stemDown e''16
  \stemDown b''16 ] \stemDown c'''8 [ \stemDown fis''8 ] \stemDown c''8
  [ \stemDown c''8 ] \stemDown b''4 | % 8
  \stemDown b'4 \stemDown b''8 [ \stemDown c'''8 ] \stemDown e''4
  \stemUp g'2 | % 9
  \stemDown e'8 [ \stemDown g''8 ] \stemDown e''8 [ \stemDown e''16
  \stemDown b''16 ] \stemDown c'''8 [ \stemDown fis''8 ] \stemDown c''8
  [ \stemDown c''8 ] \stemDown g''4 \bar "|."
}


% The score definition
\score {
  <<

    \new PianoStaff
    <<
      \set PianoStaff.instrumentName = "Harpe"
      \set PianoStaff.shortInstrumentName = "Hrp."

      \context Staff = "1" <<
        \mergeDifferentlyDottedOn\mergeDifferentlyHeadedOn
        \context Voice = "PartPOneVoiceOne" {  \PartPOneVoiceOne }
      >> \context Staff = "2" <<
        \mergeDifferentlyDottedOn\mergeDifferentlyHeadedOn
        \context Voice = "PartPOneVoiceFive" {  \PartPOneVoiceFive }
      >>
    >>
    \new Staff
    <<
      \set Staff.instrumentName = "Hautbois"
      \set Staff.shortInstrumentName = "Htbs."

      \context Staff <<
        \mergeDifferentlyDottedOn\mergeDifferentlyHeadedOn
        \context Voice = "PartPTwoVoiceOne" {  \PartPTwoVoiceOne }
      >>
    >>

  >>
  \layout {}
}

