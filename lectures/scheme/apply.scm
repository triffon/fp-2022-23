(load "lists.scm")

(define (max x . l) (foldr (lambda (x y) (if (> x y) x y)) x l))

(define (map f l . otherls)
  (let ((pl (cons l otherls)))
    (if (null? l) '()
        (cons (apply f (map1 car pl))
              (apply map f (map1 cdr pl))))))

(define (evali l)
  (eval l (interaction-environment)))

(define (construct-map l) (list 'map '1+  (list 'quote l)))
