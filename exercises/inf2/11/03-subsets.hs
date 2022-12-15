subsets [] = [[]]
subsets (x:xs) = 
  subsets xs ++ map (\subset -> x : subset) (subsets xs)