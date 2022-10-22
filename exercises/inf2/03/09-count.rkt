#lang racket

;; дадена наготово
(define (accumulate operation null-value start end term next)
  (if (> start end)
      null-value
      (operation
            (term start)
            (accumulate operation null-value (next start) end term next))))

(define (count predicate? start end)
  (accumulate
    +
    0
    start
    end
    (lambda (x) (if (predicate? x) 1 0))
    (lambda (x) (+ x 1))))