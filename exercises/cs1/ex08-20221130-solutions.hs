-- Зад.1&2
--fib n = if n < 2 then n else fib (n-1) + fib (n-2)

-- Pattern matching - най-удачният избор за проверка на конкретни стойности
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

-- case expression
--fib n = case n of 0 -> 0
--                  1 -> 1
--                  _ -> fib (n-1) + fib (n-2)

-- Зад.3
-- Guards в комбинация с pattern matching + локално дефинирана функция
fastPow _ 0 = 1
fastPow x n
  | even n    = sq (fastPow x (div n 2))
  | otherwise = x * sq (fastPow x (div n 2))
  where sq x = x * x
