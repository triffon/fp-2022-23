#lang racket
(require rackunit)
(require rackunit/text-ui)

(require "common.03.rkt")


;### Зад 10
; Броят на наредените двойки цели числа (`x`,`y`) от интервала [a,b], които имат най-голям общ делител равен на `n`.

(define (count-pairs-gcd n a b)
  (define (term x)
    (define (inner-term y)
      (if (= n (gcd x y))
          1
          0))
    (accumulate + 0 a b inner-term 1+))
  (accumulate + 0 a b term 1+))

(run-tests
  (test-suite "count-pairs-gcd tests"
    (check-eq? (count-pairs-gcd 10 1 11)
               1)
    (check-eq? (count-pairs-gcd 3 1 11)
               7)
    (check-eq? (count-pairs-gcd 16 1 11)
               0)
    (check-eq? (count-pairs-gcd 4 1 11)
               3))
  'verbose)
