#lang racket

(define (all? lst predicate?)
  (cond
    ((null? lst) #t)
    ((predicate? (car lst)) (all? (cdr lst) predicate?))
    (else #f)))