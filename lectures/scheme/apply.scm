(define (foldr op nv l)
  (if (null? l) nv (op (car l) (foldr op nv (cdr l)))))

(define (max x . l) (foldr (lambda (x y) (if (> x y) x y)) x l))

(define (map2 f l . otherls)
  (let ((pl (cons l otherls)))
    (if (null? l) '()
        (cons (apply f (map car pl))
              (apply map2 f (map cdr pl))))))

(define (evali l)
  (eval l (interaction-environment)))

(define (1+ x) (+ x 1))

(define (construct-map l) (list 'map '1+  (list 'quote l)))
