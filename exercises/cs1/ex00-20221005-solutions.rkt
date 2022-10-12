; Зад.1
(define (f1 x y)
  (if (< y 0) (and (> x -1) (< x 1) (> y -2))
      (< (sqrt (+ (sq x) (sq y))) 2)))

(define (f2 x y)
  (define (in-box? x y) ; Вградена дефиниця
    (and (<= (abs x) 1) (<= (abs y) 1)))
  (or (in-box? x y)
      (in-box? (- x 2) (- y 2))
      (in-box? (- x 4) (- y 4))))

; Зад.2
(define (fact n)
  (if (= n 0) 1
      (* n (fact (- n 1)))))

; Зад.3
(define (fib n)
  (if (< n 2) n
      (+ (fib (- n 1)) (fib (- n 2)))))

; Зад.4
(define (sum-interval a b)
  (if (> a b) 0
      (+ a (sum-interval (+ a 1) b))))

; Зад.5
(define (count-digits n)
  (if (< n 10) 1
      (+ 1 (count-digits (quotient n 10)))))

; Зад.6
(define (reverse-digits n)
  (if (= n 0) 0
      (+ (* (remainder n 10) (expt 10 (- (count-digits n) 1)))
         (reverse-digits (quotient n 10)))))

; Зад.7
(define (palindrome? n)
  (= n (reverse-digits n)))
