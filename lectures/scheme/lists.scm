(define lambda#t (lambda (x y) x))
(define lambda#f (lambda (x y) y))

(define (lambda-cons x y)
  (lambda (z) (z x y)))

(define (lambda-car p)
  (p lambda#t))

(define (lambda-cdr p)
  (p lambda#f))

;; O(|l|)
(define (list? l)
  (if (null? l) #t
      (if (not (pair? l)) #f
          (list? (cdr l)))))

;; O(|l|)
(define (list? l)
  (or (null? l) (and (pair? l) (list? (cdr l)))))

;; O(|l|)
(define (length l)
  (if (null? l) 0 (+ 1 (length (cdr l)))))

;; O(|l1|)
(define (append l1 l2)
  (if (null? l1) l2 (cons (car l1) (append (cdr l1) l2))))

;; O(|l|)
(define (copy l)
  (if (null? l) '() (cons (car l) (copy (cdr l)))))

;; O(|l|)
(define (snoc x l)
  (append l (list x)))

;; O(|l|²)
(define (reverse l)
  (if (null? l) l (append (reverse (cdr l)) (list (car l)))))

;; O(|l|)
(define (copy l)
  (if (null? l) l (cons (car l) (copy    (cdr l)))))

(define (reverse l)
  (if (null? l) l (snoc (car l) (reverse (cdr l)))))

(define (repeated f n)
  (lambda (x)
    (if (= n 0) x
        (f ((repeated f (- n 1)) x)))))

;; O(n)
(define (list-tail l n)
  ((repeated cdr n) l))

(define (list-ref l n)
  (car (list-tail l n)))

;; O(
(define (member x l)
  (cond ((null? l) #f)
        ((equal? (car l) x) l)
        (else (member x (cdr l)))))

(define (member? x l)
  (and (not (null? l)) (or (equal? (car l) x) (member? x (cdr l)))))

(define (member2 x l equality?)
    (cond ((null? l) #f)
          ((equality? (car l) x) l)
          (else (member2 x (cdr l) equality?))))

;; O(|l||x|)
(define (member x l) (member2 x l equal?))
(define (memv x l) (member2 x l eqv?))
;; O(|l|)
(define (memq x l) (member2 x l eq?))