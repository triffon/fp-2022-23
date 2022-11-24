#lang racket

(require "00-tree.rkt")

;; помощнa фукнция
(define (leaf? tree)
  (and
    (not (empty? tree))
    (empty-tree? (left-tree tree))
    (empty-tree? (right-tree tree))))

(define (count-leaves tree)
  (cond
    ((empty-tree? tree) 0)
    ((leaf? tree) 1)
    (else (+
            (count-leaves (left-tree tree))
            (count-leaves (right-tree tree))))))