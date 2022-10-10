#lang racket

(define (power base exponent)
  (cond
    ((< exponent 0) (power (/ 1 base) (- exponent)))
    ((= exponent 0) 1)
    ((> exponent 0) (* base (power base (- exponent 1))))))