#lang racket
(require rackunit rackunit/text-ui)

;### Зад 15
; Дали всички елементи на списък изпълняват предиката `p?`?
(define (all? p? l)
  (if (null? l)
      #t
      (and (p? (car l))
           (all? p? (cdr l)))))


(run-tests
  (test-suite "all? tests"
    (check-true (all? even? '()))
    (check-true (all? even? '(2 4 6 8)))
    (check-false (all? even? '(2 4 6 7 8)))
    (check-false (all? even? '(1 2 4 6 8)))
    (check-false (all? even? '(2 4 6 8 1)))
    (check-false (all? even? '(1))))
  'verbose)
