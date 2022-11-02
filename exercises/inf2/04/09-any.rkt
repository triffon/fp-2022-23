#lang racket

(define (any? lst predicate?)
  (cond
    ((null? lst) #f)
    ((predicate? (car lst)) #t)
    (else (any? (cdr lst) predicate?))))