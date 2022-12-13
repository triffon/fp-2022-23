#lang racket

;; a). Да се напише функция grow t x, която по дадено двоично дърво от числа t конструира ново,
;; в което към всяко листо на t добавя по две нови листа със зададена стойност x

(define empty-tree '())
(define empty-tree? null?)

(define (make-tree root left right)
  (list root left right))

(define (make-leaf element)
  (make-tree element empty-tree empty-tree))

(define root car)
(define left-tree cadr)
(define right-tree caddr)

;; решение
(define (leaf? tree)
  (and
    (empty-tree? (left-tree tree))
    (empty-tree? (right-tree tree))))

(define (grow tree x)
  (cond
    ((empty-tree? tree) empty-tree)
    ((leaf? tree) (make-tree (root tree) (make-leaf x) (make-leaf x)))
    (else
      (make-tree
        (root tree)
        (grow (left-tree tree) x)
        (grow (right-tree tree) x)))))

;; (define test-tree
;;   '(1 (2 () ())
;;       (3 (4 () ())
;;          (5 () ()))))

;; (grow test-tree 6)
;; '(1
;;    (2 (6 () ()) (6 () ()))
;;    (3
;;      (4 (6 () ()) (6 () ()))
;;      (5 (6 () ()) (6 () ()))))

;; (grow empty-tree 6) ;; => '()

;; b). Двоично дърво наричаме “пълно”, ако има 2^n елемента на ниво n.
;; Да се напише функция growingTrees, която генерира безкраен поток от пълни дървета
;; с височини съответно 1, 2, 3,..., като всички елементи на ниво n са със стойност n

;; примитиви за работа с потоци
(define the-empty-stream '())
(define empty-stream? null?)

(define-syntax cons-stream
  (syntax-rules () ((cons-stream h t) (cons h (delay t)))))

(define head car)
(define (tail s) (force (cdr s)))

;; решение
(define (generate-next-tree prev-tree i)
  (let ((new-tree (grow prev-tree i)))
    (cons-stream new-tree (generate-next-tree new-tree (+ i 1)))))

(define growingTrees (cons-stream (make-leaf 0) (generate-next-tree (make-leaf 0) 1)))

;; дефинирана само за да тестваме горната имплементация
;; (define (stream-take n stream)
;;   (if (or (< n 1) (empty-stream? stream))
;;       the-empty-stream
;;       (cons (head stream) (stream-take (- n 1) (tail stream)))))

;; (stream-take 3 growingTrees)

;; '((0 () ())
;;   (0
;;     (1 () ())
;;     (1 () ()))
;;   (0
;;     (1
;;       (2 () ())
;;       (2 () ()))
;;     (1
;;       (2 () ())
;;       (2 () ()))))