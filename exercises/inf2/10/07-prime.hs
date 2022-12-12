prime number =
  length divisors == 2
  where divisors = [ x | x <- [1..number], number `mod` x == 0]