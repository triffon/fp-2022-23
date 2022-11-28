#lang racket

;; ще използваме тази функция в други файлове
(provide to-edges)


(define (to-edges graph)
  (define (construct-edges from to)
    (map (lambda (x) (cons from x)) to))
  
  (apply
    append
    (map
      (lambda (lst) (construct-edges (car lst) (cdr lst)))
      graph)))