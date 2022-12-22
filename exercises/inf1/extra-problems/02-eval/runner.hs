{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE NamedFieldPuns #-}

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

type Reg = String

data Instr
    = Const Reg Int
    | Add Reg Reg Reg
    | End Reg

newtype Program = Program [Instr]

instance (Show Program) where
    show :: Program -> String
    show (Program p) = concatMap (++ "\n") (map show p)

instance (Show Instr) where
    show (Const x i) = x ++ " <- " ++ (show i)
    show (Add x y z) = x ++ " <- " ++ y ++ " + " ++ z
    show (End x) = "end " ++ x

testProg :: Program
testProg = Program
    [ Const "x" 42
    , Const "y" 26
    , Add "z" "x" "y"
    , End "z"
    ]

data MachineState
    = MachineState
        { rm :: RegMap Int
        , prg :: Program
        }

step :: MachineState -> Either (Maybe Int) MachineState
step (MachineState { rm, prg = Program (instr:rest) }) = case instr of
    (End r) -> Left $ getRM r rm
    (Const r i) -> Right $ MachineState
        { rm = putRM r i rm
        , prg = Program rest
        }
    (Add z x y) -> case (getRM x rm, getRM y rm) of
        (Just x', Just y') -> Right $ MachineState
            { rm = putRM z (x' + y') rm
            , prg = Program rest
            }
        _ -> error $ "dyado"

step _ = error $ "baba"

step' :: Either (Maybe Int) MachineState -> Either (Maybe Int) MachineState
step' = (>>= step)

run :: Program -> Maybe Int
run prg = let ms = MachineState { rm = emptyRM, prg = prg } in
    untilIsLeft step (Right ms)

newtype RegMap a = RegMap (String -> Maybe a)

putRM :: String -> a -> RegMap a -> RegMap a
putRM newK newV (RegMap m) = RegMap $ \k -> if k == newK then Just newV else m k

getRM :: String -> RegMap a -> Maybe a
getRM k (RegMap rm) = rm k

emptyRM :: RegMap a
emptyRM = RegMap $ const Nothing

untilIsLeft :: (a -> Either end a) -> Either end a -> end
untilIsLeft _ (Left x) = x
untilIsLeft f (Right x) = untilIsLeft f (f x) 

(>=>) :: (Monad m) => (a -> m b) -> (b -> m c) -> (a -> m c)
(>=>) famb fbmc a = do
    b <- famb a
    c <- fbmc b
    pure c
