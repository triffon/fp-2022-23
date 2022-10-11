#lang racket

; fact
; fib
; sum-interval

; зад
; сбор на целите числа в интервала [a, b]
(define (suminterval a b)
  'tuk)






(define (slowpow x n)
  (if (= n 0)
      1
      (* x (slowpow x (- n 1)))))
(define (square x)
  (* x x))
(define (fastpow x n)
  (cond
    ((= n 0) 1)
    ((even? n) (square (fastpow x (quotient n 2))))
    (else (* x (fastpow x (- n 1))))))

