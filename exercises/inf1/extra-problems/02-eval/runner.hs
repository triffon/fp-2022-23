{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE NamedFieldPuns #-}

import Control.Monad.State.Lazy

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
    = IConst Reg Int
    | IAdd Reg Reg Reg
    | IEnd Reg

newtype Program = Program [Instr]

instance (Show Program) where
    show :: Program -> String
    show (Program p) = concatMap (++ "\n") (map show p)

instance (Show Instr) where
    show (IConst x i) = x ++ " <- " ++ (show i)
    show (IAdd x y z) = x ++ " <- " ++ y ++ " + " ++ z
    show (IEnd x) = "end " ++ x

testProg :: Program
testProg = Program
    [ IConst "x" 42
    , IConst "y" 26
    , IAdd "z" "x" "y"
    , IEnd "z"
    ]

data MachineState
    = MachineState
        { rm :: RegMap Int
        , prg :: Program
        }

step :: MachineState -> Either (Maybe Int) MachineState
step (MachineState { rm, prg = Program (instr:rest) }) = case instr of
    (IEnd r) -> Left $ getRM r rm
    (IConst r i) -> Right $ MachineState
        { rm = putRM r i rm
        , prg = Program rest
        }
    (IAdd z x y) -> case (getRM x rm, getRM y rm) of
        (Just x', Just y') -> Right $ MachineState
            { rm = putRM z (x' + y') rm
            , prg = Program rest
            }
        _ -> Left $ Nothing

step _ = Left $ Nothing

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


-- ********************

data Expr
    = EConst Int
    | EAdd Expr Expr

instance (Show Expr) where
    show (EConst a) = show a
    show (EAdd x y) = "(" ++ (show x) ++ " + " ++ (show y) ++ ")"

(+!+) :: Expr -> Expr -> Expr
x +!+ y = EAdd x y

testExpr :: Expr
testExpr = (EConst 2) +!+ (EConst 6) +!+ ((EConst 10) +!+ (EConst 100))

-- ((2 + 6) + (10 + 100))

-- dvoika <- const 2
-- shit <- const 6
-- left <- add dvoika shit
-- desetka <- const 10
-- sto <- const 100
-- right <- add desetka 100
-- result <- add left right
-- end result

data CompilerState = CompilerState
    { instructions :: [Instr]
    , newReg :: Int
    }


compile :: Expr -> Program
compile expr = flip evalState initialCompilerState  $ do
    reg <- compileExpr expr
    pushInstr $ IEnd reg
    instrs <- getAllInstrs
    return $ Program instrs

compileExpr :: Expr -> State CompilerState Reg
compileExpr (EConst a) = do
    reg <- getNewReg
    pushInstr $ IConst reg a
    return reg
compileExpr (EAdd x y) = do
    reg <- getNewReg
    regX <- compileExpr x
    regY <- compileExpr y
    pushInstr $ IAdd reg regX regY
    return reg

pushInstr :: Instr -> State CompilerState ()
pushInstr instr = do
    s@(CompilerState { instructions }) <- get
    put $ s { instructions = instr : instructions }

getNewReg :: State CompilerState Reg
getNewReg = do
    s@(CompilerState { newReg }) <- get
    put $ s { newReg = succ newReg }
    return $ "r" ++ (show newReg)

getAllInstrs :: State CompilerState [Instr]
getAllInstrs = do
    (CompilerState { instructions }) <- get
    return $ reverse $ instructions

initialCompilerState :: CompilerState
initialCompilerState = CompilerState
    { instructions = []
    , newReg = 1
    }
