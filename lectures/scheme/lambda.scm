(load "highorder.scm")

(define lambda#t (lambda (x y) x))
(define lambda#f (lambda (x y) y))
(define (lambda-if b x y) ((b x y)))
(define (h) (/ 5 0))
(define (fact n)
  (if (= n 0) 1 (* n (fact (- n 1)))))
(define gamma
  (lambda (f)
    (lambda (n)
      (if (= n 0) 1 (* n (f (- n 1)))))))

(define (fact2 n) ((gamma fact2) n))

(define (gamma-inf me) (lambda (n) ((gamma (me me)) n)))
(define fact3 (gamma-inf gamma-inf)) 

(define Y
  (lambda (gamma)
    ((lambda (me) (lambda (n) ((gamma (me me)) n)))
     (lambda (me) (lambda (n) ((gamma (me me)) n))))))

(define fact4 (Y gamma))

(define gamma-pow2
  (lambda (f)
    (lambda (n) (if (= n 0) 1 (* 2 (f (- n 1)))))))
(define pow2 (Y gamma-pow2))