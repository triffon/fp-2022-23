#lang racket

;; един списък е подсписък на друг, ако елементите на първия списък се срещат непосредствено
;; последователно във втория
;; пример: '(2 3 4) е подсписък на '(1 2 3 4 5)

;; връща списък от всички подсписъци на lst с дължина n
;; пример: (sublists-n '(1 2 3 4 5) 3) => '((1 2 3) (2 3 4) (3 4 5))
(define (sublists-n lst n)
  (if (< (length lst) n)
      '()
      (cons (take lst n) (sublists-n (cdr lst) n))))

;; един списък от числа a се мажорира от списъка b, ако двата списъка са с еднаква дължина n
;; и ai ≤ bi за всяко i ∈ [0; n)
;; пример: '(4 2 7) се мажорира от '(4 3 9)

;; връща дали lst1 се мажорира от lst2
;; пример: (is-majored? '(4 2 7) '(4 3 9)) => #t
;; пример: (is-majored? '(4 2 7) '(3 3 9)) => #f
(define (is-majored? lst1 lst2)
  (or
    (and (null? lst1) (null? lst2))
    (and
      (not (null? lst1))
      (not (null? lst2))
      (<= (car lst1) (car lst2))
      (is-majored? (cdr lst1) (cdr lst2)))))

;; връща дали lst се мажорира от някой от списъците в ll
;; пример (is-majored-by-one? '(4 2 7) '((2 5 4) (5 4 3) (4 3 9) (3 9 12))) => #t
;; пример (is-majored-by-one? '(4 2 7) '((2 5 4) (5 4 3) (3 3 9) (3 9 12))) => #f
(define (is-majored-by-one? lst ll)
  (and
    (not (null? ll))
    (or
      (is-majored? lst (car ll))
      (is-majored-by-one? lst (cdr ll)))))

;; Списък от списъци ll наричаме мажорен, ако е вярно, че li се мажорира от подсписък на li+1
;; за всеки два съседни списъка li и li+1 в ll
;; пример: '((1 3) (4 2 7) (2 5 4 3 9 12)), защото
;; '(1 3) се мажорира от '(2 7), което е подсписък на '(4 2 7), и
;; '(4 2 7) се мажорира от '(4 3 9), което е подсписък на '(2 5 4 3 9 12)

(define (is-major? ll)
  (or
    (null? ll)
    (null? (cdr ll))
    (and 
      (is-majored-by-one? (car ll) (sublists-n (cadr ll) (length (car ll))))
      (is-major? (cdr ll)))))

;; (is-major? '((1 3) (4 2 7) (2 5 4 3 9 12))) ;; => #t
;; (is-major? '((1 3) (4 2 7) (2 5 3 3 9 12))) ;; => #f

;; ----------------------------------------------
;; Бонус: Да се реализира функция find-longest-major, която намира най-дългия мажорен
;; подсписък на даден списък от списъци от числа
;; пример: (find-longest-major '((2 3) (1 3) (4 2 7) (2 5 4 3 9 12) (2 5 4 3 9 11))) =>
;; '((1 3) (4 2 7) (2 5 4 3 9 12))

;; намира всички подсписъци на списъка lst
;; пример: (sublists '(1 2 3)) ;; => '((1) (2) (3) (1 2) (2 3) (1 2 3))
(define (sublists lst)
  (define (helper lst n result)
    (if (or (null? lst) (< n 1))
        result
        (helper lst (- n 1) (append (sublists-n lst n) result))))
    
  (helper lst (length lst) '()))

;; пример: (max-by '(1 2 3 -2 -4) abs) ;; => -4
;; пример: (max-by '((1) (1 2) (1 2 3) (1)) length) ;; => '(1 2 3)
(define (max-by lst term)
  (foldr
    (lambda (element current-max)
      (if (> (term element) (term current-max))
          element
          current-max))
    (car lst)
    lst))

(define (find-longest-major ll)
  (max-by
    (filter is-major? (sublists ll))
    length))