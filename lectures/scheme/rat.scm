(load "highorder.scm")

(define (make-rat n d)
  (if (= d 0) (/ n d)
      (cons n d)))
(define get-numer car)
(define get-denom cdr)
(define (rat? r) (and (pair? r) (number? (car r)) (number? (cdr r))))

(define (*rat p q)
  (make-rat (* (get-numer p) (get-numer q))
            (* (get-denom p) (get-denom q))))

(define (+rat p q)
  (make-rat (+
             (* (get-numer p) (get-denom q))
             (* (get-numer q) (get-denom p)))
   (* (get-denom p) (get-denom q))))

(define (<rat p q)
  (< (* (get-numer p) (get-denom q))
     (* (get-numer q) (get-denom p))))

(define 0rat (make-rat 0 1))

(define (my-exp x n)
  (accumulate +rat 0rat 0 n
              (lambda (i)
                (make-rat (pow x i) (fact i)))
              1+))

(define (to-double r)
  (+ .0 (/ (get-numer r) (get-denom r))))