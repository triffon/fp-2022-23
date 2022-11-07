#lang racket
(require rackunit)
(require rackunit/text-ui)

(require "common.03.rkt")

;### Зад 11
; Да се напише функция (twist k f g), която за дадени едноместни функции f и
; g и четно число k връща функция, еквивалентна на f(g(f(g(...(x)...)))),
; където общият брой извиквания на f и g е k.

(define (id x) x)

(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (twist k f g)
  (define (term i)
    (if (even? i)
        g
        f))
  (accumulate compose id 1 k term 1+))


(define (1+ x) (+ x 1))
(define (sq x) (* x x))
(define foo (twist 4 1+ sq))
; това ще смята ((((x^2)+1)^2)+1)
(define bar (twist 2 1+ sq))
; това ще смята ((x^2)+1)
(define bas (twist 3 1+ sq))
; това ще смята (((x+1)^2)+1)

(run-tests
  (test-suite "count-pairs-gcd tests"
    (check-eq? (foo 2) 26)
    (check-eq? (bar 2) 5)
    (check-eq? (bas 2) 10)
    (check-eq? ((twist 1 1+ sq) 2)
               3)
    )
  'verbose)
