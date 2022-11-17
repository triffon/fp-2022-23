#lang racket

(define (atom? x)
  (and (not (null? x)) (not (pair? x))))

(define (member-deep? elem lst)
  (cond
    ((null? lst) #f)
    ((atom? lst) (equal? elem lst))
    (else (or
            (member-deep? elem (car lst))
            (member-deep? elem (cdr lst))))))