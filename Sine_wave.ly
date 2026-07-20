\version "2.24.4"

\header { tagline = ##f }

\markup \box \pad-around #1 \overlay {
\raise #10 \with-color #red \draw-line #'(100 . 0)
\lower #10 \with-color #red \draw-line #'(100 . 0)
\raise #10 \with-color #'(0 1 1) \draw-line #'(0 . -20)
\with-color #darkgreen \draw-line #'(100 . 0)
\with-color #blue \path #.1 #(map (lambda (x) (list 'lineto (* .1 x) (* 10 (sin (* (/ x 1000) PI 2 15))))) (iota 1001))
}