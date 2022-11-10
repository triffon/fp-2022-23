#lang racket

(define (my-foldl op nv l)
  (if (null? l) nv (my-foldl op (op (car l) nv) (cdr l))))

(define (my-foldr op nv l)
  (if (null? l) nv (op (car l) (my-foldr op nv (cdr l)))))

(define (my-map f l)
  (my-foldr (lambda (x y) (cons (f x) y)) '() l))

(define (my-filter p l)
  (my-foldr (lambda (x y) (if (p x) (cons x y) y)) '() l))

(define (remove-duplicates l)
  (my-foldr (lambda (x y) (if (member x y) y (cons x y))) '() l))

(define (my-reverse l)
  (foldl cons '() l))

(define (all? p l)
  (foldr (lambda (x y) (and (p x) y)) #t l))

(define (any? p l)
  (foldr (lambda (x y) (or (p x) y)) #f l))

(define (union l1 l2)
  (remove-duplicates (append l1 l2)))

(define (intersection l1 l2)
  (my-filter (lambda (el) (member el l2)) l1))

(define (insert val l)
  (cond
    ((null? l) (list val))
    ((< val (car l)) (cons val l))
    (else (cons (car l) (insert val (cdr l))))))

(define (insertion-sort l)
  (foldr insert '() l))

(define (partition p l)
  (append (list (my-filter p l))
          (list (my-filter (lambda (x) (not (p x))) l))))

(define (my-flatten l)
  (foldr (lambda (el res)
           (if (list? el)
               (append (my-flatten el) res)
               (cons el res)))
         '() l))

(define (deep-map f l)
  (foldr (lambda (x y)
           (if (list? x)
               (cons (deep-map f x) y)
               (cons (f x) y)))
         '() l))

(define (my-compose f g)
  (lambda (x) (f (g x))))

(define (compose . fns)
  (foldr my-compose (lambda (x) x) fns))

(define (concate . lists)
  (apply append lists))