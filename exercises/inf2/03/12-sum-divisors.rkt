#lang racket

;; дадена наготово
;; (define (accumulate operation null-value start end term next)
;;   (if (> start end)
;;       null-value
;;       (operation
;;             (term start)
;;             (accumulate operation null-value (next start) end term next))))

;; (define (sum-divisors number)
;;   (accumulate
;;     +
;;     0
;;     1
;;     number
;;     (lambda (x) (if (= 0 (remainder number x)) x 0))
;;     (lambda (x) (+ x 1))))

;; дадено наготово
(define (filter-accumulate predicate? operation null-value start end term next)
  (cond
    ((> start end) null-value)
    ((predicate? start) (operation (term start) (filter-accumulate predicate? operation null-value (next start) end term next)))
    (else (filter-accumulate predicate? operation null-value (next start) end term next))))

(define (sum-divisors number)
  (filter-accumulate
    (lambda (x) (= 0 (remainder number x)))
    +
    0
    1
    number
    (lambda (x) x)
    (lambda (x) (+ x 1))))