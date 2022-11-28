#lang racket

(define (search pred? alist)
  (foldr 
    (lambda (kv result) (if (pred? kv) kv result))
    #f
    alist))