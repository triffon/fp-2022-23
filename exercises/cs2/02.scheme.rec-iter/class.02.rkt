#lang racket


(define (1+ n) (+ n 1))


; fact
(define (fact n)
  (if (= n 0)
      1
      (* n
         (fact (- n 1)))))

; fib
; sum-interval



; зад
; сбор на целите числа в интервала [a, b]
(define (suminterval a b)
  (if (> a b)
      0
      (+ a (suminterval (+ a 1) b))))

(define (sumint-iter a b)
  (define (for i result)
    (if (> i b)
        result
        (for (+ i 1) (+ i result))))
  (for a 0))




(define (slowpow x n)
  (if (= n 0)
      1
      (* x (slowpow x (- n 1)))))
(define (square x)
  (* x x))


(define (fastpow x n)
  (cond
    ((= n 0) 1)
    ((even? n) (square (fastpow x (quotient n 2))))
    (else (* x (fastpow x (- n 1))))))

(define (fasterpow x n)
  (define (fasterpow-iter i result)
    (cond
      ((= i 0) result)
      ((even? i) (fasterpow-iter (quotient i 2)
                                 (square result)))
      (else (fasterpow-iter (- i 1)
                            (* x result))))
    )
  
  (fasterpow-iter n 1))

    



(define (count-digits-2 n)
  (if (= n 0)
      1
      ((+ 1 (ceiling (log n 10))))))

(define (count-digits n)
  (if (and (< -10 n) (< n 10))
      1
      (+ 1 (count-digits (quotient n 10)))))