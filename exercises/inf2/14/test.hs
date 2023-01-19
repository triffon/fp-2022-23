data Tree a = EmptyTree | Tree { root :: a, subtrees :: TreeList a } deriving (Eq, Show, Read)

data TreeList a = EmptyList | Cons { firstTree :: Tree a, restTrees :: TreeList a } deriving (Eq, Show, Read)

makeLeaf :: a -> Tree a  
makeLeaf x = Tree x EmptyList

mapTree :: (a -> b) -> Tree a -> Tree b
mapTree _ EmptyTree = EmptyTree
mapTree f (Tree x subtrees) =
    Tree (f x) (mapSubtrees f subtrees)

mapSubtrees :: (a -> b) -> TreeList a -> TreeList b
mapSubtrees _ EmptyList = EmptyList
mapSubtrees f (Cons first rest) =
  Cons (mapTree f first) (mapSubtrees f rest)

tree :: Tree Int
tree =
  Tree 1
    (Cons
      (Tree 2
        (Cons (Tree 3 EmptyList) EmptyList))
    (Cons
      (Tree 4
        (Cons (Tree 5 EmptyList)
        (Cons (Tree 6 EmptyList) EmptyList)))
    (Cons (Tree 7 EmptyList) EmptyList)))