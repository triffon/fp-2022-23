#lang racket

;; (define (run-machine instructions) (...)) ;; => '(...)

;; 1. ако поредната инструкция е число или символ, то се добавя на върха на стека

;; 2. ако поредната инструкция е функция, тя се прилага над всички числа в стека
;; (допуска се, че функцията приема само един параметър), променяйки стойностите им в стека

;; 3. ако поредната инструкция е наредена двойка от операция (двуместна функция) и число n,
;; то горните две числа на стека се изваждат и обратно на върха на стека се записва резултат
;; от прилагането на операцията над тях;
;; Прилагането се повтаря до изчерпване на стека или достигане до символ, но не повече от n пъти

;; (run-machine (list 1 'x 4 'a 9 16 25 sqrt 6)) ;; => '(6 5 4 3 a 2 x 1)
;; '(1)
;; '(x 1)
;; '(4 x 1)
;; '(a 4 x 1)
;; '(9 a 4 x 1)
;; '(16 9 a 4 x 1)
;; '(25 16 9 a 4 x 1)
;; '(5 4 3 a 2 x 1)
;; '(6 5 4 3 a 2 x 1)

;; (run-machine (list 1 'x 4 'a 9 16 25 sqrt 6 (cons + 2) (cons * 5))) ;; => '(45 a 2 x 1)
;; '(1)
;; '(x 1)
;; '(4 x 1)
;; '(a 4 x 1)
;; '(9 a 4 x 1)
;; '(16 9 a 4 x 1)
;; '(25 16 9 a 4 x 1)
;; '(5 4 3 a 2 x 1)
;; '(6 5 4 3 a 2 x 1)
;; '(11 4 3 a 2 x 1)
;; '(15 3 a 2 x 1)
;; '(45 a 2 x 1)

(define (run-machine instructions)
  (define (map-over-numbers func lst)
    (map (lambda (x) (if (number? x) (func x) x)) lst))

  (define (apply-func func n stack)
    (if (or (< n 1) (< (length stack) 2) (not (number? (car stack))) (not (number? (cadr stack))))
        stack
        (apply-func func (- n 1) (cons (func (car stack) (cadr stack)) (cddr stack)))))

  (define (helper instructions result)
    (if (null? instructions)
        result
        (let ((current-instruction (car instructions))
              (rest-of-instructions (cdr instructions)))
          (cond
            ((or (symbol? current-instruction) (number? current-instruction))
              (helper rest-of-instructions (cons current-instruction result)))
            ((procedure? current-instruction)
              (helper rest-of-instructions (map-over-numbers current-instruction result)))
            ((and (pair? current-instruction) (procedure? (car current-instruction)) (number? (cdr current-instruction)))
              (helper rest-of-instructions (apply-func (car current-instruction) (cdr current-instruction) result)))
            (else (helper rest-of-instructions result))))))
  
  (helper instructions '()))