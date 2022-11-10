#lang racket

(define (digits-length number)
  (if (< (abs number) 10)
      1
      (+ 1 (digits-length (quotient number 10)))))

;; връща n-тата цифра на числото, започвайки от 1
;; броенето започва от дясно наляво
(define (get-nth-digit n number)
  (if (= n 1)
      (remainder number 10)
      (get-nth-digit (- n 1) (quotient number 10))))

(define (middle-digit number)
  (if (even? (digits-length number))
      -1
      (abs 
        (get-nth-digit
          (+ (quotient (digits-length number) 2) 1)
          number))))

;; (middle-digit 452) ;; => 5
;; (middle-digit 4712) ;; => -1