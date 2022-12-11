-- factorial е функция, която приема 1 аргумент,
-- който е число (което може да бъде сравнявано, има наредба)
-- и връща резултат от същия тип
-- factorial :: (Ord t, Num t) => t -> t
factorial n =
  if n <= 1
    then 1
    else n * factorial (n - 1)