module Parsing (readExp) where

import Exp

mapFst :: (a->c) -> [(a,b)] -> [(c,b)]
mapFst f xys = [(f x, y) | (x,y) <- xys]

readsApp :: Read var => [(Exp var, String)] -> [(Exp var, String)]
readsApp es@((e, s') : _)
  | (e', s'') : _ <- readsTerm s' = readsApp ((App e e', s''):es)
readsApp es = es

readsTerm :: Read var => [Char] -> [(Exp var, [Char])]
readsTerm (' ':s') = readsTerm s'
readsTerm ('(':s') = [(e, s'') | (e, ')':s'') <- readsExp s']
readsTerm ('\\':s') 
  | [(x, ' ':'-':'>':' ':s'')] <- reads s' = mapFst (Lam x) (readsExp s'')
readsTerm s'
  | [(x, s'')] <- reads s' = [(X x, s'')]
readsTerm _ = []

readsExp :: Read var => ReadS (Exp var)
readsExp s = readsApp (readsTerm s)

readExp :: Read var => String -> Exp var
readExp s = head [e | (e, "") <- readsExp s]
