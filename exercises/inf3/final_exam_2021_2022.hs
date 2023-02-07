segments :: [Int] -> [[Int]]
segments (s:ss) = (s:takeSegment ss s) : (segments $ dropSegment ss s) 
  where takeSegment (x:xs) last
          | x < last = x : takeSegment xs x
          | otherwise = []
        dropSegment (x:xs) last
          | x < last = dropSegment xs x
          | otherwise = x:xs

fillSegments :: [Int] -> [Int]
fillSegments seg = concat $ map (\(x:_) -> [x,x-1..0]) segs
  where segs = segments seg


generateAllWords :: Int -> [String]
generateAllWords 0 = [""]
generateAllWords n = [ x:y | x <-['a'..'z'], y <- generateAllWords (n-1)]


isPossibleSolution :: (String, String) -> String -> Bool
isPossibleSolution ([], []) [] = True
isPossibleSolution (x:xs, y:ys) (z:zs) 
  | y == '+' = x == z && isPossibleSolution (xs, ys) zs
  | y == '-' = not (x `elem` z:zs) && isPossibleSolution (xs, ys) zs
  | otherwise = (x `elem` zs) && (x /= z) && isPossibleSolution (xs, ys) zs

 
wordle :: [(String, String)] -> String
wordle patterns 
  | length solutions == 1 = head solutions
  | length solutions > 1 = "many solutions"
  | otherwise = "no solution"
  where filterPredicate word = foldr (\p res -> res && isPossibleSolution p word) True patterns
        solutions = filter filterPredicate $ generateAllWords (length (fst $ head patterns))

