--{-# OPTIONS_GHC -fwarn-incomplete-patterns #-} -- cover all cases!
--{-# OPTIONS_GHC -fwarn-unused-matches #-} -- use all your pattern matches!
--{-# OPTIONS_GHC -fwarn-missing-signatures #-} -- write all your toplevel signatures!
--{-# OPTIONS_GHC -fwarn-name-shadowing #-} -- use different names!
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-} -- no incomplete patterns in lambdas!
-- {-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE ExplicitForAll #-}

import Prelude hiding
  ( lcm
  , (.)
  , sum
  , length
  , maximum
  , map
  , filter
  , foldr
  , id
  , (<*>)
  )

square :: Int -> Int
square x = x*x

-- най-голям общ делител на n и m
-- използвайте div за целочислено делене
--gcd' :: Integer -> Integer -> Integer
--gcd' n m = undefined

-- най-малко общо кратно
lcm :: Integer -> Integer -> Integer
lcm a b = a * b `div` gcd a b

-- по дадено число намира сбора на цифрите му
sumDigits :: Int -> Int
sumDigits 0 = 0
sumDigits n = (n `rem` 10) + sumDigits (n `div` 10)


---- let и where
-- let е израз; where не е

-- разстоянието между две точки (x1,y1) и (x2,y2)
dist' :: Double -> Double -> Double -> Double -> Double
dist' x1 y1 x2 y2 =
  sqrt (square dx + square dy)
  where
    dx = x1 - x2
    dy = y1 - y2
    square x = x * x

-- let и where имат блокове с дефиниции, които зависят от идентацията
area :: Double -> (Double -> (Double -> (Double -> (Double -> (Double -> Double)))))
area x1 y1 x2 y2 x3 y3 =
  let
    a = dist x1 y1 x2 y2
    p = (a + b + c) / 2
    b = dist x2 y2 x3 y3
    c = dist x3 y3 x1 y1
  in
    sqrt ((p * (p - a) * (p - b) * (p - c)))
  where
    dist u1 v1 u2 v2 = sqrt (du^2 + dv^2)
      where
        du = u2 - u1
        dv = v2 - v1

k = let a = 5
        b = 7
 in a + b
-- a и b трябва да са едно под друго

test1 = ((((((area 6) 2) 1) 4) 5) 6)

---- Оператори
-- Операторите в хаскел винаги са бинарни, освен -
-- Всяка функция на поне 2 аргумента можем да я използваме като оператор, обграждайки я в ``
-- 12 `mod` 3
-- 243 `div` 10

-- Също така всеки оператор можем да го използваме като функция:
-- (+) 2 3

-- Можем да си дефинираме оператори
(+*) :: Int -> Int -> Int
x +* y = (x + y) * y

-- (+*) x y = (x + y) * y


x /&-^# y = x / (x - y)

-- Операторите, като функциите, може да се прилагат частично
-- (+5) (10-) (`mod`3)

---- Ламбда функции
-- \ arg -> expr
-- Пример:
square' = \x -> \y -> y * x * x
square'' x y = y * x * x

---- Функции от по-висок ред
-- (->) е дясно асоциативна, значи следните два реда означават едно и също:
-- plus :: Int -> Int -> Int
-- plus :: Int -> Int -> (Int -> Int)

-- plus 1 2
-- което е същото като
-- (plus 1) 2
--
plus :: Int -> (Int -> (Int -> Int))
-- следните две дефиниции правят едно и също нещо
plus x y z = x + y + z
--plus = \x -> \y -> \z -> x + y + z

---- Функции от по-висок ред
--
--    template <class T>
--    T id (T x) {
--        return x;
--    }
--
id :: a -> a
id x = x

-- композиция на две функции
-- scheme: (define (compose f g)
--           (lambda (x) (f (g x))))

compose :: (a -> b) -> (c -> a) -> c -> b
compose f g = \x -> f (g x)

--(.) = compose

-- друг вариант за дефиниция на (.)
f . g = \x -> f (g x)
(.) :: (b -> c) -> (a -> b) -> (a -> c)


---- Кортежи
-- (1,2) :: (Int, Int)

-- (,) :: a -> b -> (a,b)
-- fst
-- snd


-- (,,) :: a -> b -> (a,b,c)
--(,,) 1 2 3

-- type Point, Triangle, Vector
type Point = (Double, Double)
type Triangle = (Point, Point, Point)
type Vector = Point

-- <+> <*>
--(1,2) <+> (3,4) ---> (4,6)
(<+>) :: Vector -> Vector -> Vector
(x,y) <+> (z,t) = (x+z,y+t)

(<*>) :: Vector -> Vector -> Vector
(x,y) <*> (z,t) = (x * z, y * t)

---- Списъци
-- [] е списък
-- h:t е списък, ако t е списък
--
-- scheme:
-- '() е списък
-- (cons h t) е списък, ако t е списък

-- [1,2,3,4] == 1:(2:(3:(4:[]))) = 1:2:3:4:[]

-- [1,2,3,4] :: [Int]
-- [1,2,3,4] !! 2 -> 3

-- pattern matching

sum :: Num a => [a] -> a
sum [] = 0
sum (x:xs) = x + sum xs

length :: [a] -> Int
length [] = 0
length (_:xs) = 1 + length xs

-- (define (map f l)
--   (if (null? l) l
--       (cons (f (car l)) (map f (cdr l))))

map :: (a -> b) -> [a] -> [b]
map _ [] = []
map f (x:xs) = f x : map f xs

--filter :: ?
filter _ [] = []
filter p (x:xs) =
  if p x
  then x : filter p xs
  else filter p xs

filter' :: forall a. (a -> Bool) -> [a] -> [a]
filter' p [] = []
filter' p (x:xs) =
  possiblyAddX (filter' p xs)
  where
    possiblyAddX :: [a] -> [a]
    possiblyAddX = if p x then (x:) else id


foldr :: (a -> b -> b) -> b -> [a] -> b
foldr _  nv [] = nv
foldr op nv (x:xs) =
  op x (foldr op nv xs)

maximum [] = error "cannot find maximum of null list"
maximum [x] = x
--maximum (x:[]) = x
maximum (x:xs) = max x (maximum xs)

func [a,b,c] = a + b + c
func' (a:b:c:rest) = a + b + c


argMax :: Ord b => (a -> b) -> [a] -> a
argMax f [] = error ""
argMax f [x] = x
argMax f (x:y:xs) =
  argMax f (biggerNum : xs)
  where
    biggerNum =
      if f x < f y
      then y
      else x

foldr1 :: (a -> b -> b) -> [a] -> b
foldr1 _  []  = error "asd"
foldr1 _  [x] = x
foldr1 op (x:xs) =
  op x (foldr1 op xs)

argMax' :: Ord b => (a -> b) -> [a] -> a
argMax' f = foldr1 bigger
  where
    bigger x rec =
      if f x < f rec
      then rec
      else x

wtf = "wtf " ++ f

fibs = 0 : 1 : zipWith (+) fibs (tail fibs)
