module Main (main) where

import IndexedVarREPL (repl)

main :: IO ()
main = repl

{-
(\X -> \Y -> X) (Y)
===>
\Y_1 -> Y

2:
\S -> \Z -> (S) ((S) (Z))
4:
\S -> \Z -> (S) ((S) ((S) ((S) (Z))))
plus:
((\N -> \M -> \S -> \Z -> ((N) (S)) (((M) (S)) (Z))) (\S -> \Z -> (S) ((S) (Z)))) (\S -> \Z -> (S) ((S) (Z)))
-}