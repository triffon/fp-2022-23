#lang racket

(require "00-stream.rkt")

(define (stream-zip func stream1 stream2)
  (if (or (empty-stream? stream1) (empty-stream? stream2))
      the-empty-stream
      (cons-stream
        (func (head stream1) (head stream2))
        (stream-zip func (tail stream1) (tail stream2)))))