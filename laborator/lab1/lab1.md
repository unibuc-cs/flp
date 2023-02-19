# Laboratorul 1

În acest laborator ne vom aminti unele concepte de programare funcțională și
vom experimenta folosirea unui interpretor al unui mini-limbaj funcțional,
pe care îl vom numi `miniHaskell` datorita sintaxei ușor asemănatoare cu aceea
a limbajului `Haskell`.

Limbajul `miniHaskell` ne va însoți pe parcursul întregului semestru, deoarece
vom avea teme de laborator care ne vor ajuta să ne implementăm propriul nostru
interpretor `miniHaskell`.

## Limbajul `miniHaskell`

`miniHaskell` este un limbaj funcțional minimalist, având la bază doar λ-calcul
(variabile, abstracții de funcții, aplicație), și folosind extensii _sintactice_
pentru Booleeni, nr naturale, optiuni, perechi, liste și definiții (inclusiv
definiții recursive).

Prin extensii _sintactice_ înțelegem că toate extensiile sunt de fapt codări în
limbajul de bază folosind ideile de [Church encodings](https://en.wikipedia.org/wiki/Church_encoding).
De aceea, de exemplu, funcțiile care manipulează numere naturale au
o complexitate relativ crescută, deoarece un număr `n` este similar unei liste
cu `n` elemente, iar orice operație elementară asupra sa este similară unei
operații de agregare (`foldr`) a unei liste.

### Sintaxa `miniHaskell`

```yacc
Exp ::=
   x
 | '\' x '->' Exp
 | Exp Exp
 | 'let' x '=' Exp 'in' Exp
 | 'letrec' f '=' Exp 'in' Exp
```

Expresiile pot fi formate prin una din următoarele operații:

- variablile (`x`), care pot fi orice identificator sau operator definibil
  în Haskell

  *Atenție:* operatorii vor fi folosiți tot ca funcții
- λ-abstracții, care folosesc sintaxa din Haskell
- aplicarea unei expresii altei expresii
- legarea unui nume la o expresie în scopul folosirii sale în evaluarea altei
  expresii (`let`)
- legarea unui nume la o expresie (care poate folosi recursiv acel nume)
  în scopul folosirii sale în evaluarea altei expresii (`letrec`)

### Extensii sintactice

Pe lângă expresiile de bază, limbajul mai acceptă și alte tipuri de expresii
(definite în limbajul de bază).
În prezentarea lor vom folosi signaturi de funcții de tipul celor din `Haskell`.

*Atenție:* deși signaturile funcțiilor sunt prezentate folosind tipuri,
limbajul `miniHaskell` este fără tipuri, deci este responsabilitatea voastră
să le folosiți conform tipului indicat.
În partea a doua a semestrului vom implementa și un verificator de tipuri
pentru a elimina expresiile cu tipuri greșite.

#### Basic functions

[`id :: a -> a`](https://hackage.haskell.org/package/base-4.17.0.0/docs/Prelude.html#v:id)

: funcția identitate

[`const :: a -> b -> a`]()

: funcția constantă, care ignoră al doilea argument, întorcând primul ca valoare

`. :: (b -> c) -> (a -> b) -> (a -> c)`

: operatorul de compunere a două funcții

`flip :: (a -> b -> c) -> (b -> c -> a)

: funcția care schimbă ordinea agumentelor unei funcții

#### Tipul `Bool`

- `True :: Bool`
- `False :: Bool`
