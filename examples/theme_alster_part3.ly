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
  \stemUp c'4 \stemUp g'8 \stemDown b'2 \stemDown fis''4 \stemDown e''8
  | % 2
  \stemDown b'4 \stemDown c''4 \stemDown e''2. | % 3
  \stemUp c'8 r8 \stemDown g''8 [ \stemDown b''8 \stemDown b'8 ] r8
  \stemUp e'2 | % 4
  \stemDown b'8 r8 \stemDown b''8 [ \stemDown c'''8 \stemDown e''8 ] r8
  \stemUp g'2 | % 5
  \stemUp c'8 r8 \stemDown b'8 [ \stemDown b''8 \stemDown g''8 ] r8
  \stemDown e''2 | % 6
  \stemUp c'8 r8 \stemDown g''8 [ \stemDown b''8 \stemDown g'8 ] r8
  \stemUp e'2 \bar "|."
}

PartPOneVoiceFive =  {
  \clef "bass" \key c \major \time 5/4 R4*10 \stemUp c,8 r8 \stemDown
  g8 [ \stemDown b8 \stemDown b,8 ] r8 \stemUp e,2 \stemUp b,8 r8
  \stemDown b8 [ \stemDown c'8 \stemDown e8 ] r8 \stemUp g,2 \stemUp
  c,8 r8 \stemDown b,8 [ \stemDown b8 \stemDown g8 ] r8 \stemDown e2
  \stemUp c,8 r8 \stemDown g8 [ \stemDown b8 \stemDown b,8 ] r8
  \stemUp e,2 \bar "|."
}

PartPTwoVoiceOne =  {
  \clef "treble" \key c \major \time 5/4 | % 1
  \stemUp c'4 \stemUp g'8 \stemDown b'2 \stemDown fis''4 \stemDown e''8
  | % 2
  \stemDown b'4 \stemDown c''4 \stemDown e''2. | % 3
  \stemUp c'4 \stemDown g''8 [ \stemDown b''8 ] \stemDown b'4 \stemUp
  e'2 | % 4
  \stemDown b'4 \stemDown b''8 [ \stemDown c'''8 ] \stemDown e''4
  \stemUp g'2 | % 5
  \stemUp c'4 \stemDown b'8 [ \stemDown b''8 ] \stemDown g''4
  \stemDown e''2 | % 6
  \stemUp c'4 \stemDown g''8 [ \stemDown b''8 ] \stemDown b'4 \stemUp
  e'2 \bar "|."
}

PartPThreeVoiceOne =  {
  \clef "treble" \key c \major \time 5/4 | % 1
  R4*10 | % 3
  r4 \stemDown c''8 [ \stemDown e''8 ] \stemUp e'2. ~ | % 4
  \stemUp e'4 \stemDown e''8 [ \stemDown fis''8 ] \stemDown c''2. | % 5
  r4 \stemUp e'8 [ \stemUp c''8 ] \stemDown e''2. | % 6
  r4 \stemDown c''8 [ \stemDown e''8 ] \stemUp e'2. \bar "|."
}

PartPFourVoiceOne =  {
  \clef "bass" \key c \major \time 5/4 | % 1
  R4*10 | % 3
  \stemUp c2 \stemDown b4 \stemDown e2 | % 4
  \stemDown b2 \stemDown e'4 \stemDown g2 | % 5
  \stemUp c2 \stemDown e4 \stemDown b2 | % 6
  \stemUp c2 \stemDown b4 \stemDown e2 \bar "|."
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
    \new StaffGroup
    <<
      \new Staff
      <<
        \set Staff.instrumentName = "Femmes"
        \set Staff.shortInstrumentName = "F."

        \context Staff <<
          \mergeDifferentlyDottedOn\mergeDifferentlyHeadedOn
          \context Voice = "PartPThreeVoiceOne" {  \PartPThreeVoiceOne }
        >>
      >>
      \new Staff
      <<
        \set Staff.instrumentName = "Hommes"
        \set Staff.shortInstrumentName = "H."

        \context Staff <<
          \mergeDifferentlyDottedOn\mergeDifferentlyHeadedOn
          \context Voice = "PartPFourVoiceOne" {  \PartPFourVoiceOne }
        >>
      >>

    >>

  >>
  \layout {}
}

