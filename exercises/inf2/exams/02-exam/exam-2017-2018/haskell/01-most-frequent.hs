-- Да се напише функция mostFrequent, която по даден
-- списък от списъци от числа връща числото, което е сред най-често
-- срещаните числа във всички списъци, ако такова има, или 0 иначе

-- връща списък от наредени двойки от тип (<елемент>, <брой-срещания-на-елемент>)
-- histogram [1,1,3,2] -- => [(1,2),(3,1),(2,1)]
histogram [] = []
histogram lst@(x:xs) = (x, ocurrences) : histogram rest
  where ocurrences = length [ y | y <- lst, y == x]
        rest = [ y | y <- lst, y /= x]

-- намира максималният елемент в списък
-- maximumBy snd [(1, 2), (3, 1)] -- => (1, 2)
maximumBy _ [x] = x  
maximumBy func (x:xs) =
  if (func x > func maxTail)
    then x
    else maxTail
  where maxTail = maximumBy func xs

-- връща списък от най-често срещаните елементи на даден списък
-- filterMaximum [1,1,5,5,6] -- => [1, 5]
filterMaximum lst =
  map fst (filter (\(element, occurences) -> occurences == maxOccurences) elementOccurences)
  where 
    elementOccurences = histogram lst
    maxOccurences = snd (maximumBy snd elementOccurences)

-- намира сечението на две множества
-- intersection [1,2,3,4] [3,4,5,6] -- => [3,4]
intersection lst1 lst2 =
  filter (\x -> x `elem` lst2) lst1

mostFrequent lst
  | null (mostFrequentElements lst) = 0
  | otherwise = head (mostFrequentElements lst)
  where mostFrequentElements [xs] = filterMaximum xs
        mostFrequentElements (xs:xss) =
          intersection (filterMaximum xs) (mostFrequentElements xss)

-- mostFrequent [[1,1,3,2],[1,1,5],[1,5],[1,1,1,3]] -- => 1
-- mostFrequent [[1,1,3,2],[1,5,5],[1,5],[1,1,1,3]] -- => 0