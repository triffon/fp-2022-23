#lang racket

; hof, lambda
; const
;(define forever-21 (const 21))
;(forever-21 5) -> 21
;(forever-21 10) -> 21
;((const 21) 10) -> 21

; flip
;(define f (flip -))
;(f 4 10) -> 6 ; = (- 10 4)
;((flip f) 4 10) -> -6

; complement
;(define (less-than-5? x) (< x 5))
;(define f (complement less-than-5?))
;(f 3) ; => #f
;(f 5) ; => #t
;(f 7) ; => #t

; compose
;(define f (compose (lambda (x) (+ x 1)) (lambda (x) (* x x)))) ; ((x^2)+1)
;(f 3) -> 10


(define (derive f dx)
  (lambda (x) (/ (- (f (+ x dx)) (f x)) dx)))

; абстракция
; sum-cubes-interval
; постепенно се превръща в accumulate
; accumulate-i



(define (repeated f n)
  (accumulate compose id 1 n (lambda (i) f) 1+))

(define (derive-n f n dx)
  ((accumulate compose id 1 n
               (lambda (i) (lambda (f) (derive f dx))) 1+)
   f))
