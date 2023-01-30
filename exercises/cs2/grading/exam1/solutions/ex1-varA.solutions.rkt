#lang racket

; problem 1
(define (divides? i n)
  (= 0 (remainder n i)))

(define (prime? n)
  (define i-limit (- n 1))
  (define (go i)
      (or (> i i-limit)
          (and (not (divides? i n))
               (go (+ i 1)))))
  (go 2))


(define (trim n)
  (define (iter i result)
    (cond
      ((> i n)
       result)
      ((and (divides? i result) (prime? i))
       (iter (+ i 1) (quotient result i)))
      (else
        (iter (+ i 1) result))))
  (iter 2 n))


; problem 2
(define (from-to a b)
  (if (> a b)
      '()
      (cons a
            (from-to (+ a 1) b))))

(define (divisors n)
  (filter (lambda (k)
            (divides? k n))
          (from-to 2 n)))

(define (intersect l m)
  (filter (lambda (x)
            (member x m))
          l))

(define (is-unitary-divisor k n)
  (and (divides? k n)
       (null? (intersect (filter prime? (divisors k))
                         (divisors (/ n k))))))

(define (commonUnitary n m)
  (length (intersect (filter (lambda (x) (is-unitary-divisor x n))
                       (from-to 1 n))
                     (filter (lambda (x) (is-unitary-divisor x m))
                               (from-to 1 m)))))


; problem 3
(define (selectiveMerge f input-la input-lb)
  (define (rule1 a b) a)
  (define (rule2 a b) (f a b))
  (define (go prevRule la lb)
    (if (null? la) ; по условие lb също ще е празен
        '()
        (let* ((a (car la))
               (b (car lb))
               (fab (f a b))
               (rule (cond
                       ((< fab
                           (min a b))
                        rule1)
                       ((< (max a b)
                           fab)
                        rule2)
                       (else
                         prevRule))))
          (cons (rule a b)
                (go rule (cdr la) (cdr lb))))))
  (if (null? input-la)
      '()
      (cons (car input-la)
            (go rule1 (cdr input-la) (cdr input-lb)))))

; problem 4

; withDefault защото има допълнителен случай за празен списък
(define (argMaxWithDefault f l)
  (define (f-max x y)
    (if (> (f y) (f x))
        y
        x))
  (cond
    ((null? l) l)
    ((null? (cdr l)) (car l))
    (else
      (f-max (car l)
             (argMaxWithDefault f (cdr l))))))

(define (supports? phoneBands networkBands)
  (<= 2
      (length (intersect phoneBands networkBands))))

(define (coverage phoneBands networkBands)
  (/ (length (intersect phoneBands networkBands))
     (length networkBands)))

(define (preferredNetwork phone networks)
  (intersect phone
             (argMaxWithDefault (lambda (network)
                                  (coverage phone network))
                                (filter (lambda (network)
                                          (supports? phone network))
                                        networks))))

; bonus problem
(define (foldr op nv l)
  (if (null? l)
      nv
      (op (car l) (foldr op nv (cdr l)))))

(define (sum l)
  (foldr + 0 l))

(define (id x) x)
(define (maximum l)
  (argMaxWithDefault id l))

(define (any p? l)
  (foldr (lambda (x rec) (or (p? x) rec)) #f l))

(define (preferredNetworkForAll phones networks)
  (define (number-of-supported-phones network)
    (length (filter (lambda (phone)
                      (supports? phone network))
                    phones)))

  (define maxNum (maximum (map number-of-supported-phones networks)))

  (define (sum-of-coverages network)
    (sum (map (lambda (phone)
                (coverage phone network))
              (filter (lambda (phone)
                        (supports? phone network))
                      phones))))

  (define (bands-in-at-least-one-phone network)
    (filter (lambda (band)
              (any (lambda (phone)
                     (and (supports? phone network)
                          (member band phone)))
                   phones))
            network))

  (bands-in-at-least-one-phone
    (argMaxWithDefault
      sum-of-coverages
      (filter (lambda (net)
                (= maxNum (number-of-supported-phones net)))
              networks))))

(define (trace-id x)
  (display x)
  (display "\n")
  x)
(define (trace-map-f f x)
  (display (map f x))
  (display "\n")
  x)
