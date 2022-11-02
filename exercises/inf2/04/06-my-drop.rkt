#lang racket

(define (my-drop lst n)
  (if (or (null? lst) (= n 0))
      lst
      (my-drop (cdr lst) (- n 1))))