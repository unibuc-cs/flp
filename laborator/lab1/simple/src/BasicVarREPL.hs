module BasicVarREPL (interactLine, repl) where

import Exp
import Eval
import BasicVar
import Parsing
import Printing

import Control.Monad (unless)

interactLine :: String -> String
interactLine = showExp . simplify . (readExp :: String -> Exp BasicVar)

repl :: IO ()
repl = do
  s <- getLine
  unless (s == "quit") $ do
    putStrLn (interactLine s)
    repl
