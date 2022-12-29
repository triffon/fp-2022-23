-- взима първите n елемента на списък
take' :: Int -> [a] -> [a]
take' 0 _ = []
take' n [] = []
take' n (x:xs) = x : take' (n-1) xs

-- премахва първите n елемента от списък
drop' :: Int -> [a] -> [a]
drop' 0 xs = xs
drop' _ [] = []
drop' n (_:xs) = drop' (n-1) xs

-- декартово произведение
cartesian :: [a] -> [b] -> [(a,b)]
cartesian [] ys = [] -- ?
cartesian (x:xs) ys = map (\y -> (x, y)) ys ++ cartesian xs ys

concatMap f = concat . map f
--list comprehension
cartesian' xs ys = [ (x,y) | x <- xs, y <- ys ]
example xs ys =
  [ combine x y | x <- xs, y <- ys, x+y == 2 ]
  where
    combine x y = x + 10 * y
    enum :: [b] -> [(Int, b)]
    enum = enum' 0
      where
        enum' :: Int -> [c] -> [(Int, c)]
        enum' _ [] = []
        enum' i (x:xs) = (i,x) : enum' (i+1) xs

zip' :: [a] -> [b] -> [(a,b)]
zip' xs ys = [ (x,y) | (ix, x) <- enum xs , (iy, y) <- enum ys , ix == iy ]

zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' f xs ys = [ f x y | (ix, x) <- enum xs , (iy, y) <- enum ys , ix == iy ]

zipWith'' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith'' f xs = map (uncurry f) . zip' xs
--zipWith'' f xs ys = map (uncurry f) (zip' xs ys)

-- обещанията (stream-овете) от Scheme се изрично се оценяват лениво,
-- в Хаскел това е по подразбиране за всички промениливи
-- безкрайните списъци са просто списъци, за които може да игнорираме края им - пишем рекурсии без дъно
f = f

concat' :: [[a]] -> [a]
concat' = foldr (++) [] ones = 1 : ones

zeroes = zipWith (-) ones ones

from :: Int -> [Int]
from n = n : from (n+1)

repeat' :: Int -> [Int]
repeat' x = x : repeat' x

--nats' = from 1
nats = 1 : zipWith (+) ones nats

fibs = 1 : 1 : zipWith (+) fibs (tail fibs)

sieve :: [Int] -> [Int]
sieve (x:xs) =
  x : filter ((0 /=) . (`mod` x)) (sieve xs)
  --filter (\y -> (y `mod` x) /= 0) (sieve xs)

primes = sieve (from 2)

cycle' :: [a] -> [a]
cycle' xs = go xs
  where
    go [] = xs
    go (y:ys) = ys

iterate' :: (a -> a) -> a -> [a]
iterate' f x = x : map f (iterate' f x)

-- поток от Питагоровите тройки. Питагорова тройка е наредена тройка (a, b, c), за която a^2 + b^2 = c^2.
pythagoreanTriples_notWorks =
  [ (a,b,c)
  | a <- nats
  , b <- nats
  , c <- nats
  , a^2 + b^2 == c^2
  ]

pythagoreanTriples_strangeOrder = [ (a, b, a^2+b^2) | a <- nats , b <- nats ]

pythagoreanTriples =
  [ (a, b, floor c)
  | (a, b) <- orderedPairs
  , a < b
  , gcd a b == 1
  , let c :: Double
        c = sqrt (fromIntegral (a^2+b^2))
  , c == fromIntegral (floor c)
  ]

orderedPairs :: [(Int, Int)]
orderedPairs = [ (i, d-i) | d <- nats , i <- [1 .. d-1] ]

sumLast k n = k : go [k]
  where
    go memory = x : go (take n (x:memory))
      where x = sum memory

