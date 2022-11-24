#lang racket


(define m1
  '((1 2 3)
    (4 5 6)
    (7 8 9)
    (1 2 3)))

(define (transpose m)
  (apply map list m))

(define (matrix-ref m i j)
  (list-ref (list-ref m i) j))


(define (delete-list i l)
  (if (null? l)
      l
      (if (= i 0)
          (cdr l)
          (cons (car l)
                (delete-list (- i 1)
                             (cdr l))))))

(define (delete-row i m)
  (delete-list i m))

(define (delete-column i m)
  (transpose (delete-row i (transpose m))))

(define (delete-column2 i m)
  (map (lambda (row)
         (delete-list i row))
       m))


(define list->string ~s) ; from racket

(define (pretty-sprint-matrix m)
  (foldr string-append
         ""
         (map (lambda (row)
                (string-append (list->string row)
                               "\n"))
              m)))
(define (pretty-print-matrix m)
  (display (pretty-sprint-matrix m)))

(define (all? p? l)
  (foldr (lambda (x rec) (and x rec))
         #t
         (map p? l)))
(define (any? p? l)
  (not (all? (compose not p?) l)))

(define (find-columns m)
  (define (pred? col)
    (all? (λ (c)
            (any? (λ (row)
                    (member c row))
                  m))
          col))
  (apply +
         (map (λ (col)
                (if (pred? col)
                    1
                    0))
              (transpose m))))
  
;(find-columns '((1 4 3) (4 5 6) (7 4 9)))









(define the-empty-tree '())

(define (make-tree2 root left right)
  (cons root (cons left right)))
(define (make-tree root left right)
  (list root left right))

(define root-t car)
(define left-t cadr)
(define right-t caddr)

(define t1
  '(1 (2 () ())
      (3 (4 () ())
         (5 () ()))))


(define (collect-pre-order t)
  (if (null? t)
      '()
      (let ((root (root-t t))
            (left (left-t t))
            (right (right-t t)))
        (append (list root)
                (collect-pre-order left)
                (collect-pre-order right)))))

(define (collect-in-order t)
  (if (null? t)
      '()
      (let ((root (root-t t))
            (left (left-t t))
            (right (right-t t)))
        (append (collect-pre-order left)
                (list root)
                (collect-pre-order right)))))


(define (collect-post-order t)
  (if (null? t)
      '()
      (let ((root (root-t t))
            (left (left-t t))
            (right (right-t t)))
        (append (collect-pre-order left)
                (collect-pre-order right)
                (list root)))))



(define (map-tree f t)
  (if (null? t)
      '()
      (let ((root (root-t t))
            (left (left-t t))
            (right (right-t t)))
        (make-tree ; може и просто list
         (f root)
         (map-tree f left)
         (map-tree f right)))))

(define (1+ n) (+ n 1))

(define (height t)
  (if (null? t)
      0
      (+ 1
         (max (height (left-t t))
              (height (right-t t))))))

(define (leaf? t)
  (and (not (null? t))
       (null? (left-t t))
       (null? (right-t t))))
       
(define (count-leaves t)
  (cond ((null? t) 0)
        ((leaf? t) 1)
        (else (+ (count-leaves (left-t t))
                 (count-leaves (right-t t))))))
(define (remove-leaves t)
  (cond ((null? t) '())
        ((leaf? t) '())
        (else (make-tree (root-t t)
                         (remove-leaves (left-t t))
                         (remove-leaves (right-t t))))))



(define (bstH pred? t)
  (cond ((null? t) #t)
        ((leaf? t) (pred? (root-t t)))

        (else (and (pred? (root-t t))
                   (bstH (lambda (x)
                           (and (pred? x)
                                (< x
                                   (root-t t))))
                         (left-t t))
                   (bstH (lambda (x)
                           (and (pred? x)
                                (< (root-t t)
                                   x)))
                         (right-t t))
                   ))))

(define (bst? t)
  (bstH (const #t) t))

(define t2
  '(10 (9 () ())
       (15 (11 () ())
           (20 (16 () ())
               ()))))








