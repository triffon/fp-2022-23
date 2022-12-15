prime n = length divisors == 2
  where divisors = [ x | x <- [1..n], n `mod` x == 0]

primes = [ x | x <- [2..], prime x]