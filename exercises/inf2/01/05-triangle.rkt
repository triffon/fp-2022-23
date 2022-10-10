#lang racket

(define (triangle? a b c)
  (and
    (> a 0)
    (> b 0)
    (> c 0)
    (> (+ b c) a)
    (> (+ a c) b)
    (> (+ a b) c)))