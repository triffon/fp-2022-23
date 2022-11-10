#lang racket

(define (chunk lst n)
  (define (helper lst current-n current-chunk result)
    (cond
      ((null? lst) (append result (list current-chunk)))
      ((< current-n 1)
        (helper lst n '() (append result (list current-chunk))))
      (else 
        (helper
          (cdr lst)
          (- current-n 1)
          (append current-chunk (list (car lst)))
          result))))
  
  (helper lst n '() '()))

;; (chunk '(1 1 1 2 2 2 3 3) 3) =>
;; (helper '(11 1 2 2 2 3 3) 3 '()      '()) =>
;; (helper '(1 1 2 2 2 3 3)  2 '(1)     '()) =>
;; (helper '(1 2 2 2 3 3)    1 '(1 2)   '()) =>
;; (helper '(2 2 2 3 3)      0 '(1 2 2) '()) =>
;; (helper '(2 2 2 3 3)      3 '()      '((1 2 2))) =>
;; (helper '(2 2 3 3)        2 '(2)     '((1 2 2))) =>
;; (helper '(2 3 3)          1 '(2 2)   '((1 2 2))) =>
;; (helper '(3 3)            0 '(2 2 2) '((1 2 2))) =>
;; (helper '(3 3)            3 '()      '((1 2 2) (2 2 2))) =>
;; (helper '(3)              2 '(3)     '((1 2 2) (2 2 2))) =>
;; (helper '()               1 '(3 3)   '((1 2 2) (2 2 2))) =>
;; '((1 2 2) (2 2 2) (3 3))

;; -------------------------------------
;; алтернативно решение, изпозлващо
;; my-take и my-drop от упражнение 4

;;(define (my-take lst number)
;;  (if (or (= number 0) (null? lst))
;;      '()
;;      (cons
;;        (car lst)
;;        (my-take (cdr lst) (- number 1)))))

;;(define (my-drop lst n)
;;  (if (or (null? lst) (= n 0))
;;      lst
;;      (my-drop (cdr lst) (- n 1))))

;;(define (chunk lst n)
;;  (if (null? lst)
;;      '()
;;      (cons (my-take lst n) (chunk (my-drop lst n) n))))

;; не можем да използваме вградените в racket функции
;; take и drop при решаването на тази задача, защото те
;; хвърлят грешка, когато списъкът съдържа по-малко 
;; елементи от необходимото
;; пример:
;; > (take    '(1 2) 3) ;; => грешка
;; > (my-take '(1 2) 3) ;; => '(1 2)
;; > (drop    '(1 2) 3) ;; => грешка
;; > (my-drop '(1 2) 3) ;; => '()