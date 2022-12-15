#lang racket

;; Иван е много подреден човек и обича да систематизира принадлежностите си в кутии, като всичко е прилежно надписано.
;; Той следи инвентара на личния си лаптоп, като го представя чрез списък от наредени двойки:
;; етикет на кутия (произволен низ) и списък от съдържанието ѝ – етикети на предмети,
;; сред които евентуално и други кутии (също произволни низове). Всички етикети са уникални.
;; Иван има нужда от помощ с реализацията на някои функции за управление на инвентара си:

;; а). Да се реализира функция allObjects, която по даден инвентар
;; връща списък от етикетите на всички предмети, които не са кутии

(define (allObjects inventory)
  (let ((boxes (map car inventory))
        (contents (flatten (map cdr inventory))))
    
    (filter (lambda (label) (not (member label boxes))) contents)))

(define inv
  '(("docs" . ("ids" "invoices"))
    ("ids" . ("passport"))
    ("invoices" . ())
    ("memes" . ())
    ("family" . ("new year" "birthday"))
    ("funny" . ("memes"))
    ("pics" .("family" "funny"))))

;; (allObjects inv) ;; => '("passport" "new year" "birthday")

;; б) Иван не обича прахосничеството и иска да разчисти ненужните кутии.
;; Да се реализира функция cleanUp, която по даден инвентар връща негово копие, в което празните кутии са изхвърлени.
;; Упътване: Да се вземе предвид, че след изхвърляне на празни кутии,
;; други кутии може да останат празни и те също трябва да се изхвърлят.
;; Във върнатия резултат не трябва да има празни кутии.

;; функция, която приема предикат и списък и проверява дали
;; някой от елементи на списъка изпълнява зададеното условие
;; пример: (any? even? '(1 2 3)) ;; => #t
;; пример: (any? even? '(1 3 5)) ;; => #f
(define (any? pred? lst)
  (and
    (not (null? lst))
    (or (pred? (car lst)) (any? pred? (cdr lst)))))

(define get-name car)
(define get-content cdr)

(define (cleanUp inventory)
  (define (clean-up-content labels empty-box-names)
    (filter (lambda (label) (not (member label empty-box-names))) labels))

  (let*
    ((empty-boxes (filter (lambda (box) (null? (get-content box))) inventory))
     (empty-box-names (map get-name empty-boxes))
     (non-empty-boxes (filter (lambda (box) (not (null? (get-content box)))) inventory)))
     
  (if (null? empty-boxes)
      inventory
      (cleanUp
        (map
          (lambda (box)
            (cons (get-name box) (clean-up-content (get-content box) empty-box-names)))
          non-empty-boxes)))))

;; (cleanUp inv)
;; => '(("docs" "ids")
;;      ("ids" "passport")
;;      ("family" "new year" "birthday")
;;      ("pics" "family"))