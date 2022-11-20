#lang racket

(require "00-tree.rkt")

(define (binary-search-tree? tree)
  (or
    (empty-tree? tree)
    (and
      (list tree)
      (= (length tree) 3)
      (binary-search-tree? (left-tree tree))
      (binary-search-tree? (right-tree tree))
      (or
        (empty-tree? (left-tree tree))
        (<= (root (left-tree tree)) (root tree)))
      (or
        (empty-tree? (right-tree tree))
        (> (root (right-tree tree)) (root tree))))))