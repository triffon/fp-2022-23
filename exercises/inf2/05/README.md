# Упражнение 5

## Функции от по-висок ред над списъци

#### map

```scheme
;; синтаксис - map приема функция и списък
;; прилага функцията над всеки елемент от подадения списък
;; връща нов списък
;; (map function list)

(map (lambda (x) (+ x 1)) '(1 2 3)) ;; => '(2 3 4)

(map car '((1 2 3) (4) (5 6) (7)))  ;; => '(1 4 5 7)

(map
    (lambda (f) (f 2))
    (list even? (lambda (x) (+ x 1)) list))
;; => '(#t 3 (2))
```

#### filter

```scheme
;; синтаксис - filter приема функция-предикат и списък
;; премахва елементите от списъка, които не изпълняват подаденото условие
;; връща нов списък
;; (filter predicate list)

(filter (lambda (x) (> x 4)) '(2 3 4 5)) ;; => '(5)
(filter pair? '(1 (2) (3 4 5))) ;; => '((2) (3 4 5))
```

#### foldr (дясно свиване)

![foldr](./foldr.png)

```scheme
;; синтаксис - foldr приема функция, нулева стойност и списък
;; прилага подадената функция над елементите на list отдясно-наляво
;; (foldr function null-value list)

;; (foldr function null-value '(a1 a2 a3 .. an)) е еквивалентно на
;; (a1 function (a2 function (a3 function (... (an function null-value)))))

;; еквивалентно на (1 + (2 + (3 + (4 + 0))))
(foldr + 0 '(1 2 3 4)) ;; => 10

;; еквивалентно на (1 - (2 - (3 - (4 - 0))))
(foldr - 0 '(1 2 3 4)) ;; => -2

;; еквивалентно на горното
(foldr
    (lambda (curr accum) (- curr accum))
    0
    '(1 2 3 4))
;; => - 2

;; еквивалентно на (cons 1 (cons 2 (cons 3 (cons 4 '()))))
(foldr cons '() '(1 2 3 4) ;; => '(1 2 3 4)

;; "fold-right can be thought of as replacing the pairs in the spine of  
;; the list with procedure and replacing the () at the end with initial"
```

#### foldl (ляво свиване)

![foldl](./foldl-racket.png)

```scheme
;; синтаксис - foldl приема функция, нулева стойност и списък
;; прилага подадената функция над елементите на list отляво-надясно
;; (foldl function null-value list)

;; (foldl function null-value '(a1 a2 a3 .. an)) е еквивалентно на
;; (an function (... (a3 function (a2 function (a1 function null-value)))))

;; еквивалентно на (4 + (3 + (2 + (1 + 0))))
(foldl + 0 '(1 2 3 4)) ;; => 10

;; еквивалентно на (4 - (3 - (2 - (1 - 0))))
(foldl - 0 '(1 2 3 4)) ;; => 2

;; еквивалентно на горното
(foldl
    (lambda (curr accum) (- curr accum))
    0
    '(1 2 3 4))
;; => 2

;; еквивалентно на (cons 4 (cons 3 (cons 2 (cons 1 '()))))
(foldl cons '() '(1 2 3 4)) ;; => '(4 3 2 1)
```

---

## Задачи
