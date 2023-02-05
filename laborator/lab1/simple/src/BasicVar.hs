module BasicVar (BasicVar) where

import Substitution

import Data.Char (isSpace)

newtype BasicVar = BasicVar { getBasicVar :: String }
  deriving (Eq)

instance Read BasicVar where
  readsPrec _ s
    | (x@(_:_), s') <- break (`elem` "() ") $ dropWhile isSpace s
    = [(BasicVar x, s')]
  readsPrec _ _ = []

instance Show BasicVar where
  show = getBasicVar

instance Substitution BasicVar where
  avoidCaptureSubstitution = error "substitution might capture variables"