#lang racket

(require "00-tree.rkt")

;; помощнa фукнция
(define (leaf? tree)
  (and
    (not (empty? tree))
    (empty-tree? (left-tree tree))
    (empty-tree? (right-tree tree))))

(define (prune tree)
  (if (or (empty-tree? tree) (leaf? tree))
      empty-tree
      (make-tree
        (root tree)
        (prune (left-tree tree))
        (prune (right-tree tree)))))