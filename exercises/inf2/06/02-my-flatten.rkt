#lang racket

(define (atom? x)
  (and (not (null? x)) (not (pair? x))))

(define (my-flatten lst)
  (cond
    ((null? lst) '())
    ((atom? lst) (list lst))
    (else (append
            (my-flatten (car lst))
            (my-flatten (cdr lst))))))

;; (my-flatten '((1 2) () ((#t #f) "test"))) =>
;;
;; (append
;;   (my-flatten '(1 2))
;;   (my-flatten '(() ((#t #f) "test")))) =>
;;
;; (append
;;   (append
;;     (my-flatten 1)
;;     (my-flatten '(2)))
;;   (append
;;     (my-flatten '())
;;     (my-flatten '((#t #f) "test")))) =>
;;
;; (append
;;   (append
;;     (my-flatten 1)
;;     (append
;;       (my-flatten 2)
;;       (my-flatten '())))
;;   (append
;;     (my-flatten '())
;;     (append
;;       (my-flatten '(#t #f))
;;       (my-flatten '("test")))) =>
;;
;; (append
;;   (append
;;     (my-flatten 1)
;;     (append
;;       (my-flatten 2)
;;       (my-flatten '())))
;;   (append
;;     (my-flatten '())
;;     (append
;;       (append
;;         (my-flatten #t)
;;         (my-flatten '(#f))))
;;       (append
;;         (my-flatten "test")
;;         (my-flatten '())))) =>
;;
;; (append
;;   (append
;;     (my-flatten 1)
;;     (append
;;       (my-flatten 2)
;;       (my-flatten '())))
;;   (append
;;     (my-flatten '())
;;     (append
;;       (append
;;         (my-flatten #t)
;;         (append
;;           (my-flatten #f)
;;           (my-flatten '()))))
;;       (append
;;         (my-flatten "test")
;;         (my-flatten '())))) =>
;;
;; следва свиване