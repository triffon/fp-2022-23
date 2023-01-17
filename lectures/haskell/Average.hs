module Main where

getInt :: IO Int
getInt = do line <- getLine
            return $ read line

printRead :: String -> IO Int
printRead prompt = do putStrLn prompt
                      getInt



readAndSum :: Int -> IO Int
readAndSum 0 = return 0
readAndSum n = do x <- getInt
                  s <- readAndSum $ n - 1
                  return $ x + s

findAverage :: IO Double
findAverage = do n <- printRead "Моля, въведете число:"
                 putStrLn $ "Моля, въведете " ++ show n ++ " числа:"
                 s <- readAndSum n
                 return $ fromIntegral s / fromIntegral n

main :: IO ()
main = do avg <- findAverage
          putStrLn $ "Средното аритметично е: " ++ show avg

