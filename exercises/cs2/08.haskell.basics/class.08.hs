-- Следните редове включват някои полезни предупреждения в ghc:
{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}      -- cover all cases!
--{-# OPTIONS_GHC -fwarn-unused-matches #-}           -- use all your pattern matches!
--{-# OPTIONS_GHC -fwarn-missing-signatures #-}       -- write all your toplevel signatures!
{-# OPTIONS_GHC -fwarn-name-shadowing #-}           -- use different names!
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-}  -- no incomplete patterns in lambdas!

--import Prelude hiding (div)

-- Пишем в любим текстов редактор (примерно vim или vscode)
-- и пускаме програмите с ghci (или ги компилираме с ghc)

-- ghci е repl
-- :t(ype)
-- :i(nfo)
-- :l(oad)
-- :r(eload)
--
z2 = 12389712983

-- В контраст със Scheme, Haskell е:
-- 1. Статично типизиран
-- 2. С мързеливо оценяване
-- 3. Без странични ефекти

-- * Няма имплицитно кастване
-- * Зависим от идентация (и не харесва табулации)

---- Типове:
-- Bool - True или False;
-- Char - Unicode символи - примерно 'g' или 'ю' или 'λ';
-- Int - цели числа между -2^63 и (2^63 - 1) включително;
-- Integer - произволно големи цели числа (като в Scheme)
-- Float - десетични дробни числа, 32 бита;
-- Double - десетични дробни числа, 64 бита.



add :: Int -> Int -> Int
add x y = x + y

add3 :: Int -> Int -> Int -> Int
add3 x y z' = x + y + z'

inc :: Int -> Int
inc x = x+1




-- Съставни типове:
--   списъци: [a] - всички елементи на списъка са от един и същи тип а, примерно
--     [1,2,3] е от тип [Int], може също да е и от тип [Integer];
--     [True,True,True,False] е от тип [Bool];
--     [1,True,'a'] не е списък.
--
--   низове: String - същото като списък от символи [Char], примерно
--     "hello world" е от тип String и "abc" == ['a','b','c']
--
--   наредени n-торки (кортежи) - имат фиксирана дължина, но типовете на членовете на n-торката може да се различават, примерно
--     (1,2,3) е от тип (Int,Int,Int);
--     ('Щ', 1, False, [3.1, 4.8]) е от тип (Char, Int, Bool, [Float]);
--     () е от тип () и е единственият обитател на типа ().

{-
   Коментар на няколко реда
-}

-- Всички типове винаги започват с главна буква.
type String' = [Char]

---- Константи
z :: Float
z = 127387912735.01

-- Ако не укажем типа на идентификатор,
-- Haskell ще се опита сам да го измисли, т.нар. type inference.
-- Това е полезно, но понякога може Haskell да обърка типа,
-- затова ще си пишем типовите декларации.

---- Функции на 1 аргумент
plusTen :: Int -> Int
plusTen x = x + 10

-- целочислено деление
div' :: Int -> Int -> Int
div' x y = floor (fromIntegral x / fromIntegral y)

divInteger :: Integer -> Integer -> Integer
divInteger x y = floor (fromInteger x / fromInteger y)

-- Идентификаторите (тоест имената на константите и функциите)
-- винаги започват с малка буква ('_' се води малка буква)
-- и съдържат само букви, числа или символа '.
-- Имена като 1+, odd? и zip-with, каквито ползвахме в Scheme,
-- не са позволени. Ще ползваме camelCase.


mult :: Num a => Int -> Int -> a
mult a b = fromIntegral (a * b)

-- Прилагането на функции в Haskell е с най-висок приоритет
-- и е ляво асоциативно.

-- mult 2 3 + 7  -- 13
-- ((mult 2) 3) + 7
-- mult 2 (3 + 7)  -- 20

-- mult 2 succ 3  -- Грешка
-- същото като
-- (((mult 2) succ) 3)


-- if <condition> then <expr> else <expr>
-- Сравняваме числа с (==), (/=), (<), (>), (<=) и т.н.

-- модул от n
abs' :: Integer -> Integer
abs' n =
  --(if (n < 0) then (- n) else n)
  if n < 0
  then -n
  else n

-- целочислено деление на 2
half :: Integer -> Integer
half x
  | even x = (floor ((fromIntegral x) / 2.0))
  | odd x = -1
  | x == 10000 = -2
  | otherwise = div (x-1) 2

-- разглеждане на случаи - guards
fact'' :: Integer -> Integer
fact'' n =
    if n == 0
    then 1
    else n * fact'' (n-1)

fact' :: Integer -> Integer
fact' n
  | n == 0    = 1
  | n < 0     = -999999999
  | otherwise = n * fact' (n-1)






fact :: Integer -> Integer
fact 0 = 1
fact n = fact (n-1) * n




factI :: Int -> Int
factI 0 = 1
factI n = n * factI (n-1)



fib n
  | n == 0 = 0
  | n == 1 = 1
  | otherwise = fib (n-1) + fib (n-2)


fib' :: Int -> Int
fib' 0 = 0
fib' 1 = 1
fib' n = fib (n-1) + fib (n-2)
