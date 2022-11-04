#lang racket

(define l1 '(3 4 5))

(define (length L)
  (if (null? L)
      0
      (+ 1
         (length (cdr L)))))

(define (sum L)
  (if (null? L)
      0
      (let ((head (car L))
            (tail (cdr L)))
        (+ head
           (sum tail)))))

(define (member?2 x l)
  (and (not (null? l))
       (or (equal? (car l) x)
           (member?2 x (cdr l)))))

(define (member? x l)
  (if (null? l)
      #f
      (if (equal? (car l) x)
          #t
          (member? x (cdr l)))))


(define (from-to a b)
  (if (> a b)
      '()
      (cons a
            (from-to (+ a 1) b))))

(define (map f l)
  (if (null? l)
      l
      (cons (f (car l))
            (map f (cdr l)))))

(define (filter pred? l)
  (if (null? l)
      l
      (if (pred? (car l))
          (cons (car l)
                (filter pred? (cdr l)))
          (filter pred? (cdr l)))))

(define (partition pred? l)
  (if (null? l)
      '(() ())
      (let* ((rec (partition pred? (cdr l)))
             (list-of-true-things (car rec))
             (list-of-false-things (cadr rec))
             (x (car l)))
        (if (pred? x)
            (list (cons x list-of-true-things)
                  list-of-false-things)
            (list list-of-true-things
                  (cons x list-of-false-things))))))

(define (scp l)
  (define (cube x) (* x x x))
  (sum
   (map cube
        (filter prime? l))))

(define (all? p? l)
  (if (null? l)
      #t
      (and (p? (car l))
           (all? p? (cdr l)))))

(define (any? p? l)
  (if (null? l)
      #f
      (or (p? (car l))
          (any? p? (cdr l)))))

