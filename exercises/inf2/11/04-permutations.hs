insertAt element _ [] = [element] 
insertAt element 0 lst = element : lst
insertAt element n (x:xs) = x : (insertAt element (n - 1) xs)

permutations [] = [[]]
permutations (x:xs) =
  concat (map (\lst -> helper x lst) (permutations xs))
  where
    helper element lst = [ insertAt element i lst| i <- [0..length lst]]

--permutations [1,2,3] -- => [[1,2,3],[2,1,3],[2,3,1],[1,3,2],[3,1,2],[3,2,1]]