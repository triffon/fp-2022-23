#lang racket
(define (accumulate op nv a b term next)
  (if (> a b) nv
      (op (term a)
          (accumulate op nv (next a) b term next))))
          
(define (accumulate-i op nv a b term next)
  (if (> a b) nv
      (accumulate-i op (op nv (term a)) (next a) b term next)))

; Полезни функцийки (от миналия път)
(define (id x) x)
(define (++ x) (+ x 1))
(define (sq x) (* x x))
(define (const c)
  (lambda (x) c))
(define (complement p)
  (lambda (x) (not (p x))))
(define (compose f g)
  (lambda (x) (f (g x))))
(define dx 0.000001)
(define (derive f)
  (lambda (x) (/ (- (f (+ x dx)) (f x)) dx)))

; Пример за синтактично удобство на Racket: [] и {} вместо ()
(define (fib n)
  (cond [(= n 0) 0]
        [(= n 1) 1]
        [else (+ (fib (- n 1)) (fib (- n 2)))]))

; Зад.0 - факториел
(define (fact n)
  (accumulate-i * 1
                1 n
                (lambda (i) i)
                (lambda (i) (+ i 1))))
; Зад.1
(define (!! n)
  (accumulate-i * 1
                (if (odd? n) 1 2) n
                id
                (lambda (i) (+ i 2))))
; Зад.2
(define (nchk n k)
  (accumulate-i * 1
                1 (- n k)
                (lambda (i) (/ (+ k i) i))
                ++))

; Зад.3
(define (2^ n)
  (accumulate-i * 1
                1 n
                (const 2) ; (lambda (i) 2)
                ++))
; Както е известно, сумата на всички биномни
; коефициенти на n е равна на 2^n
(define (2^* n)
  (accumulate-i + 0
                0 n
                (lambda (i) (nchk n i))
                ++))

; Зад.4
(define (all? p? a b)
  (accumulate-i (lambda (acc i) (and acc i))
                #t
                a b
                p? ++))
(define (any? p? a b)
  (not (all? (complement p?) a b)))

; Зад.5
(define (sum-powers k n)
  (accumulate-i + 0
                1 n
                id
                (lambda (i) (* k i)))) ; (!)

; Зад.6
; Вариант 1: с допълнителни неутрални стойности
(define (divisors-sum n)
  (accumulate-i + 0
                1 n
                (lambda (i) (if (zero? (remainder n i)) i 0))
                ++))
; Вариант 2: със специална "насъбираща" операция,
; която наистина игнорира не-делителите
(define (divisors-sum* n)
  (define (op acc i)
    (if (zero? (remainder n i))
        (+ acc i)
        acc))
  (accumulate-i op 0
                1 n
                id ++))

; Зад.7
(define (count p? a b)
  (accumulate-i + 0
                a b
                (lambda (i) (if (p? i) 1 0))
                ++))

; Зад.8
(define (prime? n)
  (and (> n 1)
       (all? (lambda (i) (> (remainder n i) 0))
             2 (sqrt n))))

; Зад.9
; Идея: н-кратна композиция на f
; е същото като н-кратно умножение на 2:
; f.f.f <=> 2*2*2
(define (repeat n f)
  (accumulate-i compose id
                1 n
                (const f) ; не просто f (!)
                ++))

; Зад.10
; Решението от миналия път е валидно и тук
; (define (derive-n n f)
;   ((repeat n derive) f))

; Можем пак да направим същата аналогия:
;     2*2*2*1 (неутр. стойност)
; <=> f.f.f.id
; <=> (derive (derive (derive f)))
; ВНИМАНИЕ: тук операцията за насъбиране
; не е комутативна => има значение дали
; ползваме ляво или дясно свиване!
(define (apply f x) (f x))
(define (derive-n n f)
  (accumulate apply f
              1 n
              (const derive)
              ++))
