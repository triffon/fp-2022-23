data BinaryTree a = EmptyTree | Node { root :: a, left :: BinaryTree a, right :: BinaryTree a } deriving (Eq, Show, Read)

invert :: BinaryTree a -> BinaryTree a
invert EmptyTree = EmptyTree
invert (Node root left right) =
  Node root (invert right) (invert left)