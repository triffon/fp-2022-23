-- cover all cases!
{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}
-- warn about incomplete patterns v2
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-}
-- write all your toplevel signatures!
{-# OPTIONS_GHC -fwarn-missing-signatures #-}
-- use different names!
{-# OPTIONS_GHC -fwarn-name-shadowing #-}
-- use all your pattern matches!
{-# OPTIONS_GHC -fwarn-unused-matches #-}

-- Безкраен списък от всички естествени числа.
--
-- Пример:
-- >>> take 10 nats
-- [0,1,2,3,4,5,6,7,8,9]
nats :: [Integer]
nats = undefined

-- Безкрайно повторение на стойност
--
-- Пример:
-- >>> take 5 $ repeat 'a'
-- "aaaaa"
repeat :: a -> [a]
repeat = undefined

-- За функция f и аргумент x,
-- генерира безкрайният списък [x, f(x), f(f(x)), ...]
--
-- Пример:
-- >>> take 5 $ iterate (^2) 2
-- [2,4,16,256,65536]
iterate :: (a -> a) -> a -> [a]
iterate = undefined

-- За даден списък xs,
-- генерира безкрайният списък от повторение на елементите на xs
--
-- Пример:
-- >>> take 8 $ cycle [1,2,3]
-- [1,2,3,1,2,3,1,2]
cycle :: [a] -> [a]
cycle = undefined

-- Вариант на foldl, в който пазим междинните резултати от всяка стъпка
-- и връщаме списък от тях, вместо само финалният резултат.
-- (понякога доста полезно за дебъгване на foldl)
--
-- Пример:
-- >>> scanl (+) 0 [1..10]
-- [0,1,3,6,10,15,21,28,36,45,55]
scanl :: (b -> a -> b) -> b -> [a] -> [b]
scanl = undefined

-- Безкраен поток от числата на Фибоначи (hint: zipWith)
--
-- Пример:
-- >>> take 10 fibs
-- [0,1,1,2,3,5,8,13,21,34]
fibs :: [Integer]
fibs = undefined

-- Безкраен списък, в който n-тия елемент е n! (факториел)
-- Опитайте да я имплементирате чрез scanl (hint: nats)
--
-- Пример:
---- >>> take 7 factsScanl
-- [1,1,2,6,24,120,720]
factsScanl :: [Integer]
factsScanl = undefined
