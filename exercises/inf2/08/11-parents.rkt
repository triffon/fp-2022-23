#lang racket

;; ще използваме тази функция в други файлове
(provide parents)

(define (parents vertex graph)
  (let ((filtered-graph (filter (lambda (lst) (member vertex (cdr lst))) graph)))
    (map car filtered-graph)))
  