module Data where
import Text.XHtml (base, background, navy)

class Measurable a where
    size :: a -> Integer
    empty :: a -> Bool
    empty = (==0) . size

-- >>> :k Measurable Integer
-- Measurable Integer :: Constraint
-- template <typename T>
-- .... T x, y;
-- ... x == y ...

larger :: Measurable a => a -> a -> Bool
larger x y = size x > size y

-- >>> larger 20 3
-- True

instance Measurable Integer where
    size 0 = 0
    size n = 1 + size (n `div` 10)

-- >>> size 21387123987
-- 11

instance (Measurable a, Measurable b) => Measurable (a, b) where
    size (x, y) = size x + size y

-- >>> size (123312, 12412412)
-- 14

-- >>> size ((123312, 12412412), (12, 24133))
-- 21

instance Measurable a => Measurable [a] where
    size = sum . map size

-- >>> size ([112,322,13], ([2],(4141,5123)))
-- 17

-- >>> :t size
-- size :: Measurable a => a -> Integer

-- >>> :t larger
-- larger :: Measurable a => a -> a -> Bool

-- >>> :k Int
-- Int :: *

-- >>> :k Bool
-- Bool :: *

-- >>> :k Int -> (Int -> Bool) -> Integer
-- Int -> (Int -> Bool) -> Integer :: *

-- >>> :k [(Int,[Int],Int->Int)]
-- [(Int,[Int],Int->Int)] :: *

-- >>> :k Measurable
-- Measurable :: * -> Constraint

-- >>> :t EQ
-- EQ :: Ordering

-- >>> :k Ordering
-- Ordering :: *

type Name = String
type Score = Int
-- data Player = Player Name Score
data Player = Player { name :: Name, score :: Score }

-- >>> :k Name
-- Name :: *

-- >>> :k Player
-- Player :: *

-- >>> :t Player
-- Player :: Name -> Score -> Player
    
emptyPlayer :: Player
emptyPlayer = Player "" 0

instance Eq Player where
    Player n1 s1 == Player n2 s2 = n1 == n2 && s1 == s2

-- >>> :t name
-- name :: Player -> Name

-- >>> :t score
-- score :: Player -> Score

katniss :: Player
katniss = Player { name = "Katniss Everdeen", score = 45}

-- >>> name katniss
-- "Katniss Everdeen"

-- data Student = Student { name :: String, year :: Int }

data Shape = Circle { radius :: Double } | Rectangle { width, height :: Double }
                deriving (Eq, Ord, Show, Read)

-- >>> :k Shape
-- Shape :: *

-- >>> :t Circle
-- Circle :: Double -> Shape

-- >>> :t Rectangle
-- Rectangle :: Double -> Double -> Shape

circle :: Shape
circle = Circle 2.3

rect :: Shape
rect = Rectangle 3.5 1.8

area :: Shape -> Double
area (Circle radius) = pi * radius^2
area (Rectangle width height) = width * height

-- >>> (area circle, area rect)
-- (16.619025137490002,6.3)

-- >>> :t radius
-- radius :: Shape -> Double

-- >>> radius rect
-- No match in record selector radius

-- TODO: inscribe, enscribe ???

-- >>> circle
-- Circle {radius = 2.3}

-- >>> (read "Circle {radius = 2.3}":: Shape) == circle

-- >>> :t Nothing
-- Nothing :: Maybe a

-- >>> :t Just
-- Just :: a -> Maybe a

-- >>> (read "Circle {radius = 2.3}":: Shape) == circle
-- True
-- >>> (read "Circle {radius = 1.2}":: Shape) < circle
-- True
-- >>> (read "Circle {radius = 1.2}":: Shape) > circle
-- False
-- >>> :k Maybe
-- Maybe :: * -> *
-- >>> :k Maybe Int
-- Maybe Int :: *
-- >>> :k Maybe Bool
-- Maybe Bool :: *
-- >>> :k Int -> Int
-- Int -> Int :: *
-- >>> :k (->)
-- (->) :: * -> * -> *
-- >>> :k [Int]
-- [Int] :: *
-- >>> :k [Bool]
-- [Bool] :: *
-- >>> :t []
-- [] :: [a]
-- >>> :k []
-- [] :: * -> *
-- >>> :k ([] Int)
-- ([] Int) :: *
-- >>> :k ([] Bool)
-- ([] Bool) :: *
-- >>> :k ([] ([] Int))
-- ([] ([] Int)) :: *
-- >>> :k (Int, Bool)
-- (Int, Bool) :: *
-- >>> :k (,) Int Bool
-- (,) Int Bool :: *
-- >>> :k (,)
-- (,) :: * -> * -> *
-- >>> :t (,)
-- (,) :: a -> b -> (a, b)
-- >>> :k (,) [Int] (Bool -> Bool)
-- (,) [Int] (Bool -> Bool) :: *
-- >>> :k (,) Int
-- (,) Int :: * -> *
-- >>> :k (->) Int
-- (->) Int :: * -> *
-- >>> :k (->) Int Bool
-- (->) Int Bool :: *
-- >>> :k (->) Int String
-- (->) Int String :: *

