module Data where

class Measurable a where
    size :: a -> Integer
    empty :: a -> Bool
    empty = (==0) . size

-- >>> :k Measurable Integer
-- Measurable Integer :: Constraint

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
