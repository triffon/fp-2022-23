elem' x lst
  | null lst = False
  | x == head lst = True
  | otherwise = elem' x (tail lst)

-- алтернативно решение,
-- използващо pattern matching
elem'' _ [] = False
elem'' x (y:ys) = x == y || elem'' x ys