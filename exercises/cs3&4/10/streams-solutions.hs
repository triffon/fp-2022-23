-- cover all cases!
{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}
-- warn about incomplete patterns v2
{-# OPTIONS_GHC -fwarn-incomplete-uni-patterns #-}
-- write all your toplevel signatures!
{-# OPTIONS_GHC -fwarn-missing-signatures #-}
-- use different names!
{-# OPTIONS_GHC -fwarn-name-shadowing #-}
-- use all your pattern matches!
{-# OPTIONS_GHC -fwarn-unused-matches #-}

import Prelude hiding (cycle, iterate, repeat, scanl)

nats :: [Integer]
nats = 0 : map succ nats

repeat :: a -> [a]
repeat x = x : repeat x

iterate :: (a -> a) -> a -> [a]
iterate f x = x : iterate f (f x)

cycle :: [a] -> [a]
cycle xs = xs ++ cycle xs

scanl :: (b -> a -> b) -> b -> [a] -> [b]
scanl _ acc [] = [acc]
scanl op acc (x : xs) = acc : scanl op (op acc x) xs

fibs :: [Integer]
fibs = 0 : 1 : zipWith (+) fibs (drop 1 fibs)

factsScanl :: [Integer]
factsScanl = scanl (*) 1 (drop 1 nats)
