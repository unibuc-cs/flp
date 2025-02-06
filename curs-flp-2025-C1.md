---
author: Traian Florin Șerbănuță și Andrei Sipoș
institute: Facultatea de Matematică și Informatică, DL Info
date: Anul II, Semestrul II, 2024/2025
title: Fundamentele limbajelor de programare
subtitle: 1. Preliminarii Matematice.
theme: CambridgeUS
---

## Mulţimi

Obiectele matematice despre care vom vorbi la acest curs vor fi
formalizate în teoria mulţimilor: aşadar, cum se întâmplă în general în
acest caz, orice obiect cu care lucrăm va fi o mulţime.

Vom presupune oarecum cunoscut modul uzual de a lucra cu mulţimi şi de
aceea vom parcurge acum sumar doar eventualele puncte care pot părea mai
subtile.

Vom încerca să justificăm cât mai multe fapte, dar, pentru demonstraţii
complete şi riguroase, facem din nou trimitere la cursul Logică
matematică", disponibil la adresa:
$$\text{\url{https://cs.unibuc.ro/~asipos/lm/}}$$


## Operaţii pe mulţimi

Conform axiomelor teoriei mulţimilor, următoarele operaţii sunt bine
definite: $$x \cap y :=\{z \in x \mid z \in y\}$$
$$x \setminus y :=\{z \in x \mid z \not\in y\}$$
$$\bigcup F := \{ z \mid \text{exist\u a $y \in F$ cu $z \in y$}\}$$
$$x \cup y:=\bigcup\{x,y\}$$
$$F \neq \emptyset \Rightarrow \bigcap F:= \left\{z \in \bigcup F \mid \text{pentru orice $x$ cu $x \in F$, avem $z \in x$}\right\}$$
$$\mathcal{P}(x) := \{z \mid  z \subseteq x\}$$

## Mulţimi Moore

### Definiţie
Fie $X$ o mulţime. Numim o mulţime $A \subseteq\mathcal{P}(X)$
**mulţime Moore** pe $X$ dacă $X \in A$, iar, pentru orice
$B \subseteq A$ nevidă, avem $\bigcap B \in A$.

### Teoremă
Fie $X$ o mulţime şi $A$ o mulţime Moore pe $X$. Atunci există
şi este unic $C \in A$, numit **minimul** lui $A$, astfel încât pentru
orice $D \in A$, avem $C\subseteq D$.

### Demonstraţie
Unicitatea rezultă imediat: dacă avem $C_1$, $C_2 \in A$ cu
acea proprietate, atunci $C_1 \subseteq C_2$ şi $C_2 \subseteq C_1$,
deci $C_1 = C_2$. Pentru existenţă, cum $X \in A$, avem
$A \neq \emptyset$, deci $\bigcap  A \in A$. Luăm $C:=\bigcap A$ şi
verificăm că are proprietatea căutată.

## Perechi ordonate

În matematică, se foloseşte deseori noţiunea de **pereche ordonată** a
lui $x$ şi $y$, notată cu $(x,y)$. Cum am spus, în universul nostru de
discurs există doar mulţimi, deci trebuie şi ca $(x,y)$ să fie tot o
mulţime. Ea trebuie să codifice" ideea de pereche ordonată, adică pentru
orice $x$, $y$ să existe $(x,y)$, iar aceasta să poată fi distinsă de
$(y,x)$, când $x\neq y$, sau în general de vreun $(a,b)$ cu $a \neq x$
sau $b \neq y$. Nu va conta ce definiţie alegem, atât timp cât va avea
proprietăţile dorite şi o vom folosi în mod consecvent.

Definiţia cea mai frecvent folosită este cea dată de Kazimierz
Kuratowski în 1921: $(x,y):=\{\{x\},\{x,y\}\}$. Putem apoi verifica:

### Proprietatea perechilor ordonate
Fie $x$, $y$, $u$, $v$ cu $(x,y)=(u,v)$. Atunci $x=u$ şi $y=v$.

## Produsul cartezian

### Propoziţie
Fie $x$, $y$, $X$, $Y$ cu $x \in X$ şi $y \in Y$. Atunci
$(x,y) \in \mathcal{P}(\mathcal{P}(X \cup Y))$.

::: block
### Demonstraţie
Trebuie să arătăm că pentru orice $z \in (x,y)$, avem
$z \in \mathcal{P}(X \cup Y)$. Fie $z \in (x,y)$. Atunci trebuie să
arătăm că pentru orice $t \in z$, $t \in X \cup Y$, adică $t \in X$ sau
$t \in Y$. Fie $t\in z$. Cum $(x,y)=\{\{x\},\{x,y\}\}$, avem $z=\{x\}$
sau $z=\{x,y\}$. Cum $t \in z$, avem $t=x$ sau $t=y$. Deci $t \in X$ sau
$t \in Y$.
:::

Ca urmare, pentru orice $X$ şi $Y$, mulţimea definită prin
$$X \times Y:= \{w \in \mathcal{P}(\mathcal{P}(X \cup Y)) \mid \text{exist\u a $x \in X$ \c si $y \in Y$ cu $w=(x,y)$}\}$$
conţine toate perechile ordonate de elemente din $X$ cu elemente din
$Y$. O numim **produsul cartezian** al lui $X$ şi $Y$.

## Relaţii binare

### Propoziţie-Definiţie
Fie $R$ o mulţime. Următoarele afirmaţii sunt
echivalente:

-   există $A$ şi $B$ astfel încât $R \subseteq A \times B$;

-   elementele lui $R$ sunt perechi ordonate, adică pentru orice
    $z \in R$ există $x$, $y$ cu $z=(x,y)$.

În acest caz, $R$ se numeşte **relaţie (binară)**, iar dacă $A$ şi $B$
sunt ca mai sus, spunem că $R$ este o relaţie **între** $A$ şi $B$. Dacă
$A$ este astfel încât $R$ este între $A$ şi $A$, spunem că $R$ este o
relaţie **pe** $A$.

::: block
### Demonstraţie
Implicaţia $\Rightarrow$" este evidentă. Pentru implicaţia
$\Leftarrow$", notăm mulţimea $\bigcup \bigcup R$ atât cu $A$, cât şi cu
$B$. Fie $z \in R$. Atunci există $x$, $y$ cu
$z=\{\{x\},\{x,y\}\} \in R$. Aşadar, $\{x\}$, $\{x,y\} \in \bigcup R$ şi
deci $x$, $y \in \bigcup \bigcup R$. Ca urmare,
$(x,y) \in \bigcup \bigcup R \times \bigcup \bigcup R = A \times B$.
:::

Observăm şi că $A$ şi $B$ **nu sunt unice** cu acea proprietate! De
exemplu, $\emptyset$ este o relaţie pe $\emptyset$, dar şi pe
$\{\emptyset\}$.

## Grafice şi funcţii

### Definiţie
Dacă $A$ este o mulţime, notăm cu $\Delta_A$ şi denumim
**relaţia diagonală** pe $A$ acea relaţie pe $A$ definită prin
$$\{p \in A \times A \mid \text{exist\u a $a$ cu $p=(a,a)$}\}.$$

### Definiţie
Fie $A$, $B$ mulţimi şi $R$ o relaţie între $A$ şi $B$. Spunem
că $R$ este **grafic** între $A$ şi $B$ dacă pentru orice $a \in A$
există şi este unic $b \in B$ astfel încât $(a,b) \in R$.

### Definiţie
Fie $A$, $B$ mulţimi. Spunem că $f$ este **funcţie între $A$
şi $B$** (şi notăm acest fapt cu $f: A \to B$) dacă există $R$, un
grafic între $A$ şi $B$, astfel încât $f=(A,B,R)$. $A$ se numeşte
**domeniul** lui $f$, $B$ **codomeniul** lui $f$, iar $R$ **graficul**
lui $f$. Pentru orice $a \in A$ vom nota cu $f(a)$ acel unic $b \in B$
cu $(a,b) \in R$.

## Detalii de codificare

Un grafic şi o funcţie sunt mulţimi, dar ele nu sunt aceeaşi mulţime!
Avem nevoie de includerea codomeniului în codificarea" noţiunii de
funcţie pentru a putea mai târziu formaliza corect surjectivitatea.

### Propoziţie
Fie $R$ o relaţie binară. Următoarele afirmaţii sunt
echivalente:

-   există $A$ şi $B$ astfel încât $R$ este grafic între $A$ şi $B$;

-   pentru orice $x$, $y$, $z$ cu $(x,y)$, $(x,z) \in R$, avem $y=z$.

::: block
### Propoziţie
Fie $R$ o relaţie binară şi $A$, $B$, $C$, $D$ astfel încât
$R$ este grafic atât între $A$ şi $B$, cât şi între $C$ şi $D$. Atunci
$A=C$.
:::

Aceste două propoziţii (lăsate ca exerciţiu) ne arată că domeniul unei
funcţii este complet determinat de grafic (şi îl putem numi **domeniul
graficului**), ca urmare el ar fi putut să nu fie inclus în modul de
definiţie. El este inclus, totuşi, prin tradiţie.

## Notaţii despre funcţii

Pentru orice mulţime $A$, avem că $(A,A,\Delta_A)$ este funcţie. O numim
**funcţia identică pe $A$** sau **funcţia identitate pe $A$** şi o notăm
cu $\mathrm{id}_A$.

Observăm că dacă $A$, $B$ sunt mulţimi, iar $f: A \to B$, atunci
$f \in (\{A\} \times \{B\}) \times \mathcal{P}(A \times B)$, ca urmare
putem defini mulţimea tuturor funcţiilor de la $A$ la $B$, notată cu
$B^A$, prin
$$\{f \in (\{A\} \times \{B\}) \times \mathcal{P}(A \times B) \mid \text{$f$ func\c tie}\}.$$

## Imagini

::: block
### Definiţie
Fie $A$, $B$ şi $f: A \to B$. Fie $X \subseteq A$ şi
$Y \subseteq B$. Atunci:

-   notăm cu $f_*(X)$ şi numim **imaginea directă** a lui $X$ prin $f$
    mulţimea
    $$\{y \in B \mid \text{exist\u a $x \in X$ cu $f(x)=y$}\};$$

-   notăm cu $f^*(Y)$ şi numim **imaginea inversă** a lui $Y$ prin $f$
    mulţimea $$\{x \in A \mid f(x)\in Y\};$$

-   notăm cu $\mathrm{Im}f$ şi numim **imaginea** lui $f$ mulţimea
    $f_*(A)$.
:::

Mai definim **imaginea** unui grafic ca fiind imaginea unei funcţii care
îl are ca grafic. Ştim din cele anterioare că există o asemenea funcţie
şi putem arăta că imaginea nu depinde de funcţia aleasă.

## Proprietăţi ale funcţiilor

### Definiţie
Fie $A$, $B$ şi $f: A \to B$. Spunem că:

-   $f$ este **injectivă** sau **injecţie** dacă pentru orice $x$,
    $y \in A$ cu $x\neq y$, avem $f(x) \neq f(y)$;

-   $f$ este **surjectivă** sau **surjecţie** dacă $\mathrm{Im}f=B$, mai
    exact dacă pentru orice $y \in B$ există $x \in A$ cu $f(x) = y$;

-   $f$ este **bijectivă** sau **bijecţie** dacă este injectivă şi
    surjectivă.

## Compunerea şi restricţia funcţiilor

### Definiţie
Fie $A$, $B$, $C$ şi $f: A \to B$, $g: B \to C$. Definim
funcţia $g \circ f : A \to C$ (citim $g$ compus cu $f$"; ea se notează
uneori cu $f;g$, caz în care citim $f$ succedat de $g$"), pentru orice
$x \in A$, prin $$(g\circ f)(x):=g(f(x)).$$

### Proprietăţi elementare
Fie $A$, $B$, $C$, $D$ şi $f: A \to B$,
$g: B \to C$, $h: C \to D$. Atunci:

-   $(h \circ g) \circ f = h \circ (g \circ f)$;

-   $f \circ \mathrm{id}_A = f$; $\mathrm{id}_B \circ f = f$.

### Definiţie
Fie $A$, $B$, $f: A \to B$ şi $X \subseteq A$. Definim funcţia
$f_{\mid X}: X \to B$ (citim $f$ restricţionat la $X$"), pentru orice
$x \in X$, prin $f_{\mid X}(x):=f(x)$.

## Funcţii inversabile

::: block
### Definiţie
Fie $A$, $B$, $f: A \to B$. Dacă $g:B \to A$,
$g\circ f=\mathrm{id}_A$ şi $f\circ g=\mathrm{id}_B$, spunem că $f$ este
**inversabilă** iar $g$ este **inversa** sa.
:::

O inversă, dacă există, este unică. Mai exact, dacă avem $A$, $B$,
$f: A \to B$, iar $g_1$, $g_2:B \to A$ sunt inverse ale lui $f$, atunci
$g_1=g_2$, iar aceasta se poate demonstra doar folosind proprietăţile
elementare ale compunerii:
$$g_1 = g_1 \circ \mathrm{id}_B = g_1 \circ (f \circ g_2) = (g_1 \circ f) \circ g_2 = \mathrm{id}_A \circ g_2 = g_2.$$

Următorul rezultat se demonstrează uşor:

### Propoziţie
O funcţie este inversabilă dacă şi numai dacă este bijectivă.

## Comportamentul mulţimii vide faţă de funcţii

Fie $A$ o mulţime. Se pune întrebarea: există $f: \emptyset \to A$? Dacă
da, cum arată? Presupunem că ar exista o asemenea $f$. Atunci există $R$
cu $f=(\emptyset,A,R)$ şi $R\subseteq \emptyset \times A = \emptyset$,
deci $R=\emptyset$ şi $f=(\emptyset,A,\emptyset)$. Aceasta este
într-adevăr o funcţie. Ca urmare, există o unică funcţie de la
$\emptyset$ la $A$, anume $(\emptyset,A,\emptyset)$, pe care o numim
**funcţia vidă a lui $A$**. Aşadar, avem că $A^\emptyset=A^0$ este un
singleton (o mulţime cu un singur element). Spunem că $\emptyset$ este
**mulţimea iniţială**.

Dar invers? Există o funcţie $g: A \to \emptyset$? Dacă $A$ este nevidă,
atunci există $a \in A$, şi deci $g(a) \in \emptyset$, o contradicţie,
dat fiind că nu există $b \in \emptyset$. Ca urmare, funcţia există doar
când $A=\emptyset$, şi atunci $g=(\emptyset,\emptyset,\emptyset)$ (caz
particular al celui din paragraful precedent).

## Comportamentul singleton-urilor faţă de funcţii

Fixăm $X$ un singleton (repetăm, o mulţime cu un singur element) -- de
exemplu, putem lua $X:=1=\{\emptyset\}$, dar alegerea precisă a lui $X$
nu va conta.

Fie $A$ o mulţime. Atunci există o unică funcţie de la $A$ la $X$, anume
cea care duce orice element din $A$ în unicul element al lui $X$. De
aceea, spunem că orice singleton este **mulţime terminală** (noţiune
**duală** celei de mulţime iniţială).

Vrem acum, invers, să găsim toate funcţiile de la $X$ la $A$. Pentru a
găsi o asemenea funcţie, trebuie doar să selectăm elementul din $A$ în
care va fi dus acel unic element al lui $X$. Aşadar, funcţiile de la $X$
la $A$ sunt în corespondenţă biunivocă cu elementele lui $A$. Deseori,
în acest curs, vom **identifica tacit** $A^X$ cu $A$ (indiferent care
este precis singleton-ul $X$; de pildă, vom identifica $A^1$ cu $A$).

## Familii

Fie $I$ o mulţime. Numim **familie indexată după $I$** un grafic al
cărui domeniu este $I$. Dacă $F$ este o familie indexată după $I$, vom
nota, pentru orice $i \in I$, acea unică mulţime $x$ pentru care
$(i,x) \in F$ cu $F_i$. De asemenea, vom mai scrie $(F_i)_{i \in I}$ în
loc de $F$.

Definim **reuniunea** şi **intersecţia**, ca familie, ale lui $F$ --
notate cu $\bigcup_{i \in I} F_i$, respectiv cu $\bigcap_{i \in I} F_i$
-- ca fiind reuniunea, respectiv intersecţia (ultima doar în cazul în
care $I \neq \emptyset$) a imaginii ca grafic a lui $F$.

Mai definim **produsul cartezian** al lui $F$, notat cu
$\prod_{i \in I} F_i$, ca fiind mulţimea tuturor familiilor $f$ indexate
după $I$ cu proprietatea că pentru orice $i \in I$, $f_i \in F_i$.
Această mulţime există deoarece orice asemenea $f$ este element al lui
$$\mathcal{P}\left(I \times \bigcup_{i \in I} F_i\right).$$



## Tipuri de relaţii binare pe o mulţime

### Definiţie
Fie $A$ o mulţime şi $R$ o relaţie pe $A$. Pentru orice $x$,
$y \in A$, vom scrie $xRy$ în loc de $(x,y) \in R$. Spunem că $R$ este:

reflexivă
  ~ dacă pentru orice $x \in A$, $xRx$;

simetrică
  ~ dacă pentru orice $x$, $y \in A$ cu $xRy$, avem $yRx$;

tranzitivă
  ~ dacă pentru orice $x$, $y$, $z \in A$ cu $xRy$ şi $yRz$, avem $xRz$;

de echivalenţă
  ~ dacă este reflexivă, simetrică şi tranzitivă;

totală
  ~ dacă pentru orice $x$, $y \in A$, avem $xRy$ sau $yRx$;

antisimetrică
  ~ dacă pentru orice $x$, $y \in A$ cu $xRy$ şi $yRx$ avem $x=y$;

de ordine parţială
  ~ (de obicei ele sunt notate cu $\leq$) dacă
    este reflexivă, antisimetrică şi tranzitivă;

ireflexivă
  ~ dacă pentru orice $x \in A$, nu avem $xRx$;

asimetrică
  ~ dacă pentru orice $x$, $y \in A$ cu $xRy$, nu avem $yRx$.

## Tipuri de date abstracte, inductive

Până acum s-a mai lucrat cu diverse formalizări ale unor tipuri de date
inductive. De exemplu, în Haskell defineam asemenea tipuri cu o sintaxă
specifică (cu constructori). De asemenea, la cursul Logică matematică şi
computaţională" s-au introdus, printre altele, formulele logicii
propoziţionale într-un mod inductiv, într-un fel care semăna cu
următorul:

-   orice variabilă este o formulă;

-   dacă $\varphi$ este formulă, atunci $\neg\varphi$ este formulă;

-   dacă $\varphi$ şi $\psi$ sunt formule, atunci $\varphi\to\psi$ este
    formulă;

-   doar expresiile obţinute prin aplicări ale acestor reguli sunt
    formule.

Dat fiind că vom lucra cu multe asemenea definiţii în cadrul acestui
curs, vom explora în continuare cum pot fi făcute riguroase
raţionamentele cu asemenea tipuri, pentru a nu mai intra în detalii la
momentul respectiv.

## Formule

Formulele sunt expresii peste mulţimea dată de simboluri (variabile şi
conectori, toate diferite), iar proprietăţile pe care o mulţime $A$ de
expresii trebuie să le verifice pentru ca ea să fie mulţime de formule
vor fi:

-   $V \subseteq A$ (adică variabilele sunt" formule);

-   dacă $\varphi\in A$, atunci $\neg\varphi\in A$;

-   dacă $\varphi$, $\psi \in A$, atunci $\to\varphi\psi \in A$.

Submulţimile mulţimii expresiilor care verifică aceste proprietăţi
formează o mulţime Moore. Aşadar, putem lua minimul ei, pe care îl notăm
cu $Form$. Numim elementele acestei mulţimi **formule** sau
**enunţuri**.

Observăm că am folosit forma **prefixată** a formulelor pentru a le
defini -- am scris $\to\varphi\psi$ în loc de $\varphi\to\psi$ --
deoarece ne va fi mai comod la unele demonstraţii. În scurt timp, vom
oferi un mod prin care vom putea folosi în discursul nostru forma
obişnuită, i.e. **infixată**.

## Principiul inducţiei pe formule

Următoarea teoremă reprezintă o formă de inducţie **structurală** pe
mulţimea formulelor.

::: block
### Principiul inducţiei pe formule
Fie $B \subseteq Form$ astfel încât:

-   $V \subseteq B$;

-   dacă $\varphi\in B$, atunci $\neg\varphi\in B$;

-   dacă $\varphi$, $\psi \in B$, atunci $\to\varphi\psi \in B$.

Atunci $B=Form$.
:::

Enunţul rezultă imediat din faptul că $B$ este una din mulţimile ce
participă la intersecţia prin care a fost definit $Form$.

## Citirea formulelor

### Proprietatea de citire
Fie $\chi \in Form$. Atunci se întâmplă exact una
dintre următoarele alternative:

-   $\chi \in V$;

-   există $\varphi\in Form$ cu $\chi=\neg\varphi$;

-   există $\varphi$, $\psi \in Form$ cu $\chi=\to\varphi\psi$.

### Demonstraţie
Notăm cu $B$ mulţimea formulelor ce se pot scrie sub acele
forme. Atunci, clar, $B$ verifică condiţiile Principiului de inducţie
şi, deci, $B=Form$. Faptul că se întâmplă cel mult una dintre
alternative rezultă din faptul că am fixat simbolurile ca fiind
diferite.

## Despre segmente iniţiale

### Lemă
Fie $\chi \in Form$. Atunci nu există $\alpha \in Form$ care să fie
segment iniţial strict al lui $\chi$.

### Demonstraţie
Demonstrăm prin inducţie, dar nu structurală, ci inducţie
completă pe numere după lungimea lui $\chi$. Presupunem că există
$\alpha$ ca în enunţ. Din proprietatea de citire, distingem trei cazuri.
Tratăm doar cazul când există $\varphi$, $\psi$ cu
$\chi=\to\varphi\psi$. Atunci, fie $\alpha$ este vid, ceea ce nu se
poate, fie există $\varphi'$, $\psi'$ cu $\alpha=\to\varphi'\psi'$. Dacă
$\varphi$ şi $\varphi'$ ar avea lungimi diferite, atunci unul ar fi
segment iniţial strict al celuilalt, contradicţie cu ipoteza de
inducţie. Aşadar, $\varphi=\varphi'$ şi deci $\psi$ şi $\psi'$ au
lungimi diferite, de unde rezultă din nou o contradicţie cu ipoteza de
inducţie.

## Citirea unică a formulelor

### Proprietatea de citire unică
Fie $\varphi$, $\psi$, $\varphi'$,
$\psi' \in Form$ cu $\to\varphi\psi=\to\varphi'\psi'$. Atunci
$\varphi=\varphi'$ şi $\psi=\psi'$.

### Demonstraţie
Dacă $\varphi$ şi $\varphi'$ ar avea lungimi diferite,
atunci unul ar fi segment iniţial strict al celuilalt, contradicţie.
Rezultă că $\varphi$ şi $\varphi'$ au aceeaşi lungime. Dar de aici
rezultă imediat concluzia dorită.

## Scrierea infixată

Pentru a putea folosi, după cum am anunţat, o notaţie infixată, definim
pe $Form$ operaţia $\to: Form^2 \to Form$, pentru orice $\varphi$,
$\psi \in Form$, prin $$\varphi\to\psi:=\ \to\varphi\psi.$$ Atenţie:
$\to$ reprezintă obiecte complet diferite în stânga şi în dreapta
respectivei ecuaţii -- anume, în stânga este vorba de operaţia pe care o
definim acum, iar în dreapta este vorba de simbolul fixat mai devreme.
Ele sunt, însă, utilizate în contexte destul de asemănătoare cât să
folosim acelaşi semn grafic.

## Principiul recursiei pe formule

### Principiul recursiei pe formule
Fie $A$ o mulţime şi $G_0:V\to A$,
$G_\neg: A \to A$, $G_\to:A^2\to A$. Atunci există şi este unică
$F:Form\to A$ astfel încât:

-   pentru orice $v\in V$, $F(v)=G_0(v)$;

-   pentru orice $\varphi\in Form$, $F(\neg\varphi)=G_\neg(F(\varphi))$;

-   pentru orice $\varphi$, $\psi \in Form$,
    $F(\varphi\to \psi)=G_\to(F(\varphi),F(\psi))$.

## Principiul recursiei pe formule

### Demonstraţie
Unicitatea rezultă imediat prin inducţie structurală
(exerciţiu!). Pentru existenţă, vom construi $S \subseteq Form \times A$
astfel încât să verifice:

-   pentru orice $v\in V$, $(v,G_0(v)) \in S$;

-   pentru orice $\varphi\in Form$ şi $a\in A$ cu $(\varphi,a) \in S$,
    avem $(\neg\varphi, G_\neg(a)) \in S$;

-   pentru orice $\varphi$, $\psi \in Form$ şi $a$, $b\in A$ cu
    $(\varphi,a) \in S$ şi $(\psi, b) \in S$, avem
    $(\varphi\to\psi, G_\to(a,b)) \in S$,

şi să fie cea mai mică cu aceste proprietăţi -- ca mai înainte, o
construim luând intersecţia, la care participă $Form \times A$, a
tuturor submulţimilor ce verifică proprietăţile.

Rămâne de arătat că $S$ este grafic între $Form$ şi $A$ -- atunci, clar,
$F:=(Form,A,S)$ va fi funcţia căutată.

## Principiul recursiei pe formule

### Demonstraţie (cont.)
Trebuie să arătăm că, pentru orice
$\varphi\in Form$, există şi este unic $a \in A$ cu $(\varphi,a)\in S$.
Existenţa rezultă prin inducţie structurală (exerciţiu!), astfel că vom
demonstra în continuare unicitatea.

Fie $B$ mulţimea acelor $\varphi\in Form$ cu proprietatea că există şi
este unic $a \in A$ cu $(\varphi,a)\in S$. Presupunem prin absurd că
$B\neq Form$. Atunci, din contrapusa principiului de inducţie pe
formule, avem că fie $V\not\subseteq B$, fie există $\varphi_0 \in B$ cu
$\neg\varphi_0 \not\in B$, fie există $\varphi_0$, $\psi_0 \in B$ cu
$\varphi_0 \to \psi_0 \not\in B$. Ultimul caz este cel mai complex şi de
aceea îl vom demonstra doar pe acela, primele două rămânând ca
exerciţiu.

Presupunem, deci, că avem $\varphi_0$, $\psi_0 \in B$ cu
$\varphi_0 \to \psi_0 \not\in B$. Cum $\varphi_0$, $\psi_0 \in B$,
există şi sunt unice $a_0$, $b_0$ cu $(\varphi_0,a_0)\in S$ şi
$(\psi_0,b_0) \in S$, deci avem
$(\varphi_0\to\psi_0,G_\to(a_0,b_0)) \in S$. Cum
$\varphi_0 \to \psi_0 \not\in B$, există $q\neq G_\to(a_0,b_0)$ cu
$(\varphi_0 \to \psi_0,q)\in S$.

## Principiul recursiei pe formule

### Demonstraţie (cont.)
Iau $T:=S \setminus \{(\varphi_0 \to \psi_0,q)\}$.
Vom arăta că $T$ verifică cele trei proprietăţi, ceea ce va contrazice
faptul că $S$ este cea mai mică asemenea mulţime.

Fie $v \in V$. Atunci $(v,G_0(v)) \in S$, iar cum
$(v,G_0(v)) \neq (\varphi_0 \to \psi_0,q)$, avem $(v,G_0(v)) \in T$. Cea
de-a doua proprietate se arată analog.

Pentru a treia, fie $\varphi$, $\psi \in Form$ şi $a$, $b\in A$ cu
$(\varphi,a) \in T$ şi $(\psi, b) \in T$. Vrem
$(\varphi\to\psi, G_\to(a,b)) \in T$.

Cum $(\varphi,a) \in S$ şi $(\psi, b) \in S$, avem
$(\varphi\to\psi, G_\to(a,b)) \in S$. Dacă
$(\varphi\to\psi, G_\to(a,b)) \not\in T$, înseamnă că
$(\varphi\to\psi, G_\to(a,b))=(\varphi_0 \to \psi_0,q)$, deci
$\varphi\to\psi=\varphi_0 \to \psi_0$ şi $G_\to(a,b)=q$.

## Principiul recursiei pe formule

### Demonstraţie (cont.)
Cum $\varphi\to\psi=\varphi_0 \to \psi_0$, din
Proprietatea de citire unică avem $\varphi=\varphi_0$ şi $\psi=\psi_0$.
Cum $\varphi=\varphi_0$, $(\varphi_0,a)=(\varphi,a)\in S$. Dar cum
$(\varphi_0,a_0) \in S$ şi $\varphi_0 \in B$, avem $a=a_0$. Analog,
$b=b_0$. Deci $q=G_\to(a,b)= G_\to(a_0,b_0)$, contradicţie cu
presupunerea iniţială $q\neq G_\to(a_0,b_0)$.

Demonstraţia este acum încheiată.

## Aplicaţie: mulţimea variabilelor

::: block
### Corolar
Există şi este unică $Var:Form\to \mathcal{P}(V)$ astfel încât:

-   pentru orice $v\in V$, $Var(v)=\{v\}$;

-   pentru orice $\varphi\in Form$, $Var(\neg\varphi)=Var(\varphi)$;

-   pentru orice $\varphi$, $\psi \in  Form$,
    $Var(\varphi\to \psi)=Var(\varphi) \cup Var(\psi)$.
:::

De exemplu,

$Var(\neg v_0 \to v_1) = Var(\neg v_0) \cup Var(v_1) =$

$Var(v_0)  \cup Var(v_1) = \{v_0\} \cup \{v_1\} = \{v_0,v_1\}$.
