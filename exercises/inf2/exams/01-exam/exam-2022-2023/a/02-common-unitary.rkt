#lang racket

;; дадена наготово
(define (accumulate operation null-value start end term next)
  (if (> start end)
      null-value
      (operation
            (term start)
            (accumulate operation null-value (next start) end term next))))

;; Казваме, че k е унитарен делител на n, ако след делението на n на k се получава число,
;; което няма общи прости делители с k.
;; Да се реализира функция commonUnitary, която намира броя на общите унитарни делители
;; на дадени две естествени положителни числа n₁ и n₂. 

;; решение
;; намира най-голям общ делител на две числа
(define (gcd n1 n2)
  (cond
    ((< n1 n2) (gcd n2 n1))
    ((= 0 (remainder n1 n2)) n2)
    (else (gcd n2 (remainder n1 n2)))))

(define (commonUnitary n1 n2)
  (accumulate
    +
    0
    1
    (min n1 n2)
    (lambda (x) 
      (if (and (= 0 (remainder n1 x)) (= 1 (gcd (quotient n1 x) x))
               (= 0 (remainder n2 x)) (= 1 (gcd (quotient n2 x) x))) 1 0))
    1+))

;; алтернативно решение
(define (id x) x)
(define (1+ x) (+ 1 x))
(define (divides? k n) (= (remainder n k) 0))

(define (prime? number)
  (define (count-divisors number)
  	(accumulate + 0 1 number (lambda (x) (if (divides? x number) 1 0)) 1+))

  (= 2 (count-divisors number)))

(define (intersection lst1 lst2)
  (filter (lambda (x) (member x lst2)) lst1))

(define (list-prime-divisors number)
  (accumulate (lambda (k result) (if (and (divides? k number) (prime? k)) (cons k result) result)) '() 1 number id 1+))

(define (unitary? k n)
  (and
    (divides? k n)
    (null? (intersection (list-prime-divisors (quotient n k)) (list-prime-divisors k)))))

(define (list-unitary-divisors number)
  (accumulate (lambda (k result) (if (unitary? k number) (cons k result) result)) '() 1 number id 1+))

;; (define (commonUnitary n1 n2)
;;   (length (intersection (list-unitary-divisors n1) (list-unitary-divisors n2))))

;; (commonUnitary 60 140) ;; => 4	(общите унитарни делители са 1, 4, 5, 20) 