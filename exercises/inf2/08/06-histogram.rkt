#lang racket

(require "01-del-assoc.rkt")

(define (histogram lst)
  (foldr
    (lambda (x result)
      (let ((kv (assoc x result)))
        (if kv
          (cons (cons x (+ 1 (cdr kv))) (del-assoc x result))
          (cons (cons x 1) result))))
    '()
    lst))