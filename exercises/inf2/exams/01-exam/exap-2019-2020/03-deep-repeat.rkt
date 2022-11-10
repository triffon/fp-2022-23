#lang racket

;; “Ниво на влагане” на атом в дълбок списък наричаме броя пъти, който трябва да се приложи операцията car за достигане до атома.
;; Да се реализира функция deep-repeat, която в подаден дълбок списък заменя всеки атом на ниво на влагане n
;; с n негови повторения.

;; (deep-repeat '(1 (2 3) 4 (5 (6)))) ;; => (1 (2 2 3 3) 4 (5 5 (6 6 6)))

(define (atom? x)
  (and (not (null? x)) (not (pair? x))))

;; (repeat 1 5) ;; => '(1 1 1 1 1)
(define (repeat element n)
  (if (< n 1)
      '()
      (cons element (repeat element (- n 1)))))

(define (deep-repeat ll)
  (define (helper l level)
    (cond
      ((null? l) '())
      ((atom? (car l)) (append (repeat (car l) level) (helper (cdr l) level)))
      (else (cons (helper (car l) (+ level 1)) (helper (cdr l) level)))))
  
  (helper ll 1))