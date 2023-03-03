
module Test where

import Lab2

import Control.Applicative
import Data.Char

-- >>> apply anychar "abc"
-- [('a',"bc")]

-- | satisfy
-- >>> apply (satisfy isAlphaNum) "abc"
-- [('a',"bc")]
-- >>> apply (satisfy isAlphaNum) "2bc"
-- [('2',"bc")]
-- >>> apply (satisfy isAlphaNum) "@bc"
-- [] 

-- | anychar
-- >>> apply anychar "&ab"
-- [('&',"ab")]

-- | char
-- >>> apply (char 'i') "ionel"
-- [('i',"onel")]
-- >>> apply (char 'i') "Ionel"
-- []

-- | digit
-- >>> apply digit "9"
-- [('9',"")]
-- >>> apply digit "Ionel"
-- []
-- >>> apply digit "99"
-- [('9',"9")]

-- | space
-- >>> apply space " "
-- [(' ',"")]
-- >>> apply space "a "
-- []
-- >>> apply space "\na"
-- [('\n',"a")]

-- | fmap
-- >>> apply (digitToInt <$> digit) "7ab"
-- [(7,"ab")]

-- | parse-brackets
-- >>> apply (char '(' *> digit  <* char ')') "(1)23"
-- [('1',"23")]

-- | endOfInput
-- >>> apply (digit <* endOfInput) "123"
-- []
-- >>> apply (digit <* endOfInput) "1"
-- [('1',"")]

-- | parse
-- >>> parse digit "1"
-- Right '1'
-- >>> parse digit "12"
-- Left "Sirul de intrare nu a fost complet consumat sau parsare ambigua"

-- | cifraSemn
-- >>> apply cifraSemn "-123"
-- [(-1,"23")]
-- >>> apply cifraSemn "+23"
-- [(2,"3")]
-- >>> apply cifraSemn "23"
-- []

-- esueaza deoarece nu are semn

-- | string
-- >>> apply (string "Hi") "Hike"
-- [("Hi","ke")]
-- >>> apply (string "May") "March"
-- []
-- >>> apply (string "Hi") "HiHi"
-- [("Hi","Hi")]
-- >>> apply (string "March") "March"
-- [("March","")]

-- | whiteSpace
-- >>> apply whiteSpace " \t\nksdw"
-- [((),"ksdw"),((),"\nksdw"),((),"\t\nksdw"),(()," \t\nksdw")]
-- >>> apply whiteSpace "ionel"
-- [((),"ionel")]

-- | nat
-- >>> apply nat "12ab"
-- [(12,"ab"),(1,"2ab")]
-- >>> apply nat "ionel"
-- []

-- | lexeme
-- >>> apply (lexeme (string "Hello")) "Hello  World!"
-- [("Hello","World!"),("Hello"," World!"),("Hello","  World!")]

-- | symbol
-- >>> apply (symbol "if") "if (x) ..."
-- [("if","(x) ..."),("if"," (x) ...")]

-- | reserved
-- >>> apply (reserved "if") "if (x) ..."
-- [((),"(x) ..."),(()," (x) ...")]

-- | commaSep1
-- >>> apply (commaSep1 natural) "3  ,  4  , a, 5"
-- [([3,4],", a, 5"),([3,4]," , a, 5"),([3,4],"  , a, 5"),([3],",  4  , a, 5"),([3]," ,  4  , a, 5"),([3],"  ,  4  , a, 5")]

-- | identifier
-- >>> apply (identifier (satisfy isAlpha) (satisfy isAlphaNum)) "ij1 + 3"
-- [("ij1","+ 3"),("ij1"," + 3"),("ij","1 + 3"),("i","j1 + 3")]

