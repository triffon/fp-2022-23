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
