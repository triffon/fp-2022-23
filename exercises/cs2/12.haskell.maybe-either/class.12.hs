-- Maybe
data Maybe' a = Nothing' | Just' a
  deriving (Eq, Ord, Read, Show)

startsWith :: Char -> String -> Bool
startsWith c (x:_) = c == x
startsWith _ _ = False

startsWithM :: Char -> Maybe String -> Bool
startsWithM c (Just (x:_)) = c == x
startsWithM _ _ = False



parseDigit :: Char -> Maybe Int
parseDigit '0' = Just 0
parseDigit '1' = Just 1
parseDigit '2' = Just 2
parseDigit '3' = Just 3
parseDigit '4' = Just 4
parseDigit '5' = Just 5
parseDigit '6' = Just 6
parseDigit '7' = Just 7
parseDigit '8' = Just 8
parseDigit '9' = Just 9
parseDigit _   = Nothing

fromJust :: Maybe a -> a
fromJust (Just x) = x

fromMaybe :: a -> Maybe a -> a
fromMaybe _ (Just x) = x
fromMaybe y Nothing = y

anotateDigit :: Char -> String
anotateDigit c =
  case parseDigit c of
    Nothing -> "There is no digit"
    Just d -> "Your digit is " ++ show d


-- map :: (a -> b) -> [a] -> [b]
mapMaybe :: (a -> b) -> Maybe a -> Maybe b
mapMaybe _ Nothing = Nothing
mapMaybe f (Just x) = Just (f x)

anotateDigit2 :: Char -> String
anotateDigit2 c =
  fromMaybe "There is no digit"
    $ mapMaybe (\d -> "Your digit is " ++ show d)
    $ parseDigit c

parseInt :: String -> Maybe Int
parseInt cs =
  foldl op (Just 0)
    $ map parseDigit cs
  where
    op :: Maybe Int -> Maybe Int -> Maybe Int
    op Nothing _ = Nothing
    op _ Nothing = Nothing
    op (Just currentNumber) (Just d) =
      Just $ currentNumber * 10 + d


sequenceMaybe :: [Maybe a] -> Maybe [a]
sequenceMaybe [] = Just []
sequenceMaybe (Nothing : _) = Nothing
sequenceMaybe (Just y : xs) =
  case sequenceMaybe xs of
    Nothing -> Nothing
    Just ys -> Just (y : ys)

parseInt2 :: String -> Maybe Int
parseInt2 cs =
  mapMaybe digitsToInt
    $ sequenceMaybe
    $ reverse
    $ map parseDigit cs
  where
    digitsToInt [] = 0
    digitsToInt (d:ds) = (digitsToInt ds) * 10 + d


safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x:_) = Just x
--safeTail

safeDiv :: Int -> Int -> Maybe Int
safeDiv x 0 = Nothing
safeDiv x y = Just $ x `div` y

--listToMaybe :: [a] -> Maybe a
--listToMaybe [] = Nothing
--listToMaybe (x:_) = Just x
--
--maybeToList :: Maybe a -> [a]
--maybeToList Nothing = []
--maybeToList Just x = [x]



-- map :: (a -> b) -> [a] -> [b]
-- filter :: (a -> Bool) -> [a] -> [a]
filterMaybe :: (a -> Maybe b) -> [a] -> [b]
filterMaybe f xs = foldr op [] (map f xs)
  where
    op :: Maybe b -> [b] -> [b]
    op Nothing r = r
    op (Just x) r = x : r

-- Either
data Either' e a = Left' e | Right' a
-- Result<a,e>
--                Err      Ok






--find :: (a -> Maybe b) -> [a] -> Maybe b


data Op = Add | Sub | Mult | Div

parseOp :: Char -> Maybe Op
parseOp '+' = Just Add
parseOp '-' = Just Sub
parseOp '*' = Just Mult
parseOp '/' = Just Div
parseOp _ = Nothing

ifJust :: Maybe a -> (a -> Maybe b) -> Maybe b
ifJust Nothing _ = Nothing
ifJust (Just x) f = f x

parseExprAndEval :: Char -> String -> String -> Maybe Int
parseExprAndEval opChar number1 number2 =
    ifJust (parseOp opChar) (\op ->
      ifJust (parseInt number1) (\int1 ->
        ifJust (parseInt number2) (\int2 ->
          eval op int1 int2
          )
        )
      )

eval :: Op -> Int -> Int -> Maybe Int
eval Add i j = Just $ i + j
eval Sub i j = Just $ i - j
eval Mult i j = Just $ i * j
eval Div i j = i `safeDiv` j

parseExprAndEval2 :: Char -> String -> String -> Maybe Int
parseExprAndEval2 opChar number1 number2 = do
  op <- parseOp opChar
  int1 <- parseInt number1
  int2 <- parseInt number2
  eval op int1 int2

maybeToEither :: e -> Maybe a -> Either e a
maybeToEither e Nothing = Left e
maybeToEither _ (Just x) = Right x

ifRight :: Either e a -> (a -> Either e b) -> Either e b
ifRight (Left e) _ = Left e
ifRight (Right x) f = f x

data ExprError
  = OpParseFail
  | FirstIntParseFail
  | SecondIntParseFail
  | DivByZero
  deriving Show

parseExprAndEval3 :: Char -> String -> String -> Either ExprError Int
parseExprAndEval3 opChar number1 number2 =
    ifRight (maybeToEither OpParseFail (parseOp opChar)) (\op ->
      ifRight (maybeToEither FirstIntParseFail (parseInt number1)) (\int1 ->
        ifRight (maybeToEither SecondIntParseFail (parseInt number2)) (\int2 ->
          maybeToEither DivByZero (eval op int1 int2)
          )
        )
      )

parseExprAndEval4 :: Char -> String -> String -> Either ExprError Int
parseExprAndEval4 opChar number1 number2 = do
  op <- maybeToEither OpParseFail (parseOp opChar)
  int1 <- maybeToEither FirstIntParseFail (parseInt number1)
  int2 <- maybeToEither SecondIntParseFail (parseInt number2)
  maybeToEither DivByZero (eval op int1 int2)
