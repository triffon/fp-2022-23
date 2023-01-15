data BinaryTree a = EmptyTree | Node { root :: a, left :: BinaryTree a, right :: BinaryTree a } deriving (Eq, Show, Read)

binarySearchTreeInsert :: Ord a => BinaryTree a -> a -> BinaryTree a
binarySearchTreeInsert EmptyTree x =
  Node x EmptyTree EmptyTree
binarySearchTreeInsert (Node root left right) x =
  if x <= root
    then Node root (binarySearchTreeInsert left x) right
    else Node root left (binarySearchTreeInsert right x)