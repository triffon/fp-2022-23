#lang racket

;; дадена наготово
(define (accumulate operation null-value start end term next)
  (if (> start end)
      null-value
      (operation
            (term start)
            (accumulate operation null-value (next start) end term next))))

(define (any? predicate? start end)
  (accumulate
    (lambda (x y) (or x y))
    #f
    start
    end
    (lambda (x) (predicate? x))
    (lambda (x) (+ x 1))))