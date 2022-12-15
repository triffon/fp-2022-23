pythagoreanTriples =
  [(x, y, z) | x <- [1..],
               y <- [x..],
               z <- [y..],
               x^2 + y^2 == z^2]