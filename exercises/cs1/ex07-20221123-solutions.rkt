#lang racket
(define head car)
(define tail cdr)

(define (flip f)
  (lambda (x y) (f y x)))
(define (foldl op nv l)
  (if (null? l) nv
      (foldl op (op nv (head l)) (tail l))))
(define (compose f g)
  (lambda (x) (f (g x))))

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

; Зад.5
(define (find-longest-path t)
  (define (max-len x y)
    (if (> (length x) (length y)) x y))
  (if (empty-tree? t) '()
      (cons (root-tree t)
            (max-len (find-longest-path (left-tree t))
                     (find-longest-path (right-tree t))))))

; Зад.7
(define (tree->list t)
  (if (empty-tree? t) '()
      (append (tree->list (left-tree t))
              (list (root-tree t))
              (tree->list (right-tree t)))))

; Зад.8
(define (bst-insert val t)
  (cond [(empty-tree? t) (make-leaf val)]
        [(< val (root-tree t)) (make-tree (root-tree t)
                                          (bst-insert val (left-tree t))
                                          (right-tree t))]
        [else (make-tree (root-tree t)
                         (left-tree t)
                         (bst-insert val (right-tree t)))]))

; Зад.9
(define (list->bst lst)
  ;(foldr bst-insert empty-tree lst)
  (foldl (flip bst-insert) empty-tree lst))

(define tree-sort (compose tree->list list->bst))

; Зад.10
(define (valid-bst? t)
  ; Проверява дали всички стойности в дървото t са в
  ; интервала [a;b], където краищата на интервала могат
  ; да са безкрайности (обозн. с #f вместо число)
  (define (helper t a b)
    (or (empty-tree? t)
        (let [(x (root-tree t))]
          (and (or (not a) (>= x a))
               (or (not b) (<= x b))
               (helper (left-tree t) a x)
               (helper (right-tree t) x b)))))
  (helper t #f #f))
