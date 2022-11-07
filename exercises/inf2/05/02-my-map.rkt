#lang racket

(define (my-map func lst)
  (foldr
    (lambda (element result)
      (cons (func (car lst)) (my-map func (cdr lst))))
    '()
    lst))