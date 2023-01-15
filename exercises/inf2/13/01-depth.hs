data BinaryTree a = EmptyTree | Node { root :: a, left :: BinaryTree a, right :: BinaryTree a } deriving (Eq, Show, Read)

depth :: BinaryTree a -> Int
depth EmptyTree = 0
depth (Node root left right) =
  1 + max (depth left) (depth right)