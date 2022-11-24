#lang racket

(define (diagonal matrix)
  (define (diagonal-helper matrix index)
    (cond 
      ((null? matrix) '())
      ((<= (length (car matrix)) index) '())
      (else
        (cons
          (list-ref (car matrix) index)
          (diagonal-helper (cdr matrix) (+ index 1))))))
        
  
  (diagonal-helper matrix 0))