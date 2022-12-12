product' lst =
  if (null lst)
    then 1
    else (head lst) * product' (tail lst)

-- алтернативно решение,
-- използващо pattern matching
product'' [] = 1
product'' (x:xs) = x * product'' xs