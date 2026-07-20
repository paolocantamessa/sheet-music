\version "2.26.0"

#(define-markup-command (make-graph props layout inp)(markup-list?)
  (interpret-markup props layout #{ \markup \box \pad-around #1 \overlay {
  \with-color #darkcyan \raise #(/ height 2) \draw-line #(cons 0 (- height))
  \with-color #red \raise #(/ height 2) \draw-line #(cons width 0)
  \with-color #darkgreen \draw-line #(cons width 0)
  \with-color #red \lower #(/ height 2) \draw-line #(cons width 0)
  #inp
}
  #}))

#(define-markup-command (make-wave props layout inp)(list?)
  (interpret-markup props layout #{ \markup \path #line-thickness 
  #(map (lambda (x) (list 'lineto (/ (car x) resolution) (* (cadr x) (/ height 2)))) (zip (iota (length inp)) inp)) #}))
#(define (make-dots inp) (map (lambda (x) (markup #:translate (cons (/ (car x) resolution) (* (cadr x) (/ height 2))) #:draw-circle dot-area 0 #t)) (zip (iota (length inp)) inp)))

width = #100
height = #20
resolution = #10
rate = #(* width resolution)
frequency = #10
level = #.9
data = #(map (lambda (x) (* (sin (* (/ x rate) PI 2 frequency)) level)) (iota rate))
dataB = #(map (lambda (x) (* (sin (* (/ x rate) PI 2 frequency 5/4)) level)) (iota rate))
line-thickness = #.15
dot-area = #.15
\markup \column {
\make-graph { \with-color #blue \make-wave #data }
\make-graph { \with-color #darkyellow \make-wave #dataB }
\make-graph { \with-color #magenta \make-wave #(map (lambda (x) (/ (apply + x) (length x))) (zip data dataB)) }
\make-graph {
  \with-color #blue \make-wave #data
  \with-color #darkyellow \make-wave #dataB
  %\with-color #magenta \make-wave #(map (lambda (x) (/ (apply + x) (length x))) (zip data dataB))
  %\with-color #blue #(make-dots data)
  
}
}