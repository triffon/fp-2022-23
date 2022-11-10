#lang racket

;; Казваме, че списъкът x = (x1 x2 … x2n) от цели числа се получава от прочитането (look-and-say) на списъка y,
;; ако y се състои от последователно срещане на x1 пъти x2, последвано от x3 пъти x4,
;; и така нататък до x2n-1 пъти x2n.
;; Да се дефинира функция next-look-and-say, която по даден списък y намира списъка x, получен от прочитането y.

;; помощна функция - групираме последователните срещания на
;; един и същи елемент в подсписъци
;; (group-consecutive '(1 1 2 3 3)) ;; => '((1 1) (2) (3 3))
(define (group-consecutive lst)
  (foldr
      (lambda (curr accum)
          (if (or (null? accum) (not (= curr (car (car accum)))))
              (cons (list curr) accum)
              (cons (cons curr (car accum)) (cdr accum))))
      '()
      lst))

(define (look-and-say lst)
  (flatten (map
                (lambda (group)
                    (list (length group) (car group)))
                (group-consecutive lst))))

;; (look-and-say '(1 1 2 3 3))    ;; => ‘(2 1 1 2 2 3)