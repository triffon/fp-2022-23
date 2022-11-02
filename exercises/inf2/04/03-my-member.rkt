#lang racket

(define (my-member element lst)
  (cond
    ((null? lst) #f)
    ((equal? element (car lst)) lst)
    (else (my-member element (cdr lst)))))