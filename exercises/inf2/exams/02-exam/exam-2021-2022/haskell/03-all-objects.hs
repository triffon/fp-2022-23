-- Иван е много подреден човек и обича да систематизира принадлежностите си в кутии, като всичко е прилежно надписано.
-- Той следи инвентара на личния си лаптоп, като го представя чрез списък от наредени двойки:
-- етикет на кутия (произволен низ) и списък от съдържанието ѝ – етикети на предмети,
-- сред които евентуално и други кутии (също произволни низове). Всички етикети са уникални.
-- Иван има нужда от помощ с реализацията на някои функции за управление на инвентара си:

-- а). Да се реализира функция allObjects, която по даден инвентар
-- връща списък от етикетите на всички предмети, които не са кутии

-- премахва 1 ниво скоби
-- flatten [[1, 2], [3, 4]] -- => [1, 2, 3, 4]
flatten [] = []
flatten (x:xs) = x ++ flatten xs

allObjects inventory =
  filter (\label -> not (label `elem` boxes)) contents
  where
    boxes = map fst inventory
    contents = flatten (map snd inventory)

inv = [("docs", ["ids", "invoices"]), ("ids", ["passport"]),  ("invoices", []), ("memes", []),
       ("family", ["new year", "birthday"]), ("funny", ["memes"]), ("pics", ["family", "funny"])]

-- allObjects inv -- => ["passport", "new year", "birthday"]

-- б) Иван не обича прахосничеството и иска да разчисти ненужните кутии.
-- Да се реализира функция cleanUp, която по даден инвентар връща негово копие, в което празните кутии са изхвърлени.
-- Упътване: Да се вземе предвид, че след изхвърляне на празни кутии,
-- други кутии може да останат празни и те също трябва да се изхвърлят.
-- Във върнатия резултат не трябва да има празни кутии.

-- функция, която приема предикат и списък и проверява дали
-- някой от елементи на списъка изпълнява зададеното условие
-- пример: any even [1..10]   -- => True
-- пример: any even [1,3..10] -- => False
any' pred [] = False
any' pred (x:xs) = pred x || all pred xs

cleanUp inventory
  | null emptyBoxes = inventory
  | otherwise = cleanUp (map (\(name, content) -> (name, cleanUpContent content)) nonEmptyBoxes)
  where
    emptyBoxes = filter (\(_, content) -> null content) inventory
    emptyBoxNames = map fst emptyBoxes
    nonEmptyBoxes = filter (\(_, content) -> not (null content)) inventory
    cleanUpContent labels = filter (\label -> not (label `elem` emptyBoxNames)) labels

-- cleanUp inv
-- => [("docs" ["ids"]), ("ids", ["passport"]), ("family", ["new year", "birthday"]), ("pics", ["family"])]