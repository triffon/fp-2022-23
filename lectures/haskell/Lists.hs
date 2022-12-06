module Lists where

import Prelude hiding (head, tail, length)

-- >>> :t []
-- [] :: [a]
x :: Int
x = 2
-- >>> :t (x : []) 
-- (x : []) :: [Int]
-- >>> :t ((+x) : [])
-- ((+x) : []) :: [Int -> Int]

head :: [a] -> a
head (h:_) = h
-- >>> head [[1,2,3],[4,5,6]]
-- [1,2,3]

tail :: [a] -> [a]
tail (_:t) = t
-- >>> tail [[1,2,3],[4,5,6]]
-- [[4,5,6]]

null :: [a] -> Bool
null [] = True
null _  = False

length :: [a] -> Int
length []    = 0
length (_:t) = 1 + length t

-- >>> length [[1,2,3],[4,5,6]]
-- 2
