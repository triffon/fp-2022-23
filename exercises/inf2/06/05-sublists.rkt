#lang racket

;; връща всички подсписъци на lst с дължина n
;; (sublists-n '(1 2 3) 0) => '()
;; (sublists-n '(1 2 3) 1) => '((1) (2) (3))
;; (sublists-n '(1 2 3) 2) => '((1 2) (2 3))
(define (sublists-n lst n)
  (if (< (length lst) n)
      '()
      (cons (take lst n) (sublists-n (cdr lst) n))))

(define (sublists lst)
  (define (helper lst n result)
    (if (or (null? lst) (< n 1))
        result
        (helper lst (- n 1) (append (sublists-n lst n) result))))
    
  (helper lst (length lst) '()))