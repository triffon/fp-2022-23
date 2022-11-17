#lang racket
(define head car)
(define tail cdr)

(define (foldl op nv l)
  (if (null? l) nv
      (foldl op (op nv (car l)) (cdr l))))
(define (any? p? lst)
  (and (not (null? lst))
       (or (p? (head lst))
           (any? p? (tail lst)))))
(define (all? p? lst)
  (not (any? (lambda (i) (not (p? i))) lst)))

(define (divides? n)
  (lambda (d) (zero? (remainder n d))))

(define (prime? n)
  (and (> n 1)
       (not (any? (divides? n) (range 2 n)))))
; Контролно, зад.1
(define (trim n)
  (let [(divs (filter (divides? n) (filter prime? (range 2 n))))]
    (foldl / n divs)))

(define (accumulate-i op nv a b term next) 
  (if (> a b) nv 
      (accumulate-i op (op nv (term a)) 
                    (next a) b term next)))
(define (id x) x)
(define (++ x) (+ x 1))

; Втори вариант с accumulate, без генериране на списък
(define (trim* n)
  (define (op res el)
    (if (and (prime? el) ((divides? n) el))
        (/ res el)
        res))
  (accumulate-i op n
                2 (sqrt n)
                id ++))

; Дали x и y нямат общи прости делители
; -> (all? (lambda (i) (i не е просто и не е общ делител на x и y))
;          1 (max (sqrt x) (sqrt y))

; Контролно, зад.3, скелет на решение - с "предаване" напред на избора на операция
;(define (selectiveMerge f lst1 lst2)
;  (define (helper code lst1 lst2)
;    (if (null? lst) '()
;        (let* [(next ...)
;               (nextHead (if (= next 1) ... ...))]
;          (cons nextHead
;                (helper next (tail lst1) (tail lst2))))))
;  (helper 1 lst1 lst2))
;    

; Контролно, зад.4 - основна подзадача
; O(nm) време
(define (commons lst1 lst2)
  (filter (lambda (x) (member x lst2)) lst1))
(commons '(1 3 5 7 8 20) '(1 3 7 28))
; Оптимално решение: O(n+m), или големината на входа
(define (set-intersection lst1 lst2)
  (cond [(or (null? lst1) (null? lst2)) '()]
        [(< (head lst1) (head lst2)) (set-intersection (tail lst1) lst2)]
        [(> (head lst1) (head lst2)) (set-intersection lst1 (tail lst2))]
        [else (cons (head lst1) (set-intersection (tail lst1) (tail lst2)))]))
(set-intersection '(1 3 5 7 8 20) '(1 3 7 28))

; Зад.1
(define (divide lst1 lst2)
  (map (lambda (x y) (if (zero? y) #f (/ x y))) lst1 lst2))
(define (allEqual? lst)
  (all? (lambda (x) (equal? x (head lst)))
        (tail lst)))
(define (dependent? lst1 lst2)
  (allEqual? (divide lst1 lst2)))

; Зад.1.5
; Тази задача е силно аналогична на uniques :)
(define (pseudorank m)
  (length (foldr (lambda (el res)
                   (if (any? (lambda (row) (dependent? el row)) res)
                       res
                       (cons el res)))
                 '()
                 m)))

; Зад.2
(define (gauss row1 row2)
  (let [(coeff (- (/ (head row2) (head row1))))]
    (map (lambda (x y) (+ (* coeff x) y))
              row1
              row2)))
(define (dependent?* lst1 lst2)
  (all? zero? (gauss lst1 lst2))) ; :)

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

; Зад.3
(define (height t)
  (if (empty-tree? t)
      0
      (+ 1 (max (height (left-tree t))
                (height (right-tree t))))))
; Зад.4
(define (get-level n t)
  (cond [(empty-tree? t) '()]
        [(= n 0) (list (root-tree t))]
        [else (append (get-level (- n 1) (left-tree t))
                      (get-level (- n 1) (right-tree t)))]))
