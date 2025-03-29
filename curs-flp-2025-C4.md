---
author: Traian Florin Șerbănuță și Andrei Sipoș
institute: Facultatea de Matematică și Informatică, DL Info
date: Anul II, Semestrul II, 2024/2025
title: Fundamentele limbajelor de programare
subtitle: Programare logică. Prolog. Algoritmul de Unificare
theme: CambridgeUS
---

# Programare Logică

## Programare logică

- Programarea logică este o paradigmă de programare bazată pe logică.

- Unul din sloganurile programării logice:

  ::: center
  [ **Program = Logică +
  Control**](https://www.doc.ic.ac.uk/~rak/papers/History.pdf)
  :::

- Programarea logică poate fi privită ca o deducție controlată.

- Un program scris într-un limbaj de programare logică este

  - o listă de formule într-o logică

  - ce exprimă fapte și reguli despre o problemă.

## Programare logică

Exemple de limbaje de programare logică:

-    Prolog

-    Answer set programming (ASP)

-    Datalog

## Programare logică - în mod idealist

-   Un "program logic" este o colecție de proprietăți presupuse (sub
    formă de formule logice) despre lumea programului.

-   Programatorul furnizează și o proprietate (o formula logică) care
    poate să fie sau nu adevărată în lumea respectivă (întrebare,
    query).

-   Sistemul determină dacă proprietatea aflată sub semnul întrebării
    este o consecință a proprietăților presupuse în program.

-   Programatorul nu specifică metoda prin care sistemul verifică dacă
    întrebarea este sau nu consecință a programului.

## Exemplu de program logic

::: center
  ------------------------- ------- ------------------
                     `oslo`  $\to$  `windy`
                     `oslo`  $\to$  `norway`
                   `norway`  $\to$  `cold`
    `cold `$\wedge$` windy`  $\to$  `winterIsComing`
                                    `oslo`
  ------------------------- ------- ------------------
:::

**Exemplu de întrebare.** Este adevărat `winterIsComing`?

## Prolog

-   bazat pe logica clauzelor Horn

-   semantica operațională este bazată pe rezoluție

-   este Turing complet

Program:

```prolog
windy :- oslo.
norway :- oslo.
cold :- norway.
winterIsComing :- windy, cold.
oslo.
```

Intrebare:

```prolog
?- winterIsComing.
true
```

[http://swish.swi-prolog.org/](http://swish.swi-prolog.org/)

## Program în Prolog = bază de cunoștințe

**Exemplu.** Un program în Prolog:
```prolog
father(peter,meg).
father(peter,stewie).

mother(lois,meg).
mother(lois,stewie).

griffin(peter).
griffin(lois).

griffin(X) :- father(Y,X),  griffin(Y).
```

Un program în Prolog este o bază de cunoștințe (Knowledge Base).

## Program în Prolog = mulțime de predicate

Practic, gândim un program în Prolog ca o mulțime de predicate cu
ajutorul cărora descriem *lumea* (*universul*) programului respectiv.

**Exemplu.**

::: columns
::: {.column width=.5}
```prolog
father(peter,meg).
father(peter,stewie).

mother(lois,meg).
mother(lois,stewie).

griffin(peter).
griffin(lois).

griffin(X) :- father(Y,X),  griffin(Y).
```
:::

::: {.column width=.3}
**Predicate:**
```prolog
father/2
mother/2
griffin/1
```
:::
:::

## Un program în Prolog

::: center
![](images/Prolog1.jpg)
:::

## Program

-   Un program în Prolog este format din reguli de forma

    ::: center
    ```prolog
    Head :- Body.
    ```
    :::

-    Head este un predicat, iar Body este o secvență de predicate
    separate prin virgulă.

-   Regulile fără `Body` se numesc fapte.

**Exemple.**

-   Exemplu de regulă:

    ```prolog
    griffin(X) :- father(Y,X), griffin(Y).
    ```

-   Exemplu de fapt:

    ```prolog
    father(peter,meg).
    ```

## Interpretarea din punctul de vedere al logicii

Operatorul **:-** este implicația logică $\leftarrow$.

**Exemplu.** `comedy(X) :- griffin(X).`{.prolog}

dacă `griffin(X)`{.prolog} este adevărat, atunci `comedy(X)`{.prolog} este adevărat.

Virgula , este conjuncția $\wedge$.

**Exemplu.** `griffin(X) :- father(Y,X), griffin(Y).`{.prolog}

dacă `father(Y,X)`{.prolog} și `griffin(Y)`{.prolog} sunt adevărate,

atunci `griffin(X)`{.prolog} este adevărat.

## Interpretarea din punctul de vedere al logicii

Mai multe reguli cu același Head reprezintă posibilități de defini același predicat.

**Exemplu.**

```prolog
comedy(X) :- family_guy(X).
comedy(X) :- south_park(X).
comedy(X) :- disenchantment(X).
```

dacă `family_guy(X)`{.prolog} este adevărat sau `south_park(X)`{.prolog} este adevărat sau
`disenchantment(X)`{.prolog} este adevărat,

atunci `comedy(X)`{.prolog} este adevărat.

## Un program în Prolog

::: center
![](images/Prolog1.jpg)

Cum folosim un program în Prolog?
:::

## Întrebări în Prolog

::: center
![](images/Prolog.jpg)
:::

## Întrebări și ținte în Prolog

-   Prolog poate răspunde la întrebări legate de consecințele relațiilor
    descrise într-un program în Prolog.

- Întrebările sunt de forma:

  ::: center
  `?- predicat`$_1$`(`$\ldots$`),`$\ldots$`,predicat`$_n$`(`$\ldots$`).`
  :::

-   Prolog verifică dacă întrebarea este o consecință a relațiilor
    definite în program.

-   Dacă este cazul, Prolog caută valori pentru variabilele care apar în
    întrebare astfel încât întrebarea să fie o consecință a relațiilor
    din program.

-   Un predicat care este analizat pentru a răspunde la o întrebare se
    numește țintă (goal).

## Întrebări în Prolog

Prolog poate da 2 tipuri de răspunsuri:

-    `false`{.prolog} -- dacă întrebarea nu este o consecință a programului.

-    `true`{.prolog} sau valori pentru variabilele din întrebare dacă întrebarea
    este o consecință a programului.

### Exemplu
::: columns
::: {.column width=.4}
```prolog
?- griffin(meg)
true

?- griffin(glenn)
false
```
:::

::: {.column width=.4}
```prolog
?- griffin(X)
X = petr ;
X = lois ;
X = meg ;
X = stewie ;
false
```
:::
:::

## Cum găsește Prolog răspunsul

Pentru a găsi un răspuns,\
Prolog încearcă regulile în ordinea apariției lor.

**Exemplu.** Să presupunem că avem programul:

```prolog
foo(a).  foo(b).  foo(c).
```

și că punem întrebarea:

```prolog
?- foo(X).
X = a.
```
Pentru a răspunde la întrebare se caută o potrivire (unificator) între
scopul `foo(X)`{.prolog} și baza de cunoștințe. Răspunsul este substituția care
realizează unificarea, în cazul nostru `X = a`{.prolog}.

## Cum găsește Prolog răspunsul

**Exemplu.** Să presupunem că avem programul:

```prolog
foo(a).  foo(b).  foo(c).
```

și că punem întrebările:

```prolog
?- foo(X).
X = a.

?- foo(d).
false
```

Dacă nu se poate face unificarea, răspunsul este `false`{.prolog}.

## Cum găsește Prolog răspunsul

**Exemplu.** Să presupunem că avem programul:

```prolog
foo(a).  foo(b).  foo(c).
```

și că punem întrebarea:
```prolog
?- foo(X).
X = a.
```

Dacă dorim mai multe răspunsuri, tastăm `;`{.prolog}

```prolog
?- foo(X).
X = a ;
X = b ;
X = c.
```

## Cum găsește Prolog răspunsul

**Exemplu.**

::: columns
::: {.column width=.5}
Să presupunem că avem programul:

```prolog
foo(a).
foo(b).
foo(c).
```

și că punem întrebarea:

```prolog
?- foo(X).
```
:::
::: {.column width=.5}

![](images/trace1.jpg)
:::
:::

## Cum găsește Prolog răspunsul

Pentru a găsi un raspuns, Prolog redenumește variabilele.

**Exemplu.**

::: columns
::: {.column width=.5}
Să presupunem că avem programul:

```prolog
foo(a).
foo(b).
foo(c).
```

și că punem întrebarea:

```prolog
?- foo(X).
```
:::
::: {.column width=.5}

![](images/foo1.png)
:::
:::

## Cum găsește Prolog răspunsul

**Exemplu.**

::: columns
:::{.column width=.5}
Să presupunem că avem programul:

```prolog
foo(a).
foo(b).
foo(c).
```

și că punem întrebarea:

```prolog
?- foo(X).
```
:::
::: {.column width=.5}
![](images/foo2.png)
:::
:::

În acest moment, a fost găsită prima soluție: `X=_4556=a`.

## Cum găsește Prolog răspunsul

**Exemplu.**

::: columns
::: {.column width=.5}
Să presupunem că avem programul:

```prolog
foo(a).
foo(b).
foo(c).
```

și că punem întrebarea:

```prolog
?- foo(X).
```
:::
::: {.column width=.5}
![](images/foo3.png)
:::
:::

Dacă se dorește încă un răspuns, atunci se face un pas înapoi în
arborele de căutare și se încearcă satisfacerea țintei cu o nouă
valoare.

## Cum găsește Prolog răspunsul

**Exemplu.**

::: columns
::: {.column width=.5}
2 Să presupunem că avem programul:

```prolog
foo(a).
foo(b).
foo(c).
```

și că punem întrebarea:

```prolog
?- foo(X).
```
:::
::: {.column width=.5}
![arborele de căutare](images/foo4.png)
:::
:::

## Cum găsește Prolog răspunsul

**Exemplu.**

::: columns
::: {.column width=.5}
Să presupunem că avem programul:

```prolog
bar(b).
bar(c).
baz(c).
```

și că punem întrebarea:

```prolog
?- bar(X),baz(X).
```

:::
::: {.column width=.5}
![](images/bar1.png)
:::
:::

## Cum găsește Prolog răspunsul

Prolog se întoarce la ultima alegere dacă o subțintă eșuează.

**Exemplu.**

::: columns
::: {.column width=.5}
Să presupunem că avem programul:

```prolog
bar(b).
bar(c).
baz(c).
```

și că punem întrebarea:

```prolog
?- bar(X),baz(X).
```
:::
::: {.column width=.5}
![](images/bar2.png)
:::
:::

## Cum găsește Prolog răspunsul

**Exemplu.**

::: columns
::: {.column width=.5}
Să presupunem că avem programul:

```prolog
bar(b).
bar(c).
baz(c).
```

și că punem întrebarea:

```prolog
?- bar(X),baz(X).
```
:::
::: {.column width=.5}
![](images/bar3.png)
:::
:::

Soluția găsită este: `X=_4556=c`{.prolog}.

## Problema colorării hărților

Să se coloreze o hartă dată cu o mulțime de culori dată astfel încât
oricare două țări vecine să fie colorate diferit.

Cum modelăm această problemă în Prolog?

::: columns
::: {.column width=.5}
Trebuie să definim:

-   culorile

-   harta

-   constrângerile
:::
::: {.column width=.5}
![[Hartă colorată](https://www.wolfram.com/mathematica/new-in-10/entity-based-geocomputation/find-a-four-coloring-of-a-map-of-europe.html)](images/europe1.png)
:::
:::

## Problema colorării hărților

Definim culorile, harta și constrângerile.

```prolog
culoare(albastru).
culoare(rosu).
culoare(verde).
culoare(galben).

harta(RO,SE,MD,UA,BG,HU) :- vecin(RO,SE), vecin(RO,UA),
                            vecin(RO,MD), vecin(RO,BG),
                            vecin(RO,HU), vecin(UA,MD),
                            vecin(BG,SE), vecin(SE,HU).

vecin(X,Y) :- culoare(X), culoare(Y), X \== Y.
```


## Problema colorării hărților

Ce răspuns primim?

```prolog
?- harta(RO,SE,MD,UA,BG,HU).
RO = albastru,
SE = UA, UA = rosu,
MD = BG, BG = HU, HU = verde
```


#  Unificare

## Termeni (Notații)

- $x,y,z,\ldots$ pentru variabile

- $f,g,h,\ldots$ pentru simboluri de funcții arbitrare
  - _Aritatea_ lui $f$ e numărul de argumente ale simbolului $f$


- $a,b,c,\ldots$ pentru constante (simboluri de funcții fără argumente)

- $s,t,u,\ldots$ pentru termeni, formați din:
  - variabile, constante,
  - prin aplicarea de simboluri
  - de un număr finit de ori

- $Var(t)$ mulțimea variabilelor care apar în $t$

- ecuații $s\ueq t$ pentru o pereche de termeni

## Termeni (Exemple)

- $f(x,g(x,a),y)$ este un termen, unde

  - $f$ are aritate $3$,

  - $g$ are aritate $2$,

  - $a$ este o constanta

- $Var(f(x,g(x,a),y)) = \{x,y\}$


## Substituții

- Substituțiile sunt o modalitate de a înlocui variabile cu alți termeni.

- Substituțiile se aplică simultan pe toate variabilele.

__Aplicarea unei substituții – Exemplu:__

- $\Theta = \{\tcolor{x \mapsto f(x,y)}, \fcolor{y \mapsto g(a)} \}$

- $t = f(\tcolor{x},g(f(\tcolor{x},f(\fcolor{y},z))))$

- $\Theta(t) = f(\tcolor{f(x,y)},g(f(\tcolor{f(x,y)},f(\fcolor{g(a)},z))))$

## Unificare

Doi termeni $t_1$ și $t_2$ se __unifică__ dacă există valori pentru variabile,
adică o substituție $\Theta$, care egalează cei doi termeni:

$$\Theta(t_1) = \Theta(t_2)$$

În acest caz, $\Theta$ se numește __unificator__ al termenilor $t_1$ și
$t_2$.

Spunem ca un termen $t$ e __mai general__ decât un termen $t'$ dacă $t'$ se obține
din $t$ prin "specializarea" unor variabile, adică înlocuirea lor cu termeni.

- Formal, există o substituție $\Delta$ astfel încât $t' = \Delta(t)$
- De exemplu, $f(x, a, y)$ este mai general decât $f(g(y), a, h(b))$

Spunem că un unificator $\Theta$ e __mai general__ decât alt unificator $\Theta'$
dacă
există o substituție $\Delta$ astfel încât $\Theta'(x) = \Delta(\Theta(x))$
pentru orice variabilă $x$


## Unificatori (Exemplu)

-   ${\color{IntensColor} t = x + (y * y)} = +(x,*(y,y))$

-   ${\color{IntensColor} t' = x + (y * x)} = +(x,*(y,x))$

-   $\Theta = \{x \mapsto y\}$

    -   $\Theta(t) = y + (y * y)$

    -   $\Theta(t') = y + (y * y)$


-   $\Theta'= \{x \mapsto 0, y \mapsto 0\}$

    -   $\Theta'(t) = 0 + (0 * 0)$

    -   $\Theta'(t') = 0 + (0 * 0)$

    -   $\Theta' = \Theta ; \{y \mapsto 0\}$

-  $\Theta$ este mai general decât $\Theta'$ (e chiar cel mai general)


#  Un algoritm de unificare

## Algoritm de unificare – inițializare

Pentru o mulțime (finită) de ecuații $\{t_1 \ueq t'_1,\ldots, t_n \ueq t'_n\}$,
algoritmul calculează (dacă există) un unificator $\Theta$ pentru toate ecuațiile.
$$\Theta(t_1) = \Theta(t'_1), \ldots, \Theta(t_n) = \Theta(t'_n)$$

Algoritmul lucrează cu două obiecte:

  - Lista de rezolvat: $R$

  - Substituția calculată: $S$

Inițial:

  - Lista de rezolvat:
    $R = \{t_1\ueq t'_1, \ldots, t_n\ueq t'_n\}$

  -  Substituția calculată: $S = \emptyset$ – identitatea

## Algoritm de unificare – execuție

Algoritmul constă în aplicarea nedeterministă a regulilor de mai jos:

SCOATE

: o ecuație de forma $t\ueq t$ din $R$ este eliminată.

DESCOMPUNE

: o ecuație de forma
  $f(t_1,\ldots,t_n)\ueq f(t_1',\ldots,t_n')$
  din $R$ este înlocuită cu ecuațiile
  $t_1\ueq t_1', \ldots, t_n\ueq t_n'$.

REZOLVĂ

: o ecuație de forma $x\ueq t$ sau $t\ueq x$ din $R$, unde variabila
  $x$ nu apare în termenul $t$, este mutată sub forma
  $x\mapsto t$ în $S$.\
  În toți ceilalți termeni (din $R$ și $S$), $x$ este înlocuit
  cu $t$.

\HRule

EȘEC (conflict)

: există în $R$ o ecuaţie de forma\
  $f(s_1,\ldots,s_n)\ueq g(t_1,\ldots,t_m)$ cu $f \neq g$.

EȘEC (ciclu)

: există în $R$ o ecuaţie de forma\
  $x\ueq t$ sau $t\ueq x$ cu $t \neq x$ şi $x \in Var(t)$.

## Algoritm de unificare – terminare

Algoritmul se termină normal dacă $R = \emptyset$.\
În acest caz, $S$ este _cel mai general unificator_ pentru intrarea dată.

Algoritmul este oprit cu concluzia inexistenței unui unificator dacă
este folosită vreuna din regulile care produce eșec


## Algoritm de unificare - schemă

::: center
  ------------------------- ------------------------------------ -------------------------------------------------------------------------------------------------------
                               Lista soluție                                                      Lista de rezolvat
                                     S                                                                    R

     Inițial                   $\emptyset$                           $t_1\ueq t_1',\ldots, t_n\ueq t_n'$

     SCOATE                   $\ureg{S}{S}$                                          $\ureg{R', t\ueq t}{R'}$

   DESCOMPUNE                       $\ureg{S}{S}$                     $\ureg{R', f(t_1, \ldots, t_n)\ueq f(t_1', \ldots t_n')}{R', t_1\ueq t_1', \ldots t_n\ueq t_n'}$

     REZOLVĂ                   $\ureg{S}{x\mapsto t, S[x := t]}$                  $\ureg{R', x\ueq t}{R'[x := t]}$ dacă $x \not\in Var(t)$


      Final                         $S$                                    $\emptyset$
  ------------------------- ------------------------------------ -----------------------------------------------------------------------------------------------------------
:::

- $R[x := t]$: $x$ este înlocuit cu $t$ în toate ecuațiile din $R$
- $S[x := t]$: $x$ este înlocuit cu $t$ în $S(y)$ pentru orice varibilă $y$
- în regula REZOLVĂ putem avea și $t \ueq x$ în $R'$

## Exemplu: $\{g(y)\ueq x,\ f(x,h(x),y)\ueq f(g(z),w,z)\}$

::: center
   $S$                                                                                                                                    $R$                                                                                                     pas
  -------------------------------------------------------------------------------------------------------------------------------------- ----------------------------------------------------------------------------------------------------- -------------------
   $\scriptscriptstyle\emptyset$                                                                                                           $\scriptscriptstyle g(y)\ueq x,\ f(x,h(x),y)\ueq f(g(z),w,z)$                                         \tiny REZOLVĂ
   $\scriptscriptstyle{\color{IntensColor} x\mapsto g(y)}$                                                                                 $\scriptscriptstyle f({\color{IntensColor} g(y)},h({\color{IntensColor} g(y)}),y)\ueq f(g(z),w,z)$    \tiny DESCOMPUNE
   $\scriptscriptstyle x\mapsto g(y)$                                                                                                      $\scriptscriptstyle g(y)\ueq g(z),\ h(g(y))\ueq w,\ y\ueq z$                                          \tiny REZOLVĂ
   $\scriptscriptstyle{\color{IntensColor} w\mapsto h(g(y))},x\mapsto g(y)$                                                                $\scriptscriptstyle g(y)\ueq g(z),\ y\ueq z$                                                          \tiny REZOLVĂ
   $\scriptscriptstyle {\color{IntensColor} y\mapsto z}, x\mapsto g({\color{IntensColor} z}), w\mapsto h(g({\color{IntensColor} z}))$      $\scriptscriptstyle g({\color{IntensColor} z})\ueq g(z)$                                              \tiny SCOATE
   $\scriptscriptstyle y\mapsto z, x\mapsto g(z), w\mapsto h(g(z))$                                                                        $\scriptscriptstyle \emptyset$
:::
$\Theta = \{y \mapsto z,\ x \mapsto g(z),\ w \mapsto h(g(z)) \}$ este
cmgu.

## Exemplu: $\{g(y)\ueq x,\ f(x,h(y),y)\ueq f(g(z),b,z)\}$


::: center
        $S$                                                    $R$
  --------------- ------------------------------------------------------------------- ------------------------
    $\emptyset$          $g(y)\ueq x,\ f(x,h(y),y)\ueq f(g(z),b,z)$                    \tiny  DESCOMPUNE
    $\emptyset$     $g(y)\ueq x,\ x\ueq g(z),\ {\color{False}h(y)\ueq b},\ y\ueq z$    \tiny  EȘEC (conflict)
:::

-   $h$ și $b$ sunt simboluri de funcții diferite!

-   Nu există unificator pentru acești termeni.

## Exemplu: $\{g(y)\ueq x,\ f(x,h(x),y)\ueq f(y,w,z)\}$

::: center
      $S$                                                   $R$
  --------------- ----------------------------------------------------------------------------------- --------------------
   $\emptyset$     $g(y)\ueq x,\ f(x,h(x),y)\ueq f(y,w,z)$                                             \tiny DESCOMPUNE
   $\emptyset$     $g(y)\ueq x,\ x \ueq y,\ h(x) \ueq w,\ y\ueq z$                                     \tiny REZOLVĂ
   $x\mapsto y$    ${\color{False} g(y)\ueq y},\ h(y) \ueq w,\ y\ueq z$                                \tiny EȘEC (ciclu)
:::

-   În ecuația ${g(y)\ueq y}$, variabila $y$ apare în
    termenul $g(y)$.

-   Nu există unificator pentru aceste ecuații.
