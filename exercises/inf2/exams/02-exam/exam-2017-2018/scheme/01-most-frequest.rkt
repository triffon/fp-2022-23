#lang racket

;; Да се напише функция mostFrequent, която по даден
;; списък от списъци от числа връща числото, което е сред най-често
;; срещаните числа във всички списъци, ако такова има, или 0 иначе

;; изтрива елемент с ключ key от подадения асоциативен списък
;; (del-assoc 2 '((1 2) (2 3) (3 4))) ;; => '((1 2) (3 4))
(define (del-assoc key alist)
  (filter
    (lambda (kv) (not (equal? key (car kv))))
    alist))

;; връща списък от наредени двойки от тип (<елемент> . <брой-срещания-на-елемент>)
;; (histogram '(1 1 3 2)) ;; => '((1 . 2) (3 . 1) (2 . 1))
(define (histogram lst)
  (foldr
    (lambda (x result)
      (let ((kv (assoc x result)))
        (if kv
          (cons (cons x (+ 1 (cdr kv))) (del-assoc x result))
          (cons (cons x 1) result))))
    '()
    lst))

;; намира максималния елемент в списък
;; (maximum-by cdr '((1 . 2) (3 . 1)) ;; => '(1 . 2)
(define (maximum-by func lst)
  (foldr
    (lambda (x result) (if (> (func x) (func result)) x result))
    (car lst)
    (cdr lst)))

;; връща списък от най-често срещаните елементи на даден списък
;; (filter-maximum '(1 1 5 5 6)) ;; => '(1 5)
(define (filter-maximum lst)
  (let* ((hist (histogram lst))
         (max-occurences (cdr (maximum-by cdr hist))))
    (map car (filter (lambda (pair) (= max-occurences (cdr pair))) hist))))

;; намира сечението на две множества
;; (intersection '(1 2 3 4) '(3 4 5 6)) ;; => [3,4]
(define (intersection lst1 lst2)
  (filter (lambda (x) (member x lst2)) lst1))

;; намира сечението на списък от списъци
;; (intersection-lst '((1 2 3 4) (4 5 6 7) (2 3 4 5))) ;; => '(4)
(define (intersection-lst lst)
  (if (null? (cdr lst))
      (car lst)
      (intersection (car lst) (intersection-lst (cdr lst)))))

(define (mostFrequent lst)
  (let
    ((most-frequent-elements (intersection-lst (map filter-maximum lst))))
  
    (if (null? most-frequent-elements)
        0
        (car most-frequent-elements))))

;; (mostFrequent '((1 1 3 2) (1 1 5) (1 5) (1 1 1 3))) ;; => 1
;; (mostFrequent '((1 1 3 2) (1 5 5) (1 5) (1 1 1 3))) ;; => 0