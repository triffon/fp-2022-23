-- Да се реализира функция forestFire, която генерира безкраен поток 
-- от редицата от цели положителни числа, дефинирана чрез следната формула:
-- an = min { x | ∄k (1 ≤ k ≤ n/2) и (an-2k, an-k, x e аритметична прогресия)}
-- Пример: forestFire -- => [1, 1, 2, 1, 1, 2, 2, 4, 4, 1, 1, 2, 1, 1, ...]

-- Решение от Анди
-- an-2k, an-k, x e аритметична прогресия <=> x == an-k + (аn-k - an-2k) == 2*an-k - an-2k
forestFire = map f [0..]
  where f 0 = 1
        f n = findMinNotIn (findXs n)
        findXs n = [ 2 * f (n - k) - f (n - 2*k) | k <- [1..(n `div` 2)]]
        findMinNotIn lst = head [ x | x <- [1..], not (x `elem` lst)]