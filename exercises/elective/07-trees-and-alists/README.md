# Двоични дървета и асоциативни списъци

## Дървета
'() е дърво\
'(root left right) е дърво, ако left и right също са дървета\
bst е двоично наредено дърво - всички елементи на лявото поддърво са по-малки или равни на корена, а всички елементи на дясното поддърво - по-големи от него.
```
(define empty-tree '())
(define empty-tree? null?)
(define (make-tree root left right) (list root left right))
(define (root t) (car t))
(define (left t) (cadr t))
(define (right t) (caddr t))

(define (leaf? t)
  (and (not (empty-tree? t))
       (empty-tree? (left t))
       (empty-tree? (right t))))

(define (make-leaf x)
  (make-tree x empty-tree empty-tree))

(define example-tree
  (make-tree 1
             (make-tree 2
                        empty-tree
                        (make-tree 3
                                   (make-leaf 4)
                                   empty-tree))
             (make-tree 5
                        empty-tree
                        (make-tree 6
                                   (make-leaf 7)
                                   (make-leaf 8)))))
```
! Когато решаваме задачи, използваме горните дефинирани функции и абстракцията, която ни предоставят (например когато искаме да вземем корена на дървото, използваме (root t) вместо (car t), защото не следва да ни интересува начина, по който се взима корен).\

## Асоциативни списъци:
Имат вида `'((ключ1 . стойност1) ... (ключn . стойностn))`\
още познати като map, dictionary, etc ..

```
(define (1+ x) (+ x 1))

(define (create-alist l f) (map (lambda (x) (cons x (f x))) l))

(define (add-alist key value alist) (cons (cons key value) alist))
```
## Задачи за решаване
```
;; 1. (find-element i j m) -> намира m[i,j]
;; 2. tree? -> проверка дали t е дърво
;; 3. leaves -> връща списък от листата на t
;; 4. pre-order -> обхожда дърво ляво-корен-дясно
;; 5. in-order -> корен-ляво-дясно
;; 6. post-order -> дясно-корен-ляво
;; 7. map-tree f t -> прилага f върху елементите на дървото
;; 8. bst? t -> проверява дали t е двоично наредено
;; 9. bst-member? x t -> проверява дали х е член на двоично нареденото дърво t
;; 10. bst-insert x t -> добавя х на правилното място в двоично нареденото дърво t
;; 11. flip-tree t -> разменя лявото и дясното поддърво
;; 12. height t -> намира височината на дървото
;; 13. level n t -> намира елементите на ниво n
;; 14. levels t -> връща списък от нивата на t
;; 15. keys alist -> връща списък от ключовете на асоциативен списък alist
;; 16. values  alist -> списък от стойностите на alist
;; 17. map-values alist f
;; 18. filter-values alist p -> връща тези наредени двойки, за които p (value) се изпълнява
;; 19. replace key new-value alist -> на мястото на елемент с ключ key добавяме нова стойност
```