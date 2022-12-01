#lang racket
; Помощни дефиниции за работа с двоични дървета
(define empty-tree '())
(define (make-tree root left right) (list root left right))      ; не искаме просто (define make-tree list) - защо?
(define (make-leaf root) (make-tree root empty-tree empty-tree)) ; за удобство
(define root-tree car)
(define left-tree cadr)
(define right-tree caddr)
(define empty-tree? null?)

(define test-tree
  (make-tree 10
             (make-tree 7
                        (make-leaf 10)
                        (make-leaf 2))
             (make-tree 3
                        (make-tree 4
                                   (make-leaf 1)
                                   (make-leaf 2))
                        empty-tree)))

; Зад.13 от Упр.6
(define (avg t)
  (define (min* . xs) (apply min (filter number? xs)))
  (define (max* . xs) (apply max (filter number? xs)))
  (define (helper t)
    (if (empty-tree? t)
        (list '() #f #f)
        (let* [(x (root-tree t))
               (l (helper (left-tree t)))
               (r (helper (right-tree t)))
               (new-min (min* x (cadr l) (cadr r)))
               (new-max (max* x (caddr l) (caddr r)))
               (new-root (/ (+ new-min new-max) 2))]
          (list (make-tree new-root (car l) (car r))
                new-min
                new-max))))
  (car (helper t)))

; Специални форми - приличат на функции, но се оценяват
; по различен начин от стандартното стриктно оценяване:
; if, and, or, define, lambda, cond, case,
; let, let*, quote, define-syntax, delay
; Заб.: force не е специална форма - няма нужда да бъде :)

; Списъкът е наредена двойка от стойност и друг списък
; Потокът е наредена двойка от стойност и обещание за друг поток (!)

; Проблем - delay е специална форма, но cons-stream
; не е и за нея важи стриктно оценяване
;(define (cons-stream h t)
;  (cons h (delay t)))
; Решение - дефинираме cons-stream като специална форма
(define-syntax cons-stream
  (syntax-rules ()
    ((cons-stream h t) (cons h (delay t)))))
(define empty-stream #f)
(define (null-stream? s) (not s)) ; само #f е #f
(define (head-stream s) (car s))
(define (tail-stream s) (force (cdr s)))

; Връща поток на ест.числа, започвайки от n
(define (nats-from n)
  (cons-stream n (nats-from (+ n 1))))
; Горното не се оценява стриктно, а се разпъва до:
; (cons n (delay (nats-from (+ n 1)))

; Аналогични функции на тези за работа със списъци
(define (map-stream f s)
  (if (null-stream? s) empty-stream
      (cons-stream (f (head-stream s))
                   (map-stream f (tail-stream s)))))
; взима поток => връща списък
(define (take n s)
  (if (or (= n 0) (null-stream? s))
      '()
      (cons (head-stream s)
            (take (- n 1) (tail-stream s)))))
; Взима поток => връща число
(define (length-stream s)
  (if (null-stream? s) 0
      (+ 1 (length-stream (tail-stream s)))))

; Мързеливото оценяване позволява рекурсивно
; дефинирани стойности (не само функции)
(define (++ x) (+ x 1))
(define nats
  (cons-stream 0
               (map-stream ++ nats)))