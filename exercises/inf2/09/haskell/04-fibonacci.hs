-- fibonacci е функция, която приема 1 аргумент,
-- който е число (което може да бъде сравнявано, има наредба)
-- и връща резултат - също число
-- fibonacci :: (Ord t, Num t, Num a) => t -> a
-- fibonacci n =
--   if n <= 2
--     then 1
--     else fibonacci (n - 1) + fibonacci (n - 2)

-- алтернативно решение
fibonacci n = fibonacciHelper 1 1 n
  where
    fibonacciHelper curr next i =
      if i == 1
        then curr
        else fibonacciHelper next (curr + next) (i - 1)