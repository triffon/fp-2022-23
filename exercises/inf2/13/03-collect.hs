data BinaryTree a = EmptyTree | Node { root :: a, left :: BinaryTree a, right :: BinaryTree a } deriving (Eq, Show, Read)

collectPreOrder :: BinaryTree a -> [a]
collectPreOrder EmptyTree = []
collectPreOrder (Node root left right) =
  [root] ++ collectPreOrder left ++ collectPreOrder right

collectInOrder :: BinaryTree a -> [a]
collectInOrder EmptyTree = []
collectInOrder (Node root left right) =
  collectInOrder left ++ [root] ++ collectInOrder right