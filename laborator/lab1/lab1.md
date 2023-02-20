# Laboratorul 1

În acest laborator ne vom aminti unele concepte de programare funcțională și
vom experimenta folosirea unui interpretor al unui mini-limbaj funcțional,
pe care îl vom numi `miniHaskell` datorita sintaxei ușor asemănatoare cu aceea
a limbajului `Haskell`.

Limbajul `miniHaskell` ne va însoți pe parcursul întregului semestru, deoarece
vom avea teme de laborator care ne vor ajuta să ne implementăm propriul nostru
interpretor `miniHaskell`.

## Limbajul `miniHaskell`

`miniHaskell` este un limbaj funcțional minimalist, având la bază doar $\lambda$-calcul
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

  *Atenție:* operatorii vor fi folosiți tot ca funcții, dar fără a îi mai înconjura între paranteze. De exemplu, 
  compunerea a două funcții va fi `. f g`
  în loc de `f . g` sau `(.) f g`
- $\lambda$-abstracții, care folosesc sintaxa din Haskell
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

#### Funcții de bază

- [`id :: a -> a`](https://hackage.haskell.org/package/base-4.17.0.0/docs/Prelude.html#v:id)
- [`const :: a -> b -> a`](https://hackage.haskell.org/package/base-4.17.0.0/docs/Prelude.html#v:const)
- [`. :: (b -> c) -> (a -> b) -> (a -> c)`](https://hackage.haskell.org/package/base-4.17.0.0/docs/Prelude.html#v:.)
- [`flip :: (a -> b -> c) -> (b -> c -> a)`](https://hackage.haskell.org/package/base-4.17.0.0/docs/Prelude.html#v:flip).


#### Tipul `Bool`

- [`True :: Bool`](https://hackage.haskell.org/package/base-4.17.0.0/docs/Prelude.html#v:True)
- [`False :: Bool`](https://hackage.haskell.org/package/base-4.17.0.0/docs/Prelude.html#v:False)
- `if :: Bool -> a -> a -> a` este instrucțiunea condițională `if_then_else_`
- [`&& : Bool -> Bool -> Bool`](https://hackage.haskell.org/package/base-4.17.0.0/docs/Prelude.html#v:-38--38-)
- [`|| : Bool -> Bool -> Bool`](https://hackage.haskell.org/package/base-4.17.0.0/docs/Prelude.html#v:-124--124-)
- [`not :: Bool -> Bool`](https://hackage.haskell.org/package/base-4.17.0.0/docs/Prelude.html#v:not)

#### Tipul `Maybe a`

- [`Nothing :: Maybe a`](https://hackage.haskell.org/package/base-4.17.0.0/docs/Prelude.html#v:Nothing)
- [`Just :: a -> Maybe a`](https://hackage.haskell.org/package/base-4.17.0.0/docs/Prelude.html#v:Just)
- [`maybe :: b -> (a -> b) -> Maybe a -> b`](https://hackage.haskell.org/package/base-4.17.0.0/docs/Prelude.html#v:maybe)
- [`fromMaybe :: a -> Maybe a -> a`](https://hackage.haskell.org/package/base-4.17.0.0/docs/Data-Maybe.html#v:fromMaybe)
- [`isNothing :: Maybe a -> Bool`](https://hackage.haskell.org/package/base/docs/Data-Maybe.html#v:isNothing)
- [`isJust :: Maybe a -> Bool`](https://hackage.haskell.org/package/base/docs/Data-Maybe.html#v:isJust)
- `mapMaybe :: (a -> b) -> Maybe a -> Maybe b` este `fmap` pentru instanța de `Functor` a lui `Maybe`

#### Tipul pereche `(a,b)`

- `pair :: a -> b -> (a,b)` este constructorul de perechi
- [`fst :: (a, b) -> a`](https://hackage.haskell.org/package/base/docs/Prelude.html#v:fst)
- [`snd :: (a, b) -> a`](https://hackage.haskell.org/package/base/docs/Prelude.html#v:snd)

#### Tipul `Natural`

- orice număr natural poate fi folosit ca constantă
- `Z :: Natural` o altă formă a constantei `0`
- `S :: Natural -> Natural` funcția succesor
- [`+ :: Natural -> Natural -> Natural`](https://hackage.haskell.org/package/base/docs/Prelude.html#v:-43-)
- [`* :: Natural -> Natural -> Natural`](https://hackage.haskell.org/package/base/docs/Prelude.html#v:-42-)
- `pred :: Natural -> Natural` funcția predecesor (întoarce `0` pentru `0`)
- [`- :: Natural -> Natural -> Natural`](https://hackage.haskell.org/package/base/docs/Prelude.html#v:-45-)  întoarce `0` dacă scăzătorul e mai mare
- `isZero :: Natural -> Bool` testează dacă argumentul e `0`
- [`<= :: Natural -> Natural -> Bool`](https://hackage.haskell.org/package/base/docs/Prelude.html#v:-60--61-)
- [`>= :: Natural -> Natural -> Bool`](https://hackage.haskell.org/package/base/docs/Prelude.html#v:-62--61-)
- [`== :: Natural -> Natural -> Bool`](https://hackage.haskell.org/package/base/docs/Prelude.html#v:-61--61-)
- [`< :: Natural -> Natural -> Bool`](https://hackage.haskell.org/package/base/docs/Prelude.html#v:-60-)
- [`> :: Natural -> Natural -> Bool`](https://hackage.haskell.org/package/base/docs/Prelude.html#v:-62-)
- [`max :: Natural -> Natural -> Natural`](https://hackage.haskell.org/package/base/docs/Prelude.html#v:max)
- `fact :: Natural -> Natural` calculează factorialul numărului dat ca argument

#### Tipul listelor `[a]`

- orice listă de tipul `[e1, e2, e3]` este o expresie
- `null :: [a]` este un alias pentru lista vidă (`[]`)
- `: :: a -> [a] -> [a]` este constructorul de liste
- [`(++) :: [a] -> [a] -> [a]`](https://hackage.haskell.org/package/base/docs/Prelude.html#v:-43--43-)
- [`length :: [a] -> Natural`](https://hackage.haskell.org/package/base/docs/Prelude.html#v:length)
- [`isNull :: [a] -> Bool`](https://hackage.haskell.org/package/base/docs/Prelude.html#v:null) testează dacă argumentul e lista vidă
- [`uncons :: [a] -> Maybe (a, [a])`](https://hackage.haskell.org/package/base/docs/Data-List.html#v:uncons)
- `head :: [a] -> Maybe a` variantă sigură a funcției [head](https://hackage.haskell.org/package/base/docs/Prelude.html#v:head)
- `tail :: [a] -> Maybe [a]` variantă sigură a funcției [tail](https://hackage.haskell.org/package/base/docs/Prelude.html#v:tail)
- [`foldr :: (a -> b -> b) -> b -> [a] -> b`](https://hackage.haskell.org/package/base/docs/GHC-Base.html#v:foldr)
- [`map :: (a -> b) -> [a] -> [b]`](https://hackage.haskell.org/package/base/docs/Prelude.html#v:map)
- [`filter :: (a -> Bool) -> [a] -> [a]`](https://hackage.haskell.org/package/base/docs/Prelude.html#v:filter)
- [`foldl :: (b -> a -> b) -> b -> [a] -> b`](https://hackage.haskell.org/package/base/docs/GHC-List.html#v:foldl)
- [`reverse :: [a] -> [a]`](https://hackage.haskell.org/package/base-4.17.0.0/docs/Prelude.html#v:reverse)

##### Funcții speciale pentru liste de numere naturale `[Natural]`

- `nat2list :: Natural -> [Natural]` numerele naturale de la `1` la argumentul dat, în ordine inversă  
- [`product :: [Natural] -> Natural`](https://hackage.haskell.org/package/base/docs/GHC-List.html#v:product)
- [`sum :: [Natural] -> Natural`](https://hackage.haskell.org/package/base/docs/GHC-List.html#v:sum)
- [`maximum :: [Natural] -> Natural`](https://hackage.haskell.org/package/base/docs/GHC-List.html#v:maximum)

## Exerciții

### 0. Interpretorul

Executați interpretorul `miniHaskell`. Dacă nu aveți probleme în executarea lui
(de genul _missing libraries_, _bad architecture_) ar trebui să vedeți un prompt:
```
miniHaskell>
```

Acum puteți scrie orice expresie folosind limbajul descris mai sus și interpretorul va încerca să o evalueze. De exemplu:
```
miniHaskell> letrec fct = \n -> if (isZero n) 1 (* n (fct (pred n))) in fct 4
24
miniHaskell>
```

*Important:* fiecare expresie pe care o vrem evaluată trebuie să fie scrisă pe o singură linie

Pentru a ieși din interpretor trebuie sa folosiți comanda `:q` sau `:quit` ca în `ghci`

### 1. Functii lambda
Definiti o funcție `squareSum :: Natural -> Natural -> Natural` care primește două numere naturale ca argument și întoarce suma pătratelor celor două numere.

Exemplu:
```
miniHaskell> let squareSum = ... in squareSum 2 3
13
```

### 2. Recursie 
Definiți prin recursie o funcție `revRange :: Natural -> [Natural]` care primește un număr natural ca argument și întoarce lista numerelor naturale mai mici decât `n`,
în ordine descrescătoare.

Exemplu: 
```
miniHaskell> letrec revRange = ... in revRange 4 
[3, 2, 1, 0]
```
Folosind funcția anterioară, definiția funcția `range` care întoarce numerele mai mici ca `n` în ordine crescătoare. 
```
miniHaskell> let range = ... in range 4 
[0, 1, 2, 3]
```

### 3. Filter, map 
Definiți, fără a folosi explicit recursie, o funcție `justList :: [Maybe Natural] -> [Natural]` care primește o listă cu elemente `Maybe Natural` și întoarce lista formată din acei `n`
pentru care `Just n` apare în listă, păstrând ordinea și multiplicitatea. 

Exemplu: 
```
miniHaskell> let justList = ... in justList [Just 4, Nothing, Just 5, Just 7, Nothing]
[4, 5, 7]
```

### 4. Fold
Fără a folosie explicit recursie, scrieți funcția `all :: (Natural -> Bool) -> [Natural] -> Bool` care verifică dacă toate elementele unei liste satisfac un predicat.

Exemplu: 
```
miniHaskell> let all = ... in all isZero [0, 0, 0]
True 
miniHaskell> let all = ... in all isZero [0, 1]
False
```
