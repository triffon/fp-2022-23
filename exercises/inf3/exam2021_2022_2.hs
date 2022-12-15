
isNPerm n f = eqSets nats (map f nats)
  where nats = [0..n-1]
        eqSets xs ys = all (\x -> elem x ys) xs && all (\y -> elem y xs) ys

cycleFrom start f = (start:(gen (f start)))
  where gen m
          | m == start = []
          | otherwise  = (m:(gen $ f m))

maxCycle n f = foldr (\x y -> if length x >= length y then x else y) [] $ map (\x -> cycleFrom x f) nats
  where nats = [0..n - 1]

average :: [Double] -> Double
average ys = (foldl (\x res -> res + x) 0 ys) / fromIntegral (length ys)

-- movingAverage :: [Int] -> Int -> [Int]
movingAverage xs n = gen xs
  where gen xs = average (take n xs) : gen (tail xs)

allAverages xs = map (\x -> movingAverage xs x) [2..]

flatten xs = foldl (\res x -> res ++ x) [] xs

inv = [ ("docs", ["ids", "invoices"]), ("ids", ["passport"]),  ("invoices", []), ("memes", ["asd"]), ("asd", []), ("family", ["new year", "birthday"]), ("funny", ["memes"]), ("pics", ["family", "funny"]) ]

allObjects :: [(String, [String])] -> [String]
allObjects inv = filter (\label -> all (\(l, _) -> l /= label) inv) labels
  where labels = flatten $ map (\(_, items) -> items) inv

cleanUp :: [(String, [String])] -> [(String, [String])]
cleanUp inv
  | length emptyBoxes == 0 = inv
  | otherwise = cleanUp $ map (\(l, items) -> (l, filter (\x -> not $ elem x emptyBoxes) items)) nonEmptyBoxes
  where emptyBoxes = map (\(l, _) -> l) $ filter (\(_, items) -> length items == 0) inv
        nonEmptyBoxes = filter (\(_, items) -> length items /= 0) inv