pythagoreanTriples to =
  [(a, b, c) | a <- [1..to],
               b <- [a..to],
               c <- [1..to],
               a ^ 2 + b ^ 2 == c ^ 2]