#lang racket
(require rackunit rackunit/text-ui)

;### Зад 18
; Дали списък е сортиран?
(define (sorted? l)
  'тук)


(run-tests
  (test-suite "sorted? tests"
    (check-true (sorted? '()))
    (check-true (sorted? '(1)))
    (check-true (sorted? '(2 4 6 7 8)))
    (check-true (sorted? '(1 2 4 6 8)))
    (check-false (sorted? '(2 4 6 8 1)))
    (check-false (sorted? '(1 3 5 6 7 17)))
    (check-true (sorted? '(8 7 6 5 4 2 1))))
  'verbose)
