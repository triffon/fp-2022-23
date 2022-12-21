data Player = Monster String Int Int
            | Wizard Int Float
            | Princess Int [String]

data Tree a = Empty
            | Node a (Tree a) (Tree a)

data BST a = BSTEmpty
            | BSTNode a (BST a) (BST a)

insert :: Ord a => a -> BST a -> BST a
insert x BSTEmpty = BSTNode x BSTEmpty BSTEmpty
insert x (BSTNode val left right)
  | x < val   = BSTNode val (insert x left) right
  | otherwise = BSTNode val left (insert x right)

toList :: BST a -> [a]
toList BSTEmpty = []
toList (BSTNode val left right) = toList left ++ [val] ++ toList right

fromList :: Ord a => [a] -> BST a
fromList = foldr insert BSTEmpty

sort :: Ord a => [a] -> [a]
sort = toList . fromList

--length :: [a] -> Int
--length [] = 0
--length [3,5] = 2
--length (_:xs) = 1 + length xs

height :: Tree a -> Int
height Empty = 0
height (Node _ l r) = 1 + max (height l) (height r)

mapTree :: Tree (Int -> Int) -> Int -> [Int]
mapTree (Node f Empty Empty) x = [f x]
mapTree (Node f l r) x = mapTree l (f x) ++ mapTree r (f x)

testTree :: Tree (Int -> Int)
testTree = Node (+1)
                (Node (^2)
                      (Node (*2) Empty Empty)
                      (Node (\x -> x-3) Empty Empty))
                (Node (3^) Empty Empty)

count :: String -> IO Int
count filename = do
    contents <- readFile filename
    let numLines = length $ filter (=='\n') contents
    return (succ numLines)

main :: IO ()
main = do
    x <- getLine
    numLines <- count x
    let y = 2 * numLines
    print $ y

