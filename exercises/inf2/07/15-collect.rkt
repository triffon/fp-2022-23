#lang racket

(require "00-tree.rkt")

(define (collect-pre-order tree)
  (if (empty-tree? tree)
      empty-tree
      (append
        (list (root tree))
        (collect-pre-order (left-tree tree))
        (collect-pre-order (right-tree tree)))))

(define (collect-in-order tree)
  (if (empty-tree? tree)
      empty-tree
      (append
        (collect-in-order (left-tree tree))
        (list (root tree))
        (collect-in-order (right-tree tree)))))