data BinaryTree a = EmptyTree | Node { root :: a, left :: BinaryTree a, right :: BinaryTree a } deriving (Eq, Show, Read)

prune :: BinaryTree a -> BinaryTree a
prune EmptyTree = EmptyTree
prune (Node _ EmptyTree EmptyTree) = EmptyTree
prune (Node root left right) =
  Node root (prune left) (prune right)