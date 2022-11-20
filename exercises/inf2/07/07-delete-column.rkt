#lang racket

(define (delete-element index lst)
  (define (helper i current-lst)
    (cond
      ((null? current-lst) '())
      ((= index i) (cdr current-lst))
      (else (cons (car current-lst) (helper (+ 1 i) (cdr current-lst))))))
    
  (helper 0 lst))

(define (delete-column index matrix)
  (map
    (lambda (row) (delete-element index row))
    matrix))