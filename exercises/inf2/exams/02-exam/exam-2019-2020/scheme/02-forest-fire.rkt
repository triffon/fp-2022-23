#lang racket

;; Да се реализира функция forestFire, която генерира безкраен поток 
;; от редицата от цели положителни числа, дефинирана чрез следната формула:
;; an = min { x | ∄k (1 ≤ k ≤ n/2) и (an-2k, an-k, x e аритметична прогресия)}
;; Пример: forestFire ;; => '(1 1 2 1 1 2 2 4 4 1 1 2 1 1...)

;; примитиви за работа с потоци
(define the-empty-stream '())
(define empty-stream? null?)

(define-syntax cons-stream
  (syntax-rules () ((cons-stream h t) (cons h (delay t)))))

(define head car)
(define (tail s) (force (cdr s)))

;; даденa наготово
(define (map-stream f . streams)
  (cons-stream (apply f (map head streams))
               (apply map-stream f (map tail streams))))

;; Решение от Анди
;; an-2k, an-k, x e аритметична прогресия <=> x == an-k + (аn-k - an-2k) == 2*an-k - an-2k

;; генерира безкраен поток от числа с начало n
;; (from 0) ;; => '(0 1 2 3...)
(define (from n)
  (cons-stream n (from (+ n 1))))

;; генерира списък с числата в интервала [start, end]
;; (from-to 1 5) ;; => '(1 2 3 4 5)
(define (from-to start end)
  (if (> start end)
      '()
      (cons start (from-to (+ start 1) end))))

(define (f n)
  (define (find-xs n)
    (map
      (lambda (k) (- (* 2 (f (- n k))) (f (- n (* 2 k)))))
      (from-to 1 (quotient n 2))))

  (define (find-min-not-in lst)
    (define (helper i)
      (if (not (member i lst))
          i
          (helper (+ i 1))))
    
    (helper 1))

  (if (= n 0)
      1
      (find-min-not-in (find-xs n))))

(define forestFire (map-stream f (from 0)))

;; дефинирана само за да тестваме решението
;; (define (stream-take n stream)
;;   (if (or (= n 0) (empty-stream? stream))
;;       '()
;;       (cons (head stream) (stream-take (- n 1) (tail stream)))))

;; (stream-take 14 forestFire) ;; => '(1 1 2 1 1 2 2 4 4 1 1 2 1 1)