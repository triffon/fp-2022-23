#lang racket

(require "00-stream.rkt")

(define (add stream1 stream2)
  (if (or (empty-stream? stream1) (empty-stream? stream2))
      the-empty-stream
      (cons-stream
        (+ (head stream1) (head stream2))
        (add (tail stream1) (tail stream2)))))