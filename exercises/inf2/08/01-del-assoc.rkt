#lang racket

;; ще използваме тази функция в други файлове
(provide del-assoc)

(define (del-assoc key alist)
  (filter
    (lambda (kv) (not (equal? key (car kv))))
    alist))