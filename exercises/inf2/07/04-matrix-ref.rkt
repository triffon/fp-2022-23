#lang racket

(define (matrix-ref matrix i j)
  (list-ref (list-ref matrix i) j))