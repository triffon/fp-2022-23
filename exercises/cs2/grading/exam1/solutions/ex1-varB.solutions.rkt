#lang racket

(define (foldr op nv l)
  (if (null? l)
      nv
      (op (car l) (foldr op nv (cdr l)))))

; problem 1
(define (divides? i n)
  (= 0 (remainder n i)))

(define (divisors n)
  (filter (lambda (k)
            (divides? k n))
          (from-to 2 n)))

(define (prime? n)
  (define i-limit (- n 1))
  (define (go i)
      (or (> i i-limit)
          (and (not (divides? i n))
               (go (+ i 1)))))
  (go 2))

(define (product l)
  (foldr * 1 l))

(define (grow n)
  (* n (product (filter prime? (divisors n)))))

; problem 2
(define (from-to a b)
  (if (> a b)
      '()
      (cons a
            (from-to (+ a 1) b))))

(define (intersect l m)
  (filter (lambda (x)
            (member x m))
          l))

(define (is-unitary-divisor k n)
  (and (divides? k n)
       (null? (intersect (filter prime? (divisors k))
                         (divisors (/ n k))))))

(define (maxUnitary n)
  (car
    (filter (lambda (k) (is-unitary-divisor k n))
            (reverse (from-to 1 (- n 1))))))


; problem 3
(define (selectiveMap f input-la input-lb)
  (define (rule1 a b) (f a))
  (define (rule2 a b) (f b))
  (define (go prevRule la lb)
    (if (null? la) ; по условие lb също ще е празен
        '()
        (let* ((a (car la))
               (b (car lb))
               (rule (cond
                       ((< (f a) (f b) (min a b))
                        rule1)
                       ((> (f b) (f a) (max a b))
                        rule2)
                       (else
                         prevRule))))
          (cons (rule a b)
                (go rule (cdr la) (cdr lb))))))
  (if (null? input-la)
      '()
      (cons (rule1 (car input-la) (car input-lb))
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
  (<= 2 (length (intersect phoneBands networkBands))))

(define (coverage phoneBands networkBands)
  (/ (length (intersect phoneBands networkBands))
     (length networkBands)))

(define (preferredDevice network phones)
  (intersect network
             (argMaxWithDefault (lambda (phone)
                                  (coverage phone network))
                                (filter (lambda (phone)
                                          (supports? phone network))
                                        phones))))

; bonus problem
(define (sum l)
  (foldr + 0 l))

(define (id x) x)
(define (maximum l)
  (argMaxWithDefault id l))

(define (any p? l)
  (foldr (lambda (x rec) (or (p? x) rec)) #f l))

(define (preferredDeviceForAll phones networks)
  (define (number-of-supported-networks phone)
    (length (filter (lambda (network)
                      (supports? phone network))
                    networks)))

  (define maxNum (maximum (map number-of-supported-networks phones)))

  (define (sum-of-coverages phone)
    (sum (map (lambda (network)
                (coverage phone network))
              (filter (lambda (network)
                        (supports? phone network))
                      networks))))

  (define (bands-in-at-least-one-network phone)
    (filter (lambda (band)
              (any (lambda (network)
                     (and (supports? phone network)
                          (member band network)))
                   networks))
            phone))

  (bands-in-at-least-one-network
    (argMaxWithDefault
      sum-of-coverages
      (filter (lambda (phone)
                (= maxNum (number-of-supported-networks phone)))
              phones))))

(define (trace-id x)
  (display x)
  (display "\n")
  x)
(define (trace-map-f f x)
  (display (map f x))
  (display "\n")
  x)
