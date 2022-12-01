# Упражнение 9

# Scheme

## Потоци

---

## Задачи

# Haskell

## :sparkling_heart: [Learn You a Haskell for Great Good!](http://learnyouahaskell.com/chapters) :sparkling_heart:

## [Haskell компилатор (GHC)](https://www.haskell.org/downloads/)

- haskell файловете завършват на **.hs**
- GHC може да компилира haskell код, но също така позволява интерактивно да боравим с код в конзолата
- стартираме interactive mode с **ghci**
- зареждаме файл file.hs (който се намира в същата папка, в която сме стартирали терминала) с с **:l "file.hs"**
- ако сме направили промени и искаме да презаредим дефинициите от файла, го правим с **:r**
- излизаме от ghci с **:quit**

## Типове данни

### Булеви стойности 

`True`, `False`

```haskell
--  Четем "::" като "е от тип"
> :t True           -- => True  :: Bool
> :t False          -- => False :: Bool

> (not True)        -- => False
> (not False)       -- => True
> (not "")          -- => Грешка (Couldn't match type ‘[Char]’ with ‘Bool’)

> (True && True)   -- => True
> (True && False)  -- => False

> (True  || False) -- => True
> (False || False) -- => False
```

### Числа 

`Int`, `Integer`, `Float`, `Double`

Бележка: `Int` има минимална и максимална стойност, `Integer` - не, сътоветно може да бъде използван за много големи числа.

```haskell
-- сравнение
> 42 == 42   -- => True
> 42 == 42.0 -- => True
> 42 /= 42   -- => False
> 3 < 2      -- => False
> 4.5 >=  3  -- => True
-- Бележка: ако името на функцията е съставено само от специални символи,
-- се приема че работи над 2 аргумента и използва инфиксна функция при
-- извикването си

> min 1 2    -- => 1
> max 1 2    -- => 2

> even 5        -- => False
> odd 5         -- => True

-- аритметични операции
> 1 + 2         -- => 3
> 5.3 - 2       -- => 3.3
> 2 * 3         -- => 6
> 6 / 3         -- => 2.0
> 22 / 7        -- => 3.142857142857143
> 2 ^ 3         -- => 8
> sqrt 4        -- => 2.0

> abs (-3))     -- => 3

> div 5 2       -- => 2
> mod 5 2       -- => 1
-- алтернативен запис
> 5 `div` 2     -- => 2
> 5 `mod` 2     -- => 1

> round 2.718   -- => 3
> ceiling 2.718 -- => 3
> floor 2.718   -- => 2

> succ 5        -- => 6
> pred 5        -- => 4
```

### Знаци

```haskell
> :t 'b'   -- => 'b' :: Char
> :t 'B'   -- => 'B' :: Char

> succ 'b' -- => 'c'
> pred 'b' -- => 'a'
```

### Низове

```haskell
-- String и [Char] описват един и същи тип
> :t "Hello, World!"            -- => "Hello, World!" :: String

> "Llamas " ++ "are " ++ "cute" -- => "Llamas are cute"
```

## Дефиниране на функции

```haskell
-- за да дефинираме функция изреждаме името и,
-- аргументите, които приема, последвани от =,
-- и тялото на функцията
<function-name> <parameters> = <function-body>

-- функция, която приема 0 аргумента
favouriteAnimal = "doggo"

-- функция, която приема 1 аргумент
double x = x + x

-- функция, която приема 2 аргумента
sumDouble x y = double x + double y   

-- функциите също имат типове
-- когато ги дефинираме, можем изрично да зададем типа им
-- горното е добра практика, освен когато става дума за много къси функции
double :: Int -> Int
double x = x + x

-- типа на резултата е последния елемент в типовата декларация
-- параметрите са първите три
addThree :: Int -> Int -> Int -> Int  
addThree x y z = x + y + z
```

## Прилагане на функции

```haskell
-- използваме space за да приложим функция над дадени аргументи
> succ 8    -- => 9
> min 2 4   -- => 2

-- прилагането на функция има най-висок приоритет
-- сред всички операции

-- двата израза са еквивалентни
> succ 9 + max 5 4 + 1   
> (succ 9) + (max 5 4) + 1 

> succ 9 * 10    -- => 100
> succ (9 * 10)  -- => 91
```

## Условни изрази

:warning: Подравняването в Haskell има значение! :warning:

```haskell
-- if-else израз

-- задължително трябва да имаме
-- и then-branch, и else-branch изрази
-- else-branch не може да бъде пропуснат
if test-expression
  then <then-branch>
  else <then-branch>

> 4 * (if 10 > 5 then 10 else 0) + 2  -- => 42

compareTo1 x =
  if x > 1
    then "your number is bigger than 1"
    else "your number is equal to or smaller than 1"
```

```haskell
-- разглеждане на случаи (guards)

-- Различните случаи се обозначават с |, като следват името на функцията и нейните параметри

compareTo1 x
  | x >  1     = "your number is bigger than 1"
  | x == 1     = "your number is equal to 1"
  | otherwise  = "your number is smaller than 1"

-- otherwise хваща всички неописани случаи
-- otherwise може да бъде пропуснат, но не е добра практика

-- Бележка: няма = веднага след името на функцията преди първия случай (guard)
```

## Локални дефиниции

```haskell
-- let изрази

> let x = 5 in x + 3 -- => 8

cylinder :: Double -> Double -> Double  
cylinder radius height =
    let sideArea = 2 * pi * radius * height 
        topArea  = pi * (radius ^ 2)
    in  sideArea + 2 * topArea  

-- where - синтактична конструкция, не е израз
-- позволява ни да дефинираме локални "променливи"
-- в края на функцията, така че те да са видими за
-- цялата функция, включително за всичките и случаи (guards)

toCelsius :: Double -> String  
toCelsius temperature  
    | degrees <= 14.0 = "too cold"  
    | degrees <= 28.0 = "perfect"  
    | otherwise       = "too hot"
    where degrees = (temperature - 32) * 5/9
```

## Коментари

```haskell
-- Magic. Do not touch.

{-
  ekaranasuf 06/07/19 Adding temporary dirty fix 
  gtodorov   05/11/22 Temporary my ass
-}
```

---

## Задачи

1. Дефинирайте функция `add x y`, която събира $x$ и $y$

    ```haskell
    > add 1 2 -- => 3
    ```

2. Дефинирайте функция `signum x`, която връща $-1$, $0$ или $1$ в зависимост от това, дали $x$ е отрицателно, нула или положително число.

    ```haskell
    > signum 5    -- => 1
    > signum (-5) -- => -1
    ```

3. Дефинирайте функция `factorial n`, която пресмята $n!$

4. Дефинирайте функция `fibonacci n`, която пресмята $n$-тото число на Фибоначи

5. Дефинирайте функция `sum start end`, която намира сумата на числата в интервала $[start, end]$

6. Дефинирайте функция `fastPow x n`, която пресмята $x^n$, използвайки следното свойство: aко n е четно, то $x^n = (x^{(n/2)})^2$

7. Дефинирайте функция `countDigits number`, която намира броя на цифрита на дадено естествено число  