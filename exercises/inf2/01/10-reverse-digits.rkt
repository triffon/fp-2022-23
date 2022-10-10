#lang racket

(define (count-digits number)
  (if (< number 10)
      1
      (+ 1 (count-digits (quotient number 10)))))

(define (reverse-digits number)
  (if (= (count-digits number) 1)
      number
      (+
        (*
          (remainder number 10)
          (expt 10 (- (count-digits number) 1)))
        (reverse-digits (quotient number 10)))))