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
  \stemUp e'4 \stemDown g''4 \stemDown c''4 \stemDown fis''4 \stemDown
  c''4 | % 2
  \stemUp g'4 \stemDown c''8 [ \stemDown e''8 ] \stemDown fis''2. | % 3
  \stemDown b'4 \stemDown fis''4 \stemDown b'4 \stemUp e'4 \stemDown
  e''4 | % 4
  \stemUp e'4 \stemDown c''8 [ \stemDown e''8 ] \stemUp e'2 \stemDown
  c''8 [ \stemDown e''8 ] | % 5
  \stemDown fis''4 \stemDown c''8 [ \stemDown e''8 ] \stemDown g''2
  \stemDown e''8 [ \stemDown c''8 ] | % 6
  \stemUp e'4 \stemDown c''8 [ \stemDown e''8 ] \stemUp e'2. | % 7
  \stemDown g''4 \stemDown e''4 \stemDown c''4 \stemUp g'2 ~ | % 8
  \stemUp g'8 r8 \stemDown c''8 [ \stemDown e''8 ] \stemDown fis''2
  \stemDown c''4 | % 9
  \stemUp g'4 \stemDown e''8 [ \stemDown fis''8 ] \stemDown b'2
  \stemUp g'4 | \barNumberCheck #10
  r4 \stemDown c''8 [ \stemDown e''8 ] \stemUp e'2. ~ | % 11
  \stemUp e'4 \stemDown e''8 [ \stemDown fis''8 ] \stemDown c''2. | % 12
  r4 \stemUp e'8 [ \stemUp c''8 ] \stemDown e''2. | % 13
  \stemUp g'4 \stemDown c''8 [ \stemDown e''8 ] \stemDown fis''2
  \stemDown c''4 | % 14
  \stemUp g'4 \stemDown e''8 [ \stemDown fis''8 ] \stemDown b'2
  \stemUp g'4 | % 15
  \stemUp e'4 \stemDown g''4 \stemDown c''4 \stemDown fis''4 \stemDown
  c''4 | % 16
  r4 \stemDown c''8 [ \stemDown e''8 ] \stemUp e'2. ~ | % 17
  \stemUp e'4 \stemDown e''8 [ \stemDown fis''8 ] \stemDown c''2. | % 18
  \stemUp g'2 \stemDown fis''4 \stemDown b'2 | % 19
  \stemUp e'4 \stemDown fis''4 \stemDown c''4 \stemUp g'2 \bar "|."
}

PartPTwoVoiceOne =  {
  \clef "bass" \key c \major \time 5/4 | % 1
  R4*15 | % 4
  r4 r4 \stemUp c2 \stemDown b8 [ \stemDown e8 ] | % 5
  \stemDown b4 \stemDown e'4 \stemDown g4 \stemDown b4 \stemDown e8 [
  \stemDown c8 ] | % 6
  \stemDown b2 \stemDown g8 [ \stemDown e8 ] \stemUp c2 | % 7
  \stemDown e2 \stemDown b4 \stemUp c2 ~ | % 8
  \stemUp c8 r8 r2 r2 | % 9
  R4*5 | \barNumberCheck #10
  \stemUp c2 \stemDown b4 \stemDown e2 | % 11
  \stemDown b2 \stemDown e'4 \stemDown g2 | % 12
  \stemUp c2 \stemDown e4 \stemDown b2 | % 13
  R4*10 | % 15
  \stemDown b2 \stemDown e'4 \stemDown g2 | % 16
  \stemUp c2 \stemDown b4 \stemDown e2 | % 17
  \stemDown b2 \stemDown e'4 \stemDown g2 | % 18
  \stemUp c2 \stemDown b4 \stemDown e2 | % 19
  \stemDown b2 \stemDown e'4 \stemUp c2 \bar "|."
}

PartPThreeVoiceOne =  {
  \clef "treble" \key c \major \time 5/4 | % 1
  R4*85 | % 18
  \stemDown b'4 \stemDown b''8 [ \stemDown c'''8 ] \stemDown e''4
  \stemUp g'2 | % 19
  \stemUp c'4 \stemDown g''8 [ \stemDown b''8 ] \stemDown b'4 \stemUp
  e'2 \bar "|."
}


% The score definition
\score {
  <<

    \new StaffGroup
    <<
      \new Staff
      <<
        \set Staff.instrumentName = "Femmes"
        \set Staff.shortInstrumentName = "F."

        \context Staff <<
          \mergeDifferentlyDottedOn\mergeDifferentlyHeadedOn
          \context Voice = "PartPOneVoiceOne" {  \PartPOneVoiceOne }
        >>
      >>
      \new Staff
      <<
        \set Staff.instrumentName = "Hommes"
        \set Staff.shortInstrumentName = "H."

        \context Staff <<
          \mergeDifferentlyDottedOn\mergeDifferentlyHeadedOn
          \context Voice = "PartPTwoVoiceOne" {  \PartPTwoVoiceOne }
        >>
      >>

    >>
    \new Staff
    <<
      \set Staff.instrumentName = "Hautbois"
      \set Staff.shortInstrumentName = "Htbs."

      \context Staff <<
        \mergeDifferentlyDottedOn\mergeDifferentlyHeadedOn
        \context Voice = "PartPThreeVoiceOne" {  \PartPThreeVoiceOne }
      >>
    >>

  >>
  \layout {}
}

