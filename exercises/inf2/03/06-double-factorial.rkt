#lang racket

;; дадена наготово
(define (accumulate operation null-value start end term next)
  (if (> start end)
      null-value
      (operation
            (term start)
            (accumulate operation null-value (next start) end term next))))

(define (double-factorial number)
  (accumulate
    *
    1
    (if (= 1 (remainder number 2)) 1 2)
    number
    (lambda (x) x)
    (lambda (x) (+ x 2))))