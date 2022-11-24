#lang racket

(require "00-tree.rkt")

(define (invert tree)
  (if (empty-tree? tree)
      empty-tree
      (make-tree
        (root tree)
        (invert (right-tree tree))
        (invert (left-tree tree)))))