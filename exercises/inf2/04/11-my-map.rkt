#lang racket

(define (my-map func lst)
  (if (null? lst)
      '()
      (cons (func (car lst)) (my-map func (cdr lst)))))

;; (define (1+ x) (+ x 1))

;; (my-map 1+ '(1 2 3)) =
;; (cons (1+ 1) (my-map 1+ '(2 3))) =
;; (cons (1+ 1) (cons (1+ 2) (my-map 1+ '(3)))) =
;; (cons (1+ 1) (cons (1+ 2) (cons (1+ 3) (my-map 1+ '())))) =
;; (cons (1+ 1) (cons (1+ 2) (cons 4 '()))) =
;; (cons (1+ 1) (cons 3 '(4))) =
;; (cons 2 '(3 4)) =
;; '(2 3 4) =

(define (my-map-iter func lst)
  (define (helper func lst result)
    (if (null? lst)
        result
        (helper func (cdr lst) (append result (list (func (car lst)))))))
  
  (helper func lst '()))

;; (my-map-iter 1+ '(1 2 3)) =
;; (helper 1+ '(1 2 3) '()) =
;; (helper 1+ '(2 3) '(2))  =
;; (helper 1+ '(3) '(2 3))  =
;; (helper 1+ '() '(2 3 4)) =
;; '(2 3 4)