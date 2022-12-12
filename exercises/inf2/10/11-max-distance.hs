-- от задача 11
distance (x1, y1) (x2, y2) =
  sqrt ((abs (x1 - x2))^2 + (abs (y1 - y2))^2)

maxDistance lst = maximum [ distance x y | x <- lst, y <- lst]