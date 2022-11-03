#lang racket
(require rackunit)
(require rackunit/text-ui)

(require "common.03.rkt")

;### Зад 8
; Да се напише функция, която намира сбора на цифрите на числото n

(define (count-digits n)
  (define (term x)
    1)
  (define (next i)
    (* i 10))
  (accumulate + 0 1 n term next))

(define (digit-sum n)
  (define (term i)
    (remainder (quotient n (expt 10 i))
               10))
  (accumulate + 0 0 (count-digits n) term 1+))


(run-tests
  (test-suite "digit-sum tests"
    (check-eq? (digit-sum 1)
             1)
    (check-eq? (digit-sum 12)
             3)
    (check-eq? (digit-sum 7234)
             16)
    (check-eq? (digit-sum 123456)
             21)
    )
  'verbose)
