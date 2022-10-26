#lang racket

(define (apply-twice func arg)
  (func (func arg)))