#lang racket

;; ще използваме тази функция в други файлове
(provide transpose)

(define (column-count matrix)
  (length (car matrix)))

(define (get-column matrix index)
   (map
      (lambda (list) (list-ref list index))
      matrix))

(define (transpose matrix)
  (define (transpose-helper start end)
    (if (> start end)
        '()
        (cons
            (get-column matrix start)
            (transpose-helper (+ start 1) end))))
  
  (transpose-helper 0 (- (column-count matrix) 1)))

(define matrix 
  '((1 2)
    (3 4)
    (5 6)))