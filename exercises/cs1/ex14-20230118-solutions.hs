{-# LANGUAGE InstanceSigs #-}
import Data.List (nub,elemIndex)
import Data.Maybe (fromJust)
import Control.Monad.State

-- Зад.6, малко изменение
data Expr = Const Int
          | Var
          | Expr :+ Expr
          | Expr :- Expr
          | Expr :* Expr
          | Expr :^ Int
          deriving Show
-- Когато дефинираме свои оператори, особено ако приличат на
-- математически оператори, е хубаво да им зададем асоциативност и приоритет
-- за да работят коректно изрази като (Const 2) :+ (Const 3) :* (Const 5)
infixl 6 :+
infixl 6 :-
infixl 7 :*
infixr 8 :^

eval :: Expr -> Int -> Int
eval (Const c) _ = c
eval (Var) x = x
eval (e1 :+ e2) x = eval e1 x + eval e2 x
eval (e1 :- e2) x = eval e1 x - eval e2 x
eval (e1 :* e2) x = eval e1 x * eval e2 x
eval (e :^ c) x = (eval e x) ^ c

-- Бонус: опростяваме след реалното диференциране
derive :: Expr -> Expr
derive e = simplify $ derive' e
  where derive' :: Expr -> Expr
        derive' (Const c) = (Const 0)
        derive' (Var) = (Const 1)
        derive' (e1 :+ e2) = derive' e1 :+ derive' e2
        derive' (e1 :- e2) = derive' e1 :- derive' e2
        derive' (e1 :* e2) = (derive' e1 :* e2) :+ (e1 :* derive' e2)
        derive' (e :^ c) = (Const c) :* (e :^ (c - 1)) :* (derive' e)
        -- f(g(x))' = f'(g(x)) * g'(x)

e :: Expr
e = ((Const 2 :* Var) :+ (Const 1)) :^ 3

-- Можем да разпознаваме и елиминираме конкретни изрази
arithmSimplify :: Expr -> Expr 
arithmSimplify (e :* (Const 1)) = arithmSimplify e
arithmSimplify ((Const 1) :* e) = arithmSimplify e
arithmSimplify (_ :* (Const 0)) = Const 0
arithmSimplify ((Const 0) :* _) = Const 0
arithmSimplify (e :+ (Const 0)) = arithmSimplify e
arithmSimplify ((Const 0) :+ e) = arithmSimplify e
-- след конкретните pattern-и за разпознаване
-- добавяме "общите" за рекурсия надолу
arithmSimplify (Const c) = Const c
arithmSimplify (Var) = Var
arithmSimplify (e1 :+ e2) = arithmSimplify e1 :+ arithmSimplify e2
arithmSimplify (e1 :- e2) = arithmSimplify e1 :- arithmSimplify e2
arithmSimplify (e1 :* e2) = arithmSimplify e1 :* arithmSimplify e2
arithmSimplify (e1 :^ c) = arithmSimplify e1 :^ c

-- Constant folding, или елиминиране на цели дървета (подизрази),
-- в които има само константи.
constantFoldSimplify :: Expr -> Expr
constantFoldSimplify (Const c) = Const c
constantFoldSimplify (Var) = Var
constantFoldSimplify (e1 :+ e2) = case (constantFoldSimplify e1, constantFoldSimplify e2)
                                    of (Const c1, Const c2) -> Const (c1 + c2)
                                       (e1s, e2s) -> e1s :+ e2s
constantFoldSimplify (e1 :- e2) = case (constantFoldSimplify e1, constantFoldSimplify e2)
                                    of (Const c1, Const c2) -> Const (c1 - c2)
                                       (e1s, e2s) -> e1s :- e2s
constantFoldSimplify (e1 :* e2) = case (constantFoldSimplify e1, constantFoldSimplify e2)
                                    of (Const c1, Const c2) -> Const (c1 * c2)
                                       (e1s, e2s) -> e1s :* e2s
constantFoldSimplify (e :^ c) = case constantFoldSimplify e
                                  of (Const c1) -> Const (c1 ^ c)
                                     e1s -> e1s :^ c

-- Композиция на всички трансформации (внимание за реда!)
simplify = constantFoldSimplify . arithmSimplify
-- Сега derive $ Const 3 :* (Var :+ Const 1) връща Const 3

-- стандартна дефиниция, от миналия път
data Tree a = Empty
            | Node a (Tree a) (Tree a)
            deriving Show -- за визуализация

instance Functor Tree where
  fmap _ Empty = Empty
  fmap f (Node x l r) = Node (f x) (fmap f l) (fmap f r)
  
-- Зад.7
values :: Tree a -> [a]
values Empty = []
values (Node x l r) = values l ++ [x] ++ values r

labelTree :: Eq a => Tree a -> Tree Int
labelTree t = fmap f t
  where xs = nub $ values t
        f x = succ $ fromJust $ elemIndex x xs

-- Зад.8 с изрично пазене на състояние
-- и предаването му на ръка от всяка стъпка на следващата
labelTree2 :: Eq a => Tree a -> Tree Int
labelTree2 t = fst $ helper t []
  where helper :: Eq a => Tree a -> [a] -> (Tree Int, [a])
        helper Empty xs = (Empty, xs)
        helper (Node x l r) xs = (Node idx l' r', xs3)
          where (l', xs1) = helper l xs
                xs2 = if x `elem` xs1 then xs1 else xs1++[x]
                idx = succ $ fromJust $ elemIndex x xs2
                (r', xs3) = helper r xs2

-- Монада State се грижи за това предаване, вкл. на
-- рекурсивните извиквание и други State функции
labelTree3 :: Eq a => Tree a -> Tree Int
labelTree3 t = evalState (helper t) []
  where helper :: Eq a => Tree a -> State [a] (Tree Int)
        helper Empty = return Empty
        helper (Node x l r) = do
            l' <- helper l
            modify $ \xs -> if x `elem` xs then xs else xs++[x]
            idx <- gets (succ . fromJust . elemIndex x)
            r' <- helper r
            return (Node idx l' r')

t :: Tree Char
t = Node 'c' (Node 'a' (Node 'b' Empty Empty)
                       (Node 'a' Empty Empty))
             (Node 'b' Empty Empty)

-- Бонус: примерна имплементация на State монад
-- Обикновен тип с единствен мембър, който (случайно) е функция
newtype MyState s a = MyState (s -> (a,s))
instance Functor (MyState s) where
    fmap :: (a -> b) -> MyState s a -> MyState s b
    fmap f (MyState x) = MyState (\s -> let (a,s1) = x s in (f a, s1))
instance Applicative (MyState s) where
    pure :: a -> MyState s a
    pure x = MyState $ \s -> (x,s)
    (<*>) :: MyState s (a -> b) -> MyState s a -> MyState s b
    (MyState x) <*> (MyState y) = MyState (\s -> let (f,s1) = x s; (a, s2) = y s1 in (f a, s2))
instance Monad (MyState s) where
    (>>=) :: MyState s a -> (a -> MyState s b) -> MyState s b
    (MyState x) >>= f = MyState (\s -> let (a,s1) = x s; (MyState y) = f a in y s1)
-- Сега можем да заменим State и функциите му в labelTree2 с MyState и тези :)
myModify :: (s -> s) -> MyState s ()
myModify f = MyState (\s -> ((), f s))
myGets :: (s -> a) -> MyState s a
myGets f = MyState (\s -> (f s, s))
myEvalState :: MyState s a -> s -> a
myEvalState (MyState x) s = fst $ x s
