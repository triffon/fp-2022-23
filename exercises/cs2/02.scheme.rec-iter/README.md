# Рекурсия и итерация (упр 2)

#### [Сваляне на задачите][download]

> Често е по-лесно да решите задача рекурсивно първия път, нищо че е "по-бавно".

## Рекурсия

### [Зад 1 `count-digits`][count-digits]
Брой цифри на цяло число (вкл. и отрицателно).

### [Зад 2 `sum-digits`][sum-digits]
Сума от цифрите на цяло число.

### [Зад 3 `bin-to-dec`][bin-to-dec]
Преобразуване от двоична в десетична бройна система.

> Забележка: тук под бройна система разбираме просто използваните цифри в представянето на числото. Тоест няма създаваме двоични числа, започващи с [#b]. Фактически работим само с десетични числа в Scheme.

### [Зад 4 `dec-to-bin`][dec-to-bin]
Преобразува число от десетична в двоична бройна система.

### [Зад 5 `digit-occurence`][digit-occurence]
Колко пъти цифрата d се среща в цялото число n?

### [Зад 6 `reverse-digits`][reverse-digits]
Обръща реда на цифрите на число.

### [Зад 7 `palindrome?`][palindrome?]
Дали числото е палиндром?

### [Зад 8 `sum-divisors`][sum-divisors]
Сбор от делителите на число.

## Итерация

### Зад 9
Интеративен вариант в същия файл на
[`count-digits`][count-digits],
[`sum-digits`][sum-digits],
[`bin-to-dec`][bin-to-dec],
[`dec-to-bin`][dec-to-bin] и
[`reverse-digits`][reverse-digits].

### [Зад 10 `fasterpow`][fasterpow]
Итеративен вариант на Exponentiation by squaring.

### [Зад 11 `automorphic?`][automorphic?]
Дали е автоморфно числото? Едно число е _автоморфно_, ако квадратът му завършва на него.

### [Зад 12 `prime?`][prime?]
Дали числото е просто?

> Дадено цяло число n е просто, ако не се дели на никое от числата между 2 и n-1 (даже [от 2 до √n][primality-test]).

```scheme
(automorphic? 6) -> #t
(automorphic? 5) -> #t

(automorphic? 4) -> #f
(automorphic? 11) -> #f
```

[download]: https://download-directory.github.io/?url=https%3A%2F%2Fgithub.com%2Fstainlesspot%2Ffp-2022-23%2Ftree%2Fmain%2Fexercises%2Fcs2%2F02.scheme.rec-iter
[solutions]: ./solutions
[#b]: http://people.csail.mit.edu/jaffer/r5rs/Syntax-of-numerical-constants.html
[primality-test]: https://en.wikipedia.org/wiki/Primality_test
[prev-exercise]: ../01-basics/problems.01.rkt

[count-digits]: ./01.count-digits.rkt
[sum-digits]: ./02.sum-digits.rkt
[bin-to-dec]: ./03.bin-to-dec.rkt
[dec-to-bin]: ./04.dec-to-bin.rkt
[digit-occurence]: ./05.digit-occurence.rkt
[reverse-digits]: ./06.reverse-digits.rkt
[palindrome?]: ./07.palindrome.rkt
[sum-divisors]: ./08.sum-divisors.rkt
[fasterpow]: ./10.fasterpow.rkt
[automorphic?]: ./11.automorphic.rkt
[prime?]: ./12.prime.rkt
