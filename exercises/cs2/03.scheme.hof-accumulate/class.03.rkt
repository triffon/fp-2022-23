#lang racket

; hof, lambda


; const
(define (const x)
  (lambda (y) x))


;(define forever-21 (const 21))
;(forever-21 5) -> 21
;(forever-21 10) -> 21
;((const 21) 10) -> 21

; flip
(define (flip f)
  (lambda (x y)
    (f y x)))

;(define f (flip -))
;(f 4 10) ; -> 6 ; = (- 10 4)
;((flip f) 4 10);  -> -6

; complement
(define (complement p?)
  (lambda (x)
    (not (p? x))))

(define (complement2 p?)
  (compose not p?))

         
;(define (less-than-5? x) (< x 5))
;(define f (complement less-than-5?))
;(f 3) ; => #f
;(f 5) ; => #t
;(f 7) ; => #t

; compose
(define (compose f g)
  (lambda (x)
    (f (g x))))

(define f (compose (lambda (x) (+ x 1))
                   (lambda (x) (* x x)))) ; ((x^2)+1)
(f 3) ;-> 10


(define (derive f dx)
  (lambda (x) (/ (- (f (+ x dx)) (f x)) dx)))

; абстракция
; sum-cubes-interval
(define (sum-cubes-interval a b)
  (if (> a b)
      0
      (+ (* a a a)
         (sum-cubes-interval (+ a 1) b))))

(define (sum-interval2 f a b)
  (if (> a b)
      0
      (+ (f a)
         (sum-cubes-interval (+ a 1) b))))

(define (sum-cubes-interval2 a b)
  (define (cube x)
    (* x x x))
  (sum-interval2 cube a b))

(define (accumulate op nv a b term next)
  (if (> a b)
      nv
      (op (term a)
          (accumulate op nv (next a) b term next))))

  
; постепенно се превръща в accumulate
; accumulate-i

(define (accumulate-i op nv a b term next)
  (if (> a b)
      nv
      (accumulate-i op
                    (op nv (term a))
                    (next a)
                    b
                    term
                    next)))
  




(define (repeated f n)
  (accumulate compose id 1 n (lambda (i) f) 1+))

(define (repeated2 f n)
  (accumulate compose id 1 n (const f) 1+))

(define (derive-n f n dx)
  ((accumulate compose id 1 n
               (lambda (i) (lambda (f) (derive f dx)))
               1+)
   f))


(define (id x) x)
(define (1+ n) (+ 1 n))

(define (fact n)
  (accumulate * 1 1 n id 1+))

(define (newton-binomial x y n)
  (define (n-choose-k n k)
    (/ (fact n)
       (* (fact k)
          (fact (- n k)))))

  (define (term k)
    (* (expt x (- n k))
       (expt y k)
       (n-choose-k n k)))
  (accumulate +
              0
              0
              n
              term
              1+))



;### Зад 6
; Дали **за всяко** цяло число в интервала [a, b] предикатът `pred?` е истина.
(define (all-int? pred? a b)
  (accumulate (lambda (x y) (and x y))
              #t
              a
              b
              pred?
              1+
              ))




(define (count-digits n)
  (if (< n 10)
      1
      (+ 1 (count-digits (remainder n 10)))))
  
;а) (3 т.) Да се реализира функция product-digits, която намира произведението
; от цифрите на дадено естествено число.
(define (product-digits n)
  (if (< n 10)
      n
      (* (remainder n 10)
         (product-digits (quotient n 10)))))

(define (product-digits1 n)
  (define (term i)
    (remainder (quotient n (expt 10 i))
               10))
  (accumulate * 1 1 (count-digits n)
              term 1+))




