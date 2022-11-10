(define l '((1 (2)) (((3) 4) (5 (6)) () (7)) 8))

(define (atom? l)
  (and (not (null? l)) (not (pair? l))))

(define (count-atoms l)
  (cond ((null? l) 0)
        ((atom? l) 1)
        (else (+ (count-atoms (car l)) (count-atoms (cdr l))))))

(define (flatten l)
  (cond ((null? l) l)
        ((atom? l) (list l))
        (else (append (flatten (car l)) (flatten (cdr l))))))

(define (snoc x l)
  (append l (list x)))

(define (rcons x y) (cons y x))

(define (id x) x)

(define (deep-reverse l)
  (cond ((null? l) l)
        ((atom? l) l)
        (else (snoc (deep-reverse (car l)) (deep-reverse (cdr l))))))

(define (deep-foldr op term nv l)
  (cond ((null? l) nv)
        ((atom? l) (term l))
        (else (op (deep-foldr op term nv (car l))
                  (deep-foldr op term nv (cdr l))))))

(define (count-atoms l)
  (deep-foldr + (lambda (x) 1) 0 l))

(define (flatten l)
  (deep-foldr append list '() l))

(define (deep-reverse l)
  (deep-foldr snoc id '() l))

(define (foldr op nv l)
  (if (null? l) nv (op (car l) (foldr op nv (cdr l)))))

(define (deep-foldr op term nv l)
  (if (atom? l) (term l)
      (foldr op nv (map (lambda (x) (deep-foldr op term nv x)) l))))