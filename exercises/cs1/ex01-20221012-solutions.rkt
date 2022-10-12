; От миналия път
(define (f2 x y)
  (define (in-box? x y)
    (and (<= (abs x) 1) (<= (abs y) 1)))
  (or (in-box? x y)
      (in-box? (- x 2) (- y 2))
      (in-box? (- x 4) (- y 4))))

(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1)) (fib (- n 2))))))

; Зад.1
(define (sum-interval a b)
  (define (loop i res)
    (if (> i b) res
        (loop (+ i 1) (+ res i))))
  (loop a 0))

; Зад.2
(define (count-digit d n)
  (define (loop n res)
    (cond ((= n 0) res)
          ((= (remainder n 10) d) (loop (quotient n 10) (+ res 1)))
          (else (loop (quotient n 10) res))))
  (loop n 0))

; Зад.3
(define (reverse-int n)
  (define (loop n res)
    (if (= n 0) res
        (loop (quotient n 10)
              (+ (* res 10) (remainder n 10)))))
  (loop n 0))

; Зад.4
(define (divisors-sum n)
  (define (loop i res)
    (cond ((> i n) res)
          ((zero? (remainder n i))
              (loop (+ i 1) (+ res i)))
          (else (loop (+ i 1) res))))
  (loop 1 0))

; Зад.5
(define (perfect? n)
  (= (divisors-sum n) (* 2 n)))

; Зад.6
; Значително по-ефективно от (= (divisors-sum n) (+ n 1))
(define (prime? n)
  (define (loop i)
    (cond ((> i (sqrt n)) #t)
          ((zero? (remainder n i)) #f)
          (else (loop (+ i 1)))))
  (and (not (= n 1)) ; По-добре проверката да е вън от "цикъла"
       (loop 2)))

; Зад.7
; Няма нужда от помощна функция за итеративен процес :)
(define (increasing? n)
  (let ((last (remainder n 10))
        (rest (quotient n 10)))
    (or (< n 10)
        (and (< (remainder rest 10) last)
             (increasing? rest)))))

; Зад.8
; Рекурсивен процес
(define (toBinaryR n)
  (cond ((= n 0) 0)
        ((even? n) (* 10 (toBinaryR (quotient n 2))))
        (else (+ 1 (* 10 (toBinaryR (quotient n 2)))))))
; Итерираме по битовете на n от нулевия до последния (който и да е той)
; и на всяка итерация тестваме дали idx-тия бит на n е единица,
; за да сложим единица на idx-та позиция в получения запис
(define (toBinary n)
  (define (hasBit i)
    (odd? (quotient n (expt 2 i))))
  (define (loop idx res)
    (cond ((< n (expt 2 idx)) res)
          ((hasBit idx) (loop (+ idx 1) (+ res (expt 10 idx))))
          (else (loop (+ idx 1) res))))
  (loop 0 0))

; Зад.10
(define (sq x) (* x x))
(define (fast-exp x n)
  (cond ((= n 0) 1)
        ((even? n) (sq (fast-exp x (/ n 2))))
        (else (* x (sq (fast-exp x (quotient n 2)))))))













  
