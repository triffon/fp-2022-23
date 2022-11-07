#lang racket

(define (generate-interval start end)
  (if (> start end)
      '()
      (cons start (generate-interval (+ start 1) end))))

(define (generate-interval-iter start end)
  (define (helper start end result)
    (if (> start end)
        result
        (helper (+ start 1) end (append result (list start)))))
  
  (helper start end '()))