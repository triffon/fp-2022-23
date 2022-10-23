; зад 5
; колко пъти цифрата d се среща в цялото число n?
(define (digit-occurence d n)
  (if (< n 10)
      (if (= d n) 1 0)
      (+ (if (= d (remainder n 10)) 1 0)
         (digit-occurence d (quotient n 10)))))
