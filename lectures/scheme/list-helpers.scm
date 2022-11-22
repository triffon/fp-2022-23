(load "lists.scm")

(define (exists? p? l)
  (not (null? (filter p? l))))

(define (search p l)
  (and (not (null? l))
       (or (p (car l)) (search p (cdr l)))))

(define (all? p? l)
  (not (search (lambda (x) (not (p? x))) l)))