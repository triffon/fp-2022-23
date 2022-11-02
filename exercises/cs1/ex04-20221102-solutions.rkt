#lang racket
; За удобство
(define head car)
(define tail cdr)

; Как работят вградените функции
(define (length* lst)
  (if (null? lst) 0
      (+ 1 (length* (tail lst)))))
(define (map* f lst)
  (if (null? lst) '()
      (cons (f (head lst))
            (map* f (tail lst)))))
(define (filter* p? lst)
  (cond [(null? lst) '()]
        [(p? (head lst)) (cons (head lst)
                               (filter* p? (tail lst)))]
        [else (filter* p? (tail lst))]))
; Важно: итеративните функции водят до
; обръщане на реда на стойностите (!)
(define (reverse* lst)
  (define (loop lst res)
    (if (null? lst) res
        (loop (tail lst) (cons (head lst) res))))
  (loop lst '()))

; Зад.1
(define (take n lst)
  (if (or (null? lst) (= n 0))
      '()
      (cons (head lst) (take (- n 1) (tail lst)))))
(define (drop n lst)
  (if (or (null? lst) (= n 0))
      lst
      (drop (- n 1) (tail lst))))

; Зад.2
(define (all? p? lst)
  (or (null? lst)
      (and (p? (head lst))
           (all? p? (tail lst)))))
; Отново може по ДеМорган да преизползваме all?
(define (any? p? lst)
  (and (not (null? lst))
       (or (p? (head lst))
           (any? p? (tail lst)))))

; Зад.3
(define (zip lst1 lst2)
  (zipWith cons lst1 lst2)) ;)

; Зад.4
(define (zipWith f lst1 lst2)
  (if (or (null? lst1) (null? lst2))
      '()
      (cons (f (head lst1) (head lst2))
            (zipWith f (tail lst1) (tail lst2)))))

; Зад.5
(define (sorted? lst)
  (or (null? lst)
      (null? (tail lst))
      (and (<= (head lst) (head (tail lst)))
           (sorted? (tail lst)))))
