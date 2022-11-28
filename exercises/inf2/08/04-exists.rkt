#lang racket

(define (exists? pred? alist)
  (foldr 
    (lambda (kv result) (or (pred? kv) result))
    #f
    alist))