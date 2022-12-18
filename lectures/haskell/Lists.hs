module Lists where

import Prelude hiding
    (head, tail, null, length,
      enumFromTo, (++), reverse, (!!), elem,
      init, last, take, drop,
      map, filter, foldr, foldl, foldr1, foldl1)
import Distribution.Simple.Utils (xargs)

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

length2 :: [a] -> Int
length2 l
  | null l    = 0
  | otherwise = 1 + length2 (tail l)
-- >>> length2 [1..5]
-- 5

length3 :: [a] -> Int
length3 l = case l of
              []    -> 0
              (_:t) -> 1 + length3 t
-- >>> length3 [[1,2,3],[4,5,6]]
-- 2

length4 = foldr (const (+1)) 0

-- >>> length4 [1..10]
-- 10

-- >>> let [x,y]:[]:t = [[1,2],[],[3,4,5]] in (x,y,t)
-- (1,2,[[3,4,5]])
-- >>> let [x,y]:[]:t = [[1,2],[3],[4,5]] in (x,y,t)
-- /home/trifon/fmisync/Courses/2022_23/FP_2022_23/sandbox/haskell/Lists.hs:35:6-35: Non-exhaustive patterns in [x,
--                                                                                   y] : [] : t
-- >>> let x:y:[u,v,w] = [1..5] in (x,y,u,v,w)
-- (1,2,3,4,5)

-- >>> succ 2
-- 3

-- >>> succ 'a'
-- 'b'

enumFromTo from to
 | from == to = [from]
 | otherwise  = from : enumFromTo (succ from) to

-- >>> enumFromTo 1 5
-- [1,2,3,4,5]
-- >>> enumFromTo 'a' 'e'
-- "abcde"

-- >>> pred 'b'
-- 'a'
-- >>> 'a' + 1
-- No instance for (Num Char) arising from a use of ‘+’
-- >>> pred 'a'
-- '`'

(++) :: [a] -> [a] -> [a]
{-
[]     ++ l = l
(x:xs) ++ l = x:xs ++ l
-}

l1 ++ l2 = foldr (:) l2 l1

-- >>> [1..3] ++ [5..7]
-- [1,2,3,5,6,7]

reverse :: [a] -> [a]
{-
reverse []     = []
reverse (x:xs) = reverse xs ++ [x]
-}

snoc :: a -> [a] -> [a]
snoc x r = r ++ [x]

rcons :: [a] -> a -> [a]
rcons xs x = x : xs

-- reverse = foldr (\x -> (++[x])) []
-- reverse = foldr snoc []


reverse = foldl rcons []
-- >>> reverse [1..5]
-- [5,4,3,2,1]

(!!) :: [a] -> Int -> a
[]     !! _ = error "index too large"
(x:_)  !! 0 = x
(_:xs) !! n = xs !! (n - 1)

-- >>> [5..10] !! 2
-- 7

-- >>> [] !! 5
-- index too large

-- >>> [] !! (-5)
-- index too large

elem :: Eq t => t -> [t] -> Bool
elem _ [] = False
elem y (x:xs)
 | x == y    = True
 | otherwise = elem y xs

-- elem x l = not (null l) && (head l == x || elem x (tail l))

-- >>> elem 3 [1..5]
-- True
-- >>> elem 0 [1..5]
-- False
-- >>> 3 `elem` [1..5]
-- True

-- >>> (+) == (-)
-- No instance for (Eq (Integer -> Integer -> Integer))
--   arising from a use of ‘==’
--   (maybe you haven't applied a function to enough arguments?)
-- >>> show (+)
-- No instance for (Show (Integer -> Integer -> Integer))
--   arising from a use of ‘show’
--   (maybe you haven't applied a function to enough arguments?)
-- >>> :t (+)
-- (+) :: Num a => a -> a -> a
-- >>> :t 2
-- 2 :: Num p => p
-- >>> :t 1.4
-- 1.4 :: Fractional p => p

pythagoreanTriples from to =
    [ (x, y, z) | x <- [from..to],
                  y <- [x..to],
                  z <- [from..to],
                  x^2 + y^2 == z^2,
                  gcd x y == 1 ]
-- >>> pythagoreanTriples 1 50
-- [(3,4,5),(5,12,13),(7,24,25),(8,15,17),(9,40,41),(12,35,37),(20,21,29)]

init :: [a] -> [a]
init []     = error "empty list"
init [_]    = []
init (x:xs) = x:init xs

-- >>> init [1..10]
-- [1,2,3,4,5,6,7,8,9]
-- >>> init []
-- empty list

last :: [a] -> a
last []     = error "empty list"
last [x]    = x
last (_:xs) = last xs

-- >>> last [1..10]
-- 10

take 0 _      = []
take _ []     = []
take n (x:xs) = x : take (n-1) xs

drop 0 l      = l
drop _ []     = []
drop n (x:xs) = drop (n-1) xs

-- >>> take 4 [10..20]
-- [10,11,12,13]

-- >>> drop 4 [10..20]
-- [14,15,16,17,18,19,20]

map :: (a -> b) -> [a] -> [b]
{-
map _ []     = []
map f (x:xs) = f x : map f xs
-}
map f = foldr (\x -> (f x:)) []

-- something l == other l
-- something == other

-- >>> map (+1) [2..5]
-- [3,4,5,6]

filter :: (a -> Bool) -> [a] -> [a]

{-
filter _ []     = []
filter p (x:xs)
 | p x       = x:rest
 | otherwise = rest
    where rest = filter p xs
-}

filter p = foldr (\x rest -> if p x then x:rest else rest) []
-- >>> filter odd [1..10]
-- [1,3,5,7,9]

-- >>> [ (x, y) | x <- [1..3], y <- [11..13]]
-- [(1,11),(1,12),(1,13),(2,11),(2,12),(2,13),(3,11),(3,12),(3,13)]
-- >>> concat (map (\x -> map (\y -> (x, y) ) [11..13]) [1..3])
-- [[(1,11),(1,12),(1,13)],[(2,11),(2,12),(2,13)],[(3,11),(3,12),(3,13)]]

foldr :: (t1 -> t2 -> t2) -> t2 -> [t1] -> t2
foldr _  nv []     = nv
foldr op nv (x:xs) = x `op` foldr op nv xs

-- >>> foldr (+) 0 [1..10]
-- 55

-- >>> foldr (:) [] [1..10]
-- [1,2,3,4,5,6,7,8,9,10]

foldl :: (t1 -> t2 -> t1) -> t1 -> [t2] -> t1
foldl _  nv []     = nv
foldl op nv (x:xs) = foldl op (nv `op` x) xs

-- >>> foldl (+) 0 [1..10]
-- 55

-- >>> foldl (:) [] [1..10]
-- (:) :: a -> [a] -> [a]
-- Couldn't match type ‘a’ with ‘[a]’
-- Expected: [a] -> [[a]] -> [a]
--   Actual: [a] -> [[a]] -> [[a]]

foldr1 :: (t -> t -> t) -> [t] -> t
foldr1 _ []      = error "empty list"
foldr1 _ [x]     = x
foldr1 op (x:xs) = x `op` foldr1 op xs

-- >>> foldr1 (+) [1..10]
-- 55

foldl1 :: (t -> t -> t) -> [t] -> t
foldl1 _  []     = error "empty list"
foldl1 op (x:xs) = foldl op x xs

-- >>> foldl1 (+) [1..10]
-- 55

foldl2 op nv l = foldr (flip op) nv (reverse l)
-- >>> foldl2 rcons [] [1..10]
-- [10,9,8,7,6,5,4,3,2,1]
