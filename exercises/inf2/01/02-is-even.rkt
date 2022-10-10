#lang racket

(define (is-even? number)
  (= 0 (remainder number 2)))