#lang racket

(define (children vertex graph)
  (cdr (assoc vertex graph)))

;; връща списък от децата на последния връх в path,
;; премахвайки от него тези, които се срещат вече в path
(define (next-vertices graph path)
  (filter (lambda (vertex) (not (member vertex path))) (children (last path) graph)))

;; връща пътя path в дадения граф, разширен "веднъж"
;; (търсим прости пътища, т.е. без повторения на върхове)
;; (extend-path-once graph '(1 2)) => '((1 2 3) (1 2 4))
(define (extend-path-once graph path)
  (let ((next-vertices (next-vertices graph path)))
    (if (null? next-vertices)
        (list path)
        (map (lambda (vertex) (append path (list vertex))) next-vertices))))

;; връща списък от списъци с всички възможни "разширения" на пътя
;; path в дадения граф (търсим прости пътища, т.е. без повторения на върхове)
(define (extend-path graph path)
  (define (helper paths)
    (let* ((extended-paths (apply append (map (lambda (path) (extend-path-once graph path)) paths)))
           (new-paths (filter (lambda (path) (not (member path paths))) extended-paths))
           (result (append paths new-paths)))
      (if (equal? result paths) result (helper result))))

  (helper (list path)))