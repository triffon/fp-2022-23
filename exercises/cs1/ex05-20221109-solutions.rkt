#lang racket
(define head car)
(define tail cdr)

; В Ракет са вградени, за R5RS трябва да ги имполементираме сами
(define (foldr op nv lst)
  (if (null? lst) nv
      (op (head lst)
          (foldr op nv (tail lst)))))
(define (foldl op nv lst)
  (if (null? lst) nv
      (foldl op (op nv (head lst)) (tail lst))))

; Полезни помощни функции
(define (id x) x)
(define (flip f)
  (lambda (x y) (f y x)))
(define (compose f g)
  (lambda (x) (f (g x))))
(define (any? p? lst)
  (and (not (null? lst))
       (or (p? (head lst))
           (any? p? (tail lst)))))

; Помощна функция - cons-ва x в lst,
; но само ако x не се среща вече в него
(define (cons-if-not x lst)
  (if (member x lst)
      lst
      (cons x lst)))

; Зад.1
; "Наивно" рекурсивно решение - извикваме се рекурсивно
; за опашката и добавяме главата към резултата (ако я няма в него)
(define (uniques lst)
  (if (null? lst) '()
      (cons-if-not (head lst) (uniques (tail lst)))))
; С използването на foldr се получава абсолютно аналогично решение
(define (uniques* lst)
  (foldr cons-if-not '() lst))
; Тъй като редът в резултата няма значение, можем да ползваме
; и foldl - но внимаваме за асоциативността на насъбиращата операция
(define (uniques** lst)
  (foldl (flip cons-if-not) '() lst))
; Аналогичното на foldl решение с директна рекурсия
(define (uniques*** lst)
  (define (loop lst res)
    (cond [(null? lst) res]
          [(member (head lst) res) (loop (tail lst) res)]
          [else (loop (tail lst) (cons (head lst) res))]))
  (loop lst '()))
; Друг вариант с директна, "наивна" рекурсия, в който
; на всяка стъпка претърсваме опашката - това с fold е невъзможно.
(define (uniques**** lst)
  (cond [(null? lst) '()]
        [(member (head lst) (tail lst))
         (uniques**** (tail lst))]
        [else (cons (head lst)
                    (uniques**** (tail lst)))]))

; Зад.2 - разширение с предикат по избор:
; ако (cmp x y) върне истина, x трябва да е преди y.
(define (insert cmp val lst)
  (cond [(null? lst) (list val)]
        [(cmp val (head lst)) (cons val lst)]
        [else (cons (head lst)
                    (insert cmp val (tail lst)))]))

; Зад.3 - същото разширение
(define (insertion-sort cmp lst)
  (foldl (lambda (res el) (insert cmp el res)) '() lst))

; Зад.4
; Отново разширено търсене на максимум
(define (maximum-by cmp lst)
  (foldl (lambda (res el)
           (if (cmp el res) el res))
         (head lst)
         (tail lst)))
; Дължина на интервал, зададен като наредена двойка
(define (len i) (- (cdr i) (car i)))
; Дали интервалът x е подинтервал на y
(define (sub? x y)
  (and (>= (car x) (car y))
       (<= (cdr x) (cdr y))))
(define (longest-interval-subsets lst)
  (let* [(longest (maximum-by (lambda (x y) (> (len x) (len y))) lst))
         (subs (filter (lambda (x) (sub? x longest)) lst))]
    (insertion-sort (lambda (x y) (< (car x) (car y))) subs)))

(longest-interval-subsets
  '((24 . 25) (90 . 110) (0 . 100) (10 . 109) (1 . 3) (-4 . 2)))

; Зад.5
(define (group-by f lst)
  (define (get-xs val)
    (list val
          (filter (lambda (x) (equal? (f x) val)) lst)))
  (let* [(values (uniques (map f lst)))]
    (map get-xs values)))

; Зад.6
(define (compose* . fns)
  (foldl compose id fns))

; Зад.7
(define (zipWith* f . lsts)
  (if (or (null? lsts) (any? null? lsts))
      '()
      (cons (apply f (map head lsts))
            (apply zipWith* f (map tail lsts)))))
