#lang racket

;; а). “Пълзяща средна стойност” (“moving average”) на редица от дробни числа S с прозорец n наричаме
;; редицата от средни аритметични на n последователни елемента от S, където n е предварително фиксирано цяло число.
;; Да се реализира функция movingAverage, която по даден безкраен поток от дробни числа S и естествено число n ≥ 2
;; връща безкрайния поток от пълзящата средна стойност на S с прозорец n

;; примитиви за работа с потоци
(define the-empty-stream '())
(define empty-stream? null?)

(define-syntax cons-stream
  (syntax-rules () ((cons-stream h t) (cons h (delay t)))))

(define head car)
(define (tail s) (force (cdr s)))


;; решение
(define (stream-take n stream)
  (if (or (= n 0) (empty-stream? stream))
      '()
      (cons (head stream) (stream-take (- n 1) (tail stream)))))

(define (sum lst) (foldr + 0 lst))
  
(define (average lst)
  (/ (sum lst) (length lst)))

(define (movingAverage stream n)
  (cons-stream (average (stream-take n stream)) (movingAverage (tail stream) n)))

;; този поток от примера не знам как е бил генериран,
;; затова по-долу тествам с безкрайния поток от естествени числа
;; (movingAverage (1076 1356 1918 6252 6766 5525) 3)
;; => (1450.0 3175.3 4978.6 6181.0 …)

(define (from n)
  (cons-stream n (from (+ n 1))))

(define nats (from 0))
;; (stream-take 4 (movingAverage nats 2)) ;; => '(1/2 3/2 5/2 7/2)

;; б). Да се реализира функция allAverages, която по даден безкраен поток от дробни числа S
;; връща безкраен поток от безкрайни потоци A2, A3, A4,... където An представлява
;; пълзящата средна стойност на S с прозорец n

;; дадена наготово
(define (map-stream f . streams)
  (cons-stream (apply f (map head streams))
               (apply map-stream f (map tail streams))))

(define (allAverages stream)
  (map-stream (lambda (n) (movingAverage stream n)) (from 2)))

;; този поток от примера не знам как е бил генериран, 
;; затова по-долу тествам с безкрайния поток от естествени числа
;; (allAverages (1076 1356 1918 6252 6766 5525 ...)
;; => ((1216.0 1637.0 4085.0 6509.0 ...) (1450.0 3175.3 4978.6 6181.0 ...) (2650.5 4073.0 5115.25 ...) ...)

;; (stream-take 3 (map-stream (lambda (stream) (stream-take 4 stream)) (allAverages nats)))
;; => '((1/2 3/2 5/2 7/2) (1 2 3 4) (3/2 5/2 7/2 9/2))