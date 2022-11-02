#lang racket

(define (unique lst)
  (define (helper lst result)
    (cond
      ((null? lst) result)
      ((member (car lst) result) (helper (cdr lst) result))
      (else (helper (cdr lst) (append result (list (car lst)))))))
    
  (helper lst '()))