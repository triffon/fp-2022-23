#lang racket

;; Да се реализира функция selectiveMerge, която по дадени два списъка от цели числа 
;; a = (a1 a2 … an) и b = (b1 b2 … bn) с еднаква дължина и
;; двуместна числова функция f връща списък със същата дължина c = (c1 c2 … cn),
;; който се получава от избирателно сливане на списъците a и b
;; като всеки един от елементите ci се пресмята по едно от следните правила:
;; (1) копиране на стойността на ai или
;; (2) прилагане на f над ai и bi

;; Елементът c1 се пресмята по правило (1), а всеки следващ елемент се пресмята: 
;; - чрез правило (1), ако f(ai, bi) < min(ai, bi) 
;; - чрез правило (2), ако f(ai, bi) > max(ai, bi) 
;; - чрез същото правило като ci-1, в противен случай

(define (selectiveMerge func a b)
  (define (rule1 func ai bi) ai)
  (define (rule2 func ai bi) (func ai bi))

  (define (helper prev-rule lst1 lst2)
    (if (or (null? lst1) (null? lst2))
        '()
        (let ((ai (car lst1))
              (bi (car lst2))
              (arest (cdr lst1))
              (brest (cdr lst2)))
          (cond
            ((< (func ai bi) (min ai bi)) (cons (rule1 func ai bi) (helper rule1 arest brest)))
            ((> (func ai bi) (max ai bi)) (cons (rule2 func ai bi) (helper rule2 arest brest)))
            (else (cons (prev-rule func ai bi) (helper prev-rule arest brest)))))))
    
  (helper rule1 a b))

;; (selectiveMerge * '(1 2 3 4 1 3 1 2) '(10 1 2 0 5 -2 -1 4)) ;; => '(1 2 6 0 5 3 1 8) 