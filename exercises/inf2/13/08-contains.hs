data BinaryTree a = EmptyTree | Node { root :: a, left :: BinaryTree a, right :: BinaryTree a } deriving (Eq, Show, Read)

contains :: (Eq a) => BinaryTree a -> [a] -> Bool
contains _ [] = True
contains EmptyTree _ = False
contains (Node root left right) path@(x:xs) =
  x == root && (contains left xs || contains right xs) ||
  contains left path ||
  contains right path