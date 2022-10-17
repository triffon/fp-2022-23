#lang racket

(define (decimal-to-binary number)
	(if (< number 1)
		0
		(+ (remainder number 2) (* 10 (decimal-to-binary (quotient number 2))))))

;; (decimal-to-binary 5) =
;; (+ 1 (* 10 decimal-to-binary 2)) =
;; (+ 1 (* 10 (+ 0 (* 10 (decimal-to-binary 1))))) =
;; (+ 1 (* 10 (+ 0 (* 10 (+ 1 (* 10 (decimal-to-binary 0))))))) =
;; (+ 1 (* 10 (+ 0 (* 10 (+ 1 (* 10 0)))))) =
;; (+ 1 (* 10 (+ 0 (* 10 (+ 1 0)))) =
;; (+ 1 (* 10 (+ 0 (* 10 1)))) =
;; (+ 1 (* 10 (+ 0 10))) =
;; (+ 1 (* 10 10)) =
;; (+ 1 100) =
;; 101

(define (decimal-to-binary-iter number)
  (define (helper num exp result)
		(if (< num 1)
				result
				(helper
					(quotient num 2)
					(+ exp 1)
					(+ result (* (remainder num 2) (expt 10 exp))))))
	(helper number 0 0))

;; (decimal-to-binary-iter 5) =
;; (helper 5 0 0) =
;; (helper 2 1 1) =
;; (helper 1 2 1) =
;; (helper 0 3 101) =
;; 101