-- >>> :t Left (3::Int)
-- Left 3 :: Num a => Either a b

data Nat = Zero | Succ Nat deriving (Eq, Ord, Read, Show)

five :: Nat
five = Succ $ Succ $ Succ $ Succ $ Succ Zero

-- >>> five
-- Succ (Succ (Succ (Succ (Succ Zero))))

fromNat :: Nat -> Integer
fromNat Zero     = 0
fromNat (Succ n) = succ (fromNat n)
-- fromNat (Succ n) == succ (fromNat n)

-- >>> fromNat five
-- 5

-- TODO: toNat :: Integer -> Nat

{-
[]     ++ l = l
(x:xs) ++ l = x:((++) xs l)
-}

-- O(m)
plus :: Nat -> Nat -> Nat
plus Zero     n = n
plus (Succ m) n = Succ (plus m n)

-- >>> fromNat $ plus five five
-- 10

data Bin = One | BitZero Bin | BitOne Bin
  deriving (Eq, Ord, Read, Show)

six :: Bin
six = BitZero $ BitOne One

fromBin :: Bin -> Integer
fromBin One         = 1
fromBin (BitZero b) = 2 * fromBin b
fromBin (BitOne  b) = 2 * fromBin b + 1

-- >>> fromBin six
-- 6

--- TODO: toBin

succBin :: Bin -> Bin
succBin One = BitZero One
succBin (BitZero b) = BitOne b
succBin (BitOne b) = BitZero $ succBin b

-- >>> fromBin $ succBin six
-- BitOne (BitOne One)

plusBin :: Bin -> Bin -> Bin
plusBin One c                   = succBin c
plusBin (BitZero b) One         = BitOne b
plusBin (BitZero b) (BitZero c) = BitZero $ plusBin b c  
plusBin (BitZero b) (BitOne c)  = BitOne  $ plusBin b c
plusBin (BitOne b) One          = succBin b
plusBin (BitOne b) (BitZero c)  = BitOne  $ plusBin b c
plusBin (BitOne b) (BitOne c)   = BitZero $ succBin $ plusBin b c

-- >>> fromBin $ plusBin six six
-- 12

data List a = Nil | Cons { listHead :: a, listTail :: List a }
    deriving (Eq, Ord, Read, Show)

l :: List Integer
l = Cons 1 $ Cons 2 $ Cons 3 Nil

-- >>> l
-- Cons {listHead = 1, listTail = Cons {listHead = 2, listTail = Cons {listHead = 3, listTail = Nil}}}

fromList :: List a -> [a]
fromList Nil         = []
fromList (Cons x xs) = x:fromList xs

-- >>> fromList l
-- [1,2,3]

(+++) :: List a -> List a -> List a

{-
[]     ++ l = l
(x:xs) ++ l = x:((++) xs l)
-}

Nil       +++ l = l
Cons x xs +++ l = Cons x (xs +++ l)

--- >>> fromList $ l +++ l
-- Cons {listHead = 1, listTail = Cons {listHead = 2, listTail = Cons {listHead = 3, listTail = Cons {listHead = 1, listTail = Cons {listHead = 2, listTail = Cons {listHead = 3, listTail = Nil}}}}}}

-- >>> :k Nat
-- Nat :: *

-- >>> :k Bin
-- Bin :: *

-- >>> :k List
-- List :: * -> *

-- >>> :k []
-- [] :: * -> *

-- >>> :k List Nat
-- List Nat :: *

-- >>> :k [Integer]
-- [Integer] :: *

data BinTree a = Empty | Node { root :: a, left, right :: BinTree a }
    deriving (Eq, Ord, Show, Read)

leaf :: a -> BinTree a
leaf x = Node x Empty Empty

