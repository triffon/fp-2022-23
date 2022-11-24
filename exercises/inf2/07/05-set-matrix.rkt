#lang racket

(define (set-list lst i element)
  (define (helper current-lst index)
    (cond
      ((null? current-lst) '())
      ((= index i) (cons element (cdr current-lst)))
      (else (cons (car current-lst) (helper (cdr current-lst) (+ 1 index))))))
  
  (helper lst 0))

(define (set-matrix matrix i j element)
  (set-list
      matrix
      i
      (set-list
          (list-ref matrix i)
          j
          element)))