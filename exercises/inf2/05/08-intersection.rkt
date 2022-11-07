#lang racket

(define (intersection lst1 lst2)
  (cond
    ((null? lst1) '())
    ((member (car lst1) lst2) (cons (car lst1) (intersection (cdr lst1) lst2)))
    (else (intersection (cdr lst1) lst2))))

(define (intersection-fold lst1 lst2)
  (foldr
    (lambda (element result)
      (if (member element lst2)
        (cons element result)
        result))
    '()
    lst1))

;; използвам вградената filter функция
(define (intersection-filter lst1 lst2)
  (filter (lambda (x) (member x lst2)) lst1))