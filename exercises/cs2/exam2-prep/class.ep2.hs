-- Задача 3. Иван е много подреден човек и обича да систематизира
-- принадлежностите си в кутии, като всичко е прилежно надписано. Той следи
-- инвентара на личния си лаптоп, като го представя чрез списък от наредени
-- двойки: етикет на кутия (произволен низ) и списък от съдържанието ѝ –
-- етикети на предмети, сред които евентуално и други кутии (също произволни
-- низове). Всички етикети са уникални. Иван има нужда от помощ с реализацията
-- на някои функции за управление на инвентара си:

-- а) (4 т.) Да се реализира функция allObjects, която по даден инвентар връща
-- списък от етикетите на всички предмети, които не са кутии.
type Tag = String
type Inventory = [(Tag, [Tag])]

allBoxes :: Inventory -> [Tag]
allBoxes inv = map (\(tag, content) -> tag) inv

allObjects :: Inventory -> [Tag]
allObjects inv =
  concat
    (map (\(tag, content) ->
           filter (\tag2 -> not (elem tag2 boxes))
                  content)
                  -- (\tag2 -> not (tag2 `elem` boxes))
                  -- (not . (`elem` boxes))
         inv)
  where
    boxes = allBoxes inv


result1 = allObjects inv -- → ["passport", "new year", "birthday"]

-- б) (6 т.) Иван не обича прахосничеството и иска да разчисти ненужните кутии.
-- Да се реализира функция cleanUp, която по даден инвентар връща негово--
-- копие, в което празните кутии са изхвърлени.

-- Упътване: Да се вземе предвид, че след изхвърляне на празни кутии, други
-- кутии може да останат празни и те също трябва да се изхвърлят. Във върнат--
-- ия резултат не трябва да има празни кутии.
--
--
cleanUp :: Inventory -> Inventory
cleanUp inv =
  if emptyBoxes == []
  then inv
  else cleanUp newInv
  where
    emptyBoxes :: [Tag]
    emptyBoxes = map (\(tag, c) -> tag) -- fst
                     (filter (\(tag, content) -> content == []) inv)

    newInv :: Inventory
    newInv =
      map removeEmptyBoxes
          (filter (\(tag, content) -> content /= []) inv)

    removeEmptyBoxes :: (Tag, [Tag]) -> (Tag, [Tag])
    removeEmptyBoxes (tag, content) =
             (tag, filter (\tag2 -> not (tag2 `elem` emptyBoxes)) content)

result2 = cleanUp inv --  → [ ("docs", ["ids"]), ("ids", ["passport"]), ("family", ["new year", "birthday"]), ("pics", ["family"])]

actual =
  [("docs",["ids","invoices"])
  ,("ids",["passport"])
  ,("family",["new year","birthday"])
  ,("funny",["memes"])
  ,("pics",["family","funny"])
  ]
expected =
  [ ("docs", ["ids"])
  , ("ids", ["passport"])
  , ("family", ["new year", "birthday"])
  , ("pics", ["family"])
  ]

--
--
--Примери:
inv =
  [ ("docs", ["ids", "invoices"])
  , ("ids", ["passport"])
  , ("invoices", [])
  , ("memes", [])
  , ("family", ["new year", "birthday"])
  , ("funny", ["memes"])
  , ("pics", ["family", "funny"])
  ]

-- scheme:
--  '( (docs . (ids invoices))
--     (ids . (passport))
--     (invoices . ())
--     (memes . ())
--     (family . (new year birthday))
--     (funny . (memes))
--     (pics . (family funny))
--   )










-- Задача 1. Казваме, че една функция π е n-пермутация, ако тя е биекция на
-- интервала от естествени числа [0; n-1] в себе си. Цикъл в пермутацията π
-- наричаме редица от числа x1, … xk, така че π(xi) = xi+1 за i < k и π(xk) = x1.

-- а) (4 т.) Да се реализира функция isNPerm, която приема като параметри
-- естествено число n и едноместна числова функция f и проверява дали f е
-- n-пермутация.

--all :: (a -> Bool) -> [a] -> Bool

isNPerm :: Int -> (Int -> Int) -> Bool
isNPerm n f = isBijection
  where
    isBijection = isInjection && isSurjection
    isInjection =
      all (\x ->
             all (\y ->
                    -- if x == y
                    -- then True
                    -- else f x /= f y
                    x == y || f x /= f y)
                 [0 .. n-1])
          [0 .. n-1]

    isSurjection =
      all (\y ->
             any (\x ->
                    f x == y)
                 [0 .. n-1])
          [0 .. n-1]


test1 = isNPerm 3 (\x -> (3 - x) `mod` 3) -- → True
test2 = isNPerm 10 (`div` 2) -- → False
test3 = isNPerm 10 (\x -> (x + 2) `mod` 10) -- → True


-- Задача 1. Казваме, че една функция π е n-пермутация, ако тя е биекция на
-- интервала от естествени числа [0; n-1] в себе си. Цикъл в пермутацията π
-- наричаме редица от числа x1, … xk, така че π(xi) = xi+1 за i < k и π(xk) = x1.
--
-- б) (6 т.) Да се реализира функция maxCycle, която по дадено число n и
-- n-пермутация π намира максимален по дължина цикъл в π.
maxCycle :: Int -> (Int -> Int) -> [Int]
maxCycle = \n -> \f ->
  argMax length
         (map (\i -> findCycle i i) [0 .. n-1])
  where
    --findCycle :: Int -> [Int]
    --findCycle originalI = originalI : go (f originalI)
    --  where
    --    go i =
    --      if i == originalI
    --      then []
    --      else i : go (f i)
    findCycle :: Int -> Int -> [Int]
    findCycle i originalI =
      if f i == originalI
      then [i]
      else i : findCycle (f i) originalI

--argMax :: (a -> b) -> [a] -> [a]
--argMax f [] = ?
argMax f [x] = x
argMax f (x:y:xs) =
  if f x >= f y
  then argMax f (x:xs)
  else argMax f (y:xs)

--Примери:

test4 = maxCycle 3 (\x -> (3 - x) `mod` 3) -- → [1, 2]
test5 = maxCycle 10 (\x -> (x + 2) `mod` 10) -- → [0, 2, 4, 6, 8]
test6 = maxCycle 10 (\x -> (x + 3) `mod` 10) -- → [0, 3, 6, 9, 2, 5, 8, 1, 4, 7]





