(define (n+ n)
  (lambda (x)
;;    (define n (+ n 1))
    (begin
      (set! n (+ n 1))
      (display "n = ")
      (display n)
      (newline)
      (+ x n))))

(define a 0)

(define (sum x)
  (set! a (+ a x))
  a)

(define (make-account sum)
  (lambda (amount)
    (if (< (+ amount sum) 0)
        (display "Insufficient funds!")
        (begin
          (set! sum (+ amount sum))
          sum))))