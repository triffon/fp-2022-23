shift []     = []
shift (x:xs) = xs ++ [x]

rotate lst 0 = lst
rotate lst i
  | i > 0 = shift (rotate lst (i - 1))
  | i < 0 = rotate lst (length lst + i)

-- алтрнативно решение
rotate' lst i
  | i > 0 = drop i lst ++ take i lst
  | i < 0 = drop (length lst + i) lst ++ take (length lst + i) lst
  | otherwise = lst