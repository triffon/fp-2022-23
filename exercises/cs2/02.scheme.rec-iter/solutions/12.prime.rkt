#lang racket
(require rackunit)
(require rackunit/text-ui)

;### зад 12
; Дали числото е просто?
; > Дадено цяло число n е просто, ако не се дели на никое от числата между 2 и n-1 (даже [от 2 до √n][primality-test]).
(define (prime? n)
  ; друг вариант за вложените дефиниции
  ;(let (
  ;  (end (- n 1))
  ;  (go (lambda (i)
  ;    (cond
  ;      ((> i end) #t)
  ;      ((= 0 (remainder n i)) #f)
  ;      (else (go (+ i 1))))))
  ;  )
  ;  (go 2)))

  (define end (- n 1))
  (define (go i)
    (cond
      ((> i end) #t)
      ((= 0 (remainder n i)) #f)
      (else (go (+ i 1)))))

  (if (< n 2)
      #f
      (go 2)))

; [2, 3, 4, 5, 6 ..., n - 1]
; [(term 2), (term 3), (term 4), (term 5), (term 6) ..., (term n - 1)]
; #t [#f, #f, #f, #f, #f ..., #f]
; n % i = 0

(run-tests
  (test-suite
    "prime? tests"
    (check-false (prime? 0))
    (check-false (prime? 1))
    (check-false (prime? -120))
    (check-false (prime? 120))
    (check-true (prime? 2))
    (check-true (prime? 3))
    (check-true (prime? 7))
    (check-true (prime? 101))
    (check-true (prime? 2411)))
  'verbose)
