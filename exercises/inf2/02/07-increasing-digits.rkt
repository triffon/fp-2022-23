#lang racket

(define (increasing-digits? number)
	(if (< number 10)
		#t
		(and 
			(> (remainder number 10) (remainder (quotient number 10) 10)) 
			(increasing-digits? (quotient number 10)))))

;; (increasing-digits? 123) =
;; (and (> 3 2) (increasing-digits 12)) =
;; (and (> 3 2) (and (> 2 1) (increasing-digits 1))) =
;; (and (> 3 2) (and (> 2 1) #t)) =
;; (and (> 3 2) (and #t #t)) =
;; (and #t #t) =
;; #t

(define (increasing-digits-iter? number)
  (define (helper num last-digit)
    (cond
      ((< num 1) #t)
      ((< (remainder num 10) last-digit) (helper (quotient num 10) (remainder num 10)))
      (else #f)))
  (helper (quotient number 10) (remainder number 10)))

;; (increasing-digits-iter? 1234) =
;; (helper 123 4) =
;; (helper  12 3) =
;; (helper   1 2) =
;; (helper   0 1) =
;; #t