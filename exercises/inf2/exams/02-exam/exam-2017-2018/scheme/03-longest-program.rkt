#lang racket

;; Телевизионно предаване се представя с наредена тройка от
;; име (низ), начален час (наредена двойка от час и минути) и продължителност (брой минути).

;; a). Да се напише функция lastShow, което по списък от предавания
;; връща името на това, което завършва най-късно.

(define name car)

(define duration caddr)

(define (starttime show)
  (let ((start (cadr show)))
    (+ (* (car start) 60) (cdr start))))

(define (endtime show)
  (+ (starttime show) (duration show)))

;; намира максималният елемент в списък
;; (maximum-by cdr '((1 . 2) (3 . 1)) ;; => '(1 . 2)
(define (maximum-by func lst)
  (foldr
    (lambda (x result) (if (> (func x) (func result)) x result))
    (car lst)
    (cdr lst)))

(define (lastShow shows)
  (name (maximum-by endtime shows)))

;; (lastShow '(("A" (11 . 0) 120) ("B" (12 . 0) 15) ("C" (10 . 30) 90))) ;; => "A"

;; Телевизионна програма наричаме последователност от предавания,
;; чиито интервали на излъчвания са подредени в нарастващ ред и не се пресичат.

;; б). Да се напише функция longestProgram, която по даден
;; списък от предавания генерира възможно най-дълга телевизионна
;; програма, т.е. сумата от продължителностите на предаванията в нея
;; е максимална

(define (quicksortBy term lst)
  (if (null? lst)
      '()
      (append
        (quicksortBy term (filter (lambda (x) (< (term x) (term (car lst)))) (cdr lst)))
        (list (car lst))
        (quicksortBy term (filter (lambda (x) (>= (term x) (term (car lst)))) (cdr lst))))))

;; виж inf2/06/06-subsets.rkt
(define (subsets lst)
  (define (add-to-front element ll)
    (map (lambda (set) (cons element set)) ll))

  (if (null? lst)
    '(())
    (append
      (add-to-front (car lst) (subsets (cdr lst)))
      (subsets (cdr lst)))))

;; проверява дали всички предавания (сортирани по начално врмеме)
;; са непресичащи се
(define (non-intersecting? shows)
  (or
    (null? shows)
    (null? (cdr shows))
    (and
      (<= (endtime (car shows)) (starttime (cadr shows)))
      (non-intersecting? (cdr shows)))))

(define (sum-by func lst)
  (foldr (lambda (x result) (+ (func x) result)) 0 lst))

(define (longestProgram shows)
  (let ((programs (filter non-intersecting? (subsets (quicksortBy starttime shows)))))
  
  (maximum-by (lambda (program) (sum-by duration program)) programs)))

;; (longestProgram '(("A" (11 . 0) 120) ("B" (12 . 0) 15) ("C" (10 . 30) 90)))
;; => '(("A" (11 . 0) 120))

;; (longestProgram '(("A" (10 . 0) 120) ("B" (12 . 0) 15) ("C" (10 . 30) 90)))
;; => '(("A" (10 . 0) 120) ("B" (12 . 0) 15))