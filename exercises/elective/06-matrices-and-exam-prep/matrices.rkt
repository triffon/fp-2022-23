#lang racket

(define (accumulate op nv a b term next)
  (if (> a b)
      nv
      (op (term a) (accumulate op nv (next a) b term next))))


(define (dimensions m) (cons (length (car m)) (length m)))

(define (nth-row m n) (list-ref m n))

(define (nth-column m n) (map (lambda (row) (list-ref row n)) m))

(define (main-diagonal m)
  (define (helper i)
    (if (= (- (length m) i) 0)
        '()
        (cons (list-ref (list-ref m i) i) (helper (+ i 1)))))
  (helper 0))

(define (main-diagonal2 m)
  (if (null? m)
      '()
      (cons (list-ref (list-ref m 0) 0) (main-diagonal2 (map cdr (cdr m))))))

(define (second-diagonal m)
  (define (helper i)
    (if (< i 0)
        '()
        (cons (list-ref
               (list-ref m
                         (- (length m) i 1))i)
              (helper (- i 1)))))
  (helper (- (length m) 1)))

(define (remove l i)
  (if (= i 0)
      (cdr l)
      (cons (car l)
            (remove (cdr l) (- i 1)))))

(define (skip-nth-row m n)
  (if (= n 0) (cdr m) (cons (car m) (skip-nth-row (cdr m) (- n 1)))))

(define (skip-nth-column m n)
  (map (lambda (row) (remove row n)) m))

(define (transpose m)
  (define (helper index)
    (if (= index (length (car m)))
        '()
        (cons (nth-column m index) (helper (+ index 1)))))
  (helper 0))

(define (transpose2 m)
  (accumulate
   (lambda (index res) (cons (nth-column m index) res))
   '()
   0
   (- (length (car m)) 1)
   (lambda (x) x)
   (lambda (x) (+ 1 x))))

(define (sc-multiply m n)
  (map (lambda (row) (map (lambda (x) (* x n)) row)) m))