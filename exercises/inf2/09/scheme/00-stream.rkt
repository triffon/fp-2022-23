#lang racket

;; ще използваме тези функции в други файлове
(provide
  the-empty-stream
  empty-stream?
  cons-stream
  head
  tail
  stream-range
  to-list
  stream
  nats
  stream-take)

;; примитиви за работа с потоци
(define the-empty-stream '())
(define empty-stream? null?)

;; дефиниция на специална форма
(define-syntax cons-stream
  (syntax-rules () ((cons-stream h t) (cons h (delay t)))))

(define head car)
(define (tail s) (force (cdr s)))

(define (stream-range a b)
  (if (> a b)
      the-empty-stream
      (cons-stream a (stream-range (+ a 1) b))))

(define (to-list stream)
  (if (empty-stream? stream)
      '()
      (cons (head stream) (to-list (tail stream)))))

(define (from n)
  (cons-stream n (from (+ n 1))))

(define stream (stream-range 1 5))

(define nats (from 0))

(define (stream-take n stream)
  (if (or (< n 1) (empty-stream? stream))
      the-empty-stream
      (cons (head stream) (stream-take (- n 1) (tail stream)))))
