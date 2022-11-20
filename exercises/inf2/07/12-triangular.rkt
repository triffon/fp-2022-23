#lang racket

(define (starts-with-n? lst n element)
  (or
    (< n 1)
    (and
      (not (null? lst))
      (equal? (car lst) element)
      (starts-with-n? (cdr lst) (- n 1) element))))

(define (triangular? matrix)
  (define (helper index current-matrix)
    (or
      (null? current-matrix)
      (and
        (not (null? current-matrix))
        (starts-with-n? (car current-matrix) index 0)
        (helper (+ index 1) (cdr current-matrix)))))
  
  (helper 0 matrix))