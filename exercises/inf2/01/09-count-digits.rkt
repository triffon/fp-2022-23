#lang racket

(define (count-digits number)
  (if (< number 10)
      1
      (+ 1 (count-digits (quotient number 10)))))