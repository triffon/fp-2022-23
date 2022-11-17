#lang racket

;; дадена наготово
(define (accumulate op nv a b term next)
  (if (> a b) nv
          (op (term a) (accumulate op nv (next a) b term next))))

;; помощни функции, за да избегна повторение в кода по-долу
(define (identity x) x)
(define (next x) (+ x 1))

;; намира сумата от множителите на даденото число,
;; без да включва самото число 
;; (sum-divisors 6) = 1 + 2 + 3 = 6
(define (sum-divisors number)
  (accumulate
    (lambda (x y) (if (= 0 (remainder number x)) (+ x y) y))
    0
    1
    (- number 1)
    identity
    next))

(define (done? number) (= number (- (sum-divisors number) 2)))

;; -----------------------------------
(define (sum-almost-done a b)
  (define (filter-done a b)
    (accumulate (lambda (x y) (if (done? x) (cons x y) y)) '() a b identity next))

  ;; работи само за непразни списъци
  ;; намира разликата между числото number и в всеки
  ;; елемент от списъка;; връща най-малката разлика
  ;; не е нужно да се реализира с apply - може примерно
  ;; да използваме my-min от Упражнение 5
  (define (find-min-difference number lst)
    (apply min (map (lambda (x) (abs (- number x))) lst)))

  (define (closer-to-done? number a b)
    (define comparison-lst (append (list a b) (filter-done a b)))
    (define min-difference (find-min-difference number comparison-lst))

    (and
     (< min-difference (abs (- number a)))
     (< min-difference (abs (- number b)))))

  (accumulate + 0 a b (lambda (x) (if (closer-to-done? x a b) x 0)) next))
