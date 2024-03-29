#lang racket

; Двоични дървета:
;-----------------
; Двоично дърво дефинираме по следния начин:
; 1) '() е двоично дърво.
; 2) (root left right) е двоично дърво, точно когато
;   left и right са двоични дървета,
;   а root е просто стойността в корена.

; Дефинираме си няколко функции за работа с дървета:

(define root car)

(define left cadr)

(define right caddr)

; Проверяваме по дефиницията
(define (tree? t)
  (or (null? t)
      (and (list? t)
           (= (length t) 3)
           (tree? (left t))
           (tree? (right t)))))

; Конструктор
(define (make-tree root left right)
  (list root left right))

(define empty? null?)

; Едно дърво е листо ако има вида (root '() '()),
; тоест текущия връх няма наследници
(define (leaf? t)
  (and (empty? (left t))
       (empty? (right t))))


; Пример:
(define t
  '(1 (2 () ())
      (3 ()
         (4 () ()))))

; Изглежда така:
;
;   1
;  / \
; 2   3
;      \
;       4


; Асоциативни списъци:
;---------------------
; асоциативен списък ще наричаме списък от двойки
; от вида (key . value)

; още познато като map или dictionary

; ето и някой основни функции:

; По функция и списък от ключове, правим
; асоциативен списък с елементи от вида (key . fn(key))
(define (make-alist fn keys)
  (map (lambda (key)
         (cons key (fn key)))
       keys))

; Вече можем и да добавяме елементи в нашия списък
(define (add-assoc key value alist)
  (cons (cons key value)
        alist))

(add-assoc 'purpose 42 '()) ; '((purpose . 42))

; Ще е хубаво да имаме и функции с които да вземем
; само ключовете или само стойностите на списъка
(define (alist-keys alist)
  (map car alist))

;===============;=========================================
;; З А Д А Ч И ;;
;;;;;;;;;;;;;;;;;

; За двоични дървета:
;--------------------
; 1. Намира броя на листата в tree.
(define (count-leaves tree) 'undefined)

; 2. Връща ново дърво, в което f е приложена над
; всеки връх от tree.
(define (map-tree f tree) 'undefined)

; 3. Връща списък от всички върхове на разстояние n от
; корена на tree.
(define (level n tree) 'undefined)

; Обхождане на дърво, функциите да връщат списък
; от върховете в реда на обхождането им:
;---------------------------------------
; 4. корен-ляво-дясно
; (pre-order t) -> (1 2 3 4)
(define (pre-order t) 'undefined)

; 5. ляво-корен-дясно
; (in-order t) -> (2 1 3 4)
(define (in-order t) 'undefined)

; 6. ляво-дясно-корен
; (post-order t) -> (2 4 3 1)
(define (post-order t) 'undefined)

; 7. Обръща 2ката от наследници на всеки връх
; (root left right) -> (root right left)
(define (flip-tree t) 'undefined)

; За асоциативни списъци:
;------------------------
; 8.Връща списък от стойностите на асоциативен списък
(define (alist-values alist) 'undefined)

; 9. По дадени ключ и асоциативен списък,
; връща стойността от първата намерена двойка с ключа
(define (alist-assoc key alist) 'undefined)

; 10. По даден ключ изтрива първата съответстваща двойка
; със същия ключ
(define (del-assoc key alist) 'undefined)

; 11. Връща списък от списъци (result . args),
; където args са точно тези елементи x от lst,
; за които f(x) = result
(define (group-by* f lst) 'undefined)
