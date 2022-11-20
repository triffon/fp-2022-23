#lang racket

(define (zip-with operation lst1 lst2)
  (if (or (null? lst1) (null? lst2))
      '()
      (cons
          (operation (car lst1) (car lst2))
          (zip-with operation (cdr lst1) (cdr lst2)))))

(define (sum-lists lst1 lst2)
  (zip-with + lst1 lst2))

(define (sum-matrices matrix1 matrix2)
  (zip-with sum-lists matrix1 matrix2))