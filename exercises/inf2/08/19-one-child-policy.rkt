#lang racket

(require "07-vertices.rkt")
(require "08-children.rkt")
(require "11-parents.rkt")

(define (all? pred? lst)
  (or
    (null? lst)
    (and
      (pred? (car lst))
      (all? pred? (cdr lst)))))

(define (one-child-policy? graph)
  (define (has-multiple-children? vertex)
    (> (length (children vertex graph)) 1))

  (define (is-only-child? vertex)
    (all?
      (lambda (vertex)
        (< (length (children vertex graph)) 2))
      (parents vertex graph)))

  (all?
    (lambda (vertex)
      (or
        (not (has-multiple-children? vertex))
        (is-only-child? vertex)))
    (vertices graph)))