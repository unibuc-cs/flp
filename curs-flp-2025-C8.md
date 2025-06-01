% Encodări Church în Calculul Lambda
% Curs de introducere
% 2025

---

## Ce este calculul lambda?

- Calculul lambda este un model matematic al calculului.
- Utilizat pentru a studia funcțiile și computabilitatea.
- Bază teoretică pentru limbaje de programare funcționale.
- Obiectiv: Cum reprezentăm date doar cu funcții?

---

## Ce este o encodare Church?

- Reprezentarea datelor prin funcții (booleeni, numere, perechi etc.)
- Nu folosim structuri native — doar funcții lambda.
- Exemplu: valoarea „adevărat” = o funcție care returnează primul argument.

---

## Booleeni în Church

```lambda
TRUE  ≡ λx.λy. x
FALSE ≡ λx.λy. y

IF    ≡ λb.λt.λf. b t f
```

- Exemplu: `IF TRUE a b` → `a`
- Exemplu: `IF FALSE a b` → `b`

---

## Operații logice

```lambda
AND ≡ λp.λq. p q FALSE
OR  ≡ λp.λq. p TRUE q
NOT ≡ λp. p FALSE TRUE
```

- `AND TRUE FALSE → FALSE`
- `OR FALSE TRUE → TRUE`
- `NOT TRUE → FALSE`

---

## Numere naturale (Church numerals)

```lambda
0 ≡ λf.λx. x
1 ≡ λf.λx. f x
2 ≡ λf.λx. f (f x)
n ≡ λf.λx. f^n x
```

- Numere = aplicații repetate ale unei funcții.

---

## Operații pe numere

```lambda
ADD ≡ λm.λn.λf.λx. m f (n f x)
MUL ≡ λm.λn.λf. m (n f)
EXP ≡ λm.λn. n m
```

- `ADD 2 3` → `5`
- `MUL 2 3` → `6`
- `EXP 2 3` → `8`

---

## Testarea la zero

```lambda
ISZERO ≡ λn. n (λx. FALSE) TRUE
```

- `ISZERO 0 → TRUE`
- `ISZERO 1 → FALSE`

---

## Perechi și Tupluri

```lambda
PAIR   ≡ λx.λy.λf. f x y
FIRST  ≡ λp. p (λx.λy. x)
SECOND ≡ λp. p (λx.λy. y)
```

- `PAIR a b` → funcție care aplică `f` la `a` și `b`
- `FIRST (PAIR x y)` → `x`
- `SECOND (PAIR x y)` → `y`

---

## Predecesorul (PRED)

```lambda
SUCC ≡ λn.λf.λx. f (n f x)

PRED ≡ λn.
  FIRST (
    n (λp. PAIR (SECOND p) (SUCC (SECOND p)))
      (PAIR 0 0)
  )
```

- Obținem valoarea anterioară folosind o pereche de acumulare.

---

## Concluzii și aplicații

- Church encoding arată că funcțiile sunt suficiente pentru a modela orice date.
- Folosit în limbaje funcționale (ex: Haskell, Scheme).
- Bază pentru teoria tipurilor și calculul computabilității.
- Înțelegerea acestor concepte ajută în designul limbajelor de programare.

---

## Întrebări?

- Exerciții sugerate:
  - Scrieți `NOT TRUE` și evaluați.
  - Evaluați `ADD 1 2`.
  - Scrieți o funcție `MAX` folosind `IF`.
