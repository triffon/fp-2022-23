#lang racket

;; Да се реализира функция product-digits, която намира произведението от цифрите на дадено естествено число
(define (product-digits number)
  (if (< number 10)
      number
      (* (remainder number 10) (product-digits (quotient number 10)))))

;; -----------------------------------
;; Нека с {n} означим разликата на n и произведението на цифрите на n.
;; Да се реализира функция largest-diff, която намира най-голямата разлика {m} – {n} за m, n ∈ [a; b],
;; където a и b са параметри на функцията.

;; (difference-n-m '(30 . 29)) ;; => 19
(define (difference-n-m n-m-tuple)
  (define (difference number)
    (abs (- number (product-digits number))))

  (abs (- (difference (car n-m-tuple)) (difference (cdr n-m-tuple)))))

;; (from-to 1 5) ;; => '(1 2 3 4 5)
(define (from-to a b)
  (if (> a b)
      '()
      (cons a (from-to (+ a 1) b))))

;; работи само за непразни списъци
(define (maximum lst)
  (foldr max (car lst) (cdr lst)))

;; (cartesian-product '(1 2) '(3 4 5)) =>
;; '((1 . 3) (1 . 4) (1 . 5) (2 . 3) (2 . 4) (2 . 5))
(define (cartesian-product lst1 lst2)
  (if (null? lst1)
      '()
      (append
        (map (lambda (x) (cons (car lst1) x)) lst2)
        (cartesian-product (cdr lst1) lst2))))

(define (largest-diff a b)
  (define interval (from-to a b))
  (maximum (map  difference-n-m (cartesian-product interval interval))))

;; (largest-diff 28 35) ;; => 19  = {30} – {29} = (30 – 0) – (29 – 18))



