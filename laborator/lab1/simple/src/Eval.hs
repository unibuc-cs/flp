module Eval (simplify) where

import Exp
import Substitution (Substitution(substitute))

simplify :: Substitution var => Exp var -> Exp var
simplify (App e1 e2)
  | Lam x e <- se1 = simplify (substitute x e2 e)
  | otherwise = App se1 (simplify e2)
  where
    se1 = simplify e1
simplify e = e
