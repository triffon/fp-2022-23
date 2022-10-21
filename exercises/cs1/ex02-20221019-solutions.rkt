; Синтактична захар
(define (++ x) (+ x 1))
; (define ++
;   (lambda (x) (+ x 1)))

; Зад.0
(define (const c)
  (lambda (x) c))

; Аргументът f е функция - познава се само
; по това, че го ползваме като такава в (f y x)
(define (flip f)
  (lambda (x y) (f y x)))

(define (complement p)
  (lambda (x) (not (p x))))


(define (compose f g)
  (lambda (x) (f (g x))))

; Често използвани функции
(define (++ x) (+ x 1))
(define (id x) x)
(define (sq x) (* x x))

; Зад.1
(define (repeat n f)
  (if (= n 0) id  ; или (lambda (x) x)
      (compose f (repeat (- n 1) f))))

; Зад.2
(define dx 0.000001)
; операция "диференциране", т.е.
; функция->функция
(define (derive f)
  (lambda (x) (/ (- (f (+ x dx))
                    (f x))
                 dx)))

; Зад.3
; операция "n-кратно диференциране"
; Отново функция->функция
(define (derive-n n f)
  (if (= n 1)
      ;ГРЕШНО (lambda (x) (derive f)) ; число->функция
      ;вярно, но ненужно сложно (lambda (x) ((derive f) x))
      (derive f) ; функция (число->число)
      (derive (derive-n (- n 1) f))))

; По-добре: правим n-кратна композиция на
; операцията диференциране, получената операция
; прилагаме над дадената функция
(define (derive-n* n f)
  ((repeat n derive) f))

; Зад.4
(define (twist k f g)
  (if (= k 0) id
      (compose f (twist (- k 1) g f))))
