#lang racket

(require "00-stream.rkt")

(define (stream-filter pred? stream)
  (cond 
    ((empty-stream? stream) the-empty-stream)
    ((pred? (head stream))
      (cons-stream (head stream) (stream-filter pred? (tail stream))))
    (else (stream-filter pred? (tail stream)))))