-- sum' е функция, която приема 2 аргументa,
-- които са числа (които могат да бъдат сравнявани, има наредба)
-- и връща резултат - число от същия тип
-- sum' :: (Ord t, Num t) => t -> t -> t
sum' start end =
  if start > end
    then 0
    else start + (sum' (start + 1) end)