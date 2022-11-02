#lang racket

(define (my-take lst number)
  (if (or (= number 0) (null? lst))
      '()
      (cons
        (car lst)
        (my-take (cdr lst) (- number 1)))))

;; (my-take '(1 2 3) 2) =
;; (cons 1 (my-take '(2 3) 1)) =
;; (cons 1 (cons 2 (my-take '(3) 0))) =
;; (cons 1 (cons 2 '())) =
;; (cons 1 '(2)) =
;; '(1 2)

(define (my-take-iter lst number)
  (define (helper lst number result)
    (if (or (= number 0) (null? lst))
        result
        (helper
          (cdr lst)
          (- number 1)
          (append result (list (car lst))))))
  
  (helper lst number '()))

;; (my-take-iter '(1 2 3) 2) =
;; (helper '(1 2 3) 2 '()) =
;; (helper '(2 3)   1 '(1)) =
;; (helper '(3)     0 '(1 2)) =
;; '(1 2)
