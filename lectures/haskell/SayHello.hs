module Main where

main = do line <- getLine
          putStrLn $ "Hello, " ++ line 

{-
main = do putStr "Hello,"
          putChar ' '
          putStrLn "world!"
-}