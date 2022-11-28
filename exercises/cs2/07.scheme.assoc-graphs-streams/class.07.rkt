#lang racket


(define a1 '((1 . 2) (2 . 1) (3 . 5)))

(define a2 '((1 2 3) (4 5 6 7) (8 9 7 6)))

(define (foldl op nv l)
  (if (null? l)
      nv
      (foldl op (op nv (car l)) (cdr l))))

(define (index l)
  (define (op acc x)
    (cons (cons (+ 1 (caar acc)) x)
          acc))
  (define nv (list (cons 0 (car l))))
  (reverse (foldl op nv (cdr l))))


(define (histogram l)
  (define (count x l)
    (length (filter (lambda (y) (equal? y x))
                    l)))
  (define (remove x l)
    (filter (lambda (y) (not (equal? x y))) l))

  (if (null? l)
      '()
      (cons (cons (car l)
                  (count (car l) l))
            (histogram (remove (car l) l)))))


(histogram '(8 7 1 7 8 2 2 8 2 7 8 1))
; ->'((8 . 4) (7 . 3) (1 . 2) (2 . 3))




(define (group-by f l)
  (define (equi-class x)
    (filter (lambda (y)
              (equal? (f x) (f y)))
            l))
  (define (remove-class x)
    (filter (lambda (y)
              (not (equal? (f x) (f y))))
            l))

  (if (null? l)
      l
      (let ((x (car l))
            (tail (cdr l)))
        (cons (cons (f x)
                    (equi-class x))
              (group-by f (remove-class x))))))



(group-by (lambda (x) (remainder x 3)) '(0 1 2 3 4 5 6 7 8))
; връща асоциативния списък '((0 0 3 6) (1 1 4 7) (2 2 5 8))






(define stream1
  (cons 1
        (delay stream1)))




(define g1
  '((a b c d)
    (b)
    (c e)
    (d)
    (e b)))
(define g2
  '((a b c d)
    (b c)
    (c e)
    (d)
    (e b)))
(define g3
  '((a b c d)
    (b)
    (c e)
    (d d)
    (e b)))


(define (vertices g)
  (map car g))

(define (children v g)
  (cdr (assoc v g)))

(define (predecessors v g)
  (filter (lambda (u)
            (member v (children u g)))
          (vertices g)))



(define (predecessors2 v g)
  (filter (lambda (u)
            (member v (children u g)))
          (vertices g)))


(define (all? p? l)
  (foldr (lambda (x rec) (and (p? x) rec))
         #t
         l))

(define (acyclic? g)
  (define (dfs-visit v g visited)
    (if (member v visited)
        #f
        (all? (lambda (c)
               (dfs-visit c g (cons v visited)))
             (children v g))
        ))
  (dfs-visit (car (vertices g)) g '()))








(define (loop)
    (display "Input: ")
    (define a (read-line (current-input-port) 'any))
    (printf "input: ~a, length: ~a, last character: ~a\n"
        a
        (string-length a)
        (char->integer (string-ref a (- (string-length a) 1))))
    (loop))

;(loop)
