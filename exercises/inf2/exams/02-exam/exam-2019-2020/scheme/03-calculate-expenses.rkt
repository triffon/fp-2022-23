#lang racket

;; Покупка се означава с наредена тройка от име на магазин (низ), категория (низ) и цена (дробно число).
;; Да се реализира функция, която по даден списък от покупки
;; връща списък от тройки, съдържащи  категория, обща цена на покупките в тази категория,
;; името на магазина, в който общата цена на покупките в тази категория е максимална).
;; Всяка категория да се среща в точно една тройка от резултата.

(define purchases 
  '(("Ikea" "Furniture" 150.5) ("Billa" "Food" 24.4)  ("Fantastiko" "Food" 5.0)
   ("Mebeli Videnov" "Furniture" 400.0) ("Billa" "Food" 13.3) ("Lidl" "Food" 10.5)
   ("Medea" "Pharmaceuticals" 40.0) ("Ikea" "Furniture" 50.0)))

(define get-store car)
(define get-category cadr)
(define get-price caddr)

;; премахва повторенията на елемент
;; (uniques '(1 2 3 2 1)) ;; => '(1 2 3)
(define (uniques lst)
  (if (null? lst)
      '()
      (cons
        (car lst)
        (uniques (filter (lambda (x) (not (equal? x (car lst)))) (cdr lst))))))

;; намира максималния елемент в списък
;; (maximum-by cdr '((1 . 2) (3 . 1))) ;; => '(1 . 2)
(define (maximum-by func lst)
  (foldr
    (lambda (x result) (if (> (func x) (func result)) x result))
    (car lst)
    (cdr lst)))

(define (sum-by func lst)
  (foldr (lambda (x result) (+ (func x) result)) 0 lst))

(define (calculateExpenses purchases)
  (define (get-purchases category)
    (filter (lambda (purchase) (equal? category (get-category purchase))) purchases))
  
  (define (get-total category)
    (sum-by get-price (get-purchases category)))

  (define (get-store-total store category)
    (let
      ((store-purchases
        (filter
          (lambda (purchase) (equal? store (get-store purchase)))
          (get-purchases category))))
      
    (sum-by get-price store-purchases)))

  (define (get-max-store category)
    (let ((stores (uniques (map get-store (get-purchases category)))))
    
      (maximum-by (lambda (store) (get-store-total store category)) stores)))

  (map
    (lambda (category)
      (list category (get-total category) (get-max-store category)))
    (uniques (map get-category purchases))))

;; (calculateExpenses purchases)
;; => '(("Furniture" 600.5 "Mebeli Videnov") ("Food" 53.2 "Billa") ("Pharmaceuticals" 40.0 "Medea"))