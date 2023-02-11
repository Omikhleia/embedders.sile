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
  \stemDown e'8 [ \stemDown b'16 \stemDown b''16 ] \stemDown g''8
  \stemDown e''4 \stemUp g'8 \stemDown e''16 [ \stemDown c'''16
  \stemDown b''8 ] \stemDown b'4 | % 2
  \stemDown e'8 [ \stemDown b'16 \stemDown b''16 ] \stemDown g''8
  \stemDown e''4 \stemUp g'8 \stemDown b'16 [ \stemDown b''16
  \stemDown g''8 ] \stemUp c'4 | % 3
  \stemDown e'8 [ \stemDown b'16 \stemDown b''16 ] \stemDown g''8
  \stemDown e''4 \stemUp g'8 \stemDown e''16 [ \stemDown c'''16
  \stemDown b''8 ] \stemDown b'4 | % 4
  \stemDown e'8 [ \stemDown b'16 \stemDown b''16 ] \stemDown g''8
  \stemDown e''4 \stemUp g'8 \stemDown b'16 [ \stemDown b''16
  \stemDown g''8 ] \stemUp c'4 | % 5
  \stemUp c'4 \stemDown g''8 [ \stemDown b''8 ] \stemDown b'4 \stemUp
  e'2 | % 6
  \stemDown e'8 [ \stemDown b'16 \stemDown b''16 ] \stemDown g''8
  \stemDown e''4 \stemUp g'8 \stemDown b'16 [ \stemDown b''16
  \stemDown g''8 ] \stemUp c'4 | % 7
  \stemUp c'4 \stemDown g''8 [ \stemDown b''8 ] \stemDown b'4
  \stemDown e''2 \bar "|."
}

PartPOneVoiceFive =  {
  \clef "bass" \key c \major \time 5/4 R4*10 \stemUp e,8 [ \stemUp b,16
  \stemUp b16 ] \stemDown g8 \stemDown e4 \stemUp g,8 \stemDown e16 [
  \stemDown c'16 \stemDown b8 ] \stemUp b,4 \stemUp e,8 [ \stemUp b,16
  \stemUp b16 ] \stemDown g8 \stemDown e4 \stemUp g,8 \stemDown b,16 [
  \stemDown b16 \stemDown g8 ] \stemUp c,4 \stemUp c,4 \stemDown g8 [
  \stemDown b8 \stemDown b,8 ] r8 \stemUp e,2 \stemUp e,8 [ \stemUp b,16
  \stemUp b16 ] \stemDown g8 \stemDown e4 \stemUp g,8 \stemDown b,16 [
  \stemDown b16 \stemDown g8 ] \stemUp c,4 \stemUp c,4 \stemDown g8 [
  \stemDown b8 ] \stemUp b,4 \stemDown e2 \bar "|."
}

PartPTwoVoiceOne =  {
  \clef "treble" \key c \major \time 5/4 | % 1
  R4*10 | % 3
  \stemDown e'8 [ \stemDown b'16 \stemDown b''16 ] \stemDown g''8
  \stemDown e''4 \stemUp g'8 \stemDown e''16 [ \stemDown c'''16
  \stemDown b''8 ] \stemDown b'4 | % 4
  \stemDown e'8 [ \stemDown b'16 \stemDown b''16 ] \stemDown g''8
  \stemDown e''4 \stemUp g'8 \stemDown b'16 [ \stemDown b''16
  \stemDown g''8 ] \stemUp c'4 ~ | % 5
  \stemUp c'4 \stemDown g''8 [ \stemDown b''8 ] \stemDown b'4 \stemUp
  e'2 ~ | % 6
  \stemDown e'8 [ \stemDown b'16 \stemDown b''16 ] \stemDown g''8
  \stemDown e''4 \stemUp g'8 \stemDown b'16 [ \stemDown b''16
  \stemDown g''8 ] \stemUp c'4 ~ | % 7
  \stemUp c'4 \stemDown g''8 [ \stemDown b''8 ] \stemDown b'4
  \stemDown e''2 \bar "|."
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

