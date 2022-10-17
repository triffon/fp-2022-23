#lang racket

(define (power base exp)
	(define (helper exp accum)
		(if (= 0 exp)
			accum
			(helper (- exp 1) (* accum base))))
	(helper exp 1))

;; (power 5 3) =
;; (helper 3 1) =
;; (helper 2 5) =
;; (helper 1 25) =
;; (helper 0 125) =
;; 125