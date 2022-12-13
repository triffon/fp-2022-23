-- Телевизионно предаване се представя с наредена тройка от
-- име (низ), начален час (наредена двойка от час и минути) и продължителност (брой минути).

-- a). Да се напише функция lastShow, което по списък от предавания
-- връща името на това, което завършва най-късно.

type TVShow = (String, (Int, Int), Int)

-- name :: TVShow -> String
name (name, _, _) = name

-- duration :: TVShow -> number
duration (_, _, duration) = duration

-- starttime :: TVShow -> Int
starttime (_, (hours, minutes), _) = 
  hours * 60 + minutes

-- endtime :: TVShow -> Int
endtime tvshow@(_, _, duration) = 
  (starttime tvshow) + duration

-- намира максималния елемент в списък
-- maximumBy snd [(1, 2), (3, 1)] -- => (1, 2)
maximumBy _ [x] = x  
maximumBy func (x:xs) =
  if (func x > func maxTail)
    then x
    else maxTail
  where maxTail = maximumBy func xs

-- lastShow :: [TVShow] -> String
lastShow shows = name (maximumBy endtime shows)

-- lastShow [("A", (11, 0), 120), ("B", (12, 0), 15), ("C", (10, 30), 90)] -- => "A"

-- Телевизионна програма наричаме последователност от предавания,
-- чиито интервали на излъчвания са подредени в нарастващ ред и не се пресичат.

-- б). Да се напише функция longestProgram, която по даден
-- списък от предавания генерира възможно най-дълга телевизионна
-- програма, т.е. сумата от продължителностите на предаванията в нея
-- е максимална

quicksortBy _ [] = []
quicksortBy term (x:xs) = smaller ++ [x] ++ bigger
  where smaller = quicksortBy term (filter (\y -> term y < term x) xs)
        bigger = quicksortBy term (filter (\y -> term y >= term x) xs)

subsets [] = [[]]
subsets (x:xs) = subsets xs ++ map (x:) (subsets xs)

-- проверява дали всички предавания (сортирани по начално врмеме)
-- са непресичащи се
nonIntersecting :: [TVShow] -> Bool
nonIntersecting [] = True
nonIntersecting [_] = True
nonIntersecting (first : second : rest) =
  endtime first <= starttime second

sumBy func lst = foldr (\x result -> (func x) + result) 0 lst

longestProgram shows =
  maximumBy (\program -> sumBy duration program) programs
  where programs = filter nonIntersecting (subsets (quicksortBy starttime shows))

-- longestProgram [("A", (11, 0), 120), ("B", (12, 0), 15), ("C", (10, 30), 90)] 
-- => [("A", (11, 0), 120))]

-- longestProgram [("A", (10, 0), 120), ("B", (12, 0), 15), ("C", (10, 30), 90)] 
-- => [("A", (10, 0), 120), ("B", (12, 0), 15)]