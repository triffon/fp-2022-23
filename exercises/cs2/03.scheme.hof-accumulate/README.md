# 03. Accumulate и функции от по-висок ред

#### [Сваляне на задачите][download]

## Accumulate
Решете следните задачи чрез `accumulate`. За улеснение, може да първо да направите рекурсивно решение.

### [Зад 1 `fact` и `fib`][fib-fact]
Имплементирайте `fact` и `fib` чрез `accumulate`.

> Задачата за `fib` чрез `accumulate` не е особено трудна, стига да знаете формулата,
която се извежда по интересен начин от триъгълника на Паскал.
[Wikipedia](https://en.wikipedia.org/wiki/Fibonacci_number#Mathematics).

### [Зад 2 `newton-binomial`][newton-binomial]
[Нютонов бином][newton-wiki].

### [Зад 3 `count-palindromes`][count-palindromes]
Броят на целите числа палиндроми в интервала [a, b].

### [Зад 4 `prime?-acc`][prime?-acc]
Имплементирайте `prime?` чрез `accumulate` или `accumulate-i`.

### [Зад 5 `exists-int?`][exists-int?]
Дали **има** цяло число в интервала [a, b], за което предикатът `pred?` е истина?

### [Зад 6 `all-int?`][all-int?]
Дали **за всяко** цяло число в интервала [a, b] предикатът `pred?` е истина?

### [Зад 7 `count-p`][count-p]
Броят на числата, удовлетворяващи предиката `pred?` сред числата `a`, `(next a)`, `(next (next a))`, ..., `b`.

### Зад 8 `digit-sum`
Да се напише функция, която намира сбора на цифрите на числото n

### [Зад 9 `maximum-digit-sum`][maximum-digit-sum]
Най-голямата сума на цифрите на цяло число от интервала [a, b].

### [Зад 10 `count-pairs-gcd`][count-pairs-gcd]
Броят на наредените двойки цели числа (`x`,`y`) от интервала [a,b], които имат най-голям общ делител равен на `n`.

### Зад 11 `twist`
Да се напише функция `(twist k f g)`, която за дадени едноместни функции `f` и `g` и четно число `k` връща функция, еквивалентна на `f(g(f(g(...(x)...))))`, където общият брой извиквания на `f` и `g` е `k`.
```scheme
(define (++ x) (+ x 1))
(define (sq x) (* x x))
(define foo (twist 4 ++ sq))
; това ще смята ((((x^2)+1)^2)+1)
(define bar (twist 2 ++ sq))
; това ще смята ((x^2)+1)
(foo 2) -> 26
(bar 2) -> 5
```

### Зад 12. (задача 1 от контролно 2021/22)
Едно естествено число наричаме **свършено**, ако е с 2 по-малко от сумата на всичките си делители по-малки от него.
- а) (3 т.) Да се реализира функция `done?`, която проверява дали дадено число е свършено.
- б) (7 т.) Да се реализира функция `sum-almost-done`, която по подадени естествени числа a и b намира сумата на всички числа в интервала [a; b], които са по-близко до свършено число, отколкото до краищата на интервала.

```scheme
(done? 20) → #t
(done? 28) → #f

(sum-almost-done 5 24) → 153 ; сумата на числата от 13 до 21
```

### Зад 13. (вариант А, задача 1 от контролно 2019/20)
- а) (3 т.) Да се реализира функция `product-digits`, която намира произведението от цифрите на дадено естествено число.
- б) (7 т.) Нека с **{n}** означим разликата на n и произведението на цифрите на **n**. Да се реализира функция `largest-diff`, която намира най-голямата разлика **{m} – {n}** за **m, n ∈ [a; b]**, където **a** и **b** са параметри на функцията.
Пример:
```scheme
(largest-diff 28 35) → 19  = {30} – {29} = (30 – 0) – (29 – 18)
```


[download]: https://download-directory.github.io/?url=https%3A%2F%2Fgithub.com%2Ftriffon%2Ffp-2022-23%2Ftree%2Fmain%2Fexercises%2Fcs2%2F03.scheme.hof-accumulate
[newton-wiki]: https://en.wikipedia.org/wiki/Binomial_theorem

[fib-fact]: ./01.fib-fact.rkt
[newton-binomial]: ./02.newton-binomial.rkt
[count-palindromes]: ./03.count-palindromes.rkt
[prime?-acc]: ./04.prime-acc.rkt
[exists-int?]: ./05.exists-int.rkt
[all-int?]: ./06.all-int.rkt
[count-p]: ./07.count-p.rkt
[maximum-digit-sum]: ./09.maximum-digit-sum.rkt
[count-pairs-gcd]: ./10.count-pairs-gcd.rkt
