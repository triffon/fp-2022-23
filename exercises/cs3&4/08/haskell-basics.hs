-- Започваме с коментар
-- Тези неща ще ви се карат:
-- cover all cases!
{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}
-- no incomplete patterns in lambdas!
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-}
-- use different names!
{-# OPTIONS_GHC -fwarn-name-shadowing #-}
-- use all your pattern matches!
{-# OPTIONS_GHC -fwarn-unused-matches #-}

-- Тук скривам някои функции,
-- за да няма колизии с нашите дефиниции.
import Prelude hiding (abs, filter, map, reverse)

-- Prelude идва с някои стандартни дефиниции,
-- с които разполагаме по подразбиране.

-- ghci commands:
--  - :l(oad)
--  - :r(eload)
--  - :q(uit)
--  - :t(ype)

-- В контраст със Scheme, Haskell е:
-- 0) Статично типизиран - променливите имат тип)
-- 1) С лениво/мързеливо оценяване
-- 2) Чист (pure) - без странични ефекти

-- * Зависим от идентация (+ не харесва табулации)

-- * Силно типизиран - няма имплицитно кастване!

-- Прости типове (константи):
-- Bool     - булев тип с константи True и False
-- Char     - Unicode символи
-- Int      - целочислен тип
-- Integer  - целочислен тип с неограничен размер
-- Float    - десетични числа с единична прецизност
-- Double   - десетични числа с двойна прецизност

-- * Именат на типовете винаги започват с главна буква.

-- Съставни типове:
-- (a,b,c) - тип кортеж (tuple) с фиксирана дължина
--           и произволни типове на компонентите.
-- [a]     - тип списък с произволна дължина и елементи от тип a.

-- Пример:
-- [1,2,3] - списък от числа [Int]
-- (1,'а') - наредена двойка от число и символ (Int, Char)
-- "asdf"  - низ, същото като списък от символи, т.е. String = [Char]

-- Променливи:
-- -----------
-- Типова декларация на променлива var от тип t
-- var :: t

-- Дефиниция на променлива var със стойност <expr>
-- var = <exp>

-- Не може да има декларация без придружаваща я дефиниция!
-- Но може да има дефиниция без експлицитна декларация.

-- Haskell може да предположи каква е типовата декларация (type inference),
-- но ние ще я пишем експлицитно!

-- Имената на идентификаторите винаги започват с малка буква или "_".
-- Не могат да съдържат "-", т.е. ще се придържаме към camel case.

-- Пример:
num :: Int
num = 5

-- Пример:
-- square = \x y -> if x == y then 'a' else 'b'

-- Функции:
-- --------
-- Типова декларация на функция fun,
-- която взима n-1 аргумента от съответни типове t1...tn-1
-- и връща резултат от тип tn
-- fun :: t1 -> t2 -> ... tn-1 -> tn

-- Дефиниция на функцията fun над аргументи x1 ... xn-1
-- fun x1 x2 ... xn-1 = <expr>

mult :: Int -> Int -> Int
mult a b = a * b

-- Прилагане на функции:
-- ---------------------
-- f x1 x2 .. xn
-- където f е идентификатора на функцията,
-- x1 .. xn са аргументи и <space> e разделител.

-- Функциите на практика пак се прилагат префиксно,
-- но скобите не са задължителни!
-- Пример: mult 2 3

-- Операциите вече, се прилагат инфиксно, за щастие.
-- Пример: 1 + 2 * 3
-- Имат си съответните приоритети и винаги можем да използваме скоби,
-- за да задаваме приоритет експлицитно.

-- Прилагането на функции е с най-висок приоритет!
-- mult 2 3 + 7    ~~> 13
-- mult 2 (3 + 7)  ~~> 20
-- mult 2 succ 3   ~~> Грешка
-- Тук mult бърза да се изпълни
-- и като втори аргумент не вижда резултата от succ 3, а функцията succ.

-- mult 2 $ 3 + 7 ~~> 20
-- Оператора ($) прилага функцията отдясно върху аргумента отляво,
-- като изчаква аргумента да се оцени. Така често можем да си спестяваме скоби.

-- Видяхме как операциите се прилагат инфиксно.
-- Всяка функция на 2 аргумента можем
-- да я приложим като бинарна операция с <backtick>.
-- Пример: 2 `mult` 3

-- От друга страна всеки оператор можем да го използваме като функция.
-- Пример: (+) 2 3

-- В Haskell има само функции на 1 аргумент:
-- -----------------------------------------
-- Нека разгледаме типа на следната функця
-- plus :: Int -> Int -> Int

