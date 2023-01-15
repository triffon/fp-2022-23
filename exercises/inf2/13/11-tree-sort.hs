data BinaryTree a = EmptyTree | Node { root :: a, left :: BinaryTree a, right :: BinaryTree a } deriving (Eq, Show, Read)

-- от задача 03-collect.hs
collectInOrder :: BinaryTree a -> [a]
collectInOrder EmptyTree = []
collectInOrder (Node root left right) =
  collectInOrder left ++ [root] ++ collectInOrder right

-- от задача 10-binary-search-insert.hs
binarySearchTreeInsert :: Ord a => BinaryTree a -> a -> BinaryTree a
binarySearchTreeInsert EmptyTree x =
  Node x EmptyTree EmptyTree
binarySearchTreeInsert (Node root left right) x =
  if x <= root
    then Node root (binarySearchTreeInsert left x) right
    else Node root left (binarySearchTreeInsert right x)

treeSort lst =
  collectInOrder $ helper lst EmptyTree
  where
    helper [] tree = tree
    helper (x:xs) tree = helper xs (binarySearchTreeInsert tree x)