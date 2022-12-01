(load "envs.scm")
(load "lists.scm")

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

(define (enum a b)
  (if (> a b) the-empty-stream
              (cons-stream a (enum (+ a 1) b))))

(define (take n s)
  (if (or (= n 0) (empty-stream? s)) '()
      (cons (head s) (take (- n 1) (tail s)))))

;; потокът от първата позиция, за която p? дава истина
(define (find-stream p? s)
  (cond ((empty-stream? s) #f)
        ((p? (head s))     s)
        (else (find-stream p? (tail s)))))

(define (from a)
  (cons-stream a (from (+ a 1))))

(define nats (from 0))

(define (generate-fibs-from fn fn+1)
  (cons-stream fn
               ;; числата на Фибоначи от n+1 нататък
               (generate-fibs-from fn+1 (+ fn fn+1))))

(define fibs (generate-fibs-from 0 1))

;; (define (map1 f l)
;;  (if (null? l) '()
;;      (cons (f (car l)) (map1 f (cdr l)))))


(define (map-stream f s)
  (if (empty-stream? s) the-empty-stream
      (cons-stream (f (head s)) (map-stream f (tail s)))))

;;(define (filter p? l)
;;  (cond ((null? l) l)
;;        ((p? (car l)) (cons (car l) (filter p? (cdr l))))
;;        (else (filter p? (cdr l)))))

(define (filter-stream p? s)
  (cond ((empty-stream? s) s)
        ((p? (head s)) (cons-stream (head s) (filter-stream p? (tail s))))
        (else (filter-stream p? (tail s)))))

(define (zip-stream op s1 s2)
  (if (or (empty-stream? s1) (empty-stream? s2)) the-empty-stream
      (cons-stream (op (head s1) (head s2)) (zip-stream op (tail s1) (tail s2)))))

;; само за безкрайни потоци
(define (map-stream f . ls)
  (cons-stream (apply f (map head ls))
               (apply map-stream f (map tail ls))))

(define ones (cons-stream 1 ones))

;; !!!! (define (tail nats2) (map-stream + nats2 ones))
(define nats (cons-stream 0 (map-stream + nats ones)))

(define fibs (cons-stream 0 (cons-stream 1 (map-stream + fibs (tail fibs)))))