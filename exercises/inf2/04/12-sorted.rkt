#lang racket

(define (sorted? lst)
  (cond
    ((or (null? lst) (null? (cdr lst))) #t)
    ((> (car lst) (cadr lst)) #f)
    (else (sorted? (cdr lst)))))