#lang racket

(require "00-tree.rkt")

(define (map-tree func tree)
  (if (empty-tree? tree)
      empty-tree
      (make-tree
        (func (root tree))
        (map-tree func (left-tree tree))
        (map-tree func (right-tree tree)))))