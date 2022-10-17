#lang racket

(define (sum-interval start end)
	(define (helper start accum)
		(if (> start end)
			accum
			(helper (+ start 1) (+ accum start))))
	(helper start 0))

;; (sum-interval 1 5) =
;; (helper 1 0) =
;; (helper 2 1) =
;; (helper 3 3) =
;; (helper 4 6) =
;; (helper 5 10) =
;; (helper 6 15) =
;; 15