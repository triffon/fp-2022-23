#lang racket

(define (my-reverse lst)
  (if (null? lst)
      '()
      (append
        (my-reverse (cdr lst))
        (list (car lst)))))

;; (my-reverse '(1 2 3)) =
;; (append (my-reverse '(2 3)) '(1)) =
;; (append (append (my-reverse '(3)) '(2)) '(1)) =
;; (append (append (append '() '(3)) '(2)) '(1)) =
;; (append (append '(3) '(2)) '(1)) =
;; (append '(3 2) '(1)) =
;; '(3 2 1)

(define (my-reverse-iter lst)
  (define (helper lst result)
    (if (null? lst)
        result
        (helper (cdr lst) (cons (car lst) result))))
  
  (helper lst '()))

;; (my-reverse-iter '(1 2 3)) =
;; (helper '(1 2 3) '())      =
;; (helper '(2 3)   '(1))     =
;; (helper '(3)     '(2 1))   =
;; (helper '()      '(3 2 1)) =
;; '(3 2 1)