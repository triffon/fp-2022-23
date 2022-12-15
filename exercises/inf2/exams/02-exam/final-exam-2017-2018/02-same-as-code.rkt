#lang racket

;; Път от корен до възел в двоично дърво кодираме с поредица от цифри 0 и 1,
;; която започва с цифрата 1, а за всяка следваща цифра 0 означава завиване по левия клон, а 1 — по десния.
;; Да се реализира функция sameAsCode, която в двоично дърво от числа връща такова число x,
;; което съвпада по стойност с двоичното число, кодиращо пътя от корена до x, или 0, ако такова число няма.
;; Представянето на дървото е по ваш избор.

(define empty-tree? null?)
(define root car)
(define left-tree cadr)
(define right-tree caddr)

(define (binary-to-decimal number)
	(if (= number 0)
		0
		(+ (* 2 (binary-to-decimal (quotient number 10))) (remainder number 10))))

(define (sameAsCode tree)
  (define (helper tree path)
    (cond
      ((empty-tree? tree) '())
      ((= (root tree) (binary-to-decimal path))
        (append
          (list (root tree))
          (helper (left-tree tree) (* path 10))
          (helper (right-tree tree) (+ (* path 10) 1))))
      (else
        (append
          (helper (left-tree tree) (* path 10))
          (helper (right-tree tree) (+ (* path 10) 1))))))

  (let ((result (helper tree 1)))
    (if (null? result) 0 (car result))))
  
;; (sameAsCode '(5 (3 () (2 () ())) (4 (6 () ()) ()))) ;; => 6 (в двоичен запис: 110)

;; разписано решение
;; (helper '(5 (3 () (2 () ())) (4 (6 () ()) ()))) 1) => 
;;
;; (append (helper '(3 () (2 () ())) 10) (helper (4 (6 () ()) ()) 11)) =>
;;
;; (append
;;   (append (helper '() 100) (helper '(2 () ()) 101)))
;;   (append (helper '(6 () ()) 110) (helper '() 111))) =>
;; 
;; (append
;;   (append '() (append (helper '() 1010) (helper '() 1011)))
;;   (append (append '(6) (helper '() 1100) (helper '() 1101)) '())) =>
;;
;; (append
;;   (append '() (append '() '()))
;;   (append (append '(6) '() '()) '())) =>
;;
;; '(6)