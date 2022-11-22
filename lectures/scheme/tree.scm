(define empty-tree '())
(define empty-tree? null?)
(define (make-tree root left right) (list root left right))
(define root-tree car)
(define left-tree cadr)
(define right-tree caddr)
(define (make-leaf x) (make-tree x empty-tree empty-tree))

(define t
  (make-tree 1 (make-leaf 2)
               (make-tree 3 (make-leaf 4)
                            (make-leaf 5))))

(define (tree? t)
  (or (null? t)
      (and
       (list? t)
       (= (length t) 3)
       (tree? (cadr t))
       (tree? (caddr t)))))
