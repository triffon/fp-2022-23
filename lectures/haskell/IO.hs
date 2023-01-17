module Main where

{-
noSpaces = do text <- getContents
              putStr $ filter (/=' ') text           
-}

noSpaces = interact $ filter (/= ' ')

{-
main = do text <- getContents
          putStr text
-}

-- main = interact id
main = noSpaces