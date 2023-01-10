module Main where

main = do putStrLn "Моля, въведете палиндром: "
          line <- getLine
          let revLine = reverse line
          if revLine == line then putStrLn "Благодаря!"
          else do putStrLn $ line ++ " не е палиндром!"
                  main

getInt :: IO Int
getInt = do line <- getLine
            return $ read line

main2 = do n <- getInt
           print (n + 1)
{- while (...) { std::cin >> "... "; std::cout << "..."; } -}