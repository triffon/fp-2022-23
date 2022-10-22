#lang racket

(define (identity x) x)

(define (repeat f n)
  (if (= n 0)
      identity
      (lambda (x) (f ((repeat f (- n 1)) x)))))

;; ------------------------
;; алтернативно решение
;; от задача 04-compose.rkt
;; (define (compose f g)
;;   (lambda (x) (f (g x))))
;; 
;; (define (repeat func n)
;;   (if (= n 0)
;;     identity
;;     (compose func (repeat func (- n 1)))))

;; ------------------------
;; алтернативно решение
;; дадена наготово
;; (define (accumulate operation null-value start end term next)
;;   (if (> start end)
;;       null-value
;;       (operation
;;             (term start)
;;             (accumulate operation null-value (next start) end term next))))

;; (define (repeat f n)
;;   (accumulate
;;     compose
;;     identity
;;     1
;;     n
;;     (lambda (_) f)
;;     (lambda (i) (+ i 1))))

;; note: конвенция: когато сложим _ за име на параметър подсказваме,
;; че той няма да се ползва в тялото на функцията