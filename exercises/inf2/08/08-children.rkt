#lang racket

(provide children)

(define (children vertex graph)
  (let ((lst (assoc vertex graph)))
    (if lst (cdr lst) '())))