-- Изпит 2021/22, зад.1
getSegment :: (Ord a) => [a] -> [a]
getSegment [] = []
getSegment [x] = [x]
getSegment (x:y:xs)
  | x <= y = [x] -- x и y са в разл. сегменти, значи текущият приключва в x
  | otherwise = x : getSegment (y:xs) -- x и y са в един и същ

segments :: (Ord a) => [a] -> [[a]]
segments [] = []
segments xs = first : segments rest
  where first = getSegment xs
        rest = drop (length first) xs

fillSegments :: (Num a, Enum a, Ord a) => [a] -> [a]
fillSegments xs = concat [ f s | s<-segments xs]
  where f (a:_) = [a,a-1..0]

-- Изпит 2021/22, зад.3
generate :: Int -> [String]
generate 0 = [""] -- празната дума
generate n = [ c:str | str<-generate (n-1), c<-['a'..'z']]
--generate n = concat . map (\str -> map (\c -> c:str) ['a'..'z']) $ generate (n-1)
-- List comprehension-ът всъщност е синтактична захар за:
--generate n = do
--    str <- generate (n-1)
--    c <- ['a'..'z']
--    return $ c:str
-- и това е валиден код, защото дори списъкът е монад!

type Move = (String,String)
wordle :: [Move] -> String
wordle moves = helper moves allWords
  where n = length . fst $ head moves
        allWords = generate n
        helper :: [Move] -> [String] -> String
        helper [] [w] = w
        helper [] words = "Many solutions"
        helper _ [] = "no solution"
        helper (m:ms) words = helper ms (filter (\w -> match m w && match2 m w) words) 
          where match :: Move -> String -> Bool
                match (s:ss,a:as) (w:ws)
                  | a == '+' && s == w = match (ss,as) ws
                  | a == '-' && s /= w = match (ss,as) ws
                  | a == '?' = match (ss,as) ws -- Игнорираме ?, match2 ще се погрижи
                  | otherwise = False
                match _ _ = True
                match2 :: Move -> String -> Bool
                match2 (s,a) w = all (\s -> s `elem` w) [ s | (s,a)<-zip s a, a=='?']
                -- Проблем: не трябва това да са независими функции :(

-- Изпит 2021/22, зад.2
house :: [(Int,[Int])]
house = [(0, [1, 2]), (1, [0, 2]), (2, [0, 1, 3]), (3, [2])]
tom room = (room + 1) `mod` 3

neighbs :: Int -> [(Int,[Int])] -> [Int]
neighbs u g = head [ ns | (v,ns)<-g, u == v]

spike :: [(Int,[Int])] -> Int -> (Int -> Int) -> Int -> [Int]
spike h x t y = helper [(x,y,[x])]
  where -- Потенциален проблем - трябва да филтрираме дублиращи се координати
        -- и да помислим за ограничаване на бездънната рекурсия :)
        helper coords = case find coords of Just path -> path
                                            Nothing -> helper next
          where next = [ (u,t y,prev++[u]) | (x,y,prev)<-coords, u<-(x:neighbs x h)]
        -- По списък от координати намира тези, в които x==y и връща съотв. натрупан път
        -- Ако няма такива координати, връща празен списък
        find :: [(Int,Int,[Int])] -> Maybe [Int]
        find [] = Nothing
        find ((x,y,path):rest)
          | x == y    = Just path
          | otherwise = find rest

-- Изпит 2019/20, вар.А, зад.3
-- Няма смисъл да имаме празни наследници => нека всички дървета поначало са непразни
data Tree a = Tree a [Tree a]

-- Намира пътищата до всички срещания на x, кодирани като
-- списък от индексите на всеки наследник на предишния връх в пътя
paths :: (Eq a) => a -> Tree a -> [[Int]]
paths x t = helper x t []
  where helper x (Tree root subtrees) curr
          | x == root = curr : results
          | otherwise = results
          where results = concat [ helper x t (curr++[i]) | (t,i)<-zip subtrees [0..] ]

-- foldl1 е ляво насъбиране, използващо първият елемент за първоначална стойност
lcp :: (Eq a) => [[a]] -> [a]
lcp lsts = foldl1 lcp2 lsts
  where lcp2 [] _ = []
        lcp2 _ [] = []
        lcp2 (x:xs) (y:ys)
          | x == y    = x : lcp2 xs ys
          | otherwise = []

values :: [Int] -> Tree a -> [a]
values [] (Tree root _) = [root]
values (i:is) (Tree root subtrees) = root : values is (subtrees !! i)

minPredecessor :: (Ord a) => a -> Tree a -> a
minPredecessor x t = minimum $ values (lcp (paths x t)) t

-- Пробното дърво от дъската: резултатът от lcp трябва да е [0,0],
-- стойностите по пътя [2,1], от които най-малката - 1
t :: Tree Int
t = Tree 2 [Tree 1 [Tree 5 [Tree 2 [],
                            Tree 3 [Tree 4 [],
                                    Tree 5 []]],
                    Tree 0 [],
                    Tree 6 [Tree 5 [],
                            Tree 7 []]],
            Tree 3 [],
            Tree 4 []
          ]