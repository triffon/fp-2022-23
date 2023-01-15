data BinaryTree a = EmptyTree | Node { root :: a, left :: BinaryTree a, right :: BinaryTree a } deriving (Eq, Show, Read)

binarySearchTree EmptyTree = True
binarySearchTree (Node _ EmptyTree EmptyTree) = True
binarySearchTree (Node x left EmptyTree) =
  x >= root left
binarySearchTree (Node x EmptyTree right) =
  x < root right
binarySearchTree (Node x left right) =
  x >= root left && x < root right