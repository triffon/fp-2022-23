#lang racket

(define (nth lst n)
  (cond
    ((null? lst) 'undefined)
    ((= n 0) (car lst))
    (else (nth (cdr lst) (- n 1)))))