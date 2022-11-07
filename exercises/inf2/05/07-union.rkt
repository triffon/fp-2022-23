#lang racket

;; използвам append вместо cons, за да запазя реда 
;; на елементите; по условие не е нужно, спокойно
;; можем да използваме cons също (виж 08-intersections.rkt)
(define (union lst1 lst2)
  (cond
    ((null? lst2) lst1)
    ((member (car lst2) lst1) (union lst1 (cdr lst2)))
    (else (union (append lst1 (list (car lst2))) (cdr lst2)))))

;; използвам foldl вместо foldr, както и append, 
;; за да запазя реда на елементите; по условие
;; не е нужно, спокойно можем да използваме foldr
;; и/или cons също (виж 08-intersections.rkt)
(define (union-fold lst1 lst2)
  (foldl
    (lambda (element result)
      (if (member element result)
          result
          (append result (list element))))
    lst1
    lst2))

;; използвам вградената filter функция
(define (union-filter lst1 lst2)
  (append
    lst1
    (filter
      (lambda (x) (not (member x lst1)))
      lst2)))