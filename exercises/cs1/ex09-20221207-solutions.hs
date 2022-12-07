import Data.List

-- Зад.4 от миналия път
--complAdd p1 p2 = (fst p1 + fst p2, snd p1 + snd p2)
complAdd (x1,y1) (x2,y2) = (x1+x2, y1+y2)
complSub (x1,y1) (x2,y2) = (x1-x2, y1-y2)
complMult (x1,y1) (x2,y2) = (x1*x2-y1*y2, x1*y2+x2*y1)

-- Зад.6 от миналия път
repeated _ 0 = id -- Идентитет, или \x -> x
repeated f n = f . repeated f (n - 1)

-- Зад.1
minimum' lst = foldl min (head lst) (tail lst)
maximum' lst = foldl max (head lst) (tail lst)
reverse' lst = foldl (flip (:)) [] lst
length' lst = foldl (\res _ -> res + 1) 0 lst
all' p lst = foldl (\res el -> res && p el) True lst
any' p lst = foldl (\res el -> res || p el) False lst
replicate' n x = foldr (\_ res -> x : res) [] [1..n]

-- Зад.2
countDivisors n = length [ d | d<-[1..n], n `mod` d == 0]
prime n = null [ x | x<-[2..sqn], n `mod` x == 0 ]
  where sqn = floor $ sqrt $ fromIntegral n
descartes lst1 lst2 = [ (x,y) | x<-lst1, y<-lst2 ]

-- Зад.3
primes = filter prime [2..]

-- Зад.4
primes' = sieve [2..]
  where sieve (x:xs) = x : sieve [ y | y<-xs, y `mod` x /= 0 ]

-- Зад.5
-- Проблем: това _никога_ няма да "извърти" всички y за x=0
-- и да генерира наредени двойки с друга първа компонента
--   pairs = [(x,y) | x<-[0..], y<-[0..]]
-- Решение: обхождаме по диагонали - т.к. всеки от тях е краен,
-- всяка наредена двойка ще се достигне за крайно време:
pairs = [ (x,diag-x) | diag<-[0..], x<-[0..diag] ]

-- Зад.6 - за следващия път
compress :: Eq a => [a] -> [(a, Int)]
compress = undefined

-- Зад.7
maxRepeated :: Eq a => [a] -> Int
maxRepeated lst = maximum $ map snd $ compress lst
