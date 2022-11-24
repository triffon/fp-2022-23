#lang racket

(require "00-tree.rkt")

(define (level tree index)
  (define (helper tree current-level)
    (cond
      ((empty-tree? tree) empty-tree)
      ((= current-level index) (list (root tree)))
      (else (append
              (helper (left-tree tree) (+ 1 current-level))
              (helper (right-tree tree) (+ 1 current-level))))))
  
  (helper tree 0))