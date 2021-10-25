-- We follow Graham Hutton, Programming in Haskell, 2nd edition, Chapter 13
import Data.Char
import Control.Monad
import Control.Applicative




newtype Parser a =
    Parser { apply :: String -> [(a, String)] }
      

instance Monad Parser where
    return x  = Parser (\s -> [(x,s)])
    m >>= k   = Parser (\s ->
                   [ (y, u) |
                     (x, t) <- apply m s,
                     (y, u) <- apply (k x) t ])
                     
                     
instance Applicative Parser where
  pure = return
  mf <*> ma = do
    f <- mf
    a <- ma
    return (f a)       

instance Functor Parser where              
  fmap f ma = pure f <*> ma                        


parse :: Parser a -> String -> a
parse m s = head [ x | (x,t) <- apply m s, t == "" ]


                    
                                       
anychar :: Parser Char
anychar = Parser f
    where
    f []     = []
    f (c:s) = [(c,s)]

  -- Recunoasterea unui caracter cu o proprietate
satisfy :: (Char -> Bool) -> Parser Char
satisfy p = Parser f
    where
    f []                 = []
    f (c:s) | p c        = [(c, s)]
            | otherwise = []

  -- Recunoasterea unui anumit caracter
char :: Char -> Parser Char
char c = satisfy (== c)     

string :: String -> Parser String
string [] = Parser (\s -> [([],s)])
string (x:xs) = Parser f  
 where
   f s = [(y:z,zs)| (y,ys)<- apply (char x) s, (z,zs) <- apply (string xs) ys]
  
stringM :: String -> Parser String
stringM []      = return []
stringM (x:xs) = do
                     y <- char x;
                     ys <- stringM xs;
                     return (y:ys)

                     
failM = Parser (\s ->[])

satisfyM :: (Char -> Bool) -> Parser Char
satisfyM p = do 
            c <- anychar
            if p c then return c else failM    
digit = satisfyM isDigit
abcP = satisfyM (`elem` ['A','B','C'])

alt :: Parser a -> Parser a -> Parser a
alt p1 p2 = Parser f
          where f s = apply p1 s ++ apply p2 s 
 
instance MonadPlus Parser where
    mzero      = failM
    mplus m n  = Parser (\s -> apply m s ++ apply n s)

instance Alternative Parser where
  empty  = mzero
  (<|>) = mplus    
 




-- parserCharUp = (pure toUpper <*> parserChar) 

-- parserCharOrd = fmap ord parserChar


-- sumOrdTwo = (fmap (+) parserCharOrd <*> parserCharOrd) 

-- ch :: Char -> Char -> String
-- ch x y = x:[y]  

-- number :: Parser Int
-- number  = P (\inp -> case inp of
                    -- []      -> []
                    -- (x:xs)  -> if (isDigit x) then [(digitToInt x,xs)] else [])
 

                    
-- no :: Int -> Int -> Int -> Int -> Int
-- no x y z v = x*1000+y*100+z*10 + v                  


-- numberFourTimes = fmap no number <*> number <*> number <*> number 

 
