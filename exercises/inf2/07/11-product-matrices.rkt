#lang racket

(require "08-transpose.rkt")

(define (zip-with operation lst1 lst2)
  (if (or (null? lst1) (null? lst2))
      '()
      (cons
          (operation (car lst1) (car lst2))
          (zip-with operation (cdr lst1) (cdr lst2)))))

(define (product-vectors vector1 vector2)
  ;; можем да изпозлваме директно вградения map вместо zip-with
  (foldr + 0 (zip-with * vector1 vector2)))

(define (product-matrices matrix1 matrix2)
  (define transposed-matrix2 (transpose matrix2))

  (map
    (lambda (row) 
      (map (lambda (column) (product-vectors row column)) transposed-matrix2))
    matrix1))