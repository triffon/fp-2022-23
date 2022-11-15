(load "lists.scm")
(load "highorder.scm")

(define (all? p? l)
;  (null? (filter (lambda (x) (not (p? x))) l)))
  (foldr (lambda (x y) (and x y)) #t (map p? l)))

(define (matrix? m)
  (and (list? m) (not (null? m)) (not (null? (car m)))
       (let ((rowlength (length (car m))))
         (all? (lambda (x) (and (list? x) (= (length x) rowlength))) (cdr m)))))

(define m '((1 2 3) (4 5 6)))

;; долните функции работят коректно само ако (matrix? m)

(define count-rows length)
(define (count-cols m)
  (length (car m)))

(define get-first-row car)
(define (get-first-col m)
  (map car m))

(define del-first-row cdr)
(define (del-first-col m)
  (map cdr m))

;; TODO проверка за коректност на i
(define (get-row i m)
  (list-ref m i))

;; TODO проверка за коректност на i
(define (get-col i m)
  (map (lambda (row) (list-ref row i)) m))

;; разширяваме функцията да работи и над празни матрици
(define (transpose m)
  (if (null? (get-first-row m)) '()
      (cons (get-first-col m) (transpose (del-first-col m)))))

(define (transpose m)
  (accumulate cons '() 0 (- (count-cols m) 1)
              (lambda (i) (get-col i m)) 1+))

(define (transpose m)
  (apply map list m))

(define (sum-vectors v1 v2)
  (map + v1 v2))

(define (sum-matrices m1 m2)
  (map sum-vectors m1 m2))

(define (mult-vectors v1 v2)
  (apply + (map * v1 v2)))

(define (mult-matrices m1 m2)
  (map (lambda (row) (map (lambda (col) (mult-matrices row col))  (transpose m2)) m1)))