t :: BinTree Integer
t = Node 1 (Node 2 (leaf 3) (leaf 4)) (leaf 5)

-- >>> t
-- Node {root = 1, left = Node {root = 2, left = Node {root = 3, left = Empty, right = Empty}, right = Node {root = 4, left = Empty, right = Empty}}, right = Node {root = 5, left = Empty, right = Empty}}

-- TODO: DOTprint

depth :: BinTree a -> Integer
depth Empty        = 0
depth (Node x l r) = 1 + max (depth l) (depth r)

-- >>> depth t
-- 3
leaves :: BinTree a -> [a]
leaves Empty = []
leaves (Node x Empty Empty) = [x]
leaves (Node x l r) = leaves l ++ leaves r

-- >>> leaves t
-- []

-- map     :: (a -> b) -> [a]    -> [b]
mapBinTree :: (a -> b) -> BinTree a -> BinTree b
mapBinTree _ Empty = Empty
mapBinTree f (Node x l r) = Node (f x) (mapBinTree f l) (mapBinTree f r)

-- >>> mapBinTree (+1) t
-- Node {root = 2, left = Node {root = 3, left = Node {root = 4, left = Empty, right = Empty}, right = Node {root = 5, left = Empty, right = Empty}}, right = Node {root = 6, left = Empty, right = Empty}}

-- foldr :: (a -> b -> b) -> b -> [a] -> b
foldrBinTree :: (a -> b -> b) -> b -> BinTree a -> b
foldrBinTree _  nv Empty = nv
foldrBinTree op nv (Node x l r) = foldrBinTree op (x `op` foldrBinTree op nv r) l

-- >>> foldrBinTree (+) 0 t
-- 15

-- data Tree a = Tree { rootTree :: a, subtrees :: [a]}

data Tree a = Tree { rootTree :: a, subtrees :: TreeList a}
    deriving (Eq, Ord, Show, Read)

data TreeList a = None | SubTree { firstTree :: Tree a, restTrees :: TreeList a }
    deriving (Eq, Ord, Show, Read)

leafTree :: a -> Tree a
leafTree x = Tree x None
tree :: Tree Integer
tree = Tree 1 $ SubTree (leafTree 2)
              $ SubTree (Tree 3 $ SubTree (leafTree 4) None)
              $ SubTree (leafTree 5) None

-- >>> tree
-- Tree {rootTree = 1, subtrees = SubTree {firstTree = Tree {rootTree = 2, subtrees = None}, restTrees = SubTree {firstTree = Tree {rootTree = 3, subtrees = SubTree {firstTree = Tree {rootTree = 4, subtrees = None}, restTrees = None}}, restTrees = SubTree {firstTree = Tree {rootTree = 5, subtrees = None}, restTrees = None}}}}

level :: Integer -> Tree a -> [a]
level 0 (Tree x _ ) = [x]
level n (Tree _ ts) = levelTrees (n-1) ts

levelTrees :: Integer -> TreeList a -> [a]
levelTrees _ None = []
levelTrees n (SubTree t ts) = level n t ++ levelTrees n ts

-- >>> map (`level` tree) [0..2]

data SExpr = SBool Bool | SChar Char | SInt Int | SDouble Double | SList { list :: [SExpr] }
      deriving (Eq, Ord, Show, Read)

sexpr :: SExpr
sexpr = SList [SInt 2, SChar 'a', SList [SBool True, SDouble 1.2, SList []]]

-- >>> sexpr
-- SList {list = [SInt 2,SChar 'a',SList {list = [SBool True,SDouble 1.2,SList {list = []}]}]}

countAtoms :: SExpr -> Integer
countAtoms (SList ses) = foldr ((+) . countAtoms) 0 ses
-- countAtoms (SList ses) = sum $ map countAtoms ses
countAtoms _           = 1

-- >>> countAtoms sexpr
-- 4

-- >>> list sexpr
-- [SInt 2,SChar 'a',SList {list = [SBool True,SDouble 1.2,SList {list = []}]}]

-- flatten :: SExpr -> SExpr
-- list :: SExpr (SList) -> [SExpr]
-- concat :: [[a]] -> [a]
-- [SList [SExpr]] ---> [[SExpr]] ---> [SExpr] ---> SList [SExpr]
flatten (SList ses) = SList (concatMap (list . flatten) ses)
flatten atom        = SList [atom]

-- >>> flatten sexpr
-- SList {list = [SInt 2,SChar 'a',SBool True,SDouble 1.2]}
