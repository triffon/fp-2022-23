module Tuples where
type Point = (Double, Double)
p :: Point
p = (2.3, 3.5)
-- >>> p
-- (2.3,3.5)
-- >>> :t p
-- p :: Point

-- >>> fst (1, 2, 3)
-- Couldn't match expected type: (a, b0)
--             with actual type: (a0, b1, c0)
-- >>> ()
-- ()
-- >>> :t ()
-- () :: ()
