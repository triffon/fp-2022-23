#lang racket

(define (count-divisors number)
	(define (helper divisor count)
		(cond 
			((< divisor 1) count)
			((= (remainder number divisor) 0) (helper (- divisor 1) (+ count 1)))
			(else (helper (- divisor 1) count))))
	(helper number 0))

(define (prime? number)
  (= 2 (count-divisors number)))