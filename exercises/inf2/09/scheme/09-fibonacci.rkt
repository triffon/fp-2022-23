#lang racket

(require "00-stream.rkt")

(define (fibonacci-helper curr next)
  (cons-stream curr (fibonacci-helper next (+ curr next))))

(define fibonacci (fibonacci-helper 1 1))