---
title: "Fundamentele Limbajelor de Programare"
subtitle: "Gramatici de operatori cu precedență"
author: "Traian-Florin Șerbănuță"
institute: "UNIBUC"
theme: "default"
urlcolor: "red"
linkstyle: "bold"
toc: false
date: "19 martie 2021"
---

## Gramatici de operatori cu precedențe

### Definiție
O gramatică independenta de context se numește gramatică de operatori dacă:

- Nu are producții vide \hfill `A ::= `
- Nu are terminale adiacente în partea dreaptă \hfill `A ::= BC`

### Exemplu rău

```
E ::= E A E | -E | (E) | x
A ::= + | - | * | / | ^
```

### Exemplu bun

```
E ::= E + E | E - E | E * E | E / E | E ^ E | - E | T
T ::= (E) | id | nat
```

##  Adăugăm precedențe și atribute de asociativitate

```
E ::= T
    > E ^ E (right)
    > - E
    > E * E (left) | E / E (left)
    > E + E (left) | E - E (left)
```

##  Calculăm tabela de precedențe

```
E ::= T
    > E ^ E (right)
    > - E
    > E * E (left) | E / E (left)
    > E + E (left) | E - E (left)
```

      T   ^   0-   *   /   +   -   \$
---- --- --- ---- --- --- --- --- ---
  T       >        >   >   >   >   >
  ^   <   <   >    >   >   >   >   >
 0-   <   <   <    >   >   >   >   >
  *   <   <   <    >   >   >   >   >
  /   <   <   <    >   >   >   >   >
  +   <   <   <    <   <   >   >   >
  -   <   <   <    <   <   >   >   >
  \$   <   <   <    <   <   <   <   <

## Adăugăm precedențele în șirul de analizat

      T   ^   0-   *   /   +   -   \$
---- --- --- ---- --- --- --- --- ---
  T       >        >   >   >   >   >
  ^   <   <   >    >   >   >   >   >
 0-   <   <   <    >   >   >   >   >
  *   <   <   <    >   >   >   >   >
  /   <   <   <    >   >   >   >   >
  +   <   <   <    <   <   >   >   >
  -   <   <   <    <   <   >   >   >
  \$   <   <   <    <   <   <   <   <

- Dacă vrem să analizăm `-2^2^x + 3 * 5 - 2 + 4`

- Transformăm în `$<-<2>^<2>^<x>+<3>*<5>-<2>+<4>$`

## Algoritm

1. Punem pe stivă până la primul `>`
2. Cănd întâlnim `>` scoatem din stivă până la `<`, și evaluăm
   - Am scos din stivă `< V1 o V2 >`
     - unde `V`-urile sunt valori deja obținute
   - Calculăm valoarea nouă `V` (arbore de parsare, număr)
3. Vedem relația dintre operatorul de pe stivă și cel din șir
   - dacă `<`, punem `< V` pe stivă și mergem la (1)
   - dacă `>`, punem `V >` pe stiva și mergem la (2)
   - dacă `=` (aceeași producție), punem `V` pe stivă și mergem la (1)

Până când avem doar `$` în șir și operatorul rămas în stivă e `$`

## Exemplu

- `$<-<2>^<2>^<x>+<3>*<5>-<2>+<4>$`
- `^<2>^<x>+<3>*<5>-<2>+<4>$` \hfill   `$<-<2>` \hfill \ 
- `^<2>^<x>+<3>*<5>-<2>+<4>$`  \hfill  `$<-<2` \hfill (`0- < ^`)
- `^<x>+<3>*<5>-<2>+<4>$`  \hfill  `$<-<2^<2>` \hfill \ 
- `^<x>+<3>*<5>-<2>+<4>$`  \hfill  `$<-<2^<2`  \hfill (`^ < ^`)
- `+<3>*<5>-<2>+<4>$`  \hfill  `$<-<2^<2^<x>`  \hfill \ 
- `+<3>*<5>-<2>+<4>$`   \hfill `$<-<2^<2^x>`   \hfill (`^ > +`)
- `+<3>*<5>-<2>+<4>$`   \hfill `$<-<2^(2^x)>`   \hfill (`^ > +`)
- `+<3>*<5>-<2>+<4>$`   \hfill `$<-(2^(2^x))>`   \hfill (`0- > +`)
- `+<3>*<5>-<2>+<4>$`  \hfill  `$<(-(2^(2^x)))`   \hfill (`$ < +`)

### Algoritm
1. Punem pe stivă până la primul `>`
2. Cănd întâlnim `>` scoatem din stivă până la `<`, și evaluăm
3. Vedem relația dintre operatorul de pe stivă și cel din șir
  - dacă `<`, punem `<` apoi valoarea pe stivă si mergem la (1)
  - dacă `>`, punem valoarea, apoi `>` pe stiva și mergem la (2)


## Exemplu

- `+<3>*<5>-<2>+<4>$`    `$<(-(2^(2^x)))`
- `*<5>-<2>+<4>$`    `$<(-(2^(2^x)))+<3>`
- `*<5>-<2>+<4>$`    `$<(-(2^(2^x)))+<3`    \hfill (`+ < *`)
- `-<2>+<4>$`    `$<(-(2^(2^x)))+<3*<5>`
- `-<2>+<4>$`    `$<(-(2^(2^x)))+<3*5>`     \hfill (`* > -`)
- `-<2>+<4>$`    `$<(-(2^(2^x)))+(3*5)>`     \hfill (`+ > -`)
- `-<2>+<4>$`    `$<((-(2^(2^x)))+(3*5))`     \hfill (`$ < -`)
- `+<4>$`    `$<((-(2^(2^x)))+(3*5))-<2>`
- `+<4>$`    `$<((-(2^(2^x)))+(3*5))-2>`   \hfill (`- > +`)
- `+<4>$`    `$<(((-(2^(2^x)))+(3*5))-2)`   \hfill (`$ < +`)

### Algoritm
1. Punem pe stivă până la primul `>`
2. Cănd întâlnim `>` scoatem din stivă până la `<`, și evaluăm
3. Vedem relația dintre operatorul de pe stivă și cel din șir
  - dacă `<`, punem `<` apoi valoarea pe stivă si mergem la (1)
  - dacă `>`, punem valoarea, apoi `>` pe stiva și mergem la (2)


## Exemplu

- `+<4>$`    `$<(((-(2^(2^x)))+(3*5))-2)`
- `$`    `$<(((-(2^(2^x)))+(3*5))-2)+<4>`
- `$`    `$<(((-(2^(2^x)))+(3*5))-2)+4>`    \hfill (`+ > $`)
- `$`    `$((((-(2^(2^x)))+(3*5))-2)+4)`    \hfill (gata)

### Algoritm
1. Punem pe stivă până la primul `>`
2. Cănd întâlnim `>` scoatem din stivă până la `<`, și evaluăm
3. Vedem relația dintre operatorul de pe stivă și cel din șir
  - dacă `<`, punem `<` apoi valoarea pe stivă si mergem la (1)
  - dacă `>`, punem valoarea, apoi `>` pe stiva și mergem la (2)
  
Până când avem doar `$` în șir și operatorul rămas în stivă e `$`


## Surse

- [Gatevidyalay](https://www.gatevidyalay.com/tag/operator-precedence-parsing-example-ppt/)

- [Wikipedia](https://en.wikipedia.org/wiki/Operator-precedence_grammar)

- [Text.Parsec.Expr](https://hackage.haskell.org/package/parsec-3.1.14.0/docs/Text-Parsec-Expr.html)