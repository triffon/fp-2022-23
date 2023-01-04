-- Зад.1
safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x:_) = Just x

safeTail :: [a] -> Maybe [a]
safeTail [] = Nothing
safeTail (_:xs) = Just xs

safeUncons :: [a] -> Maybe (a,[a])
safeUncons [] = Nothing
safeUncons (x:xs) = Just (x,xs)

stripPrefix :: Eq a => [a] -> [a] -> Maybe [a]
stripPrefix [] lst = Just lst
stripPrefix _ [] = Nothing
stripPrefix (x:xs) (y:ys)
  | x == y    = stripPrefix xs ys
  | otherwise = Nothing

findIndex :: Eq a => a -> [a] -> Maybe Int
findIndex _ [] = Nothing
findIndex y (x:xs)
  | x == y    = Just 0
  | otherwise = succ <$> findIndex y xs
-- | otherwise = case findIndex y xs of Nothing -> Nothing
--                                      Just idx -> Just (succ idx)

-- $ прилага функция над стойност
-- <$> прилага функция над "опакована" стойност и опакова обратно резултата
maybebstValues :: Maybe a -> [a]
maybebstValues (Just x) = [x]
maybebstValues Nothing = []

mapMaybe :: (a -> Maybe b) -> [a] -> [b]
mapMaybe f = foldr (\el res -> case f el of Nothing -> res; Just x -> x:res) []

-- стандартна дефиниция, от миналия път
data Tree a = Empty
            | Node a (Tree a) (Tree a)
            deriving Show -- за визуализация

-- Зад.3
maxSumPath :: (Num a, Ord a) => Tree a -> a
maxSumPath Empty = 0
maxSumPath (Node x l r) = x + max (maxSumPath l) (maxSumPath r)

-- Зад.4
prune :: Tree a -> Tree a
prune Empty = Empty
prune (Node _ Empty Empty) = Empty
prune (Node x l r) = Node x (prune l) (prune r)

-- Зад.5
bloom :: Tree a -> Tree a
bloom Empty = Empty
bloom t@(Node x Empty Empty) = Node x t t -- reuse :)
bloom (Node x l r) = Node x (bloom l) (bloom r)

-- Зад.6
rotatel, rotater :: Tree a -> Tree a
rotatel  (Node p a (Node q b c)) = Node q (Node p a b) c
rotater (Node q (Node p a b) c) = Node p a (Node q b c)

-- Зад.7 - търсената функция е безкрайно по-полезна след преименуване :)
instance Functor Tree where
  fmap _ Empty = Empty
  fmap f (Node x l r) = Node (f x) (fmap f l) (fmap f r)

-- Пример за инстанциране на клас, зависещо от класа на съдържания тип
-- deriving Eq на дървото ще генерира точно това
instance Eq a => Eq (Tree a) where
  Empty == Empty = True -- освен да се извикват, оператори се и дефинират инфиксно
  (Node x1 l1 r1) == (Node x2 l2 r2) = x1 == x2 && l1 == l2 && r1 == r2
  _ == _ = False

-- Инстанция на друг полезен клас - за "обхождане" на съдържаните стойности, в случая ляво-корен-дясно
-- сега можем да викаме функции като fold-овете, length, sum, maximum върху дърветата ни :)
instance Foldable Tree where
  foldr _ nv Empty = nv
  foldr op nv (Node x l r) = foldr op (op x (foldr op nv r)) l

testTree :: Tree (Int -> Int)
testTree = Node (+1)
                (Node (^2)
                      (Node (*2) Empty Empty)
                      (Node (\x -> x-3) Empty Empty))
                (Node (3^) Empty Empty)

-- Демонстрация на <$>
testTree2 :: Tree Bool
testTree2 = even <$> succ <$> ($5) <$> testTree

-- Зад.9
-- от миналия път:
data BST a = BSTEmpty
           | BSTNode a (BST a) (BST a)

bstInsert :: Ord a => a -> BST a -> BST a
bstInsert val BSTEmpty = BSTNode val BSTEmpty BSTEmpty
bstInsert val (BSTNode x l r)
  | val < x   = BSTNode x (bstInsert val l) r
  | otherwise = BSTNode x l (bstInsert val r)

bstValues :: BST a -> [a]
bstValues BSTEmpty = []
bstValues (BSTNode x l r) = bstValues l ++ [x] ++ bstValues r

bstFromList :: Ord a => [a] -> BST a
bstFromList = foldr bstInsert BSTEmpty

bstSort :: Ord a => [a] -> [a]
bstSort = bstValues . bstFromList

bstSearch :: Ord a => a -> BST a -> Bool
bstSearch _ BSTEmpty = False
bstSearch val (BSTNode x l r)
  | val == x  = True
  | val < x   = bstSearch val l
  | otherwise = bstSearch val r

bstSize :: BST a -> Int
bstSize BSTEmpty = 0
bstSize (BSTNode _ l r) = 1 + bstSize l + bstSize r 
