#lang racket

(define (my-length lst)
  (if (null? lst)
      0
      (+ 1 (my-length (cdr lst)))))

;; (my-length '(1 2 3)) =
;; (+ 1 (my-length '(2 3))) =
;; (+ 1 (+ 1 (my-length '(3)))) =
;; (+ 1 (+ 1 (+ 1 (my-length '())))) =
;; (+ 1 (+ 1 (+ 1 0))) =
;; (+ 1 (+ 1 1)) =
;; (+ 1 2) =
;; 3

(define (my-length-iter lst)
  (define (helper lst result)
    (if (null? lst)
        result
        (helper (cdr lst) (+ 1 result))))

  (helper lst 0))

;; (my-length-iter '(1 2 3)) =
;; (helper '(1 2 3) 0) =
;; (helper '(2 3)   1) =
;; (helper '(3)     2) =
;; (helper '()      3) =
;; 3