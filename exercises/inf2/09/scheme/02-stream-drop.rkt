#lang racket

(require "00-stream.rkt")

(define (stream-drop n stream)
  (if (< n 1)
    stream
    (stream-drop (- n 1) (tail stream))))