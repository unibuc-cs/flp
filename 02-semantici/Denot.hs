import Data.Function (fix)
data AExp
    = Int Int
    | Var Id
    | AExp :+: AExp

data BExp
    = Bool Bool
    | AExp :<=: AExp

data Stmt
    = Skip
    | Stmt ::: Stmt
    | If BExp Stmt Stmt
    | While BExp Stmt

type Id = String
type State = Id -> Int
type DAExp = State -> Int
type DBExp = State -> Bool
type DStmt = State -> State

denotAExp :: AExp -> DAExp
denotAExp (Int n) s = n
denotAExp (Var x) s = s x
denotAExp (e1 :+: e2) s
  = denotAExp e1 s
  + denotAExp e2 s

denotBExp :: BExp -> DBExp
denotBExp (Bool b) s = b
denotBExp (a1 :<=: a2) s
  = denotAExp a1 s
  <= denotAExp a2 s

denotStmt :: Stmt -> DStmt
denotStmt Skip = id
denotStmt (s1 ::: s2) =
  denotStmt s2 . denotStmt s1
denotStmt (If c t e) = dIf
 where
    dIf s
     |denotBExp c s = denotStmt t s
     |otherwise     = denotStmt e s
denotStmt (While b c) =
  fix (\w s ->
    if denotBExp b s
      then w (denotStmt c s)
      else s)