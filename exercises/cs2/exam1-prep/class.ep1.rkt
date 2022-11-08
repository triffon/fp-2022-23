#lang racket

; “Ниво на влагане” на атом в дълбок списък наричаме
; броя пъти, който трябва да се приложи операцията car
; за достигане до атома.
; Да се реализира функция deep-delete,
; която в даден дълбок списък изтрива всички
; числови атоми, които са по- малки от нивото
; им на влагане.

(define (atom? x)
  (and (not (null? x))
       (not (pair? x))))

(define dl1 '(1 (2 (2 4) 1) 0 (3 (1))))
; → (1 (2 (4)) (3 ()))

(define (deep-delete dl)
  (deep-delete-lvl 0 dl))

(define (deep-delete-lvl level dl)
  (cond ((null? dl) dl)
        ((atom? dl)
         (if (< dl level)
             #f
             dl))
        (else
          (let ((atom-rec
                 (deep-delete-lvl (+ 1 level) (car dl))))
            (if (equal? atom-rec #f)
                (deep-delete-lvl level (cdr dl))
                (cons atom-rec
                      (deep-delete-lvl level (cdr dl))
                ))))))


(define (deep-delete2 dl)
  (deep-delete-lvl2 0 dl))

(define (deep-delete-lvl2 level dl)
  (cond ((null? dl) dl)
        ((null? (car dl)))
        ((atom? (car dl))
         (if (<= (car dl) level)
             (deep-delete-lvl2 level (cdr dl))
             (cons (car dl)
                   (deep-delete-lvl2 level (cdr dl)))))
        (else ; (car dl) е списък
          (cons (deep-delete-lvl2 (+ 1 level) (car dl))
                (deep-delete-lvl2 level (cdr dl))))))




; ==================================

(define (sum-divisors-less-than d n)
  (if (>= d n)
      0
      (+ (if (= 0 (remainder n d))
             d
             0)
         (sum-divisors-less-than (+ 1 d) n))))

(define (accumulate-i op nv a b term next)
  (if (> a b)
      nv
      (accumulate-i op
                    (op (term a) nv)
                    (next a)
                    b
                    term
                    next)))

(define (1+ n) (+ 1 n))

(define (sum2d n)
  (define (term x)
    (if (= 0 (remainder n x))
        x
        0))
  (accumulate-i + 1 2 (- n 1) term 1+))



(define (done? n)
  (= (+ n 2)
     (sum2d n)))

(done? 20)
(done? 28)
(done? 464)
(done? 1000)

(define (last l)
  (list-ref l (- (length l) 1)))

(define (from-to a b)
  (if (> a b)
      '()
      (cons a
            (from-to (+ a 1) b))))
(define (filter p? l)
  (cond ((null? l) l)
        ((p? (car l)) (cons (car l)
                            (filter p? (cdr l))))
        (else (filter p? (cdr l)))))
(define (sum l)
  (foldr + 0 l))

(define (sum-almost-done a b)
  (if (null? (filter done? (from-to a b)))
      0
      (sum-almost-done-impl a b)))

(define (sum-almost-done-impl a b)
  (define all-done (filter done? (from-to a b)))
  (define first-done (car all-done))
  (define last-done (last all-done))
  (define (avg-up x y)
    (+ 1 (quotient (+ x y) 2)))
  (define (avg-down x y)
    (if (even? (+ x y))
        (- (quotient (+ x y) 2)
           1)
        (quotient (+ x y) 2)))
  (define u (avg-up a first-done))
  (define v (avg-down last-done b))

  (sum (from-to u v)))

(sum-almost-done 5 24); → 153
(sum-almost-done 2 10)


(define (product l)
  (foldr * 1 l))

(define (explode-digits n)
  (if (< n 10)
      (list n)
      (cons (remainder n 10)
            (explode-digits (quotient n 10)))))

(define (product-digits n)
  (product (explode-digits n)))


(product-digits 111222)

(define (largest-diff a b)
  (define (max x y)
    (if (> y x)
        y
        x))
  (define (term m)
    (define (inner-term n)
      (- (- m (product-digits m))
         (- n (product-digits n))))
    (accumulate-i max 0 a b inner-term 1+))
  (accumulate-i max 0 a b term 1+))

(largest-diff 28 35) ;→ 19

(define (maximum l)
  (if (null? (cdr l))
      (car l)
      (max (car l)
           (maximum (cdr l)))))

(define (max-metric ml ll)
  (define (sum-values f)
    (sum
     (map (lambda (l) (f l))
          ll)))
  (define (better-metric fm sm) ; == (argmax sum-values fm sm)
    (if (> (sum-values fm)
           (sum-values sm))
        fm
        sm))

  (if (null? (cdr ml))
      (car ml)
      (better-metric (car ml)
                     (max-metric (cdr ml) ll)))
  ; цялото това тяло == (foldr1 better-metric ml)
      )

;(foldr op nv ml)
; )

(define (prod l) (apply * l))
;(define (sum l) (apply + l))

(max-metric (list sum prod) '((0 1 2) (3 4 5) (1337 0)))
; → <sum>
(max-metric (list car sum)  '((1000 -1000) (29 1) (42)))
; → <car>

