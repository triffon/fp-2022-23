#lang racket

(require "00-tree.rkt")

(define (depth tree)
  (if (empty-tree? tree)
      0
      (+ 1 (max
             (depth (left-tree tree))
             (depth (right-tree tree))))))