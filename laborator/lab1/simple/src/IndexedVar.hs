module IndexedVar (IndexedVar) where

import FreshVar
import Substitution

data IndexedVar var = IndexedVar
  { ivName :: var
  , ivCount :: Int
  } deriving (Eq)

instance Read var => Read (IndexedVar var) where
  readsPrec n s = map (\(x, s') -> (IndexedVar x 0, s')) (readsPrec n s)

instance Show var => Show (IndexedVar var) where
  show (IndexedVar x 0) = show x
  show (IndexedVar x n) = show x ++ "_" ++ show n

instance Eq var => FreshVar (IndexedVar var) where
  freshVar x xs = x { ivCount = maxCount + 1}
    where
      maxCount = maximum [ivCount y | y <- x : xs, ivName y == ivName x]

instance Eq var => Substitution (IndexedVar var) where
  avoidCaptureSubstitution = avoidCaptureFresh substitute
