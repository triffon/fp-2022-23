#lang racket

(require "00-tree.rkt")

;; ще използваме тази функция в други файлове
(provide binary-search-tree-insert)

;; решение
(define (binary-search-tree-insert tree element)
  (cond
    ((empty-tree? tree) (make-leaf element))
    ((<= element (root tree))
      (make-tree
        (root tree)
        (binary-search-tree-insert (left-tree tree) element)
        (right-tree tree)))
    (else
      (make-tree
        (root tree)
        (left-tree tree)
        (binary-search-tree-insert (right-tree tree) element)))))