#lang racket

(define (my-foldr operation null-value lst)
  (if (null? lst)
      null-value
      (operation (car lst) (my-foldr operation null-value (cdr lst)))))

;; foldl in racket
(define (my-foldl operation null-value lst)
  (if (null? lst)
      null-value
      (foldl operation (operation (car lst) null-value) (cdr lst))))