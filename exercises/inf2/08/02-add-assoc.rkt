#lang racket

(define (add-assoc key value alist)
  (let ((new-kv (cons key value)))
    (if (assoc key alist)
        (map
          (lambda (kv) (if (equal? (car kv) key) new-kv kv))
          alist)
        (cons new-kv alist))))