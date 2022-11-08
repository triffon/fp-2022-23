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




