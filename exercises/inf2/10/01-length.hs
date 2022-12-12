length' lst =
  if (null lst)
    then 0
    else 1 + length' (tail lst)

-- алтернативно решение,
-- използващо pattern matching
length'' [] = 0
length'' (_:xs) = 1 + length'' xs

-- алтернативно решение,
-- използващо list comprehension
length''' lst = sum [ 1 | _ <- lst]