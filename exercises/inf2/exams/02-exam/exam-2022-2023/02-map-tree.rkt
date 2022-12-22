#lang racket

;; Разглеждаме двоично дърво от функции с представяне по ваш избор.
;; Прилагане на дърво от функции към число се нарича последователното прилагане
;; на функциите от корена до някое листо над числото,
;; като за всяко дърво са възможни толкова различни прилагания, колкото листа има то.
;; Да се реализира функция mapTree, която по дадено дърво от едноместни числови функции и
;; дадено число намира списък от резултатите от всички възможни прилагания на дървото над числото.
;; Да се опише избраното представяне на дървото. 

(define empty-tree '())
(define empty-tree? null?)

(define root car)
(define left-tree cadr)
(define right-tree caddr)

(define (leaf? tree)
  (and
    (not (empty-tree? tree))
    (empty-tree? (left-tree tree))
    (empty-tree? (right-tree tree))))

(define (mapTree tree number)
  (cond
    ((empty-tree? tree) '())
    ((leaf? tree) (list ((root tree) number)))
    (else
      (append
        (mapTree (left-tree tree) ((root tree) number))
        (mapTree (right-tree tree) ((root tree) number))))))

;; тестваме решението
(define (1+ x) (+ 1 x))
(define (expt2 x) (expt x 2))
(define (3^ x) (expt 3 x))
(define (2* x) (* 2 x))
(define (minus3 x) (- x 3))

(define example-tree
  (list 1+ (list expt2 (list 2* empty-tree empty-tree)
                       (list minus3 empty-tree empty-tree))
           (list 3^ empty-tree empty-tree)))

(mapTree example-tree 2) ;; => '(18 6 27)
(mapTree example-tree 1) ;; => '(8 1 9)