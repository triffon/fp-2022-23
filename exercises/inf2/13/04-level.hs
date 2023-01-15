data BinaryTree a = EmptyTree | Node { root :: a, left :: BinaryTree a, right :: BinaryTree a } deriving (Eq, Show, Read)

level :: (Eq a) => BinaryTree a -> Int -> [a]
level EmptyTree _ = []
level (Node root _ _) 0 = [root]
level (Node _ left right) index =
  level left updateIndex ++ level right updateIndex
  where updateIndex = index - 1