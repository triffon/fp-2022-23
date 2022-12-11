#lang racket

(require "00-stream.rkt")

(define (stream-ref stream i)
  (define (helper curr-stream curr-index)
    (if (= curr-index i)
        (head curr-stream)
        (helper (tail curr-stream) (+ 1 curr-index))))
  
  (helper stream 0))