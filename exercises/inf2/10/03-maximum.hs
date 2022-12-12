maximum' lst
  | length lst == 1 = head lst
  | head lst > maximum' (tail lst) = head lst
  | otherwise = maximum' (tail lst)

-- алтернативно решение,
-- използващо pattern matching
maximum'' [x] = x  
maximum'' (x:xs) =
  if (x > maxTail)
    then x
    else maxTail
  where maxTail = maximum'' xs
