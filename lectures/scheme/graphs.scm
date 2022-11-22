(load "assoc-lists.scm")

(define g
  '((1 2 3)
    (2 3)
    (3 4 5)
    (4)
    (5 2 4 6)
    (6 2)))

;; O(|V|)
(define vertices keys)

;; O(|V|)
(define (children v g)
  (cdr (assv v g)))

;; O(|V|+|E|)
(define (edge? u v g)
  (memv v (children u g)))

;; O(|V|)
(define (map-children v f g)
  (map f (children v g)))

;; O(|V|)
(define (search-child v p g)
  (search p (children v g)))

;; O(|V|²)
(define (childless g)
  (filter (lambda (v) (null? (children v g))) (vertices g)))

;; O(|V|²+|V||E|)
(define (parents v g)
  (filter (lambda (u) (edge? u v g)) (vertices g)))

(define (symmetric? g)
  (all? (lambda (u)
          (all? (lambda (v) (edge? v u g))
                (children u g)))
        (vertices g)))

  