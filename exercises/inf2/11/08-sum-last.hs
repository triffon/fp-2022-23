sumLast k n = k : helper n [k]
  where helper n lastn = element : helper n newn
          where element = sum lastn
                newn = if (length lastn < n)
                          then lastn ++ [element]
                          else (tail lastn) ++ [element]
