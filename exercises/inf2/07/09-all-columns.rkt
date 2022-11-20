#lang racket

(define (all-columns? predicate? matrix)
  (foldr
    (lambda (row result)
      (and (predicate? row) result))
    #t
    matrix))