#lang racket

(define (foldl op nv l)
  (if (null? l) nv
      (foldl op (op nv (car l)) (cdr l))))

(define (foldl1 op l)
  (foldl op (car l) (cdr l)))

(define (id x) x)

(define (tom room) (modulo (+ room 1) 3))
(define house '((0 1 2) (1 0 2) (2 0 1 3) (3 2)))

(define (spike house s tom t)
  (define (generate-tom-path r)
    (cond ((= (tom r) t) (list r))
          ((member (tom r) (assoc r house)) (cons r (generate-tom-path (tom r))))
          (else (list r))))

  (define tom-path (generate-tom-path t))

  (define (spike-path c dest path)
    (define possible-destinations (filter (lambda (x) (not (member x path))) (cdr (assoc c house))))
    (define paths (filter id (map (lambda (x) (spike-path x dest (cons c path))) possible-destinations)))

    (cond ((= c dest) (reverse (cons c path)))
          ((null? paths) #f)
          (else
           (foldl1
            (lambda (res x) (if (> (length res) (length x)) x res))
            paths))))

  (define (tom-path-with-length t dest curr-length min-length)
    (cond ((and (>= curr-length min-length) (= t dest)) curr-length)
          ((member (tom t) (assoc t house)) (tom-path-with-length (tom t) dest (+ 1 curr-length) min-length))
          (else min-length)))

  (define spike-paths (map (lambda (tr) (cons (spike-path s tr '()) tr)) tom-path))

  (define preferred-path (foldl1
                          (lambda (res x)
                            (if (< (tom-path-with-length t (cdr res) 1 (length (car res)))
                                   (tom-path-with-length t (cdr x) 1 (length (car x))))
                                res x)) 
                          spike-paths))

  (define (pump path l)
    (if (= (length path) l)
        path
        (pump (cons (car path) path) l)))

  (pump (car preferred-path)
        (tom-path-with-length t (cdr preferred-path) 1 (length (car preferred-path))))
        
)