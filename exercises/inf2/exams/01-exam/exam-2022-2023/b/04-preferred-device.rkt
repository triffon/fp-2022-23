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

;; Да се реализира функция preferredDevice, която по подадени обхват на мобилна мрежа и
;; списък обхвати на мобилни устройства избира предпочитано устройство, такова
;; че то да е съвместимо с мрежата и да има максимално покритие към нея.
;; Функцията да връща списъка на тези честотни ленти на предпочитаното устройство,
;; които се поддържат от мрежата, или празен списък, ако няма нито едно съвместимо устройство.

(define (max-by func lst)
  (foldr (lambda (x result) (if (> (func x) (func result)) x result)) (car lst) (cdr lst)))

(define (preferredDevice mobile-network mobile-devices)
  (let* ((compatible-devices (filter (lambda (device) (compatible? device mobile-network)) mobile-devices))
         (preferred-device (max-by (lambda (device) (coverage device mobile-network)) compatible-devices)))
    
    (intersection mobile-network preferred-device)))

;; (preferredDevice '(2 4 5 17 30) '((1 3 5 7 9 20) (1 2 3 4 5 7 12 14 30) (2 4 17)) ;; => (2 4 5 30) 

;; Бонус: Да се реализира функция preferredDeviceForAll, която приема списък от обхвати от устройства и
;; списък от обхвати на мрежи и избира предпочитано устройство, което е съвместимо с максимален брой мрежи,
;; а ако има няколко такива устройства, предпочита това,
;; за което сумата на покритията спрямо съвместимите с него мрежи е максимална.
;; Функцията да връща списъка на тези честотни ленти на предпочитаното устройство,
;; които се поддържат от поне една от съвместимите с него мрежи.
(define (preferredDeviceForAll mobile-devices mobile-networks)
  (define (coverage-sum mobile-device mobile-networks)
    (apply + (map (lambda (network) (coverage mobile-device network)) mobile-networks)))

  (define device-to-networks
    (map
      (lambda (device)
        (cons device (filter (lambda (network) (compatible? device network)) mobile-networks)))
      mobile-devices))

  (define (compare-devices current result)
    (let* ((device (car current))
           (networks (cdr current))
           (compatible-networks-count (length networks))
           (coverages-sum (coverage-sum device networks))

           (result-device (car result))
           (result-networks (cdr result))
           (result-compatible-networks-count (length result-networks))
           (result-coverages-sum (coverage-sum result-device result-networks)))
      (cond
        ((> compatible-networks-count result-compatible-networks-count) current)
        ((and
          (= compatible-networks-count result-compatible-networks-count)
          (> coverages-sum result-coverages-sum))
            current)
        (else result))))
  
  (define preferred-device
    (foldr compare-devices (car device-to-networks) (cdr device-to-networks)))
  
  (intersection (car preferred-device) (apply append (cdr preferred-device))))
  
;; (preferredDeviceForAll '((2 4 5 6 17 20) (1 2 3 20 30)) '((1 3 5 7 9 20) (1 2 3 4 5 7 12 14 30) (6 40)))
;; mobile-device = '(2 4 5 6 17 20) compatible-mobile-networks = '((1 3 5 7 9 20) (1 2 3 4 5 7 12 14 30))
;; length = 2 coverage = '(2/6 + 3/9) = 1/3 + 1/3 = 2/3

;; mobile-device = '(1 2 3 20 30) compatible-mobile-networks = '((1 3 5 7 9 20) (1 2 3 4 5 7 12 14 30))
;; length = 2 coverage = '(3/6 + 4/9) = 1/2 + 4/9 = 17/18

;; => '(1 2 3 20 30)