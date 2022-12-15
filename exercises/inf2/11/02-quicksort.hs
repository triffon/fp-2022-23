quicksort [] =[]
quicksort (x:xs) =
  quicksort smaller ++ [x] ++ quicksort larger
  where smaller = filter (\y -> y <= x) xs
        larger = filter (\y -> y > x) xs
