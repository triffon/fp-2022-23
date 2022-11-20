#lang racket

(require "00-tree.rkt")

;; помощна фукнция
(define (leaf? tree)
  (and
    (not (empty? tree))
    (empty-tree? (left-tree tree))
    (empty-tree? (right-tree tree))))

(define (paths tree)
  (cond
    ((empty-tree? tree) '(()))
    ((leaf? tree) (list (list (root tree))))
    (else
      (map
        (lambda (path) (cons (root tree) path))
        (append
          (paths (left-tree tree))
          (paths (right-tree tree)))))))