-- (->) е дясно асоциативна операция,
-- тоест ако разпишем скобите, типа на plus ще изглежда така:
-- plus :: Int -> (Int -> Int)
-- Тоест plus приема число и връща функция на 1 аргумент:
-- (plus 1) 2

-- А тъй като прилагането на функция е с най-висок приоритет -
-- няма нужда от скоби и пишем просто:
-- plus 1 2

-- Тоест функциите на повече аргументи са функции от по-висок ред.
-- Това се нарича currying.

-- Това ни позволява да правим частично прилагане на ф-ии.
-- squareAll :: [Int] -> [Int]
-- squareAll xs = map (^2) xs
-- Тук (^2) е частично приложен инфиксния оператор (^)

-- Ако разпишем скобите на горния пример:
-- squareAll xs = (map (^2)) xs
-- С по-прости имена:
-- f x = g x
-- Значи f = g
-- Haskell ни позволява по същия начин да "съкращаваме" аргументите:
-- squareAll = map (^2)
-- Това се нарича ета редукция в ламбда смятането и поражда така наречения
-- безточков (point-free) стил на програмиране.
-- Без точки в смисъла на "без аргументи".

-- Някои функции свързани с currying:
-- curry :: ((a, b) -> c) -> a -> b -> c
-- uncurry :: (a -> b -> c) -> (a, b) -> c

-- Типови променливи:
-- ------------------
-- В света на типовете всеки конкретен тип е като константа
-- Съответно можем да правим и променливи.

-- Например функцията map може да работи над списъци от различен тип:
-- [Char], [Int], [Int -> String] и т.н.
-- Как така? Ами ето как изглежда типа на map:
-- map :: (a -> b) -> [a] -> [b]

-- Спомнете си че типовете винаги започват с главна буква,
-- така Haskell знае дали говорим за тип (типова константа)
-- или за типова променлива

-- Някой сеща ли се за функция от тип (а -> a) ?
-- Ами за функция от тип (a -> b) ?

-- NOTE: в Hoogle може да търсите функции по декларация

-- Още функции/оператори:
-------------------------
-- Ламбда функция
-- \x y -> x + 2 * y

-- Композиция на функции
-- ((*2) . (+1)) 10 ~~> 22

-- Функция на обърнати аргументи:
-- flip (-) 10 2 ~~> -8

-- Достъп до елементи на наредена двойка
-- fst (1, 2) ~~> 1
-- snd (1, 2) ~~> 2

-- Достъп до части на списък:
-- head [1,2,3] ~~> 1
-- tail [1,2,3] ~~> [2,3]
-- init [1,2,3] ~~> [1,2]
-- last [1,2,3] ~~> 3

-- Добавяне на елемент към списък с (:).
-- 1 : [2,3] ~~> [1,2,3]

-- Сравняване на стойности с (==)
-- 1 == 2 ~~> False

-- Условен израз
-- if even x then "even" else "thats odd"


--------------------------------------------------------------------------------
-- ЗАДАЧИ --
------------

-- Имплементирайте следните функции.
-- Измислете и съответните типови декларации.

-- * Решете задачите без явна рекурсия.

-- абсолютна стойност (модул) за цели числа
abs = undefined

-- прилага дадена (едноаргументна) функция f над аргумент x
-- apply (+1) 0 ~~> 1
apply = undefined

-- композиция на едноаргументни функции
-- compose (+1) (^2) 2 ~~> 9
compose = undefined

-- За списъци от цели числа,
-- проверява дали първия списък е префикс на втория
-- prefix [1,2,3] [1,2,3,4,5] ~~> True
-- Hint: take, drop
prefix = undefined

-- За списъци от цели числа,
-- проверява дали първия списък е суфикс на втория
-- prefix [4,5] [1,2,3,4,5] ~~> True
-- Hint: take, drop
suffix = undefined

-- Използвайте foldl/foldr
filter = undefined

-- Използвайте foldl/foldr
map = undefined

-- Използвайте foldl/foldr
reverse = undefined

-- За дадени функция f, предикат p и списък xs
-- връща списък от елементите на xs, за които е изпълнен предиката p,
-- като над тези елементи е приложена функцията f.
weakListComprehension = undefined

-- по даден списък от числа xs и функция над числа f
-- връща списък от тези елементи x на xs, за които f(x) е от xs
-- Hint: elem
closed = undefined

-- За даден списък xs, връща наредена двойка (ys,zs), където
-- - ys са елементите на нечетни позиции в xs
-- - zs са елементите на четни позиции в xs
-- Използвайте foldl/foldr.
uninterleave = undefined

-- Бонус: Дайте колкото можете по-безточкови дефиниции
