
# Как да форматираме кода си в Scheme

Виж [тук](http://community.schemewiki.org/?scheme-style) и [тук](http://web.archive.org/web/20020809131500/www.cs.dartmouth.edu/~cs18/F2002/handouts/scheme-tips.html)

---

TL;DR

:arrow_right: Избягваме самотни скоби

```scheme
;; лошо
(define (factorial n)
  (if (= n 0)
      1
      (* n (factorial (- n 1)))
  )
)

;; по-добре
;; затваряшите скоби са в края на последния израз
;; следващият израз започва на нов ред
(define (factorial n)
  (if (= n 0)
      1
      (* n (factorial (- n 1)))))
```

:arrow_right: Индентираме подизразите на даден израз еднаквно

```scheme
;; лошо
;; подизразите на cond не са подравнени
(define (power base exponent)
  (cond ((< exponent 0) (power (/ 1 base) (- exponent)))
    ((= exponent 0) 1)
    ((> exponent 0) (* base (power base (- exponent 1))))))

;; по-добре
(define (power base exponent)
  (cond
    ((< exponent 0) (power (/ 1 base) (- exponent)))
    ((= exponent 0) 1)
    ((> exponent 0) (* base (power base (- exponent 1))))))

;; друг вариант
(define (power base exponent)
  (cond ((< exponent 0) (power (/ 1 base) (- exponent)))
        ((= exponent 0) 1)
        ((> exponent 0) (* base (power base (- exponent 1))))))
```

:arrow_right: Ако някой от подизразите на даден израз стане сложен, отделяме всички подизрази на нов ред

```scheme
;; лошо
;; не е веднага очевидно, че събираме 3 израза -
;; 3^2 + 2x - 1
(define (root? x)
  (= 0 (+
         (* 3 (expt x 2))
         (* 2 x) -1)))

;; по-добре
;; всеки подизраз е на нов ред
(define (root? x)
  (= 0 (+
         (* 3 (expt x 2))
         (* 2 x)
         -1)))
```