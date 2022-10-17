#lang racket

(define (reverse-digits number)
	(define (helper num accum)
		(if (= num 0)
			accum
			(helper (quotient num 10) (+ (* accum 10) (remainder num 10)))))
	(helper number 0))

;; (reverse-digits 145) =
;; (helper 145   0) =
;; (helper  14   5) =
;; (helper   1  54) =
;; (helper   0 541) =
;; 541