-- Quicksort, приемащ предикат за сравнение
-- пример: (<) за нарастващ ред, (>) за намаляващ
quicksortBy :: (a -> a -> Bool) -> [a] -> [a]
quicksortBy _ [] = []
quicksortBy _ [x] = [x]
quicksortBy cmp (x:xs) = 
    quicksortBy cmp [ y | y<-xs, cmp y x ]
    ++ [x]
    ++ quicksortBy cmp [ y | y<-xs, not (cmp y x)]

-- Примерно използване на по-сложен предикат
-- Проблем: той се извиква при всяко сравнение на два елемента
--maxLength lsts = quicksortBy (\x y -> length x < length y) lsts

-- Two-step sort: харчи повече памет, но не преизчислява функцията на всяко сравнение
quicksortOn :: Ord b => (a -> b) -> [a] -> [a]
quicksortOn f lst = map fst $ quicksortBy (\p1 p2 -> snd p1 < snd p2) [ (x,f x) | x<-lst ]

maxLength :: [[a]] -> [[a]]
maxLength lsts = quicksortOn length lsts

specialSort :: (Eq a, Ord a) => [[a]] -> [[a]]
specialSort lsts = quicksortBy (\x y -> mostFrequent x < mostFrequent y) lsts
  where mostFrequent lst = fst $ head $ quicksortBy (\p1 p2 -> snd p1 > snd p2 || (snd p1 == snd p2 && fst p1 > fst p2)) [ (x, count x lst) | x<-lst ]
        count x lst = length [ y | y<-lst, x==y ]

type Graph = [(Int,[Int])]
vertices :: Graph -> [Int]
vertices g = map fst g
children :: Int -> Graph -> [Int]
children u g = snd $ head $ filter (\p -> fst p == u) g
-- all, any
none :: (a -> Bool) -> [a] -> Bool
none p lst = all (\x -> not $ p x) lst
parents :: Int -> Graph -> [Int]
parents u g = [ v | v<-vertices g, u `elem` (children v g) ]

makeSet :: Eq a => [a] -> [a]
makeSet = undefined

isFamily :: [Int] -> Graph -> Bool
isFamily f g = all (\u -> (all (`elem` f) (children u g)
                        && none (`elem` f) (parents u g))
                     || (all (`elem` f) (parents u g)
                        && none (`elem` f) (children u g))) f

buildFamily :: Int -> Graph -> Bool -> [Int]
buildFamily u g flag = helper [u] [u] flag
  where helper curr all flag
          | null next = all
          | otherwise = helper next (all ++ next) (not flag)
          where tmp = makeSet $ concat $ map (\u -> if flag then children u g else parents u g) curr
                next = [ v | v<-tmp, not (v `elem` all) ]

minIncluding :: Int -> Graph -> [Int]
minIncluding u g
  | isFamily attempt1 g = attempt1
  | isFamily attempt2 g = attempt2
  | otherwise           = []
  where attempt1 = buildFamily u g False
        attempt2 = buildFamily u g True
        