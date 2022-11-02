#lang racket
(require rackunit rackunit/text-ui)

;### Зад 19
; Сортиране на списък по алгоритъма insertion sort. https://en.wikipedia.org/wiki/Insertion_sort
(define (insertion-sort l)
  'тук)


(run-tests
  (test-suite "insertion-sort tests"
    (check-equal? (insertion-sort '())
                  '())
    (check-equal? (insertion-sort '(1))
                  '(1))
    (check-equal? (insertion-sort '(2 4 6 7 8))
                  '(2 4 6 7 8))
    (check-equal? (insertion-sort '(1 2 4 6 8))
                  '(1 2 4 6 8))
    (check-equal? (insertion-sort '(2 4 6 8 1))
                  '(1 2 4 6 8))
    (check-equal? (insertion-sort '(8 7 6 5 4 2 1))
                  '(1 2 4 5 6 7 8)))
  'verbose)
