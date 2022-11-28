#lang racket

(require "09-edge.rkt")
(require "12-to-edges.rkt")

(define (symmetric? graph)
  (foldr
    (lambda (edge result)
      (and result (edge? (cdr edge) (car edge) graph)))
    #t
    (to-edges graph)))