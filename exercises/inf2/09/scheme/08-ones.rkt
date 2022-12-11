#lang racket

(require "00-stream.rkt")

(define ones (cons-stream 1 ones))