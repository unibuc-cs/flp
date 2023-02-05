module Eta (eta) where

import Exp
import Eval ( simplify )
import FreshVar
import FreeVars ( allVars )
import Substitution

import Data.List (union)

eta :: (FreshVar var, Substitution var) => Exp var -> Exp var -> Bool
eta e1 e2 = checkEq (simplify e1) (simplify e2)
  where
    checkEq (X x) (X y) = x == y
    checkEq (App e11 e12) (App e21 e22)
      = checkEq e11 e21 && checkEq e12 e22
    checkEq ex@(Lam x _) ey@(Lam _ _)
      = eta (App ex ez) (App ey ez)
      where
        z = freshVar x (allVars ex `union` allVars ey)
        ez = X z
    checkEq _ _ = False
