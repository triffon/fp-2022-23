#lang racket

(define (zip lst1 lst2)
  (if (or (null? lst1) (null? lst2))
      '()
      (cons
        (cons (car lst1) (car lst2))
        (zip (cdr lst1) (cdr lst2)))))

(define (zip-iter lst1 lst2)
  (define (helper lst1 lst2 result)
    (if (or (null? lst1) (null? lst2))
        result
        (helper
          (cdr lst1)
          (cdr lst2)
          (append result (list (cons (car lst1) (car lst2)))))))
  
  (helper lst1 lst2 '()))