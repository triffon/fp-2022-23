#lang racket

;; Разглеждаме ациклични графи с представяне по ваш избор.
;; “Семейство” наричаме множество от възли F такова, че за всеки възел u ∈ F е вярно, че
;; - във F са всичките му деца и нито един негов родител или
;; - всичките му родители и нито едно негово дете

;; а) Да се реализира функция isFamily, която проверява дали
;; дадено множество от възли е семейство в даден граф;

(define (children vertex graph)
  (cdr (assoc vertex graph)))

(define (parents vertex graph)
  (foldr
    (lambda (kv result)
      (if (member vertex (cdr kv)) (cons (car kv) result) result))
    '()
    graph))

;; функция, която приема предикат и списък и проверява дали
;; всички елементи на списъка изпълняват зададеното условие
;; пример: (all? odd? '(1 2 3)) ;; => #f
;; пример: (all? odd? '(1 3 5)) ;; => #t
(define (all? pred? lst)
  (or
    (null? lst)
    (and (pred? (car lst)) (all? pred? (cdr lst)))))

;; функция, която приема предикат и списък и проверява дали
;; някой от елементи на списъка изпълнява зададеното условие
;; пример: (any? even? '(1 2 3)) ;; => #t
;; пример: (any? even? '(1 3 5)) ;; => #f
(define (any? pred? lst)
  (and
    (not (null? lst))
    (or (pred? (car lst)) (any? pred? (cdr lst)))))

;; "във F са всичките му деца и нито един негов родител"
(define (all-children-no-parents vertex graph vertices)
  (and
    (all? (lambda (x) (member x vertices)) (children vertex graph))
    (not (any? (lambda (x) (member x vertices)) (parents vertex graph)))))

;; "във F са всичките му родители и нито едно негово дете"
(define (all-parents-no-children vertex graph vertices)
  (and
    (all? (lambda (x) (member x vertices)) (parents vertex graph))
    (not (any? (lambda (x) (member x vertices)) (children vertex graph)))))

(define (isFamily? graph vertices)
  (all?
   (lambda (vertex)
     (or
      (all-children-no-parents vertex graph vertices)
      (all-parents-no-children vertex graph vertices)))
   vertices))

;; “Семейство” наричаме множество от възли F такова, че за всеки възел u ∈ F е вярно, че
;; - във F са всичките му деца и нито един негов родител или
;; - всичките му родители и нито едно негово дете

;; б) Да се реализира функция minIncluding, която по даден
;; възел u намира минимално множество от възли, което е семейство и
;; съдържа u (ако такова семейство има).

;; виж inf2/06/06-subsets.rkt
(define (subsets lst)
  (define (add-to-front element ll)
    (map (lambda (set) (cons element set)) ll))

  (if (null? lst)
    '(())
    (append
      (add-to-front (car lst) (subsets (cdr lst)))
      (subsets (cdr lst)))))

;; намира минималния елемент в списък
;; (minimum-by cdr '((1 . 2) (3 . 1))) ;; => '(3 . 1)
(define (minimum-by func lst)
  (foldr
    (lambda (x result) (if (< (func x) (func result)) x result))
    (car lst)
    (cdr lst)))

(define (minIncluding graph vertex)
  (define vertices (map car graph))
  (define potential-families
    (filter (lambda (subset) (member vertex subset)) (subsets vertices)))
  (define families
    (filter (lambda (vertices) (isFamily? graph vertices)) potential-families))
    
  (if (null? families)
      '()
      (minimum-by length families)))
