# Наредени двойки и списъци

### Загрявка
```
(define (accumulate op nv a b term next)
  (if (> a b)
      nv
      (op (term a) (accumulate op nv (next a) b term next))))

;; count-divisors n -> намира броя на делителите на числото n
```

## Наредени двойки
`(1 . 2)`\
`(define a (cons 1 2))`\
`(define b (cons 1 2))`

### quote - или ' - не оценява последващия израз
`(quote 1) = '1`

Строим наредени двойки с функцията cons: `(define a (cons 1 2))`\
Взимане на първия елемент: `(car a)`\
Взимане на втория елемент: `(cdr a)`\
cons може да се влага: `(cons (cons 1 2) 3)`\
car и cdr също:
```
(define x (cons (cons 1 2) 3))
(define y (cons 4 (cons 5 6)))

(car (car x)) ;; => 1 (caar)
(cdr (cdr y)) ;; => 6 (cddr)
(cdr (car x)) ;; => 2 (cdar)
(car (cdr y)) ;; => 5 (cadr)
```
Проверка за наредена двойка: `pair?`

### Пример с рационални числа:

```
(define (make-rational x y)
  (cons x y))

(define (nominator a)
  (car a))

(define (denominator a)
  (cdr a))

(define (sum-rationals a b)
  (/ (+ (* (nominator a) (denominator b))
        (* (nominator b) (denominator a)))
     (* (denominator a) (denominator b))))

(define (mult-rationals a b)
  (/ (* (nominator a) (nominator b))
     (* (denominator a) (denominator b))))

(define (mult-rationals2 a b)
  (let (
        (nom (* (nominator a) (nominator b)))
        (denom (* (denominator a) (denominator b))))
    (make-rational nom denom)))
```

## Списъци
Дефиниция:
Празният списък е списък `'()`\
Ако l е списък, то `(cons x l)` също е списък.
Първият елемент на l се нарича глава, а следващите - опашка.
Примери за списъци:
```
'(1 2 3)
(cons 1 (cons 2 '()))
(list 1 2 3)
'(1 2 (3 4) 5) ;; без втори quote! -> '(1 2 '(3 4) 5) е грешно
'("ab" 3 #t (lambda (x) (+ x 1))) -> няма изискване елементите да са еднакъв тип
Викането на функции е списък.
```
Проверка за празен списък: `(null? l)`\
Проверка за списък: `(list? l)`\
Какво ще ни върне `(pair? l)`?


## Задачи
```
(define (sum-elements l)
  (if (null? l)
      0
      (+ (car l) (sum-elements (cdr l)))))

(define (member? x l)
  (cond
    ((null? l) #f)
    ((= (car l) x) #t)
    (else (member? x (cdr l)))))
;; member - вграденият метод връща подсписък с глава х или #f
```

## Сравнения

Сравнение на числа: `(= x y)`\
Сравнение на стойности `(eqv? a b)`\
Сравнение на списъци: `(equal? l1 l2)`\
!!Съществува и eq? - проверява за обекти в паметта, не го използваме в този курс, придържайте се към eqv?

## Задачи за решаване:
```
;; my-length l -> намира дължината на списъка (вградено е length)
;; n-th l n -> намира n-тия елемент на l (вградено е (list-ref l n))
;; count-occurs x l -> намира броя на срещанията на х в l
;; my-append l1 l2 -> залепя l1 и l2 (вградено е append)
;; push-back x l -> залепя х в края на l
;; take n l -> връща подсписък с първите n елемента на l
;; drop n l -> подсписък без първите n елемента на l
;; remove x l -> маха първото срещане на х в l
;; remove-all x l -> маха всички срещания на х от l
;; reverse l -> обръща реда на елементите в l
;; reverse-iter l -> като горното, но итеративно
;; all? p l -> проверява дали всички елементи на l изпълняват предиката p
;; any? p l -> проверява дали някой елемент на l изпълнява предиката p
;; my-map f l -> прилага функцията f върху елементите на l
;; my-filter p l -> връща само елементите от l, които отговарят на p
```