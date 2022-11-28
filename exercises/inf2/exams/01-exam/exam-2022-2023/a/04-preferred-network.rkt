#lang racket

;; Обхват на мобилно устройство или мобилна мрежа наричаме множеството от поддържаните от тях
;; честотни ленти и представяме със списък от различни естествени числа.

;; Казваме, че дадено мобилно устройство е съвместимо с дадена мобилна мрежа,
;; ако имат поне две общи честотни ленти.

(define (intersection lst1 lst2)
  (filter (lambda (x) (member x lst2)) lst1))

(define (compatible? mobile-device mobile-network)
  (>= (length (intersection mobile-device mobile-network)) 2))

;; Покритие на дадено мобилно устройство спрямо дадена мобилна мрежа наричаме
;; частното на броя на общите поддържани от устройството и мрежата ленти и големината на обхвата на мрежата.

(define (coverage mobile-device mobile-network)
  (/ (length (intersection mobile-device mobile-network)) (length mobile-network)))

;; Да се реализира функция preferredNetwork, която по подадени обхват на мобилно устройство и
;; списък от обхвати на мобилни мрежи избира предпочитана мрежа, такава че
;; тя да е съвместима с устройството и да има максимално покритие спрямо него.
;; Функцията да връща списъка на тези честотни ленти на предпочитаната мрежа,
;; които се поддържат от устройството, или празен списък, ако няма нито една съвместима мрежа.

(define (max-by func lst)
  (foldr (lambda (x result) (if (> (func x) (func result)) x result)) (car lst) (cdr lst)))

(define (preferredNetwork mobile-device mobile-networks)
  (let* ((compatible-networks (filter (lambda (network) (compatible? mobile-device network)) mobile-networks))
         (preferred-network (max-by (lambda (network) (coverage mobile-device network)) compatible-networks)))
    
    (intersection mobile-device preferred-network)))

;; (preferredNetwork '(1 3 5 7 8 20) '((1 3 8 40 41) (1 3 7 28) (5))) ;; => (1 3 7) 