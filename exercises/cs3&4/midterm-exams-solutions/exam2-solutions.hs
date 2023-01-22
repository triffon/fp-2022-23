data BTree a
  = Nil
  | Node a (BTree a) (BTree a)
  deriving (Show)

-- Вариант А:
-------------
type MatchResult = (String, String, Int, Int)

goalDiff :: [MatchResult] -> String -> Int
goalDiff matches team = totalGoals - receivedGoals
  where
    totalGoals = foldl (\acc (_, _, x, y) -> acc + x + y) 0 matches
    receivedGoals = foldl op 0 matches
    op acc (t1, t2, g1, g2)
      | t1 == team = acc + g1
      | t2 == team = acc + g2
      | otherwise = acc

matchScore :: Int -> Int -> Int
matchScore x y
  | x > y = 3
  | y > x = -1
  | otherwise = 0

tournamentScore :: [MatchResult] -> String -> Int
tournamentScore matches team = foldl op 0 matches
  where
    op acc (t1, t2, g1, g2)
      | t1 == team = acc + matchScore g1 g2
      | t2 == team = acc + matchScore g2 g1
      | otherwise = acc

unique :: Eq a => [a] -> [a]
unique [] = []
unique (x : xs)
  | x `elem` xs = unique xs
  | otherwise = x : unique xs

maxGoal :: [MatchResult] -> [String] -> [String]
maxGoal matches teams = map snd $ filter (\(gd, _) -> gd == maxGd) withGoals
  where
    withGoals :: [(Int, String)]
    withGoals = map (\t -> (goalDiff matches t, t)) teams
    (maxGd, _) = maximum withGoals

maxGoalMinPoints :: [MatchResult] -> String
maxGoalMinPoints matches =
  snd . minimum . map toScoreTuple $ maxGoal matches teams
  where
    teams = unique $ concatMap (\(t1, t2, _, _) -> [t1, t2]) matches
    toScoreTuple t = (tournamentScore matches t, t)

-- If elements are from Num a, then (3^) won't work
fTree :: BTree (Int -> Int)
fTree =
  Node
    (+ 1)
    ( Node
        (^ 2)
        (Node (* 2) Nil Nil)
        (Node (\x -> x - 3) Nil Nil)
    )
    (Node (3 ^) Nil Nil)

mapTree :: BTree (a -> a) -> a -> [a]
mapTree Nil v = [v]
mapTree (Node f Nil Nil) v = [f v]
mapTree (Node f l r) v = mapTree l (f v) ++ mapTree r (f v)

zipWith4 :: (a -> b -> c -> d -> e) -> [a] -> [b] -> [c] -> [d] -> [e]
zipWith4 _ [] _ _ _ = []
zipWith4 _ _ [] _ _ = []
zipWith4 _ _ _ [] _ = []
zipWith4 _ _ _ _ [] = []
zipWith4 f (x : xs) (y : ys) (z : zs) (t : ts) =
  f x y z t : zipWith4 f xs ys zs ts

-- Задачата е малко странна,
-- защото трабва да вземем списък от 3 потока
-- и да върнем списък от 3 потока.
--
-- Следното ми се струва по-нормално и просто:
-- braidStreams ([a],[a],[a]) -> ([a],[a],[a])
-- Защото не трябва да мислим за дължината на получения списък
braid :: [a] -> [a] -> [a] -> ([a], [a], [a])
braid xs ys zs = (xs', ys', zs')
  where
    (xs', ys', zs') = unzip3 $ zipWith4 f xs ys zs [0 ..]
    f x y z t
      | even t = (y, x, z)
      | otherwise = (x, z, y)

braidStreams :: [[a]] -> [[a]]
braidStreams xss
  | length xss /= 3 = error "Expecting a list with 3 elements!"
  | otherwise = [xs', ys', zs']
  where
    xs : ys : zs : _ = xss
    (xs', ys', zs') = braid xs ys zs

-- Вариант Б:
-------------
prime :: Int -> Bool
prime n
  | n < 2 = False
  | otherwise = null [x | x <- [1 .. n], n `rem` x == 0]

pTree :: BTree (Int -> Bool)
pTree =
  Node
    (< 2)
    ( Node
        odd
        (Node (> 6) Nil Nil)
        (Node prime Nil Nil)
    )
    (Node (> 0) Nil Nil)

groupByTrace :: BTree (a -> Bool) -> [a] -> [[a]]
groupByTrace Nil xs = [xs]
groupByTrace (Node p l r) xs = groupByTrace l left ++ groupByTrace r right
  where
    left = filter (not . p) xs
    right = filter p xs

sameTrace :: BTree (a -> Bool) -> [a] -> Bool
sameTrace bt = any ((> 1) . length) . groupByTrace bt

-- Hard coded,
-- Но би ви спестило доста време от имплементация на permutations
permTuple3 :: (a, a, a) -> [(a, a, a)]
permTuple3 (x, y, z) =
  [ (x, y, z),
    (x, z, y),
    (y, x, z),
    (y, z, x),
    (z, x, y),
    (z, y, x)
  ]

combStep :: (Num a, Ord a) => (a, a, a) -> (a, a, a) -> (a, a, a)
combStep prev = snd . minimum . map f . permTuple3
  where
    f x = (s prev x, x)
    s (x1, y1, z1) (x2, y2, z2) =
      abs (x2 - x1) + abs (y2 - y1) + abs (z2 - z1)

comb :: (Num a, Ord a) => [a] -> [a] -> [a] -> ([a], [a], [a])
comb (x : xs) (y : ys) (z : zs) = unzip3 $ zipWith combStep zipped zipped'
  where
    zipped = zip3 xs ys zs
    zipped' = drop 1 zipped

combStreams :: (Num a, Ord a) => [[a]] -> [[a]]
combStreams xss
  | length xss /= 3 = error "Expecting a list with 3 elements!"
  | otherwise = [xs', ys', zs']
  where
    xs : ys : zs : _ = xss
    (xs', ys', zs') = comb xs ys zs
