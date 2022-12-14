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

(define (dfs-path? u v g)
  (or (eqv? u v) (search (lambda (w) (dfs-path? w v g)) (children u g))))

(define (cons#f x t) (and t (cons x t)))

;; рекурсивно решение, само за ациклични графи
(define (dfs-path u v g)
  (or (and (eqv? u v) (list u))
      (cons#f u (search-child u (lambda (w) (dfs-path w v g)) g))))

;; итеративно решение с проверка за цикли
(define (dfs-path u v g)
  (define (dfs-search path)
    (let ((current (car path)))
      (or (and (eqv? current v) (reverse path))
          (search-child current (lambda (w) (and (not (memv w path))
                                                 (dfs-search (cons w path)))) g))))
  (dfs-search (list u)))

;; не проверява за цикли
;; нивото е списък от върхове
(define (bfs-path? u v g)
  (define (bfs-level level)
    (and (not (null? level))
         (or (memv v level)
             (bfs-level (apply append (map (lambda (w) (children w g)) level))))))
  (bfs-level (list u)))

;; проверява за цикли
;; нивото е списък от пътища
(define (bfs-path u v g)
  ;; extend :: List V -> List (List V)
  (define (extend path)
    (map-children (car path) (lambda (u) (cons u path)) g))
  ;; remains-acyclic? :: List V -> Bool
  (define (remains-acyclic? path)
    (not (memv (car path) (cdr path))))
  ;; extend-acyclic :: List V -> List (List V)
  (define (extend-acyclic path)
    (filter remains-acyclic? (extend path)))
  ;; target-path :: List V -> Bool
  (define (target-path path)
    (and (eqv? (car path) v) (reverse path)))
  ;; bfs-level :: List (List V) -> List V
  ;; map :: (A -> B) x List A -> List B
  ;; A -> B == List V  -> List (List V)
  ;; A == List V
  ;; B == List (List V)
  ;; (map extend-acyclic level) :: List (List (List V))
  (define (bfs-level level)
    (and (not (null? level))
         (or (search target-path level)
             (bfs-level (apply append (map extend-acyclic level))))))
  (bfs-level (list (list u))))