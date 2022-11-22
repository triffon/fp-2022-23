(load "highorder.scm")
(load "matrix.scm")
(load "list-helpers.scm")

(define (make-alist f keys)
  (map (lambda (x) (cons x (f x))) keys))

(define (keys alist)
  (map car alist))

(define (values alist)
  (map cdr alist))

(define (alist? al)
  (and (list? al)
;; !!!       (apply and pair? al)))
       (all? pair? al)
       (all? (lambda (key) (= 1 (length (filter (lambda (kv) (equal? (car kv) key)) al)))) (keys al))))
;; TODO конструктивен предикат

;; считаме, че (alist? al)
;; съществуване
(define (assoc key al)
  (cond ((null? al) #f)
        ((equal? (caar al) key) (car al))
        (else (assoc key (cdr al)))))

;; всяко
(define (assoc key al)
  (let ((find-keys (filter (lambda (kv) (equal? (car kv) key)) al)))
    (and (not (null? find-keys)) (car find-keys))))

(define (assoc key al)
  (search (lambda (kv) (and (equal? (car kv) key) kv)) al))

(define (del-assoc key al)
  (filter (lambda (kv) (not (equal? (car kv) key))) al))

(define (change-assoc key value al)
  (map (lambda (kv) (if (equal? (car kv) key) (cons key value) kv)) al))

(define (add-assoc key value al)
  (if (assoc key al) (change-assoc key value al) (cons (cons key value) al)))
