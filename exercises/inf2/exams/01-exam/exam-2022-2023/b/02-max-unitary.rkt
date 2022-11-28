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
;; Да се реализира функция maxUnitary, която по дадено съставно число n
;; намира най-големия му унитарен делител по-малък от n.

;; решение
;; намира най-голям общ делител на две числа
(define (gcd n1 n2)
  (cond
    ((< n1 n2) (gcd n2 n1))
    ((= 0 (remainder n1 n2)) n2)
    (else (gcd n2 (remainder n1 n2)))))

(define (maxUnitary number)
  (accumulate
    max
    1
    1
    (- number 1)
    (lambda (x) 
      (if (and (= 0 (remainder number x)) (= 1 (gcd (quotient number x) x))) x 1))
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

;; (define (maxUnitary number)
;;   (last (accumulate (lambda (k result) (if (unitary? k number) (cons k result) result)) '() 1 (- number 1) id 1+)))

;; (maxUnitary 60) ;; => 20 