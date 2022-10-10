#lang racket

(define (fibonacci n)
  (cond
    ((= n 0) 1)
    ((= n 1) 1)
    (else (+
            (fibonacci (- n 1))
            (fibonacci (- n 2))))))

;; (fibonacci 3) =
;; (+ (fibonacci 2) (fibonacci 1)) = 
;; (+ (+ (fibonacci 1) (fibonacci 0)) 1) =
;; (+ (+ 1 1) 1) =
;; (+ 2 1) =
;; 3

;; алтернативно решение, използващо if
;; вместо cond израз
;; (define (fibonacci number)
;;   (if (< number 2)
;;       1
;;       (+
;;         (fibonacci (- number 1))
;;         (fibonacci (- number 2)))))