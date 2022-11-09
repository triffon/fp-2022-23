#lang racket
(require rackunit rackunit/text-ui)

;### Зад 16
; Дали поне един елемент на списък изпълняват предиката `p?`?
(define (any? p? l)
  (if (null? l)
      #f
      (or (p? (car l))
          (any? p? (cdr l)))))


(run-tests
  (test-suite "any? tests"
    (check-false (any? even? '()))
    (check-true (any? even? '(2 4 6 8)))
    (check-true (any? even? '(2 4 6 7 8)))
    (check-true (any? even? '(1 2 4 6 8)))
    (check-true (any? even? '(2 4 6 8 1)))
    (check-false (any? even? '(1)))
    (check-false (any? even? '(1 3 5 7 17))))
  'verbose)
