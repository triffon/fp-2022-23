#lang racket

(require "00-stream.rkt")

(define (stream-map func stream)
  (if (empty-stream? stream)
      the-empty-stream
      (cons-stream
        (func (head stream))
        (stream-map func (tail stream)))))