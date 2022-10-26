#lang racket

;; дадена наготово
(define (accumulate operation null-value start end term next)
  (if (> start end)
      null-value
      (operation
            (term start)
            (accumulate operation null-value (next start) end term next))))

(define (filter-accumulate predicate? operation null-value start end term next)
  (cond
    ((> start end) null-value)
    ((predicate? start) (operation (term start) (filter-accumulate predicate? operation null-value (next start) end term next)))
    (else (filter-accumulate predicate? operation null-value (next start) end term next))))

(define (filter-accumulate-iter predicate? operation null-value start end term next)
  (if (> start end)
      null-value
      (filter-accumulate-iter
        predicate?
        operation
        (if (predicate? start) (operation null-value (term start)) null-value)
        (next start)
        end
        term
        next)))