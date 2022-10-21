# Функции от по-висок ред
## Accumulate, анонимни функции, let изрази


### Загрявка:
```
;; automorphic? n - когато повдигнем n на квадрат дали завършва със себе си
```
## Функция от по-висок ред - приемат функции като аргументи и/или връщат функции

код от упражнението:

```
;; a + |b|
(define (mod-sum a b)
  ((if (< 0 b) + -) a b))

(define (cube x)
  (* x x x))

(define (id x) x)
(define (plus-one x) (+ x 1))

(define (sum-interval a b)
  (if (> a b)
      0
      (+ (id a) (sum-interval (+ a 1) b))))

(define (sum-cubes-interval a b)
  (if (> a b)
      0
      (+ (cube a) (sum-cubes-interval (+ a 1) b))))

(define (product a b)
  (if (> a b)
      1
      (* a (product (+ a 1) b))))

(define (sum-int-func a b f)
  (if (> a b)
      0
      (+ (f a) (sum-int-func (+ a 1) b f))))

;; тук първоначално подадохме cubes, после сменихме с анонимна функция

(define (sum-cubes-interval2 a b)
  (sum-int-func a b (lambda (x) (* x x x))))
```

Най-важното: изведохме долните две:

```
(define (accumulate op nv a b term next)
  (if (> a b)
      nv
      (op (term a) (accumulate op nv (next a) b term next))))

(define (accumulate-iter op nv a b term next)
  (if (> a b)
      nv
      (accumulate-iter op (op (term a) nv) (next a) b term next)))
```

И още примери:

```
(define (sum-interval-acc a b)
  (accumulate + 0 a b id (lambda (x) (+ x 1))))

(define (sum-cubes-acc a b)
  (accumulate + 0 a b cube plus-one))

(define (product-acc a b)
  (accumulate * 1 a b id plus-one))

(define (product-exp-acc a b)
  (accumulate * 1 a b exp plus-one))
```

## Анонимни (lambda) функции

Общ вид:
```
(lambda (<аргумент 1> <аргумент 2> ... <аргумент n>) (<тяло>))
```

```
(lambda (x) (+ x 1))
((lambda (x) (+ x 1)) 4)

(define a 5)
(define 1+ (lambda (x) (+ x 1))) ;; == (define (1+ x) (+ x 1))

(define 2+ (lambda (x) (+ x 2)))
;; (define (2+ x) (+ x 2))

(define (n+ n) (lambda (x) (+ x n)))
(define (n++ n x) (+ x n))

;; compose f g -> връща процедура - композицията на f и g
(define (compose f g) (lambda (x) (f (g x))))
```

## Let, let*, letrec
- свързваме име и стойност локално за израза
- let* ни дава достъп до горните свързвания
- letrec ни дава опция да ги викаме рекурсивно (ама да мислим за дъно все пак)
### ! ВАЖНО: let стойностите са достъпни само в блока им

```
(define (sum-let a b)
  (let
    ((first a)
    (second (b)))
    (+ first second)
  )
)

(define (division a b)
  (let* (
        (делимо a)
        (делител b)
        (частно (/ делимо делител)))
    частно))

(define (testletrec-even? x)
  (letrec
    ((my-even? (lambda (x)
                (if (= x 0)
                    #t
                    (my-odd? (- x 1)))))
    (my-odd? (lambda (x)
                (not (my-even? x)))))
    (my-odd? x)))
```

## Задачи за решаване:
```
;; Използвайки accumulate, анонимни функции и let изрази:

;; 1. repeat f n - композиция на f n пъти в себе си
;; 2. factorial - използвайки accumulate
;; 3. all? a b pred - проверка дали всички числа в интервала [a, b] удовлетворяват предиката pred
;; 4. any? a b pred - проверка дали някой елемент в интервала удовлетворява предиката pred
;; 5. count-primes a b - брои колко прости числа има в интервала
;; 6. sum-roots a b c - намира сбора на корените на квадратно уравнение с параметри a, b и c
```
