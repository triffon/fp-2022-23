(load "highorder.scm")

(define (make-rat n d)
  (let ((r 
           (if (= d 0) (/ n d)
               (let* ((g (gcd n d))
                      (n1 (quotient n g))
                      (d1 (quotient d g)))
                 (if (> d1 0) (cons n1 d1) (cons (- n1) (- d1)))))))
    (define (this prop . params)
      (case prop
        ('rat? #t)
        ('get-numer (car r))
        ('get-denom (cdr r))
        ('print r)
        ('* (make-rat (apply * (this 'get-numer) (map (lambda (p) (p 'get-numer)) params))
                      (apply * (this 'get-denom) (map (lambda (p) (p 'get-denom)) params))))
        (else (/ 1 0))))
  this))
          
(define (check-rat f)
  (lambda (p)
    (if (rat? p) (f p) (/ 1 0))))

(define (get-numer r) (r 'get-numer))
(define (get-denom r) (r 'get-denom))
(define (rat? p) (r 'rat?))

(define (*rat p q) (p '* q))

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