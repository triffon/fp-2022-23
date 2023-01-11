-- Зад.1
-- Причини да НЕ ползваме синоним на BST (k,v) за Map:
-- - не всяко BST е валиден асоциативен списък (не трябва да се повтарят ключове)
-- - BST (k,v) изисква Ord v, което е ненужно
-- - бихме извиквали погрешка функции за BST над Map-ове, които да го направят невалидно
-- => създаваме си отделен тип
data Map k v = Empty
             | Node k v (Map k v) (Map k v)
             deriving Show

mapInsert :: Ord k => k -> v -> Map k v -> Map k v
mapInsert key newVal Empty = Node key newVal Empty Empty
mapInsert key newVal (Node key' val left right)
  | key < key'  = Node key' val (mapInsert key newVal left) right
  | key > key'  = Node key' val left (mapInsert key newVal right)
  | otherwise   = Node key' newVal left right

mapSearch :: Ord k => k -> Map k v -> Maybe v
mapSearch key Empty = Nothing
mapSearch key (Node key' val left right)
  | key < key'  = mapSearch key left
  | key > key'  = mapSearch key right
  | otherwise   = Just val

-- За удобство
fromPairs :: Ord k => [(k,v)] -> Map k v
fromPairs = foldr (uncurry mapInsert) Empty

-- Зад.2
-- Да си личи, че след fmap-ване ключовете остават същите
instance Functor (Map k) where
  fmap _ Empty = Empty
  fmap f (Node key val left right)
    = Node key (f val) (fmap f left) (fmap f right)

-- Зад.4
-- Проблем - когато имаме произволен брой поддървета, няма смисъл някои от тях да са празни
-- => създаваме си помощен тип за непразно дърво с произволен брой наследници,
-- всеки от които е също непразно дърво. Листата просто ще имат празен списък от наследници
data NonEmptyNTree a = NNode a [NonEmptyNTree a]
-- Основният тип - дървото може да е празно, но поддърветата не
data NTree a = NEmpty | RealTree (NonEmptyNTree a)

ntreeSize :: NTree a -> Int
ntreeSize NEmpty = 0
ntreeSize (RealTree t) = helper t
  where helper :: NonEmptyNTree a -> Int
        helper (NNode _ subtrees) = 1 + sum (map helper subtrees)

instance Functor NonEmptyNTree where
    fmap f (NNode val subtrees) = NNode (f val) (fmap f <$> subtrees) -- fmap inside a fmap, yo
instance Functor NTree where
    fmap f NEmpty = NEmpty
    fmap f (RealTree t) = RealTree (fmap f t)

-- Зад.5
data Direction = L | R deriving Show

mapPath :: Ord k => k -> Map k v -> Maybe [Direction]
mapPath _ Empty = Nothing
mapPath key (Node key' val left right)
  | key < key'  = (L:) <$> mapPath key left
  | key > key'  = (R:) <$> mapPath key right
  | otherwise   = Just []
