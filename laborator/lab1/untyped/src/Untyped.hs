{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE DeriveFunctor #-}
module Untyped (Exp, readExp, showExp, simplify, repl) where

import Control.Monad (unless)
import Data.Functor.Foldable
import Data.List ( delete, union ) 

-- e ::= x | \x -> e | (e) (e)
type Var = String

data ExpF e
  = X Var
  | Lam Var e
  | App e e
  deriving (Functor)

newtype Exp = Exp { getExp :: ExpF Exp }

type instance Base Exp = ExpF
instance Recursive Exp where
  project = getExp
instance Corecursive Exp where
  embed = Exp

showExpF :: ExpF String -> String
showExpF (X v) = v
showExpF (Lam v s) = "\\" ++ v ++ " -> " ++ s
showExpF (App s1 s2) = "(" ++ s1 ++ ") (" ++ s2 ++ ")" 

showExp :: Exp -> String
showExp = fold showExpF

findMatchingParen :: String -> (String, String)
findMatchingParen = go 0 "" where
  go :: Int -> String -> String -> (String, String)
  go 0 e (')':s) = (reverse e, s)
  go n e (')':s) = go (n - 1) (')':e) s
  go n e ('(':s) = go (n + 1) ('(':e) s
  go n e (ch:s) = go n (ch:e) s
  go _ _ "" = error "empty string encountered in findMatchingPattern"

readExpF :: String -> ExpF String
readExpF ('\\':ch:' ':'-':'>':' ':s) = Lam [ch] s
readExpF ('(':s)
  | (e1, ' ':'(':s1) <- findMatchingParen s,
    (e2, "") <- findMatchingParen s1
  = App e1 e2
  | otherwise = error ("Cannot parse application in (" ++ s)
readExpF [ch] = X [ch]
readExpF s = error ("Cannot parse expression: " ++ s)

readExp :: String -> Exp
readExp = unfold readExpF

simplify :: Exp -> Exp
simplify (Exp (App e1 e2))
  | Exp (Lam x e) <- se1 = simplify (substitute x e2 e)
  | otherwise = Exp (App se1 (simplify e2))
  where
    se1 = simplify e1
simplify e = e

repl :: IO ()
repl = do
  s <- getLine
  unless (s == "quit") $ do
    putStrLn . showExp . simplify . readExp $ s
    repl

freeVarsF :: ExpF [Var] -> [Var]
freeVarsF (X v) = [v]
freeVarsF (App vs1 vs2) = vs1 `union` vs2
freeVarsF (Lam v vs) = delete v vs

freeVars :: Exp -> [Var]
freeVars = fold freeVarsF

substitute :: Var -> Exp -> Exp -> Exp
substitute x e = elgot go checkLambda
  where
    fve = freeVars e
    go (X y) | x == y = e
    go e' = embed e'
    checkLambda e'@(Exp (Lam y _))
      | x == y = Left e'
      | y `elem` fve = error "substitution might capture variables"
    checkLambda e' = Right (project e')
