#lang racket

(define (my-filter predicate? lst)
  (cond
    ((null? lst) '())
    ((predicate? (car lst)) (cons (car lst) (my-filter predicate? (cdr lst))))
    (else (my-filter predicate? (cdr lst)))))

;; (my-filter odd? '(1 2 3 4 5)) =
;; (cons 1 (my-filter odd? '(2 3 4 5))) =
;; (cons 1 (my-filter odd? '(3 4 5))) =
;; (cons 1 (cons 3 (my-filter odd? '(4 5)))) =
;; (cons 1 (cons 3 (my-filter odd? '(5)))) =
;; (cons 1 (cons 3 (cons 5 '()))) =
;; '(1 3 5)

(define (my-filter-iter predicate? lst)
  (define (helper predicate? lst result)
    (cond
      ((null? lst) result)
      ((predicate? (car lst)) (helper predicate? (cdr lst) (append result (list (car lst)))))
      (else (helper predicate? (cdr lst) result))))
  
  (helper predicate? lst '()))

;; (my-filter-iter odd? '(1 2 3 4 5)) =
;; (helper odd? '(1 2 3 4 5) '())      =
;; (helper odd? '(2 3 4 5)   '(1))     =
;; (helper odd? '(3 4 5)     '(1))     =
;; (helper odd? '(4 5)       '(1 3))   =
;; (helper odd? '(5)         '(1 3))   =
;; (helper odd? '()          '(1 3 5)) =
;; '(1 3 5)