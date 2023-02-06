#lang racket
(define head car)
(define tail cdr)
; Изпит 2019/20, вар.А, зад.3
(define (make-tree root . xs)
  (cons root xs))
(define (root-tree t) (head t))
(define (subtrees t) (tail t))

(define t
  (make-tree 2
   (make-tree 1
    (make-tree 5
     (make-tree 2)
     (make-tree 3
      (make-tree 4)
      (make-tree 5)))
    (make-tree 0)
    (make-tree 6
     (make-tree 5)
     (make-tree 7)))
   (make-tree 3)
   (make-tree 4)))



(define (concat lsts)
  (apply append lsts))

(define (enumerate i xs)
  (if (null? xs) '()
      (cons (cons (head xs) i)
            (enumerate (+ i 1) (tail xs)))))

(define (paths x curr t)
  (let* [(subs (enumerate 0 (subtrees t)))
         (results (concat
                   (map
                    (lambda (e)
                      (paths x (append curr (list (cdr e))) (car e)))
                    subs)))]
    (if (= x (root-tree t))
        (cons curr results)
        results)))
(define (paths* x t)
  (paths x '() t))

(define (lcp-2 l1 l2)
  (cond [(null? l1) '()]
        [(null? l2) '()]
        [(not (= (head l1) (head l2))) '()]
        [else (cons (head l1)
                    (lcp-2 (tail l1) (tail l2)))]))
(define (lcp lsts)
  (foldr lcp-2 (head lsts) (tail lsts)))
(define (maximum xs)
  (foldr max (head xs) (tail xs)))

(define (get-values path t)
  (if (null? path)
      (list (root-tree t))
      (cons (root-tree t)
            (get-values (tail path)
                        (list-ref (subtrees t) (head path))))))
(define (minPredecessor x t)
  (apply min (get-values (lcp (paths* x t)) t)))
