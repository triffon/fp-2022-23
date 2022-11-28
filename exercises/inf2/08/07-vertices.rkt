#lang racket

;; ще използваме тази функция в други файлове
(provide vertices)

(define (vertices graph)
  (map car graph))