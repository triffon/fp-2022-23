-- Даден е списък от три потока a, b, c.
-- Да се реализира функция braidStreams, която “сплита” потоците
-- като получава нов списък от три потока a', b', c', 
-- като на всяка четна стъпка разменя съответните елементи на първия и втория поток,
-- а на всяка нечетна стъпка, разменя елементите на втория и третия поток,
-- както е показано на диаграмата

braidStreams [] = []
braidStreams streams = 
  [constructStream getFirst  streams 1,
   constructStream getSecond streams 1,
   constructStream getThird  streams 1]
  where
    getFirst  [(f:_), _, _] = f
    getSecond [_, (s:_), _] = s
    getThird  [_, _, (t:_)] = t
    constructStream getElement streams@[(_:firsts), (_:seconds), (_:thirds)] 1 =
      getElement streams : constructStream getElement [seconds, firsts, thirds] 2
    constructStream getElement streams@[(_:firsts), (_:seconds), (_:thirds)] 2 =
      getElement streams : constructStream getElement [firsts, thirds, seconds] 1

-- тестваме решението
-- nats = [0..]
-- evens = [2,4..]
-- divisibleBy5 = [5,10..]

--     0   1   2   3   4   5   6   7   8
-- a   0   1   2   3   4   5   6   7   8
-- b   2   4   6   8  10  12  14  16  18
-- c   5  10  15  20  25  30  35  40  45

--     0   1   2   3   4   5   6   7   8
-- a'  0   4   6  20  25   5   6  16  18
-- b'  2   1  15   8   4  30  14   7  45
-- c'  5  10   2   3  10  12  35  40   8

-- map (\stream -> take 9 stream) (braidStreams [nats,evens,divisibleBy5])
-- => [[0,4,6,20,25,5,6,16,18],[2,1,15,8,4,30,14,7,45],[5,10,2,3,10,12,35,40,8]]
