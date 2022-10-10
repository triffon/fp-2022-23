#lang racket

(define (root? x)
  (= 0 (+
         (* 3 (expt x 2))
         (* 2 x)
          -1)))