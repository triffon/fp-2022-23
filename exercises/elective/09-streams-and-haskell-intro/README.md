# Потоци

## Отложени операции - нещо, което ще се изчисли в бъдещето (когато ни потрябва)
```
(define example (delay (+ 1 2))) ; това ще върне promise
(force example) ; ще накара promise да се изпълни
```

## Потоци
Потокът изглежда като `(<глава> . <опашка>)`, където опашка е promise. Работим с потоци по идентичен начин на работата със списъци.

## Как се дефинират функции за работа с потоци?
```
;; (define (cons-stream a b)
;;  (cons a (delay b)))
;; така няма да ни се получи^

(define-syntax cons-stream
  (syntax-rules () {(cons-stream a b) (cons a (delay b))}))
;; Така се дефинира специална форма. Тя ще ни позволи да отложим оценяването на втория аргумент на cons.

(define the-empty-stream '())

(define (stream-first str) (car str))
(define (stream-rest str) (force (cdr str)))
```

## Вградени функции за работа с потоци
### Вляво - за работа със списъци; вдясно - за работа с потоци

За да използваме функциите за потоци, сменяме езика на racket:
```
#lang racket

;; '() -> empty-stream
;; cons -> stream-cons
;; list -> stream
;; list? -> stream?
;; car -> stream-first
;; cdr -> stream-rest
;; list-ref -> stream-ref
;; null? -> stream-empty?
```

Във всеки един момент работим с някаква част от поток, затова можем без проблем да дефинираме безкрайни потоци.


## Задачи за решаване:

```
;; 1. stream-from-interval a b - връща поток от числата в затворения интервал [a,b]
;; 2. stream-to-list s - връща списък от елементите на поток s
;; 3. stream-from-list l - връща поток от елементите на списък l
;; 4. ones -> безкраен поток от единици
;; 5. n-stream -> поток от всички естествени числа, започващи от n
;; 6. my-stream-take -> поток от първите n елемента на даден поток
;; 7. add-streams s1 s2-> поток от сбора на два потока
;; 8. fib-stream -> безкраен поток от числата на Фибоначи
;; 9. repeat-list l -> прави безкраен поток от елементите на списък l
;; 10. iterate x f -> безкраен поток от типа x, f(x), f(f(x)), ...
```

# Въведение в Haskell
## (типизиран език, който се компилира)

## Малко детайли за работа:
Сваляме си GHC (Glasgow Haskell Compiler) от [тук](https://www.haskell.org/downloads/).\
[Книжка за Haskell](http://learnyouahaskell.com/)\
[VS code](https://code.visualstudio.com/) (редактор, в който можем и да използваме терминал)\
**!!! Внимаваме с индентацията на кода, който пишем!**

### Полезни команди:
`ghci` - така отваряме интерактивния режим на GHC. Следващите команди са след като вече сме заредили ghci\
`:load` или `:l` + път към файла ни - зарежда файла в средата ни\
`:reload` или `:r` - след всяка промяна, за да се обнови\
`:quit` или `:q` за изход от ghci

### Основни типове в езика:
```
-- Bool
-- Int
-- Integer
-- Float
-- Double
-- Char
-- String
```

### Аритметични операции:

```
4 + 5
(+) 4 5
4 `mod` 3
4 `div` 2
2 ^ 3
```

### Сравнения:
```
4 >= 5
2 == 3
2 /= 3
```

## Логически операции
```
True && True
True || False
not True
```


### Задаване на тип и стойност:
```
a :: Int
a = 5

-- :t a в ghci ще ни върне типа на а
```

### Дефиниране на функция:
```
mySum :: Int -> Int -> Int
mySum a b = a + b

-- mySum приема два аргумента от тип Int и връща Int

-- currying - имаме отложено оценяване
add4 :: Int -> Int
add4 = mySum 4
```

### Примери за употреба на основни конструкции:

```
-- с if + рекурсия
fact :: Int -> Int
fact n = if n == 1 then 1 else n * fact (n - 1)

-- с гардове
-- тук след името на функцията не слагаме =
fact' :: Int -> Int
fact' n
  | n == 1 = 1
  | otherwise = n * fact' (n - 1)

-- pattern matching
-- винаги от най-конкретното към по-общото
fact'' :: Int -> Int
fact'' 1 = 1
fact'' n = n * fact'' (n - 1)

-- вложени функции
fib :: Int -> Int
fib n = helper 1 1 n where
  helper curr prev i
    | i == 0 = 0
    | i == 1 = curr
    | otherwise = helper (curr + prev) curr (i - 1)

-- друг начин за вложени функции
fib' :: Int -> Int
fib' n = let
  helper curr prev i
    | i == 0 = 0
    | i == 1 = curr
    | otherwise = helper (curr + prev) curr (i - 1)
 in helper 1 1 n
 ```

## Задачи за решаване:
```
-- 1. max a b
-- 2. countDigits
-- 3. reverseDigits
-- 4. prime?
```