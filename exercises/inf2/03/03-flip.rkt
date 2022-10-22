#lang racket

(define (flip f)
  (lambda (x y) (f y x)))