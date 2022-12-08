# Упражнение 7

## Матрици

Можем да представим матрица като списък от списъци с равен брой елементи.

```scheme
;; матрица 1 x 1
'((1))

;; матрица 2 x 3
'((1 2 3) (4 5 6))
```

<details>
  <summary>Проверка за матрица</summary>
  
  ```scheme
  (define (all? predicate? lst)
    (foldr
      (lambda (x result) (and x result))
      #t
      (map predicate? lst)))

  (define (matrix? m)
    (and
      (list? m)
      (not (null? m))
      (not (null? (car m)))
      (let ((rowlength (length (car m))))
        (all?
          (lambda (x)
            (and (list? x) (= (length x) rowlength)))
          (cdr m)))))
  ```
</details>

### Помощни функции за работа с матрици

```scheme
(define matrix 
  '((1 2 3)
    (4 5 6)
    (7 8 9)))

;; вземане на първи ред и колона
(define get-first-row car)
(define (get-first-column matrix)
  (map car matrix))

;; (get-first-row matrix) ;; => '(1 2 3)
;; (get-first-column matrix) ;; => '(1 4 7)

;; изтриване на първи ред и колона
(define del-first-row cdr)
(define (del-first-column matrix)
  (map cdr matrix))

;; (del-first-row matrix) ;; => '((4 5 6) (7 8 9))
;; (del-first-column matrix) ;; => '((2 3) (5 6) (8 9))

;; вземане на произволен ред и колона
(define (get-row index matrix)
  (list-ref matrix index))

(define (get-column index matrix)
  (map (lambda (row) (list-ref row index)) matrix))

;; (get-row 1 matrix) ;; => '(4 5 6)
;; (get-column 1 matrix) ;; => '(2 5 8)
```

## Двоични дървета

### Пример

![Binary Tree](./binary-tree.png)

```scheme
'(1 (2 () ())
    (3 (4 () ())
       (5 () ())))
```

### Рекурсивна дефиниция

  - Празният списък `()` е дърво
  - `(root left-tree right-tree)` е дърво
      - с корен `root`
      - `left-tree` — ляво поддърво
      - `right-tree` — дясно поддърво

### Помощни функции за работа с двоични дървета

```scheme

(define empty-tree '())
(define empty-tree? null?)

(define (make-tree root left right)
  (list root left right))

(define (make-leaf element)
  (make-tree element empty-tree empty-tree))

(define root-tree car)
(define left-tree cadr)
(define right-tree caddr)
```

<details>
  <summary>Проверка за двоично дърво</summary>
  
  ```scheme
  (define (tree? tree)
    (or
      (null? tree)
      (and
        (list? tree)
        (= (length tree) 3)
        (tree? (left-tree tree))
        (tree? (right-tree tree)))))
  ```
</details>

---

## Задачи с матрици

```scheme
(define matrix 
  '((1 2)
    (3 4)
    (5 6)))
```

1. Дефинирайте функции `(row-count matrix)` и `(column-count matrix)`, които връщат броя редове и броя колони на матрицата `matrix` съответно.

2. Дефинирайте функция `(sum matrix)`, която намира сумата на всички елементи в дадена матрица

    ```scheme
    > (sum matrix) ;; => 21
    ```

3. Дефинирайте функция `(minimum matrix)`, която намира най-малкия елемент в дадената матрица

4. Дефинирайте функция `(matrix-ref matrix i j)`, която връща елемент на позиция $(i, j)$ в дадената матрица.

    ```scheme
    > (matrix-ref matrix 2 1) ;; => 6
    ```

5. Дефинирайте функция `(set-matrix matrix i j element)`, която връща матрицата матрица, образувана от `matrix`, но на позиция $(i, j)$ се намира `element`

    ```scheme
    > (set-matrix matrix 1 1 0)
    ;; => '((1 2) (3 0) (5 6)))
    ```

6. Дефинирайте функция `(diagonal matrix)`, която връщa диагонала на дадената матрица

    ```scheme
    > (diagonal matrix) ;; => '(1 4)
    ```

7. Дефинирайте функция `(delete-column index matrix)`, която връща матрица, образувана от `matrix`, премахвайки колоната на позиция `index`

    ```scheme
    > (delete-column 1 matrix) ;; => '((1) (3) (5)))
    ```

8. Дефинирайте функция `(transpose matrix)`, която транспонира дадената матрица

    ```scheme
    > (transpose matrix)
    ;; => '((1 3 5) (2 4 6))
    ```

9. Дефинирайте функция `(all-columns? predicate? matrix)`, който проверява дали за всяка колона в матрицата `matrix` е изпълнен предикатът `predicate?`.
Пример: Дали във всяка колона се съдържа нечетно число.

    ```scheme
    > (all-columns? (lambda (column) (member 2 column)) matrix) ;; => #f
    ```

