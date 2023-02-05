module Exp (Exp(..)) where

-- e ::= x | \x -> e | (e) (e)
data Exp var
  = X var
  | Lam var (Exp var)
  | App (Exp var) (Exp var)
  deriving (Show)
