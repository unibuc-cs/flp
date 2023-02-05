module FreshVar (FreshVar(..), avoidCaptureFresh) where

import Exp
import FreeVars

import Data.List (union)

class FreshVar var where
  freshVar :: var -> [var] -> var

avoidCaptureFresh :: (Eq var, FreshVar var) => (var -> Exp var -> Exp var -> Exp var) -> var -> Exp var -> [var] -> var -> Exp var -> Exp var
avoidCaptureFresh subst x e fve y ey = Lam freshY (subst x e freshEY)
    where
      freshY = freshVar y $ [x] `union` fve `union` allVars ey
      freshEY = subst y (X freshY) ey