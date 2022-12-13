-- Покупка се означава с наредена тройка от име на магазин (низ), категория (низ) и цена (дробно число).
-- Да се реализира функция, която по даден списък от покупки
-- връща списък от тройки, съдържащи  категория, обща цена на покупките в тази категория,
-- името на магазина, в който общата цена на покупките в тази категория е максимална).
-- Всяка категория да се среща в точно една тройка от резултата.

-- type Purchase = (String, String, Double)

-- purchases :: [Purchase]
purchases =
  [("Ikea", "Furniture", 150.5), ("Billa", "Food", 24.4), ("Fantastiko", "Food", 5.0),
   ("Mebeli Videnov", "Furniture", 400.0), ("Billa", "Food", 13.3), ("Lidl", "Food", 10.5),
   ("Medea", "Pharmaceuticals", 40.0), ("Ikea", "Furniture", 50.0)]

-- getStore :: Purchase -> String
getStore (store, _, _) = store

-- getCategory :: Purchase -> String
getCategory (_, category, _) = category

-- getPrice :: Purchase -> Double
getPrice (_, _, price) = price

-- премахва повторенията на елемент
-- uniques [1, 2, 3, 2, 1] -- => [1, 2, 3]
uniques [] = []
uniques (x:xs) = x : uniques (filter (\y -> y /= x) xs)

-- намира максималния елемент в списък
-- maximumBy snd [(1, 2), (3, 1)] -- => (1, 2)
maximumBy _ [x] = x  
maximumBy func (x:xs) =
  if (func x > func maxTail)
    then x
    else maxTail
  where maxTail = maximumBy func xs

-- calculateExpenses :: [Purchase] -> [(String, Double, String)]
calculateExpenses purchases =
  map (\category -> (category, getCategoryTotal category, getMaxStore category)) categories
  where
    categories = uniques (map getCategory purchases)
    getPurchases category = filter (\purchase -> getCategory purchase == category) purchases
    getCategoryTotal category = sum (map getPrice (getPurchases category))
    getMaxStore category = maximumBy getStoreTotal stores
      where
          stores = uniques (map getStore (getPurchases category))
          getStoreTotal store =
            let storePurchases = filter (\purchase -> getStore purchase == store) (getPurchases category)
            in sum (map getPrice storePurchases)
    
-- calculateExpenses purchases
-- => [("Furniture", 600.5, "Mebeli Videnov"), ("Food", 53.2, "Billa"), ("Pharmaceuticals", 40.0, "Medea")]