#lang racket

(define (insert element sorted-lst)
  (cond
    ((null? sorted-lst) (list element))
    ((> element (car sorted-lst)) (cons (car sorted-lst) (insert element (cdr sorted-lst))))
    (else (cons element sorted-lst))))

(define (insertion-sort lst)
  (if (null? lst)
      '()
      (insert (car lst) (insertion-sort (cdr lst)))))