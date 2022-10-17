(define (square x) (* x x))

(define (dist x1 y1 x2 y2)
  (define sq square)
  (let ((dx (- x2 x1))
        (dy (- y2 y1)))
   (sqrt (+ (sq dx) (sq dy)))))


(define (area x1 y1 x2 y2 x3 y3)
  (let* ((a (dist x1 y1 x2 y2))
         (b (dist x2 y2 x3 y3))
         (c (dist x3 y3 x1 y1))
         (p (/ (+ a b c) 2)))
   (sqrt (* p (- p a) (- p b) (- p c)))))

(define (qpow x n)
  (cond ((= n 0) 1)
        ((negative? n) (/ 1 (qpow x (- n))))
        ((even? n) (square (qpow x (/ n 2))))
        (else (* x (qpow x (- n 1))))))

(define (pow x n)
  (cond ((= n 0) 1)
        ((negative? n) (/ 1 (pow x (- n))))
        (else (* x (pow x (- n 1))))))

(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1)) (fib (- n 2))))))

(define (qfib n)
  (define (iter i fi fi-1)
    (if (= i n) fi
        (iter (+ i 1) (+ fi fi-1) fi)))
  (iter 1 1 0))
