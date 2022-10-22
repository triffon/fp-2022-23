#lang racket

;; дадено наготово
(define (filter-accumulate predicate? operation null-value start end term next)
  (cond
    ((> start end) null-value)
    ((predicate? start) (operation (term start) (filter-accumulate predicate? operation null-value (next start) end term next)))
    (else (filter-accumulate predicate? operation null-value (next start) end term next))))

(define (count predicate? start end)
  (filter-accumulate
    predicate?
    +
    0
    start
    end
    (lambda (x) (if (predicate? x) 1 0))
    (lambda (x) (+ x 1))))