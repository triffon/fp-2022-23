-- решение, използващо pattern matching и list comprehension
-- lst@(x:xs) е пример за използване на именуван образец
histogram [] = []
histogram lst@(x:xs) = (x, ocurrences) : histogram rest
  where ocurrences = length [ y | y <- lst, y == x]
        rest = [ y | y <- lst, y /= x]

-- пример: histogram [1,1,2,3,3,3,4,2,2,2,1,1]
-- lst = [1,1,2,3,3,3,4,2,2,2,1,1] - целият списък
-- x = 1 - първият елемент на списъка
-- xs = [1,2,3,3,3,4,2,2,2,1,1] - списъка, без първия му елемент