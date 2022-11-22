(load "highorder.scm")

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

(define (length l)
  (foldr + 0 (map (lambda (x) 1) l))) 
  ;; (foldr (lambda (h r) (1+ r)) 0 l))

;; O(|l1|)
(define (append2 l1 l2)
  (if (null? l1) l2 (cons (car l1) (append2 (cdr l1) l2))))

(define (append2 l1 l2)
  (foldr cons l2 l1))

;; O(|l|)
(define (copy l)
  (if (null? l) '() (cons (car l) (copy (cdr l)))))

;; O(|l|)
(define (snoc x l)
  (append l (list x)))

;; O(|l|²)
(define (reverse l)
  (if (null? l) l (append (reverse (cdr l)) (list (car l)))))

;; O(n)
(define (reverse-faster l)
  (define (iter l result)
    (if (null? l) result
        (iter (cdr l) (cons (car l) result))))
  (iter l '()))

(define (reverse-faster l)
  (foldl rcons '() l))


;; O(|l|)
(define (copy l)
  (if (null? l) l (cons (car l) (copy    (cdr l)))))

(define (copy l)
  (foldr cons '() l))

(define (reverse l)
  (if (null? l) l (snoc (car l) (reverse (cdr l)))))

(define (reverse l)
  (foldr snoc '() l))


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

(define (member? x l)
  (foldr (lambda (h res) (or res (equal? h x))) #f l))

(define (from-to a b)
  (if (> a b) '()
      (cons a (from-to (+ a 1) b))))

;; ((term a) (term (next a)) (term (next (next a)))  ... (term b)) 
(define (collect a b term next)
  (if (> a b) '()
      (cons (term a) (collect (next a) b term next))))

(define (accumulate op nv a b term next)
  (foldr op nv (collect a b term next)))

(define (from-to a b)
  (collect a b id 1+))

(define (map1 f l)
  (if (null? l) '()
      (cons (f (car l)) (map1 f (cdr l)))))

(define (foldr op nv l)
  (if (null? l) nv
      (op (car l) (foldr op nv (cdr l)))))

(define (map1 f l)
  (foldr (lambda (h res) (cons (f h) res)) '() l))

(define (filter p? l)
  (cond ((null? l) l)
        ((p? (car l)) (cons (car l) (filter p? (cdr l))))
        (else (filter p? (cdr l)))))

(define (filter p? l)
  (foldr (lambda (h res) (if (p? h) (cons h res) res)) '() l))

;; (define (copy l)
;;   (if (null? l) '() (cons (car l) (copy    (cdr l)))))

;; (define (accumulate op nv a b term next)
;;  (if (> a b) nv (op (term a) (accumulate op nv (next a) b term next))))

;;(define (accumulate-i op nv a b term next)
;;  (if (> a b) nv
;;      (accumulate-i op (op nv (term a)) (next a) b term next)))

(define (rcons x y) (cons y x))

(define (foldr op nv l)
  (if (null? l) nv (op (car l) (foldr op nv (cdr l)))))

(define (foldl op nv l)
  (if (null? l) nv (foldl op (op nv (car l)) (cdr l))))


;; O(n) по време
;; O(n) по памет
(define (fact n)
  (foldr * 1 (from-to 1 n)))

(define (maximum l)
  (foldr max (car l) l))

(define (foldr1 op l)
  (if (null? (cdr l)) (car l) (op (car l) (foldr1 op (cdr l)))))

;; !!! 
;; (define (foldr1 op l)
;;   (foldr op (car l) (cdr l)))

;; (define (foldr1 op l)
;;   (foldr op (last l) (remove-last l)))

(define (foldl1 op l)
  (foldl op (car l) (cdr l)))
