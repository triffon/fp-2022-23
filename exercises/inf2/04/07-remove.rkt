#lang racket

(define (remove lst element)
  (cond
    ((null? lst) '())
    ((equal? element (car lst)) (remove (cdr lst) element))
    (else (cons (car lst) (remove (cdr lst) element)))))

;; (remove '(1 "test" 3 3 4) 3) =
;; (cons 1 (remove '("test" 3 3 4) 3)) =
;; (cons 1 (cons "test" (remove '(3 3 4) 3))) =
;; (cons 1 (cons "test" (remove '(3 4) 3))) =
;; (cons 1 (cons "test" (remove '(4) 3))) =
;; (cons 1 (cons "test" (cons 4 (remove '() 3))))) =
;; (cons 1 (cons "test" (cons 4 '()))) =
;; (cons 1 (cons "test" '(4))) =
;; (cons 1 '("test" 4)) =
;; '(1 "test" 4)

(define (remove-iter lst element)
  (define (helper lst element result)
    (cond
      ((null? lst) result)
      ((equal? element (car lst)) (helper (cdr lst) element result))
      (else (helper (cdr lst) element (append result (list (car lst)))))))
  
  (helper lst element '()))

;; (remove-iter '(1 "test" 3 3 4) 3) =
;; (helper '(1 "test" 3 3 4) 3 '())           =
;; (helper '("test" 3 3 4)   3 '(1))          =
;; (helper '(3 3 4)          3 '(1 "test"))   =
;; (helper '(3 4)            3 '(1 "test"))   =
;; (helper '(4)              3 '(1 "test"))   =
;; (helper '()               3 '(1 "test" 4)) =
;; '(1 "test" 4)
