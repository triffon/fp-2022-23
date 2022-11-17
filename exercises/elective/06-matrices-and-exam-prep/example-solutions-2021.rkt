#lang racket

(define (accumulate op nv a b term next)
  (if (> a b)
      nv
      (op (term a) (accumulate op nv (next a) b term next))))

;; 1 задача

(define (id x) x)
(define (1+ x) (+ x 1))

(define (sum-divisors n)
  (accumulate
   (lambda (x y) (if (= (remainder n x) 0) (+ x y) y))
    0 1 (- n 1) id 1+))

(define (done? n)
  (= (- (sum-divisors n) n) 2))

(define (expand-interval a b)
  (accumulate (lambda (x y) (if (done? x) (cons x y) y)) '() (+ a 1) (- b 1) id 1+))

(define (closest-done? l el)
  (foldr (lambda (x y) (if (< (abs (- el x)) (abs (- el y)) x y) (car l) (cdr l))) (car l) (cdr l)))

(define (sum-almost-done a b)
  (let
      ((interval (expand-interval a b)))
    (accumulate (lambda (x y)
                  (if (and
                       (< (abs (- x (closest-done? interval x))) (abs (- x a)))
                       (< (abs (- x (closest-done? interval x))) (abs (- x b))))
                      (+ x y)
                      y))
                0 a b id 1+)))


;; 2 задaча

(define (run-machine l)
  (define (transform-stack stack f n)
    (if (or (null? stack) (null? (cdr stack)) (symbol? (car stack)) (symbol? (cadr stack)) (= n 0))
      stack
      (transform-stack (cons (f (car stack) (cadr stack)) (cddr stack)) f (- n 1))))

  (define (map-numbers f l)
    (cond
      ((null? l) '())
      ((number? (car l)) (cons (f (car l)) (map-numbers f (cdr l))))
      (else (cons (car l) (map-numbers f (cdr l))))))
  
  (define (helper stack ll)
    (cond
      ((null? ll) stack)
      ((or (number? (car ll)) (symbol? (car ll))) (helper (cons (car ll) stack) (cdr ll)))
      ((procedure? (car ll)) (helper (map-numbers (car ll) stack) (cdr ll)))
      ((pair? (car ll)) (helper (transform-stack  stack (caar ll) (cdar ll)) (cdr ll)))
      (else (helper stack (cdr ll)))))
  (helper '() l))
        


;; 3 задача

(define (majors? l1 l2)
  (cond
    ((and (null? l1) (null? l2)) #t)
    ((or (null? l1) (null? l2)) #f)
    ((> (car l1) (car l2)) #f)
    (else (majors? (cdr l1) (cdr l2)))))

(define (take n l)
  (cond
    ((< (length l) n) '())
    ((= 0 n) '())
    (else (cons (car l) (take (- n 1) (cdr l))))))

(define (sublists l n)
  (if (null? l)
      '()
      (cons (take n l) (sublists (cdr l) n))))

(define (majors-in-list? l1 l2)
  (foldr (lambda (x y) (or (majors? l1 x) y)) #f (sublists l2 (length l1))))

(define (is-major? l)
  (if (or (null? l) (null? (cdr l)))
    #t
    (and (majors-in-list? (car l) (cadr l)) (is-major? (cdr l)))))