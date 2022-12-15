#lang racket

; Задача 2.
; 1.
; (6 т.) Да се напише функция clone t x y, която по дадено двоично
; дърво  от  числа  t получава  ново  със  зададен  корен  x и  две
; поддървета,  получени  от  t чрез  увеличаване  на  всичките  му
; елементи със зададено число y.



(define t1
  '(1 (2 () ())
      (3 () ())))

(define t2
  '(1 (2 () ())
      (3 (6 () ()) (7 () (8 () ())))))

(define root-t car)
(define left-t cadr)
(define right-t caddr)

(define make-tree list)

(define (map-tree f t)
  (if (null? t)
      t
      (let ((root (root-t t))
            (left (left-t t))
            (right (right-t t)))
        (list (f root)
              (map-tree f left)
              (map-tree f right)))))

(define (clone t x y)
  (define (increase root)
    (+ root y))

  (if (null? t)
      (list x '() '())
      (let ((root (root-t t))
            (left (left-t t))
            (right (right-t t)))
        (list x
              (map-tree increase left)
              (map-tree increase right)))))

;(clone t1 999 88)
;(clone t2 -1 -77)

(define-syntax cons-stream
  (syntax-rules ()
    ((cons-stream h t) (cons h (delay t)))))

(define head car)

(define (tail s) (force (cdr s)))

(define (map-stream f . streams)
  (cons-stream (apply            f (map head streams))
               (apply map-stream f (map tail streams))))

(define (filter-stream p? s)
  (if (p? (head s))
      (cons-stream (head s) (filter-stream p? (tail s)))
                            (filter-stream p? (tail s))))
; 2.
; (6 т.) Двоично дърво наричаме “пълно”, ако има 2^n елемента на ниво
; n. Да се напише функция  cloningTrees, която генерира безкраен
; поток от пълни дървета с височини съответно 1, 2, 3,..., като всички
; елементи на ниво n са със стойност n.

(define (generate-tree size)
  (define (generate-level level)
    (if (> level size)
        '()
        (make-tree level
               (generate-level (+ level 1))
               (generate-level (+ level 1)))))
  (generate-level 0)
  )
;(generate-tree 4)

(define (from n)
  (cons-stream n (from (+ n 1)))
  )
(define (take n stream)
  (if (= n 0)
      '()
      (cons (head stream)
            (take (- n 1) (tail stream)))))

(define cloningTrees
  (map-stream (lambda (i)
                (generate-tree i))
              (from 1)))

(take 10 cloningTrees)
