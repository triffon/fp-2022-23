#lang racket

(define (binary-to-decimal number)
	(if (= number 0)
		0
		(+ (* 2 (binary-to-decimal (quotient number 10))) (remainder number 10))))

;; (binary-to-decimal 101) =
;; (+ (* 2 (binary-to-decimal 10)) 1) = 
;; (+ (* 2 (+ (* 2 (binary-to-decimal 1)) 0)) 1) =
;; (+ (* 2 (+ (* 2 (+ (* 2 (binary-to-decimal 0)) 1)) 0)) 1) =
;; (+ (* 2 (+ (* 2 (+ (* 2 0) 1)) 0)) 1) =
;; (+ (* 2 (+ (* 2 (+ 0 1)) 0)) 1) =
;; (+ (* 2 (+ (* 2 1) 0)) 1) =
;; (+ (* 2 (+ 2 0)) 1) =
;; (+ (* 2 2) 1) =
;; (+ 4 1) =
;; 5

(define (binary-to-decimal-iter number)
	(define (helper num power accum)
		(if (= num 0)
			accum
			(helper (quotient num 10) (+ power 1) (+ accum (* (remainder num 10) (expt 2 power))))))
	(helper number 0 0))

;; (binary-to-decimal-iter 101) =
;; (helper  101  0  0) =
;; (helper   10  1  2) =
;; (helper    1  2  2) =
;; (helper    0  3 10) =
;; 5