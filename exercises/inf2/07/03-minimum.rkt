#lang racket

(define (minimum-list lst)
  (foldr min (car lst) (cdr lst)))

(define (minimum matrix)
  (minimum-list (map minimum-list matrix)))