#lang racket

(require "00-tree.rkt")

(define (contains? tree path)
  (or
    (null? path)
    (and
      (not (empty-tree? tree))
      (or
        (and 
          (equal? (root tree) (car path))
          (or
            (contains? (left-tree tree) (cdr path))
            (contains? (right-tree tree) (cdr path))))
        (contains? (left-tree tree) path)
        (contains? (right-tree tree) path)))))