zipWith' _  _ [] = []
zipWith' _ [] _ = []
zipWith' func (x:xs) (y:ys) = func x y : zipWith' func xs ys