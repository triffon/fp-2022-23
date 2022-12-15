#lang racket

;; а). Казваме, че една функция π е n-пермутация, ако тя е биекция на интервала от естествени числа [0; n-1] в себе си.
;; Да се реализира функция isNPerm, която приема като параметри естествено число n
;; и едноместна числова функция f и проверява дали f е n-пермутация

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

(define (from-to start end)
  (if (> start end)
      '()
      (cons start (from-to (+ start 1) end))))

(define (isNPerm n func)
  (let*
    ((interval (from-to 0 (- n 1)))
     (is-injection (all? (lambda (x) (member (func x) interval)) interval))
     (is-surjection (all? (lambda (x) (any? (lambda (y) (= (func y) x)) interval)) interval)))
     
    (and is-injection is-surjection)))

;; (isNPerm 3 (lambda (x) (remainder (- 3 x) 3))) ;; => #t
;; (isNPerm 10 (lambda (x) (quotient x 2))) ;; => #f
;; (isNPerm 10 (lambda (x) (remainder (+ x 2) 10))) ;; => #t

;; б). Цикъл в пермутацията π наричаме редица от числа x1, … xk, така че π(xi) = xi+1 за i < k и π(xk) = x1.
;; Да се реализира функция maxCycle, която по дадено число n и n-пермутация π
;; намира максимален по дължина цикъл в π

;; намира максималния елемент в списък
;; (maximum-by cdr '((1 . 2) (3 . 1))) ;; => '(1 . 2)
(define (maximum-by func lst)
  (foldr
    (lambda (x result) (if (> (func x) (func result)) x result))
    (car lst)
    (cdr lst)))

; (define (maxCycle n func)
;   ;; констурира цикъл, започващ от x
;   ;; пример: (generate-cycle (lambda (x) (remainder (- 3 x) 3)) 1) ;; => '(1 2)
;   (define (generate-cycle x) (helper func x x))

;   (define (helper func xi x1)
;     (if (= (func xi x1))
;         (list xi)
;         (cons xi (helper func (func xi) x1))))

;   (maximum-by length (map generate-cycle (from-to 0 (- n 1)))))

(define (maxCycle n func)
  ;; констурира цикъл, започващ от x
  ;; пример: (generate-cycle (lambda (x) (remainder (- 3 x) 3)) 1) ;; => '(1 2)
  (define (generate-cycle x) (helper func x x))

  (define (helper func xi x1)
    (if (= (func xi) x1)
        (list xi)
        (cons xi (helper func (func xi) x1))))

 (maximum-by length (map generate-cycle (from-to 0 (- n 1)))))

(maxCycle 3  (lambda (x) (remainder (- 3 x) 3))) ;; => [1, 2]
(maxCycle 10 (lambda (x) (remainder (+ x 2) 10))) ;; => [0, 2, 4, 6, 8]
(maxCycle 10 (lambda (x) (remainder (+ x 3) 10))) ;; => [0, 3, 6, 9, 2, 5, 8, 1, 4, 7]