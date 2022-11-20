#lang racket

(require "00-tree.rkt")
(require "24-binary-search-tree-insert.rkt")

(define (collect-in-order tree)
  (if (empty-tree? tree)
      empty-tree
      (append
        (collect-in-order (left-tree tree))
        (list (root tree))
        (collect-in-order (right-tree tree)))))

(define (tree-sort lst)
  (define (construct-binary-tree lst result)
    (if (null? lst)
        result
        (construct-binary-tree
          (cdr lst)
          (binary-search-tree-insert result (car lst)))))
  
  (collect-in-order (construct-binary-tree lst empty-tree)))