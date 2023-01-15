data BinaryTree a = EmptyTree | Node { root :: a, left :: BinaryTree a, right :: BinaryTree a } deriving (Eq, Show, Read)

cons x [] = []
cons x lst = x : lst

path :: Eq a => a -> BinaryTree a -> [a]
path _ EmptyTree = []
path x tree@(Node root left right) =
  if root == x
    then [root]
    else shortestPath x tree
  where
    shortestPath x tree =
      let 
        leftPath = path x left
        rightPath = path x right
      in
        if (not $ null leftPath) && length leftPath < length rightPath
          then cons root leftPath
          else cons root rightPath