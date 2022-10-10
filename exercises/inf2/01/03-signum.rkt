#lang racket

(define (signum number)
  (cond
    ((< number 0) -1)
    ((= number 0) 0)
    ((> number 0) 1)))