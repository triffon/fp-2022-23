#lang racket

(define (sum-interval a b)
  (if (> a b)
      0
      (+ a (sum-interval (+ a 1) b))))