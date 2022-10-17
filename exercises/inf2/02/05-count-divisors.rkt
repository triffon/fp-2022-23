#lang racket

(define (count-divisors number)
	(define (helper divisor count)
		(cond 
			((< divisor 1) count)
			((= (remainder number divisor) 0) (helper (- divisor 1) (+ count 1)))
			(else (helper (- divisor 1) count))))
	(helper number 0))

;; (count-divisors 6) =
;; (helper 6 0) =
;; (helper 5 1) =
;; (helper 4 1) =
;; (helper 3 1) =
;; (helper 2 2) =
;; (helper 1 3) =
;; (helper 0 4) =
;; 4