(define make-rat cons)
(define get-numer car)
(define get-denom cdr)
(define (rat? r) (and (pair? r) (number? (car r)) (number? (cdr r))))