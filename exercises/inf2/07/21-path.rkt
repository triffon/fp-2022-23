#lang racket

(require "00-tree.rkt")

(define (path element tree)
  (cond
    ((empty-tree? tree) #f)
    ((equal? element (root tree)) (list element))
    (else
      (let
        ((path-in-left-tree (path element (left-tree tree)))
         (path-in-right-tree (path element (right-tree tree))))
         
         (cond
          (path-in-left-tree (cons (root tree) path-in-left-tree))
          (path-in-right-tree (cons (root tree) path-in-right-tree))
          (else #f))))))