10. Дефинирайте функция `(sum-matrices matrix1 matrix2)`, която събира две матрици с еднаква размерност

    ```scheme
    > (sum-matrices
        '((1 2 3) (4 5 6) (7 8 9))
        '((0 1 2) (3 4 5) (6 7 8)))
        ;; => '(( 1  3  5)
        ;;      ( 7  9 11)
        ;;      (13 15 17))
    ```

11. Дефинирайте функция `(product-matrices matrix1 matrix2)`, която умножава две матрици

    ```scheme
    > (product-matrices
        '((1 2 3) (4 5 6) (7 8 9))
        '((0 1 2) (3 4 5) (6 7 8)))
      ;; => '((24  30  36)
      ;;      (51  66  81)
      ;;      (78 102 126))
    ```

12. Дефинирайте функция `(triangular? matrix)`, която проверява дали дадена матрица е горно-триъгълна (всички елементи под главния диагонал са нули)

    ```scheme
    > (triangular?
        '((1 2 3 4)
          (0 5 6 7)
          (0 0 8 9)
          (0 0 0 1))) ;; => #t
    ```

## Задачи с двоични дървета

```scheme
(define tree
  '(1 (2 () ())
      (3 (4 () ())
         (5 () ()))))
```

13. Дефинирайте функция `(depth tree)`, която намира дължочината на подаденото двоично дърво

    ```scheme
    > (depth tree) ;; => 3
    ```

14. Дефинирайте функция `(map-tree func tree)`, която връща ново дърво, образувано от `tree`, замествайки всеки връх $x$ от дървото `tree` с $func(x)$.

    ```scheme
    > (map-tree (lambda (x) (+ x 1)) tree)
    ;; => '(2 (3 () ())
    ;;        (4 (5 () ())
    ;;           (6 () ())))
    ```

15. Дефинирайте функции `(collect-pre-order tree)` и`(collect-in-order tree)`, които връщат списък от елементите на дървото, обходено съотвено root-left-right и left-root-right

    ```scheme
    > (collect-pre-order tree) ;; => '(1 2 3 4 5)
    > ((collect-in-order tree) ;; => '(2 1 4 3 5)
    ```

16. Дефинирайте функция `(count-leaves tree)`, която намира броя на листата на подаденото двоично дърво

    ```scheme
    > (count-leaves tree) ;; => 3
    ```

17. Дефинирайте функция `(level tree index)`, която връща списък от стойностите на възлите, намиращи се на дълбочина `index` от корена

    ```scheme
    > (level tree 1) ;; => '(2 3)
    ```

18. Дефинирайте функция `(prune tree)`, която премахва всички листа в подаденото дърво

    ```scheme
    > (prune tree) ;; => '(1 () (3 () ()))
    ```

19. Дефинирайте функция `(invert tree)`, която връща огледалния образ на `tree`

    ```
        1               1
       / \   invert    / \
      2   3 ========> 3   2
         / \         / \
        4   5       5   4
    ```

20. Дефинирайте фунцкия `(contains? tree path)`, която проверява дали пътят `path` - списък от стойности, се съдържа в подаденото дърво

    ```scheme
    (define example-tree
      '(1 (2 () ())
          (1 (2 () ())
             (3 (4 () ())
                (5 () ())))))

    > (contains? example-tree '(1 3 4)) ;; => #t
    > (contains? example-tree '(1 2 4)) ;; => #f
    ```

21. Дефинирайте функция `(path element tree)`, която намира пътя до `element` в подаденото дърво или връща `#f`, ако такъв не съществува

    ```scheme
    > (path 4 tree) ;; => '(1 3 4)
    > (path 6 tree) ;; => #f
    ```

22. Дефинирайте функция `(paths tree)`, която намира всички пътища, започващи от корена, в подаденото дърво

    ```scheme
    > (paths tree) ;; => '((1 2) (1 3) (1 3 4) (1 3 5))
    ```
23. Двоично наредено дърво е двоично дърво, в което:
    - елементите, $<=$ от корена, се намират в лявото поддърво 
    - елементите, $>$ от корена, се намират в дясното поддърво</br></br>
    
    Дефинирайте предикат `(binary-search-tree? tree)`, който проверява дали подаденото дървото е наредено

      ```scheme
      (define binary-search-tree
        '(3 (1 () (2 () ()))
            (4 () (5 () ()))))

      > (binary-search-tree? tree) ;; => #f
      > (binary-search-tree? binary-search-tree) ;; => #t
      ```

24. Дефинирайте функция `(binary-serach-tree-insert tree element)`, която вмъква елемента `element` в подаденото двоичното наредено дърво. Новополученото дърво трябва да бъде двоично наредено.

25. Дефинирайте функция `(tree-sort lst)`, която сортира подадения списък, използвайки двоично наредено дървo