sumDivisors number =
  sum [ x | x <- [1..number], number `mod` x == 0]
