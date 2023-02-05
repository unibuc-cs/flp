module Substitution (Substitution(..)) where

import Exp
import FreeVars (freeVars)

class Eq var => Substitution var where
  substitute :: var -> Exp var -> Exp var -> Exp var
  substitute x e = go
    where
      fve = freeVars e
      go (X y)
        | x == y = e
        | otherwise = X y
      go (App e1 e2) = App (go e1) (go e2)
      go e'@(Lam y ey)
        | x == y = e'
        | y `elem` fve = avoidCaptureSubstitution x e fve y ey
        | otherwise = Lam y (go ey)

  avoidCaptureSubstitution :: var -> Exp var -> [var] -> var -> Exp var -> Exp var
    
