#lang racket

;; Да се напише функция (meetTwice? f g a b), която проверява дали в целочисления интервал [a; b]
;; съществуват две различни цели числа x и y такива, че f(x) = g(x) и f(y) = g(y).

(define (accumulate op null-value start end term next)
  (if (> start end)
      null-value
      (op
          (term start)
          (accumulate op null-value (next start) end term next))))

(define (meet-twice? f g start end)
  (>=
      (accumulate
          +
          0
          start
          end
          (lambda (x) (if (= (f x) (g x)) 1 0))
          (lambda (x) (+ x 1)))
      2))

;; (meet-twice? (lambda (x) x) (lambda(x) (- x)) -3 1)   ;; => #f
;; (meet-twice? (lambda (x) x) sqrt 0 5)                 ;; => #t