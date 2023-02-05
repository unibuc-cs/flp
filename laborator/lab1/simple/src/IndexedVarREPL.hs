module IndexedVarREPL (interactLine, repl) where

import Exp
import Eval
import Eta
import IndexedVar
import BasicVar
import Parsing
import Printing

import Control.Monad (unless)
import System.IO

interactLine :: String -> String
interactLine = showExp . simplify . (readExp :: String -> Exp (IndexedVar BasicVar))

evalREPL :: IO ()
evalREPL = do
  putStr "eval> " >> hFlush stdout
  s <- getLine
  unless (s == "quit") $ do
    putStrLn (interactLine s)
    evalREPL

etaREPL :: IO ()
etaREPL = do
  putStr "eta 1st> " >> hFlush stdout
  s1 <- getLine
  unless (s1 == "quit") $ do
    let e1 = readExp s1 :: Exp (IndexedVar BasicVar)
    putStr "eta 2nd> " >> hFlush stdout
    s2 <- getLine
    unless (s2 == "quit") $ do
      let e2 = readExp s2 :: Exp (IndexedVar BasicVar)
      print (eta e1 e2)
      etaREPL

repl :: IO ()
repl = do
  putStr "Main> " >> hFlush stdout
  s <- getLine
  unless (s == "quit") $ do
    case s of
      "eval" -> evalREPL
      "eta" -> etaREPL
      _ -> putStrLn "<error>: expecting 'eval' or 'repl'"
    repl
