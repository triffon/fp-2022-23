import Control.Arrow
import Control.Monad
import Data.Function
import Data.List
import Data.Maybe
import Data.Ord

-----------
-- Задача 1
-----------

divisibleBy = (.) (==0) . mod

notDivisibleBy = not ... divisibleBy

prime n = n > 1 && (n `notDivisibleBy`) `all` [2 .. n-1]

-- O(n²)
primeDivisors n = product $ filter (prime &^& (n `divisibleBy`)) [2 .. n]

trim = ap div primeDivisors

grow = ap (*) primeDivisors

-- O(n)
primeDivisorsDirect op = snd . liftM2 (foldl step) (join (,)) (enumFromTo 2)
  where step p@(_, result) d = until ((`notDivisibleBy` d) . fst)
                                     ((`div` d) *** const (op result d)) p

trimDirect = primeDivisorsDirect div

growDirect = primeDivisorsDirect (*)

-----------
-- Задача 2
-----------

unitary n = (n `divisibleBy`) &^& (==1) . (div n >>= gcd)

commonUnitary n₁ n₂ = length $ filter (unitary n₁ &^& unitary n₂) [1 .. min n₁ n₂]

maxUnitary n = head $ filter (unitary n) [n-1, n-2 .. 1]

-----------
-- Задача 3
-----------

selectiveProcess select rule = join2 $ zipWith3 rule ... fillGaps ... zipWith select
  where fillGaps = reverse . foldl (\r@(y:_) -> (:r) . fromMaybe y) [1] . tail

selectiveMerge f = selectiveProcess select rule
  where select aᵢ bᵢ
          | liftM22 (<) f min aᵢ bᵢ = Just 1
          | liftM22 (>) f max aᵢ bᵢ = Just 2
          | otherwise = Nothing
        rule 1 = const
        rule 2 = f

selectiveMap f = selectiveProcess select rule
  where select aᵢ bᵢ
          | trans (<) (f aᵢ) (f bᵢ) (min aᵢ bᵢ) = Just 1
          | trans (>) (f bᵢ) (f aᵢ) (max aᵢ bᵢ) = Just 2
          | otherwise = Nothing
        trans f a b c = f a b && f b c
        rule 1 = f ... const
        rule 2 = f ... const'

-----------
-- Задача 4
-----------

commonBands = length ... intersect

cover = liftM2 (flip (/) `on` fromIntegral) length . commonBands

compatible = (>=2) ... commonBands

preferredFor modify range = intersect range .
                            maximumBy (comparing $ modify cover range) .
                            ([-1]:) . filter (compatible range)

preferredNetwork = preferredFor id

preferredDevice  = preferredFor flip

--------
-- Бонус
--------

preferredForAll modify ranges = foldr1 union .
                                liftM2 map intersect compatibleRanges .
                                maximumBy (comparing $
                                           length . compatibleRanges &&&
                                           sum . (liftM2 map (modify cover) compatibleRanges))
  where compatibleRanges = (`filter` ranges) . compatible

preferredNetworkForAll = preferredForAll id

preferredDeviceForAll  = preferredForAll flip

----------
-- Тестове
----------

tests = and [
  trim 360 == 12,
  trimDirect 360 == 12,
  grow 20 == 200,
  growDirect 20 == 200,
  commonUnitary 60 140 == 4,
  maxUnitary 60 == 20,
  selectiveMerge (*) [1, 2, 3, 4, 1, 3, 1, 2]
                     [10, 1, 2, 0, 5, -2, -1, 4]
                  == [1, 2, 6, 0, 5, 3, 1, 8],
  selectiveMap (\x -> x^2 - 2) [2, -1, -2, -1, 4, 0, 1, -4]
                               [10, 2, -3, 2, -1, 1, 3, 5]
                            == [2, -1, 7, 2, -1, -2, -1, 23],
  sort (preferredNetwork [1, 3, 5, 7, 8, 20]
                         [[1, 3, 8, 40, 41], [1, 3, 7, 28],  [5]])
    == [1, 3, 7],
  sort (preferredDevice [2, 4, 5, 17, 30]
                        [[1, 3, 5, 7, 9, 20], [1, 2, 3, 4, 5, 7, 12, 14, 30], [2, 4, 17]])
    == [2, 4, 5, 30],
  sort (preferredNetworkForAll [[1, 3, 5, 7, 9, 20], [1, 2, 3, 4, 5, 7, 12, 14, 30], [2, 4, 17]]
                               [[1, 3, 8, 40, 41], [1, 3, 7, 28],  [5], [2, 4, 5, 17, 30]])
    == [2, 4, 5, 17, 30],
  sort (preferredDeviceForAll  [[1, 3, 8, 40, 41], [1, 3, 7, 28],  [5], [2, 4, 5, 17, 30]]
                               [[1, 3, 5, 7, 9, 20], [1, 2, 3, 4, 5, 7, 12, 14, 30], [2, 4, 17]])
    == [1, 2, 3, 4, 5, 7, 30]
  ]

------------------
-- Помощни нотации
------------------

infixr 8 ...
(...)   =   (.)  .  (.)
liftM22 = liftM2 . liftM2
infixr 8 &^&
(&^&)   = liftM2 (&&)
join2   = curry . (>>= uncurry) . uncurry
const'  = const id

{-------------------------------------
 Речник
 -------------------------------------
 (∘) x y           = x ∘ y
 (x ∘) y           = x ∘ y
 (∘ y) x           = x ∘ y
 x `op` y          = op x y
 f $ x             = f x
 flip f x y        = f y x
 id x              = x
 const  x y        = x
 const' x y        = y
                   = const id x y
 (f . g) x         = f (g x)
 ap f g x          = f x (g x)
 (g >>= f) x       = f (g x) x
 on f g x y        = f (g x) (g y)
 (f ... g) x y     = f (g x y)
 liftM2 f g h x    = f (g x) (h x)
 liftM22 f g h x y = f (g x y) (h x y)
 join f x          = f x x
 join2 f x y       = f x y x y
 (f <=< g) x y     = f (g x y) y
 (f *** g) (x, y)  = (f x, g y)
 (f &&& g) x       = (f x, g x)
                   = liftM2 (,) f g x
 (f &^& g) x       = f x && g x
                   = liftM2 (&&) f g x
 --------------------------------------}
