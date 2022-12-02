#lang racket

(define (accumulate-i op nv a b term next)
  (if (> a b)
      nv
      (accumulate-i op (op nv (term a)) (next a) b term next)))


(define (1+ n) (+ n 1))

; Variant A ->
;-------------
; Task 1:
;--------
; Да се реализира функция trim, която по дадено естествено положително число n
; връща числото, което се получава след последователното деление на n
; на всеки негов прост делител точно по веднъж. 
(define (prime? p)
  (define (op nv x)
    (and nv (not (zero? (remainder p x)))))
  (and (> p 1)
       (accumulate-i op #t 2 (/ p 2) identity 1+)))

(define (trim n)
  (define (op nv x)
    (if (and (prime? x) (zero? (remainder n x)))
        (/ nv x)
        nv))
  (accumulate-i op n 1 n identity 1+))

; Task 2:
;--------
; Казваме, че k е унитарен делител на n, ако след делението на n на k
; се получава число, което няма общи прости делители с k.
; Да се реализира функция commonUnitary, която намира броя
; на общите унитарни делители на дадени естествени положителни числа n₁ и n₂.
(define (unitary? n k)
  (= (gcd (/ n k) k) 1))

(define (commonUnitary k n)
  (let ((treshold (min n k))
        (op (lambda (nv x)
              (if (and (unitary? k x) (unitary? n x))
                  (1+ nv)
                  nv))))
    (accumulate-i op 0 1 treshold identity 1+)))

; Task 3:
;--------
; Да се реализира функция selectiveMerge, която по дадени два списъка
; от цели числа, с еднаква дължина:
; a = (a1 a2 … an)
; b = (b1 b2 … bn)

; и двуместна числова функция f, връща списък със същата дължина
; c = (c1 c2 … cn), който се получава от избирателно сливане на списъците a и b
; като всеки един от елементите ci се пресмята по едно от следните правила:
; (1) копиране на стойността на ai или
; (2) прилагане на f над ai и bi.
;
; Елементът c1 се пресмята по правило (1), а всеки следващ елемент се пресмята: 
; - чрез правило (1), ако f(ai, bi) < min(ai, bi) 
; - чрез правило (2), ако f(ai, bi) > max(ai, bi) 
; - чрез същото правило като ci-1, в противен случай. 
(define (zip l1 l2)
  (if (or (null? l1) (null? l2))
      '()
      (cons (cons (car l1) (car l2))
            (zip (cdr l1) (cdr l2)))))

(define (merge f tie ai bi)
  (let* ((fab (f ai bi))
         (tie-ai (cons 1 ai))
         (tie-fab (cons 2 fab)))
    (cond ((< fab (min ai bi)) tie-ai)
          ((> fab (max ai bi)) tie-fab)
          (else (if (= tie 1) tie-ai tie-fab)))))

(define (selectiveMerge f l1 l2)
  (define (op ab nv)
    (let* ((tie (car nv))
           (res (cdr nv))
           (merge-res (merge f tie (car ab) (cdr ab))))
      (cons (car merge-res) (cons (cdr merge-res) res))))
  (reverse (foldl op '(1) (zip l1 l2))))

; Task 4
; TODO: polish the solution, avoid duplicate code/iterations
;
; Обхват на мобилно устройство или мобилна мрежа наричаме:
; множеството от поддържаните от тях честотни ленти и представяме със списък
; от различни естествени числа.
;
; Казваме, че дадено мобилно устройство е съвместимо с дадена мобилна мрежа,
; ако имат поне две общи честотни ленти.
;
; Покритие на дадено мобилно устройство спрямо дадена мобилна мрежа наричаме:
; частното на броя на общите поддържани от устройството и мрежата ленти
; и големината на обхвата на мрежата.
;
; Да се реализира функция preferredNetwork, която по подадени обхват
; на мобилно устройства и списък от обхвати на мобилни мрежи
; избира предпочитана мрежа, такава че тя да е съвместима с устройството
; и да има максимално покритие спрямо него. Функцията да връща списъка
; на тези честотни ленти на предпочитаната мрежа, които се поддържат
; от устройството, или празен списък - ако няма нито една съвместима мрежа. 

(define (intersection-len dev-range net-range)
  (foldl
   (lambda (x nv)
     (if (member x net-range) (1+ nv) nv))
   0
   dev-range))

(define (compatible? dev-range net-range)
  (> (intersection-len dev-range net-range) 1))

; NOTE: maybe there's a better way to handle the empty list?
(define (coverage dev-range net-range)
  (if (null? net-range)
      -1
      (/ (intersection-len dev-range net-range)
         (length net-range))))

(define (preferredNetwork dev-range net-ranges)
  (define (op nr nv)
    (if (and (compatible? dev-range nr)
             (> (coverage dev-range nr)
                (coverage dev-range nv)))
        nr
        nv))
  (filter (lambda (x) (member x dev-range))
          (foldl op '() net-ranges)))


; Variant B ->
;-------------
; Task 1:
;--------
; Да се реализира функция grow, която по дадено естествено положително число n
; връща числото, което се получава след последователното умножение на n
; по всеки негов прост делител точно по веднъж.
(define (grow n)
  (define (op nv x)
    (if (and (prime? x)
             (zero? (remainder n x)))
        (* nv x)
        nv))
  (accumulate-i op n 2 (/ n 2) identity 1+))

; Task 2:
;--------
; Казваме, че k е унитарен делител на n, ако след делението на n на k
; се получава число, което няма общи прости делители с k.
; Да се реализира функция maxUnitary, която по дадено съставно число n
; намира най-големия му унитарен делител по-малък от n.
(define (maxUnitary n)
  (define (op nv x)
    ; No need to check if x > nv,
    ; as candidates are traversed in increasing order
    (if (unitary? n x)
        x
        nv))
  (accumulate-i op 1 2 (- n 1) identity 1+))

; Task 3:
;--------
; Да се реализира функция selectiveMap, която по дадени два списъка
; от цели числа с еднаква дължина:
; a = (a1 a2 … an)
; b = (b1 b2 … bn)
; и едноместна числова функция f връща списък със същата дължина
; c = (c1 c2 … cn), който се получава от избирателно трансформиране
; на списъците a и b като всеки един от елементите ci се пресмята по едно
; от следните правила:
; (1) прилагане на f над ai или
; (2) прилагане на f над bi.

; Елементът c1 се пресмята по правило (1), а всеки следващ елемент се пресмята:
; - чрез правило (1) ако f(ai) < f(bi) < min(ai, bi)
; - чрез правило (2) ако f(bi) > f(ai) > max(ai, bi)
; - чрез същото правило като ci-1, в противен случай.

(define (smap f tie a b)
  (let* ((fa (f a))
         (fb (f b))
         (tie-fa (cons 1 fa))
         (tie-fb (cons 2 fb)))
    (cond ((< fa fb (max a b)) tie-fa)
          ((> fb fa (max a b)) tie-fb)
          (else (if (= tie 1) tie-fa tie-fb)))))

(define (selectiveMap f l1 l2)
  (define (op ab nv)
    (let* ((tie (car nv))
           (res (cdr nv))
           (smap-res (smap f tie (car ab) (cdr ab))))
      (cons (car smap-res) (cons (cdr smap-res) res))))
  ((foldl op '(1) (zip l1 l2))))

; Task 4:
;--------
; Обхват на мобилно устройство или мобилна мрежа наричаме:
; множеството от поддържаните от тях честотни ленти и представяме със списък
; от различни естествени числа.

; Казваме, че дадено мобилно устройство е съвместимо с дадена мобилна мрежа,
; ако имат поне две общи честотни ленти.

; Покритие на дадено мобилно устройство спрямо дадена мобилна мрежа наричаме:
; частното на броя на общите поддържани от устройството и мрежата ленти
; и големината на обхвата на мрежата.

; Да се реализира функция preferredDevice, която по подадени обхват
; на мобилна мрежа и списък обхвати на мобилни устройства
; избира предпочитано устройство, такова че то да е съвместимо с мрежата
; и да има максимално покритие към нея.
; Функцията да връща списъка на тези честотни ленти
; на предпочитаното устройство, които се поддържат от мрежата,
; или празен списък, ако няма нито едно съвместимо устройство.
(define (preferredDevice net-range dev-ranges)
  (define (op dr nv)
    (if (and (compatible? dr net-range)
             (> (coverage dr net-range)
                (coverage nv net-range)))
        dr
        nv))
  (filter (lambda (x) (member x net-range))
          (foldl op '() dev-ranges)))

; TODO: Bonus problem
