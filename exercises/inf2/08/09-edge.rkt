#lang racket

(provide edge?)

(define (children vertex graph)
  (let ((lst (assoc vertex graph)))
    (if lst (cdr lst) '())))

(define (edge? u v graph)
  ;; member връща #f или самия елемент
  ;; ако върне самия елемент, с (not (not <element>))
  ;; превръщаме стойността в boolean
  (not (not (member v (children u graph)))))