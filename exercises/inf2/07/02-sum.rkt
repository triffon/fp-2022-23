#lang racket

(define (sum-list lst)
  (foldr + 0 lst))

(define (sum matrix)
  (sum-list (map sum-list matrix)))

;; алтернативно решение
;; (define (sum matrix)
;;   (apply + (map (lambda (row) (apply + row)) matrix)))

(define matrix 
  '((1 2)
    (3 4)
    (5 6)))