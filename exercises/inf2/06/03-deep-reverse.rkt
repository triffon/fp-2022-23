#lang racket

(define (atom? x)
  (and (not (null? x)) (not (pair? x))))

(define (deep-reverse lst)
  (cond
    ((null? lst) '())
    ((atom? lst) lst)
    (else (append
            (deep-reverse (cdr lst))
            (list (deep-reverse (car lst)))))))