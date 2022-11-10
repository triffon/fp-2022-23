#lang racket

;; Нека е даден списък l от числа и двуместна операция над числа ⊕.
;; Функцията f наричаме “ендоморфизъм над l”, ако f трансформира l в себе си, запазвайки операцията ⊕, т.е.
;; ∀x∈l f(x)∈l и
;; ∀x,y∈l f(x) ⊕ f(y) = f(x ⊕ y).
;; Да се реализира функция is-em?, която проверява дали f е ендоморфизъм.

;; ∀x∈l f(x)∈l
(define (maps-into-itself? list function)
  (foldl
      (lambda (element result)
          (and
              (member (function element) list)
              result))
      #t
      list))

;; помощна функция - декартово произведелениe за да намеря всички двойки от ∀x ∀y
;; (cartesian-product '(1 2) '(3 4)) => '((1 . 3) (1 . 4) (2 . 3) (2 . 4))
(define (cartesian-product lst1 lst2)
  (if (null? lst1)
      '()
      (append
          (map
              (lambda (element)
                  (cons (car lst1) element))
              lst2)
          (cartesian-product (cdr lst1) lst2))))

;; ∀x,y∈l f(x) ⊕ f(y) = f(x ⊕ y)
(define (closed-under-operation? lst operation function)
  (foldl
      (lambda (element result)
          (and
              (equal?
                  (operation (function (car element)) (function (cdr element)))
                  (function (operation (car element) (cdr element))))
              result))
      #t
      (cartesian-product lst lst)))

(define (is-endomorphism? lst operation function)
  (and
      (maps-into-itself? lst function)
      (closed-under-operation? lst operation function)))

;; (is-endomorphism? '(0 1 4 6) + (lambda (x) (remainder x 3))) ;; => #t