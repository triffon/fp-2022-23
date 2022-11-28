#lang racket

;; дадена наготово
(define (accumulate operation null-value start end term next)
  (if (> start end)
      null-value
      (operation
            (term start)
            (accumulate operation null-value (next start) end term next))))

;; Да се реализира функция trim, която по дадено естествено положително число n връща числото,
;; което се получава след последователното деление на n на всеки негов прост делител точно по веднъж.

;; решение
(define (1+ x) (+ 1 x))
(define (divides? k n) (= (remainder n k) 0))

(define (prime? number)
  (define (count-divisors number)
  	(accumulate + 0 1 number (lambda (x) (if (divides? x number) 1 0)) 1+))

  (= 2 (count-divisors number)))

(define (trim number)
  (accumulate
    (lambda (k result) (/ result k))
    number
    1
    number
    (lambda (k) (if (and (divides? k number) (prime? k)) k 1))
    1+))

;; (trim 360) ;; => 12 (= 360 / 2 / 3 / 5) 