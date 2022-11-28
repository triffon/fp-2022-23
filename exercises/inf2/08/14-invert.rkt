#lang racket

(require "07-vertices.rkt")
(require "11-parents.rkt")

(define (invert graph)
  (map
    (lambda (vertex) (cons vertex (parents vertex graph)))
    (vertices graph)))

;; алтернативно решение, обхождащо графа ред по ред
;; (require "01-del-assoc.rkt")

;; (define (invert graph)
;;   (define (add from to graph)
;;     (foldr
;;       (lambda (child result)
;;         (let ((node (assoc child result)))
;;           (cons (cons child (cons from (cdr node))) (del-assoc child result))))
;;       graph
;;       to))

;;   (foldr
;;     (lambda (lst result)
;;       (let* ((from (car lst))
;;              (to (cdr lst)))
;;         (add from to result)))
;;     ;; по този начин не губим върхове, към които няма ребра
;;     (map (lambda (lst) (list (car lst))) graph)
;;     graph))

;; друго алтернативно решение би било да ползваме
;; from-edges (задача 13) и to-edges (задача 14),
;; като flip-нем стойностите в ребрата (от-до)