# Функции от по-висок ред за работа със списъци

Списъци; Функции за работа със списъци - apply, fold

## Apply
Прилага функция върху списък с аргументи
- Елементите на списъка се подават на съответното място като аргументи
- Подават се едновременно
```
(apply + '(1 2 3))

(define (my-sum a b)
  (+ a b))

(apply my-sum '(1 2))
(apply my-sum '(1 2 3))
```

## Fold -> "сгъване" - имаме сгъване от ляво надясно (foldl) и от дясно наляво (foldr)
- `(foldl my-sum 0 '(1 2 3))` и `(foldr my-sum 0 '(1 2 3))` ще изведат еднакъв резултат
- `(foldr cons '() '(1 2 3))` е еквивалентно на `(cons 1 (cons 2 (cons 3 '())))`
- `(foldl cons '() '(1 2 3))` е еквивалентно на `(cons 3 (cons 2 (cons 1 '())))`
- Функцията, която подаваме на fold, трябва да е двуаргументна. Вторият елемент е nv или резултата до момента.
```
(define (my-map f l)
  (foldr (lambda (x y) (cons (f x) y)) '() l))

(define (my-filter p l)
  (foldr (lambda (x y) (if (p x) (cons x y) y)) '() l))
```

## Функции с произволен брой аргументи
args е обикновен списък
- може да проверяваме дали е празен
- може да го кръстим по друг начин
- може да му прилагаме функции
```
;; (define (f . args) ...)

(define (compose f g)
  (lambda (x) (f (g x))))

(define (compose-funcs . fns)
  (foldr compose (lambda (x) x) fns))
```


## Задачи
```
;; my-foldl
;; my-foldr
;; my-max
;; remove-duplicates
;; union l1 l2 - намира обединението на два списъка
;; intersection l1 l2 - намира сечението на два списъка
;; my-reverse l - обръща елементите на списък
;; all? p l - проверява дали всички елементи на l удовлетворяват p
;; any? p l - проверява дали някой елемент на l изпълнява p
;; insert val l (l е нареден (сортиран))
;; insertion-sort l - сортира l
;; partition p l - разделя l на два списъка - списък с елементи, които изпълняват p и такива, които не го
;; my-flatten l - превръща всички подсписъци в елементи (елиминира влагането) -> (flatten '(1 2 (3 4 (5)) 6)) -> '(1 2 3 4 5 6)
;; deep-map f l - прилага f върху всички елементи на l. ако l включва подсписъци, прилага f върху елементите на подсписъците
;; concat . lists - конкатенира произволен брой списъци (веднъж пробвайте с fold, веднъж с apply)
```



