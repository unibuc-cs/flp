module Printing (showExp) where

import Exp

showExp :: Show var => Exp var -> String
showExp (X v) = show v
showExp (Lam v s) = "\\" ++ show v ++ " -> " ++ showExp s
showExp (App s1 s2) = lApp s1 ++ " " ++ rApp s2
  where
    lApp e@(Lam _ _) = addParens $ showExp e
    lApp e = showExp e
    rApp e@(App _ _) = addParens $ showExp e
    rApp e = lApp e
    addParens s = "(" ++ s ++ ")"

