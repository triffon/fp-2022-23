distance point1 point2 =
  sqrt ((abs (fst point2 - fst point1))^2 + (abs (snd point2 - snd point1))^2)

-- алтернативно решение,
-- използващо pattern matching
distance' (x1, y1) (x2, y2) =
  sqrt ((abs (x1 - x2))^2 + (abs (y1 - y2))^2)