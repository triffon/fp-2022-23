# Матрици + подготовка за контролно

## Загрявка: 
`(sum-of-products ll)` -> намира сумата от произведенията на всички подсписъци в ll
`(sum-of-products '((1 2 3) (4 5) (6))) -> (6 20 6) -> 32`

## Матрици
- представят се като списък от редовете си
- всеки ред има равна дължина

```
'((1 2 3)
  (4 5 6)
  (7 8 9))

(define (remove-first-row m) (cdr m))
(define (remove-first-column m) (map cdr m))
```

## Задачи

```
;; 1. dimensions -> наредена двойка брой редове и колони
;; 2. main-diagonal -> намира главния диагонал
;; 3. second-diagonal -> намира другия диагонал
;; 4. nth-row -> намира n-тия ред
;; 5. nth-column -> намира n-тата колона
;; 6. transpose -> транспонира матрицата m
;; 7. skip-nth-row -> маха n-тия ред
;; 8. skip-nth-column -> маха n-тата колона
;; 9. sc-multiply -> скаларно произведение на матрицата m с числото x
;; 10. multiply -> умножава матриците m и n
```


## Подготовка за контролно
Примерно контролно 1: https://learn.fmi.uni-sofia.bg/mod/page/view.php?id=259431 \
Примерно контролно 2: https://learn.fmi.uni-sofia.bg/mod/url/view.php?id=218641
