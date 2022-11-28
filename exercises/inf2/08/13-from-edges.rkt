#lang racket

(require "01-del-assoc.rkt")

(define (from-edges edges)
  (foldr
    (lambda (edge result)
      (let* ((from (car edge))
             (to (cdr edge))
             (node (assoc from result)))
        (if node
            (cons (cons from (cons to (cdr node))) (del-assoc from result))
            (cons (list from to) result))))
    '()
    edges))