module FreeVars (freeVars, allVars) where

import Exp

import Data.List ( delete, union ) 

freeVars :: Eq var => Exp var -> [var]
freeVars (X v) = [v]
freeVars (App e1 e2) = freeVars e1 `union` freeVars e2
freeVars (Lam v e) = delete v (freeVars e)

allVars :: Eq var => Exp var -> [var]
allVars (X v) = [v]
allVars (App e1 e2) = freeVars e1 `union` freeVars e2
allVars (Lam v e) = [v] `union` allVars e
