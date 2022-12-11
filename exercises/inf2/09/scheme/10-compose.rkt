#lang racket

(require "00-stream.rkt")

(define (compose func x)
  (cons-stream x (compose func (func x))))