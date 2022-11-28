#lang racket

(define (map-values func alist)
  (map
    (lambda (kv) (cons (car kv) (func (cdr kv))))
    alist))