#lang racket

(require "09-edge.rkt")

(define (contains-path? graph path)
  (or 
    (null? path)
    (and
      (null? (cdr path))
      ;; assoc връща наредена двойка ако съществува
      ;; елемент с дадения ключ в списъка
      ;; но аз искам да върна boolean от функцията си
      ;; затова "изкуствено" прилагам not 2 пъти
      ;; пример: (not (not '(1 . 2))) = (not #f) = #t
      (not (not (assoc (car path) graph))))
    (and
      (edge? (car path) (cadr path) graph)
      (contains-path? graph (cdr path)))))