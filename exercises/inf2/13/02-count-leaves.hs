data BinaryTree a = EmptyTree | Node { root :: a, left :: BinaryTree a, right :: BinaryTree a } deriving (Eq, Show, Read)

countLeaves :: BinaryTree a -> Int
countLeaves EmptyTree = 0
countLeaves (Node _ EmptyTree EmptyTree) =
  1
countLeaves (Node _ left right) =
  countLeaves left + countLeaves right