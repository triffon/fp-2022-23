replicate' n element =
  if (n < 1)
    then []
    else element : replicate' (n - 1) element

-- алтернативно решение,
-- използващо pattern matching
replicate'' 0 _ = []
replicate'' n element = element : replicate'' (n - 1) element

-- алтернативно решение,
-- използващо list comprehension
replicate''' n element = [ element | _ <- [1..n]]