module Main where

import Control.Monad

getInt :: IO Int
getInt = do line <- getLine
            return $ read line

printRead :: String -> IO Int
printRead prompt = do putStrLn prompt
                      getInt

readInt :: String -> IO Int
readInt what = printRead $ "Моля, въведете " ++ what ++ ":"

readAndSum :: Int -> IO Int
readAndSum 0 = return 0
readAndSum n = do x <- getInt
                  s <- readAndSum $ n - 1
                  return $ x + s

-- map f (map g (map h l))
-- map (f . g . h) l
findAverage :: IO Double
findAverage = do n <- readInt "брой"
                 l <- mapM (readInt . ("число " ++) . show) [1..n]
                 let s = sum l
                 return $ fromIntegral s / fromIntegral n

main :: IO ()
main = forever $ do avg <- findAverage
                    putStrLn $ "Средното аритметично е: " ++ show avg
                    putStrLn "Хайде отново!"

