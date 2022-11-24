#lang racket

;; ще използваме тези функции в други файлове
(provide
  empty-tree
  empty-tree?
  make-tree
  make-leaf
  root
  left-tree
  right-tree)

(define empty-tree '())
(define empty-tree? null?)

(define (make-tree root left right)
  (list root left right))

(define (make-leaf element)
  (make-tree element empty-tree empty-tree))

(define root car)
(define left-tree cadr)
(define right-tree caddr)