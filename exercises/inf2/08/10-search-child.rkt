#lang racket

(define (children vertex graph)
  (let ((lst (assoc vertex graph)))
    (if lst (cdr lst) '())))

(define (search-child vertex pred? graph)
  (foldr
    (lambda (child result) (if (pred? child) child result))
    #f
    (children vertex graph)))