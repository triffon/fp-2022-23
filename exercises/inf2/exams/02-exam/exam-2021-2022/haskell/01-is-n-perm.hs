-- а). Казваме, че една функция π е n-пермутация, ако тя е биекция на интервала от естествени числа [0; n-1] в себе си.
-- Да се реализира функция isNPerm, която приема като параметри естествено число n
-- и едноместна числова функция f и проверява дали f е n-пермутация

-- функция, която приема предикат и списък и проверява дали
-- всички елементи на списъка изпълняват зададеното условие
-- пример: all odd [1..10]   -- => False
-- пример: all odd [1,3..10] -- => True
all' pred [] = True
all' pred (x:xs) = pred x && all pred xs

-- функция, която приема предикат и списък и проверява дали
-- някой от елементи на списъка изпълнява зададеното условие
-- пример: any even [1..10]   -- => True
-- пример: any even [1,3..10] -- => False
any' pred [] = False
any' pred (x:xs) = pred x || all pred xs

isNPerm n func =
  isInjection && isSurjection
  where
    interval = [0..(n-1)]
    isInjection = all (\x -> (func x) `elem` interval) interval
    isSurjection = all (\x -> any (\y -> (func y) == x) interval) interval

-- isNPerm 3 (\x -> (3 - x) `mod` 3) -- => True
-- isNPerm 10 (`div` 2) -- => False
-- isNPerm 10 (\x -> (x + 2) `mod` 10) -- => True

-- б). Цикъл в пермутацията π наричаме редица от числа x1, … xk, така че π(xi) = xi+1 за i < k и π(xk) = x1.
-- Да се реализира функция maxCycle, която по дадено число n и n-пермутация π
-- намира максимален по дължина цикъл в π

maximumBy _ [x] = x  
maximumBy func (x:xs) =
  if (func x >= func maxTail)
    then x
    else maxTail
  where maxTail = maximumBy func xs

maxCycle n func =
  maximumBy length (map generateCycle [0..(n-1)])
  where
    -- констурира цикъл, започващ от x
    -- пример: generateCycle (\x -> (3 - x) `mod` 3) 1 -- => [1, 2]
    generateCycle x = helper func x x
    helper func xi x1 =
      if (func xi == x1)
        then [xi]
        else xi : helper func (func xi) x1

-- maxCycle 3 (\x -> (3 - x) `mod` 3) -- => [1, 2]
-- maxCycle 10 (\x -> (x + 2) `mod` 10) -- => [0, 2, 4, 6, 8]
-- maxCycle 10 (\x -> (x + 3) `mod` 10) -- => [0, 3, 6, 9, 2, 5, 8, 1, 4, 7]