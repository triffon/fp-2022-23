#lang racket

(define (my-min lst)
  (foldr
    (lambda (element current-min)
      (if (< element current-min)
          element
          current-min))
    (car lst)
    lst))