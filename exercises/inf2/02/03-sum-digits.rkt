#lang racket

(define (sum-digits number)
  (if (< number 10)
      number
      (+ (remainder number 10) (sum-digits (quotient number 10)))))

;; (sum-digits 123) =
;; (+ 3 (sum-digits 12)) =
;; (+ 3 (+ 2 (sum-digits 1)) =
;; (+ 3 (+ 2 1)) =
;; (+ 3 3) =
;; 6

(define (sum-digits-iter number)
	(define (helper num accum)
		(if (= num 0)
			accum
			(helper (quotient num 10) (+ accum (remainder num 10)))))
	(helper number 0))

;; (sum-digits-iter 123) =
;; (helper 123 0) =
;; (helper  12 3) =
;; (helper   1 5) =
;; (helper   0 6) =
;; 6