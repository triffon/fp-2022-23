#lang racket

(define (my-filter pred lst)
  (foldr
    (lambda (element result)
      (if (pred element)
          (cons element (my-filter pred (cdr lst)))
          (my-filter pred (cdr lst))))
    '()
    lst))