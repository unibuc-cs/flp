
module Lab2 where

import Control.Applicative
import Data.Char

newtype Parser a = Parser { apply :: String -> [(a, String)] }

satisfy :: (Char -> Bool) -> Parser Char
satisfy p = Parser go
  where
    go [] = []   -- imposibil de parsat șirul vid
    go (c:input)
      | p c = [(c, input)]   -- dacă predicatul ține, întoarce c și restul șirului de intrare
      | otherwise = []       -- în caz contrar, imposibil de parsat

-- | satisfy
-- >>> apply (satisfy isAlphaNum) "abc"
-- [('a',"bc")]
-- >>> apply (satisfy isAlphaNum) "2bc"
-- [('2',"bc")]
-- >>> apply (satisfy isAlphaNum) "@bc"
-- [] 

--- | Acceptă orice caracter
anychar :: Parser Char
anychar = undefined

-- | anychar
-- >>> apply anychar "&ab"
-- [('&',"ab")]

--- | acceptă doar caracterul dat ca argument
char :: Char -> Parser Char
char = undefined

-- | char
-- >>> apply (char 'i') "ionel"
-- [('i',"onel")]
-- >>> apply (char 'i') "Ionel"
-- []

--- | acceptă o cifră
digit :: Parser Char
digit = undefined

-- | digit
-- >>> apply digit "9"
-- [('9',"")]
-- >>> apply digit "Ionel"
-- []
-- >>> apply digit "99"
-- [('9',"9")]

--- | acceptă un spațiu (sau tab, sau sfârșit de linie -- vedeți funcția din Data.Char )
space :: Parser Char
space = undefined

-- | space
-- >>> apply space " "
-- [(' ',"")]
-- >>> apply space "a "
-- []
-- >>> apply space "\na"
-- [('\n',"a")]

--- | succes doar dacă am șirul de intrare este vid 
endOfInput :: Parser ()
endOfInput  = Parser go
  where
    go "" = [((), "")]
    go _ = []

instance Functor Parser where
    fmap f pa = Parser (\input -> [(f a, rest) | (a, rest) <- apply pa input])

-- | fmap
-- >>> apply (digitToInt <$> digit) "7ab"
-- [(7,"ab")]

instance Applicative Parser where
    pure a = Parser (\input -> [(a, input)])
    pf <*> pa = Parser (\input -> [(f a, resta) | (f, restf) <- apply pf input, (a, resta) <- apply pa restf])

parseCifra = digitToInt <$> digit
douaCifre c1 c2 = 10 * c1 + c2

-- | parseCifra
-- >>> apply parseCifra "7ab"
-- [(7,"ab")]
-- >>> douaCifre 2 3
-- 23
-- >>> apply (pure douaCifre <*> parseCifra <*> parseCifra) "23c"
-- [(23,"c")]

-- | parse-brackets
-- >>> apply (char '(' *> digit  <* char ')') "(1)23"
-- [('1',"23")]

-- | endOfInput
-- >>> apply (digit <* endOfInput) "123"
-- []
-- >>> apply (digit <* endOfInput) "1"
-- [('1',"")]

parse :: Parser a -> String -> Either String a
parse = undefined

-- | parse
-- >>> parse digit "1"
-- Right '1'
-- >>> parse digit "12"
-- Left "Sirul de intrare nu a fost complet consumat sau parsare ambigua"

instance Monad Parser where
    pa >>= k = Parser (\input -> [(b, restb) | (a, resta) <- apply pa input, (b, restb) <- apply (k a) resta])

cifraIntreParanteze :: Parser Int
cifraIntreParanteze 
  = do
    char '('
    d <- digit
    char ')'
    return (digitToInt d)

cifraSemn :: Parser Int
cifraSemn = undefined

-- | cifraSemn
-- >>> apply cifraSemn "-123"
-- [(-1,"23")]
-- >>> apply cifraSemn "+23"
-- [(2,"3")]
-- >>> apply cifraSemn "23"
-- []

