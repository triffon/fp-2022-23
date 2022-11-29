(load "envs.scm")

;; !!!
;; (define (delay e) (lambda () e))
(define (force e) (e))
(define-syntax delay
  (syntax-rules () ((delay x) (lambda () x))))


(define the-empty-stream '())
;; !!! (define (cons-stream h t) (cons h (delay t)))
(define-syntax cons-stream
  (syntax-rules () ((cons-stream h t) (cons h (delay t)))))

(define head car)
(define (tail s) (force (cdr s)))
(define empty-stream? null?)

(define s (cons-stream 1 (cons-stream 2 (cons-stream b the-empty-stream))))
