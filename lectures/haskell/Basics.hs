module Basics where

import Prelude hiding (gcd)

-- >>> x
-- 2
x :: Int
-- x = "abc"
x = 2

y :: Double
-- >>> y
-- 11.5
y = fromIntegral (x^2) + 7.5

z :: String
-- >>> z
-- "I love Haskell"
z = "I love Haskell"
-- z = "I love Scheme"

square :: Int -> Int
square x = x * x
{-
>>> square 2
>>> square x
4
4
>>> square 2.7
No instance for (Fractional Int) arising from the literal ‘2.7’
>>> square 2 + 3
7
>>> square (2 + 3)
25
-}

hypothenuse :: Double -> Double -> Double
hypothenuse a b = sqrt (a**2 + b**2)
-- >>> ((hypothenuse 3) 4)
-- 5.0
-- >>> hypothenuse 3 4
-- 5.0
-- >>> hypothenuse 3
-- No instance for (Show (Double -> Double))
--   arising from a use of ‘evalPrint’
--   (maybe you haven't applied a function to enough arguments?)

twice :: (t -> t) -> t -> t
twice f x = f (f x)
-- >>> twice square 3
-- 81
-- >>> 13 `div` 5
-- 2
-- >>> (-         5) 8
-- Non type-variable argument in the constraint: Num (t1 -> t2)
-- (Use FlexibleContexts to permit this)
-- >>> (5-) 8
-- -3
-- >>> (subtract 5) 8
-- 3

fact n
 | n == 0    = 1
 | n > 0     = n * fact (n - 1)
 | otherwise = error "подадено отрицателно число"
-- >>> fact 7
-- 5040
-- >>> fact (-5)
-- подадено отрицателно число
-- >>> :t error
-- error :: [Char] -> a
-- >>> let x = 5 in x + 3
-- 8
-- >>> (let x = 5 in x + 3) + x
-- 10
-- >>> (let n = 5 in n + 3)
-- 8
-- >>> (let n = 5 in n + 3) + n
-- Variable not in scope: n
-- >>> x + 3 where x = 5
-- parse error on input ‘where’
result = let x = 2
             y = 3
         in x + y
-- >>> result
-- 5
result2 = let { x = 2; y = 3 } in x + y
-- >>> result2
-- 5

(??) x y = x * 2 + y * 3
--- >>> 5 ?? 8
-- 34
x !!! y = fact x + square y
--- >>> 5 !!! 8
-- 184
gcd 0 0 = error "няма най-голям общ делител"
gcd x 0 = x
gcd 0 y = y
gcd x y
  | x == y    = x
  | x > y     = gcd (x - y) y
  | otherwise = gcd x (y - x)
-- >>> gcd 20 36
-- 4