-- esueaza deoarece nu are semn

string :: String -> Parser String
string = undefined

-- | string
-- >>> apply (string "Hi") "Hike"
-- [("Hi","ke")]
-- >>> apply (string "May") "March"
-- []
-- >>> apply (string "Hi") "HiHi"
-- [("Hi","Hi")]
-- >>> apply (string "March") "March"
-- [("March","")]

instance Alternative Parser where
    empty = Parser (const [])
    p <|> p' = Parser (\input -> apply p input ++ apply p' input)

naiveNatural :: Parser Int
naiveNatural = undefined

-- | Elimină zero sau mai multe apariții ale lui `space`
whiteSpace :: Parser ()
whiteSpace = undefined

-- | whiteSpace
-- >>> apply whiteSpace " \t\nksdw"
-- [((),"ksdw"),((),"\nksdw"),((),"\t\nksdw"),(()," \t\nksdw")]
-- >>> apply whiteSpace "ionel"
-- [((),"ionel")]

-- | parses a natural number (one or more digits)
nat :: Parser Int
nat = undefined

-- | nat
-- >>> apply nat "12ab"
-- [(12,"ab"),(1,"2ab")]
-- >>> apply nat "ionel"
-- []

-- | aplică un parser, și elimină spațiile de după
lexeme :: Parser a -> Parser a
lexeme = undefined

-- | lexeme
-- >>> apply (lexeme (string "Hello")) "Hello  World!"
-- [("Hello","World!"),("Hello"," World!"),("Hello","  World!")]

-- | parses a natural number and skips the space after it
natural :: Parser Int
natural = undefined

-- | Parses the string and skips whiteSpace after it
symbol :: String -> Parser String
symbol = undefined

-- | symbol
-- >>> apply (symbol "if") "if (x) ..."
-- [("if","(x) ..."),("if"," (x) ...")]

-- | Parses the string, skips whiteSpace, returns unit
reserved :: String -> Parser ()
reserved = undefined

-- | reserved
-- >>> apply (reserved "if") "if (x) ..."
-- [((),"(x) ..."),(()," (x) ...")]

-- | parsează virgulă, eliminând spațiile de după
comma :: Parser ()
comma = undefined

-- | parsează argumentul intre paranteze rotunde
--   elimină spațiile de după paranteze
parens :: Parser a -> Parser a
parens = undefined

-- | parsează argumentul intre paranteze pătrate
--   elimină spațiile de după paranteze
brackets :: Parser a -> Parser a
brackets = undefined

-- | una sau mai multe instanțe, separate de virgulă,
--   cu eliminarea spațiilor de după fiecare virgulă
--   intoarce lista obiectelor parsate
commaSep1 :: Parser a -> Parser [a]
commaSep1 = undefined

-- | commaSep1
-- >>> apply (commaSep1 natural) "3  ,  4  , a, 5"
-- [([3,4],", a, 5"),([3,4]," , a, 5"),([3,4],"  , a, 5"),([3],",  4  , a, 5"),([3]," ,  4  , a, 5"),([3],"  ,  4  , a, 5")]

-- | zero sau mai multe instanțe, separate de virgulă,
--   cu eliminarea spațiilor de după fiecare virgulă
--   intoarce lista obiectelor parsate
commaSep :: Parser a -> Parser [a]
commaSep = undefined

-- | date fiind parsere pentru prima literă si pentru felul literelor următoare
--   scrieți un parser pentru un identificator
ident :: Parser Char -> Parser Char -> Parser String
ident identStart identLetter = undefined

-- | ca mai sus, dar elimină spatiile de după
identifier :: Parser Char -> Parser Char -> Parser String
identifier start letter = lexeme (ident start letter)

-- | identifier
-- >>> apply (identifier (satisfy isAlpha) (satisfy isAlphaNum)) "ij1 + 3"
-- [("ij1","+ 3"),("ij1"," + 3"),("ij","1 + 3"),("i","j1 + 3")]

