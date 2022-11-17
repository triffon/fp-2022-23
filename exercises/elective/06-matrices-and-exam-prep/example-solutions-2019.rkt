#lang racket

(define (accumulate op nv a b term next)
  (if (> a b)
      nv
      (op (term a) (accumulate op nv (next a) b term next))))

;; 1 задача

(define (product-digits n)
  (define (helper result curr)
    (if (= curr 0)
        result
        (helper (* result (remainder curr 10)) (quotient curr 10))))
   (helper 1 n))

(define (largest-diff a b)
  (define (calculate-diff x)
    (abs (- x (product-digits x))))

  (define (max-diff x y)
    (if (> (calculate-diff x) y) (calculate-diff x) y))

  (define (min-diff x y)
    (if (< (calculate-diff x) y) (calculate-diff x) y))
  
  (let (
      (maxim (accumulate max-diff 0 a b (lambda (x) x) (lambda (x) (+ x 1))))
      (minim (accumulate min-diff 10000 a b (lambda (x) x) (lambda (x) (+ x 1)))))
    (- maxim minim)))

;; 2 задача

(define (max-metric ml ll)
  (car (foldr
        (lambda (x y) (if (> (cdr x) (cdr y)) x y))
        (cons (lambda (x) x) 0)
        (map (lambda (m) (cons m (apply + (map m ll)))) ml))))

(define (prod l) (apply * l))
(define (sum l) (apply + l))

;; 3 задача

(define (repeat x n)
  (if (= n 0) '() (cons x (repeat x (- n 1)))))

(define (deep-repeat ll)
  (define (helper res currl lvl)
    (cond
      ((null? currl) res)
      ((list? (car currl))
       (append
        (helper res (car currl) (+ lvl 1))
        (helper '() (cdr currl) lvl)))
      (else (helper
             (append res (repeat (car currl) lvl))
             (cdr currl) lvl))))
  (helper '() ll 1))