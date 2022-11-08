#lang racket

(define (push-back x l)
  (if (null? l)
      (list x)
      (cons (car l)
            (push-back x (cdr l)))))

(define (explode-digits n)
  (if (< n 10)
      (list n)
      (push-back (remainder n 10)
                 (explode-digits (quotient n 10)))))

(explode-digits 123456788976)


(define (foldr op nv l)
  (if (null? l)
      nv
      (op (car l)
          (foldr op nv (cdr l)))))

(define (foldr1 op l)
  (foldr op (car l) (cdr l)))



(define (map* f l)
  (foldr (lambda (x rec)
           (cons (f x)
                 rec))
         '()
         l))

(define (map** f l)
  (foldl (lambda (acc x)
           (cons (f x)
                 acc))
         '()
         l))




(define (atom? x)
  (and (not (null? x))
       (not (pair? x))))

;### Задача 12
; Намира броя атоми в дълбокия списък dl.
(define (count-atoms dl)
  (cond ((null? dl) 0)
        ((null? (car dl)) 0)
        ((atom? (car dl))
         (+ 1 (count-atoms (cdr dl))))
        (else ; (car dl) е списък
         (+ (count-atoms (car dl))
            (count-atoms (cdr dl))))))

         

;### Задача 13
; Списък от атомите в дълбокия списък dl.
(define (flatten dl)
  (cond ((null? dl) '())
        ((atom? dl) (list dl))
        (else ; dl е списък
         (append (flatten (car dl))
                 (flatten (cdr dl))))))







 