#lang racket

(require "00-stream.rkt")

(define (to-list stream)
  (if (empty-stream? stream)
      '()
      (cons (head stream) (to-list (tail stream)))))