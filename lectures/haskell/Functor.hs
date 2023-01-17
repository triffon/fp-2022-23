module Functor where

import Data
import Prelude hiding (Functor(..), Applicative(..), (<$>), pure, (<*>))
import Control.Monad (when)
import Text.XHtml (base)

class Functor f where
    fmap :: (a -> b) -> f a -> f b
    (<$>) :: (a -> b) -> f a -> f b
    (<$>) = fmap

-- >>> :k Functor
-- Functor :: (* -> *) -> Constraint

instance Functor Maybe where
    fmap :: (a -> b) -> Maybe a -> Maybe b
    -- защо не fmap _ _ = Nothing
    fmap f Nothing  = Nothing
    fmap f (Just x) = Just $ f x

-- >>> fmap (+1) (Just 3)
-- Just 4

-- >>> (+1) <$> Just 3
-- Just 4

-- >>> :k (,) Int Int
-- (,) Int Int :: *
-- >>> :k (Int,Int)
-- (Int,Int) :: *

-- >>> :k (,)
-- (,) :: * -> * -> *

-- >>> :k (,) Int
-- (,) Int :: * -> *

instance Functor ((,) c) where
    fmap :: (a -> b) -> (c, a) -> (c, b)
    fmap f (x, y) = (x, f y)

-- >>> fmap (+1) (5, 8)
-- (5,9)
-- >>> (+1) <$> (5,8)
-- (5,9)

instance Functor (Either c) where
    fmap :: (a -> b) -> Either c a -> Either c b
    fmap _ (Left x)  = Left x
    fmap f (Right y) = Right $ f y

-- >>> (+1) <$> Left 5
-- Left 5
-- >>> (+1) <$> Right 6
-- Right 7

instance Functor [] where
    fmap :: (a -> b) -> [a] -> [b]
    fmap = map

instance Functor BinTree where
    fmap :: (a -> b) -> BinTree a -> BinTree b
    fmap = mapBinTree

-- >>> (+1) <$> t
-- Node {root = 2, left = Node {root = 3, left = Node {root = 4, left = Empty, right = Empty}, right = Node {root = 5, left = Empty, right = Empty}}, right = Node {root = 6, left = Empty, right = Empty}}

instance Functor ((->) r) where
    fmap :: (a -> b) -> (r -> a) -> (r -> b)
    -- fmap f g = f . g
    fmap = (.)

-- >>> ((+1) <$> (*2)) 10
-- 21
class Functor f => Applicative f where
    pure  :: a -> f a
    (<*>) :: f (a -> b) -> f a -> f b
    -- fmap = (<*>) . pure

instance Applicative Maybe where
    pure = Just
    Nothing <*> _       = Nothing
    _       <*> Nothing = Nothing
    (Just f)<*> (Just x) = Just $ f x

{-
instance Applicative ((,) c) where
    pure :: a -> (c, a) ??? 
-}

instance Applicative [] where
    pure x = [x]
    fs <*> xs = [ f x | f <- fs, x <- xs ]

-- >>> [(+1),(*2)] <*> [3, 5, 8]
-- [4,6,9,6,10,16]

-- >>> (+) <$> Just 2 <*> Just 3
-- Just 5

-- >>> liftA2 (+) (Just 2) (Just 3)
-- Variable not in scope:
--   liftA2
--     :: (a0_a1cJG[tau:1] -> a0_a1cJG[tau:1] -> a0_a1cJG[tau:1])
--        -> Maybe a1_a1cJJ[tau:1] -> Maybe a2_a1cJN[tau:1] -> t_a1cJE[sk:1]

-- >>> do x <- [1..3]; y <- [4..x+4]; return $ x + y
-- [5,6,6,7,8,7,8,9,10]
-- >>> [ x + y | x <- [1..3], y <- [4..x+4]]
-- [5,6,6,7,8,7,8,9,10]
