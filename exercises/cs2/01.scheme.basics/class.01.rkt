#lang racket

(define (1+ n) (+ 1 n))
(define (ascii->code char)
  (cond
    ((= char 'A) 65)
    ((= char 'D) 68)
    ((= char 'E) 69)
    ; и така нататък...
    (else 'unknown)))

; задачки (`'тук` трябва да попълните):
; зад 1
; No | Преведете следните аритметични изрази на scheme: | пресмятат се до:
;---|--------------------------------------------------|-------------------
; 1 | (10 + 5.16 + 19 + 9.712361) * (20 - (16 - 4))    | 350.97888
; 2 | 1/4 + 2/5 + 3/8 + 6 * (5.1 - 1.6) * (9/3 - 7/4)  | 27.274999999999995
; 3 | 3^(60 ÷ 7) + ((2^10) ÷ 179)                      | 6566
; 4 | (1 - i)^21                                       | колко е?

(define (is-six y)
  (if (= y 6)
      'числото-е-шест
      'числото-не-е-шест))

(define x 6)
(define (xf z) (+ 7 z))

(define (my-func z y k o n)
  (+ 7
     (* z y)
     (* y k o n)))

; зад 2
(define (even? n) ; четно
  (= 0 (remainder n 2))
  )

(define (odd? n) ; нечетно
  (not (even? n))
  )

(define odd?-1 (compose not even?))






(display "pokazvam\n")
6

(define var (display "var se oceni"))

(define var2 (+ 10 2))

(define (func x) (display "func se oceni"))



(define r (remainder 5 2)) ; остатък
(define q (quotient 19 2)) ; целочислено деление
; зад 3
; схемата за оценяване
(define (grade points)
  (if (< points 60)
      2
      (if (< points 100)
          3
          (if (< points 140)
              4
              (if (< points 180)
                  5
                  6)))))

(define (grade2 points)
  (cond
    ((< points 60) 2)
    ((< points 100) 3)
    ((< points 140) 4)
    ((< points 180) 5)
    (else 6)))



; бонус ако направите оценката
; да е наредена двойка от число и думичка
