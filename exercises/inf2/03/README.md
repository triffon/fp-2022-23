# Упражнение 3

## Lambda функции

Анонимни фукнции - удобни когато фукнцията, която дефинираме се използва само на едно място. Не е нужно да им измисляме име.

```scheme
(lambda (arg1 arg2 ... argn)
    body)

;; идентитет
(lambda (a) a)

;; функция, която при подадено число, връща следващото
(lambda (a) (+ a 1))

;; lambda функциите могат да бъдат извикани с аргументи 
;; веднага след дефиницията си
> ((lambda (a) (+ a 1)) 1) ;; => 2
```
## Функции от по-висок ред

Функциите в Scheme са "first-class citizens" - те могат да бъдат подавани наоколо, подобно на всички останали стойности (числа, списъци).

Функция от по-висок ред е тази, която приема функция като аргумент и/или връща функция като резултат.

```scheme
;; функция, която приема функция като аргумент
(define (apply1 func a b)
    (func a b))

> (apply1 + 1 2)     =>  3
> (apply1 expt 2 3)  =>  8
> (apply2 string-append "yo " " dawg") => "yo dawg"

;; функция, която връща функция като резултат
(define (apply2 func)
  (lambda (a b) (func a b)))

> (apply2 + 1 2) => error
;; apply2: arity mismatch;
;; the expected number of arguments does not match the given number
;; expected: 1
;; given: 3

> ((apply2 +) 1 2)     => 3
> ((apply2 expt) 2 3)  => 8
> ((apply2 string-append) "yo " "dawg") => "yo dawg"
```

![Yo Dawg Meme](./xzibit.jpeg)

## Accumulate

Функциите от по-висок ред допринасят за модулярността на програмата. Използването на функция, която е приложима в различни случаи, прави програмата по-четима от писането на сходни функции за всеки отделен случай.

```scheme
(define (accumulate operation null-value start end term next)
  (if (> start end)
      null-value
      (operation
            (term start)
            (accumulate operation null-value (next start) end term next))))

(define (accumulate-iter operation null-value start end term next)
  (if (> start end)
      null-value
      (accumulate-iter operation (operation null-value (term start)) (next start) end term next)))

(define (sum-interval start end)
  ???)

(define (prod-interval start end)
  ???)

(define (factorial number)
  ???)

(define (power base exp)
  ???)
```
