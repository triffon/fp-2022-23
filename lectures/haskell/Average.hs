module Main where

getInt :: IO Int
getInt = do line <- getLine
            return $ read line

readInt :: IO Int
readInt = do putStrLn "Моля, въведете брой: "
             getInt

readAndSum :: Int -> IO Int
readAndSum 0 = return 0
readAndSum n = do x <- getInt
                  s <- readAndSum $ n - 1
                  return $ x + s

findAverage :: IO Double
findAverage = do n <- readInt
                 putStrLn $ "Моля, въведете " ++ show n ++ " числа:"
                 s <- readAndSum n
                 return $ fromIntegral s / fromIntegral n

main :: IO ()
main = do avg <- findAverage
          putStrLn $ "Средното аритметично е: " ++ show avg

