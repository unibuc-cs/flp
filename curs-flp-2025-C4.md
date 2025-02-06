---
author: Traian Florin Șerbănuță și Andrei Sipoș
institute: Facultatea de Matematică și Informatică, DL Info
date: Anul II, Semestrul II, 2024/2025
title: Fundamentele limbajelor de programare
subtitle: 3. Semantică Axiomatică. Logica Hoare. Cea mai slabă precondiție.
theme: CambridgeUS
---

## Logica Hoare

Reamintim din Introducerea istorică faptul că Hoare a introdus reguli de
a raţiona cu enunţuri de forma $$\{A\}c\{B\},$$ însemnând faptul că un
program $c$, care satisface la începutul rulării sale proprietatea $A$,
va satisface la sfârşit proprietatea $B$. Aceste reguli oferă o
**semantică axiomatică** pentru un limbaj imperativ, care este numită
**logică Hoare**, şi care are rolul de a formaliza adecvat procesul
**verificării programelor**.

Pentru a o defini, va trebui să extindem conceptele introduse anterior
de expresie aritmetică şi expresie booleană.

## Expresii aritmetice extinse

Fixăm o mulţime $V$, ale cărei elemente vor fi numite **variabile
logice**, care vor avea oarecum acelaşi rol ca variabilele din logica de
ordinul I (altul decât cel al variabilelor din IMP, numite şi
**variabile de program**, care reprezentau locuri în memorie, ca în
limbajele imperative uzuale).

O **expresie aritmetică extinsă** va avea exact una dintre următoarele
forme:

-   un număr întreg $n$;

-   o variabilă de program $X$ (element al lui $L$);

-   o variabilă logică $x$ (element al lui $V$);

-   $a_0+a_1$, $a_0-a_1$, $a_0*a_1$, unde $a_0$ şi $a_1$ sunt expresii
    aritmetice extinse.

## Expresii booleene extinse (aserţiuni)

O **expresie booleană extinsă**, numită şi **aserţiune**, va avea exact
una dintre următoarele forme:

-   o valoare booleană (**true** sau **false**);

-   $a_0=a_1$, $a_0 \leq a_1$, unde $a_0$ şi $a_1$ sunt expresii
    aritmetice extinse;

-   $\neg A_0$, $A_0 \land A_1$, $A_0 \lor A_1$, unde $A_0$ şi $A_1$
    sunt aserţiuni;

-   $\forall x A$, unde $x \in V$ şi $A$ este o aserţiune.

Considerăm cunoscută prescurtarea $A \to B$ pentru $(\neg A) \lor B$.

## Substituţia

Putem defini în modul absolut natural substituţiile de forma $A[x:=a]$
sau $A[X:=a]$, unde $A$ este o aserţiune, $X \in L$, $x \in V$, iar $a$
este o expresie aritmetică -- nu extinsă: de aceea, nu trebuie să ne
preocupăm de redenumiri de variabile logice (cum o facem la logica de
ordinul I). Enunţăm doar clauza:
$$(\forall z A)[x:=a] := \begin{cases} \forall z A, & \mbox{dac\u a } z=x, \\
\forall z (A[x:=a]), & \mbox{altfel}.\end{cases}$$

## Evaluarea expresiilor aritmetice extinse

Vom numi **interpretare** o funcţie de la $V$ la $\mathbb{Z}$. Pentru
orice $\sigma \in \Sigma$ şi orice interpretare $I : V \to \mathbb{Z}$,
definim o funcţie $|\cdot|^I_\sigma$ care evaluează expresii aritmetice
extinse în numere întregi, în mod recursiv, în felul următor:

-   pentru orice $N \in \mathbb{Z}$, $|N|^I_\sigma:=N$;
-   pentru orice $X \in L$, $|X|^I_\sigma:=\sigma(X)$;
-   pentru orice $x \in V$, $|x|^I_\sigma:=I(x)$;
-   pentru orice expresii aritmetice extinse $a_0$, $a_1$, avem\
    $|a_0+a_1|^I_\sigma:=|a_0|^I_\sigma+|a_1|^I_\sigma$,\
    $|a_0-a_1|^I_\sigma:=|a_0|^I_\sigma-|a_1|^I_\sigma$,\
    $|a_0*a_1|^I_\sigma:=|a_0|^I_\sigma*|a_1|^I_\sigma$.

Avem că, pentru orice expresie aritmetică $a$,
$|a|^I_\sigma=e_\sigma(a)=\llbracket a \rrbracket (\sigma)$.

Analog cu cele anterioare, pentru orice $I : V \to \mathbb{Z}$,
$x \in V$ şi $N \in \mathbb{Z}$, definim interpretarea
$I_{x \mapsto N}$, pentru orice $y \in V$, prin:
$$I_{x \mapsto N}(y) := \begin{cases} N, & \mbox{dac\u a } y=x, \\
I(y), & \mbox{altfel}.\end{cases}$$

## Evaluarea aserţiunilor

Definim acum, pentru $\sigma \in \Sigma$, $I : V \to \mathbb{Z}$ şi $A$
aserţiune, relaţia $\sigma \models^I A$, în mod recursiv, în felul
următor:

-   $\sigma \models^I \textbf{true}$,
    $\sigma \not\models^I \textbf{false}$;
-   pentru orice expresii aritmetice extinse $a_0$, $a_1$, avem\
    $\sigma \models^I a_0=a_1$ dacă şi numai dacă
    $|a_0|^I_\sigma=|a_1|^I_\sigma$,\
    $\sigma \models^I a_0\leq a_1$ dacă şi numai dacă
    $|a_0|^I_\sigma\leq|a_1|^I_\sigma$;
-   pentru orice aserţiuni $A_0$, $A_1$, avem\
    $\sigma \models^I \neg A_0$ dacă şi numai dacă
    $\sigma \not\models^I  A_0$,\
    $\sigma \models^I A_0 \land A_1$ dacă şi numai dacă
    $\sigma \models^I  A_0$ şi $\sigma \models^I  A_1$,\
    $\sigma \models^I A_0 \lor A_1$ dacă şi numai dacă
    $\sigma \models^I  A_0$ sau $\sigma \models^I  A_1$;
-   pentru orice $x \in V$ şi orice aserţiune $A$, avem\
    $\sigma \models^I \forall x A$ dacă şi numai dacă, pentru orice
    $N \in \mathbb{Z}$, $\sigma \models^{I_{x \mapsto N}}  A$.

Avem că, pentru orice expresie booleană $b$, $\sigma \models^I b$ dacă
şi numai dacă $e_\sigma(b)=\llbracket b \rrbracket (\sigma)=1$. Notăm cu
$\models A$ faptul că, pentru orice $\sigma$ şi $I$,
$\sigma \models^I A$. Notăm şi
$A^I:=\{\sigma \in \Sigma \mid \sigma \models^I A\}$.

## Enunţuri Hoare şi semantica lor

Vom numi **enunţ Hoare** o expresie de forma $\{A\}c\{B\}$, unde $A$ şi
$B$ sunt aserţiuni, iar $c$ este o instrucţiune. Vom defini semantica
acestora în felul următor:

-   pentru orice $\sigma$ şi $I$, $\sigma \models^I \{A\}c\{B\}$ dacă
    $\sigma \models^I A$ implică faptul că, pentru orice $\sigma'$ cu
    $(\sigma,\sigma') \in \llbracket c \rrbracket$,
    $\sigma' \models^I B$;

-   pentru orice $I$, $\models^I \{A\}c\{B\}$ dacă, pentru orice
    $\sigma$, $\sigma \models^I \{A\}c\{B\}$, sau, echivalent, pentru
    orice $(\sigma,\sigma') \in \llbracket c \rrbracket$,
    $\sigma \models^I A$ implică $\sigma' \models^I B$;

-   $\models \{A\}c\{B\}$ dacă, pentru orice $I$,
    $\models^I \{A\}c\{B\}$.

Prezentăm în continuare regulile de deducţie pentru aceste enunţuri
Hoare.

## Regulile de deducţie Hoare

$$\begin{aligned}
\frac{}{\{A\}\textbf{skip}\{A\}} \qquad & \frac{}{\{B[X:=a]\}X:=a\{B\}}\\[1em]
\frac{\{A\}c_0\{C\}\quad  \{C\}c_1\{B\}}{ \{A\}c_0;c_1\{B\}} \qquad & \frac{\{A \land b\}c_0\{B\}\quad  \{A \land\neg b\}c_1\{B\}}{ \{A\}\textbf{if $b$ then $c_0$ else $c_1$}\{B\}}\\[1em]
\frac{\{A \land b\}c\{A\}}{ \{A\}\textbf{while $b$ do $c$}\{A \land\neg b\}} \qquad & \frac{\models A \to A' \quad  \{A'\}c\{B'\} \quad \models B' \to B}{ \{A\}c\{B\}}
\end{aligned}$$

Notăm faptul că o aserţiune $\{A\}c\{B\}$ poate fi dedusă prin aceste
reguli cu $\vdash \{A\}c\{B\}$. Observăm şi că ultima regulă, numită
**regula consecinţei**, este de fapt o **pseudo-regulă**, având în
vedere că nu este decidabil dacă o aplicare a ei este corectă (de ce?).

## Un exemplu concret

### Lemă
Fie $X \in L$, $a$ o expresie aritmetică şi $A$ o aserţiune cu
proprietatea că $X$ nu apare nici în $a$, nici în $A$. Atunci
$$\vdash\{A\}X:=a\{A \land X=a\}.$$

::: block
### Demonstraţie
Din regula pentru atribuire,
$\vdash\{A \land a=a\}X:=a\{A \land X=a\}$. Cum
$\models A \to A \land a=a$, din regula consecinţei obţinem concluzia.
:::

Fixăm $N$, $S$, $I \in L$ (distincte două câte două) şi
$n \in \mathbb{N}$ şi considerăm programul $p$, definit ca:
$$((N:=n; S:=0); I:=0); (\textbf{while $I \leq N$ do $(S:= S+I; I:=I+1)$}).$$
Vom arăta că $\vdash \{\textbf{true}\}p\{2*S=n*(n+1)\}$. Vom nota blocul
**while** din $p$ cu $w$.

## Un exemplu concret

Din lemă, avem
$\vdash \{\textbf{true}\}N:=n\{\textbf{true} \land N=n\}$, deci, din
regula consecinţei, $\vdash \{\textbf{true}\}N:=n\{N=n\}$. Tot din lemă,
avem $\vdash \{N=n\}S:=0\{N=n \land S=0\}$. Din regula pentru
secvenţiere, avem
$\vdash \{\textbf{true}\} N:=n; S:=0 \{N=n \land S=0\}$. Similar,
obţinem apoi
$\vdash \{\textbf{true}\} (N:=n; S:=0); I:=0 \{N=n \land S=0 \land I=0\}$.

Din regula pentru atribuire, avem $$\begin{aligned}
\vdash\ &\{2*(S+I)+2*(I+1)=(I+1)*(I+2) \land I+1 \leq N+1 \land N=n\}\\
 &S:=S+I\\
 &\{2*S+2*(I+1) = (I+1)*(I+2) \land I+1 \leq N+1 \land N=n\},
\end{aligned}$$ iar din regula consecinţei, scoatem $$\begin{aligned}
\vdash\ &\{2*S+2*I=I*(I+1) \land I \leq N \land N=n\}\\
 &S:=S+I\\
 &\{2*S+2*(I+1) = (I+1)*(I+2) \land I+1 \leq N+1 \land N=n\}.
\end{aligned}$$

## Un exemplu concret

Tot din regula pentru atribuire, obţinem $$\begin{aligned}
\vdash\ &\{2*S+2*(I+1) = (I+1)*(I+2) \land I+1 \leq N+1 \land N=n\}\\
 &I:=I+1\\
 &\{2*S+2*I=I*(I+1) \land I \leq N+1 \land N=n\}.
\end{aligned}$$

Din regula pentru secvenţiere, avem $$\begin{aligned}
\vdash\ &\{2*S+2*I=I*(I+1) \land I \leq N \land N=n\}\qquad\qquad\qquad\qquad\\
 &S:=S+I; I:=I+1\\
 &\{2*S+2*I=I*(I+1) \land I \leq N+1 \land N=n\}.
\end{aligned}$$

Din regula consecinţei, obţinem $$\begin{aligned}
\vdash\ &\{2*S+2*I=I*(I+1) \land I \leq N+1 \land N=n \land I\leq N\}\qquad\\
 &S:=S+I; I:=I+1\\
 &\{2*S+2*I=I*(I+1) \land I \leq N+1 \land N=n\}.
\end{aligned}$$

## Un exemplu concret

Aplicând regula pentru **while**, avem: $$\begin{aligned}
\vdash\ &\{2*S+2*I=I*(I+1) \land I \leq N+1 \land N=n \}\\
 &\textbf{while $I \leq N$ do $(S:= S+I; I:=I+1)$}\\
 &\{2*S+2*I=I*(I+1) \land I \leq N+1 \land N=n \land \neg(I \leq N)\}.
\end{aligned}$$

Din regula consecinţei, scoatem
$$\vdash \{N=n \land S=0 \land I=0\} w \{2*S = n*(n+1)\}.$$

Aplicând
apoi regula pentru secvenţiere pentru acest enunţ şi pentru cel obţinut
mai devreme, anume
$$\vdash \{\textbf{true}\} (N:=n; S:=0); I:=0 \{N=n \land S=0 \land I=0\},$$
obţinem $\vdash \{\textbf{true}\}p\{2*S=n*(n+1)\}$, ceea ce trebuia
demonstrat.

## Teorema de corectitudine

### Teorema de corectitudine
Pentru orice $A$, $B$, $c$ cu
$\vdash \{A\}c\{B\}$, avem $\models \{A\}c\{B\}$.

### Demonstraţie
Demonstrăm prin inducţie după regulile Hoare. Tratăm cazul
regulii pentru **while**. Notăm $w:=\textbf{while $b$ do $c$}$.
Presupunem $\models \{A \land b\}c\{A\}$. Vrem
$\models\{A\}w\{A \land\neg b\}$. Fie $I : V \to \mathbb{Z}$. Notând
$W:=\{(\sigma,\sigma') \in \Sigma^2\mid \sigma \models^I A \text{ implic\u a } \sigma' \models^I A \land\neg b\}$,
vrem să arătăm $\llbracket w \rrbracket \subseteq W$. Este suficient să
arătăm
$\Gamma^{\llbracket b \rrbracket}_{\llbracket c \rrbracket}(W) \subseteq W$.

Fie
$(\sigma,\sigma') \in \Gamma^{\llbracket b \rrbracket}_{\llbracket c \rrbracket}(W)$
şi tratăm cazul $e_\sigma(b)=1$. Ştim $\sigma \models^I A$ şi vrem
$\sigma' \models^I A \land\neg b$. Din definiţia lui
$\Gamma^{\llbracket b \rrbracket}_{\llbracket c \rrbracket}$, avem că
există $\sigma''$ cu $(\sigma,\sigma'') \in \llbracket c \rrbracket$ şi
$(\sigma'',\sigma') \in W$. Cum $e_\sigma(b)=1$,
$\sigma \models^I A \land b$. Cum $\models \{A \land b\}c\{A\}$, avem
$\sigma'' \models^I A$, iar, cum $(\sigma'',\sigma') \in W$, avem
$\sigma' \models^I A \land\neg b$, ceea ce trebuia demonstrat.

## Cea mai slabă precondiţie

Pentru orice instrucţiune $c$, orice aserţiune $B$ şi orice interpretare
$I$, definim **cea mai slabă precondiţie** (**semantică**) a lor prin
$$ws^I(c,B):=\{\sigma \in \Sigma \mid \text{pentru orice $\sigma' \in \Sigma$ cu $(\sigma,\sigma') \in \llbracket c \rrbracket$, $\sigma' \models^I B$}\}.$$
Avem că, pentru orice $A$, $B$, $c$, $I$, $\models^I \{A\}c\{B\}$ dacă
şi numai dacă $A^I \subseteq ws^I(c,B)$ (exerciţiu!).

În continuare, vom demonstra că această construcţie poate fi capturată
de o aserţiune, în sensul că, pentru orice instrucţiune $c$ şi orice
aserţiune $B$, există o aserţiune $A$, numită şi ea **cea mai slabă
precondiţie** (**sintactică**, de data aceasta), astfel încât, pentru
orice $I$, $A^I = ws^I(c,B)$. În particular, $A$ este unică până la o
echivalenţă semantică. Vom construi o asemenea aserţiune prin inducţie
structurală şi o vom nota cu $wp(c,B)$. Aşadar, pentru orice $c$ şi $B$,
$\models \{wp(c,B)\}c\{B\}$, iar, pentru orice $I$, $wp(c,B)^I$ va fi
egal cu $ws^I(c,B)$.

## Definirea celei mai slabe precondiţii

Vom avea: $$\begin{aligned}
wp(\textbf{skip},B) &:=B \\
wp(X:=a, B) &:= B[X:=a] \\
wp(c_0;c_1, B) &:= wp(c_0, wp(c_1,B)) \\
wp(\textbf{if $b$ then $c_0$ else $c_1$},B) &:= (b \land wp(c_0,B)) \lor (\neg b \land wp(c_1,B)).
\end{aligned}$$

Definiţia pentru instrucţiunea **while** va fi destul de
migăloasă şi, de aceea, doar vom schiţa ideile care stau la baza ei. Vom
nota în continuare, ca de obicei, $w:=\textbf{while $b$ do $c$}$. Scopul
este de a defini $wp(w,B)$.


## Despre **while**

**Claim 1**: Avem că, pentru orice $(\sigma,\sigma') \in \Sigma^2$,
$(\sigma,\sigma')\in \llbracket w \rrbracket$ dacă şi numai dacă există
$n \geq 0$ şi un şir finit de stări $(\sigma_i)_{i \leq n}$ cu
$\sigma_0 = \sigma$, $\sigma_n = \sigma'$,
$\llbracket b \rrbracket(\sigma_n) = 0$ şi, pentru orice $i$ cu
$0 \leq i < n$, $\llbracket b \rrbracket(\sigma_i) = 1$ şi
$(\sigma_i,\sigma_{i+1}) \in \llbracket c \rrbracket$.

Demonstraţia acestui fapt este un exerciţiu care foloseşte ideile despre
cel mai mic punct fix din demonstraţiile anterioare. Faptul următor
rezultă imediat din el.

**Claim 2**: Avem că, pentru orice $\sigma$ şi $I$,
$\sigma \in ws^I(w,B)$ dacă şi numai dacă pentru orice $n \geq 0$ şi
orice şir finit de stări $(\sigma_i)_{i \leq n}$ cu $\sigma_0 = \sigma$
şi, pentru orice $i$ cu $0 \leq i < n$,
$\llbracket b \rrbracket(\sigma_i) = 1$ şi
$(\sigma_i,\sigma_{i+1}) \in \llbracket c \rrbracket$, avem
$\sigma_n \models^I b \lor B$.

Vom dori în continuare să reducem şirurile de stări la şiruri de numere.
Pentru aceasta, ne folosim de faptul că locurile de memorie menţionate
în aserţiuni şi instrucţiuni sunt în număr finit, şi numai valorile
acelora sunt cele care contează.

## Despre **while**

Fie $X_1,\ldots,X_l$ acele locuri de memorie care apar în $w$ şi $B$.

**Claim 3**: Avem că, pentru orice $\sigma$ şi $I$,
$\sigma \in ws^I(w,B)$ dacă şi numai dacă pentru orice $n \geq 0$ şi
orice $(s_{ij})_{i \leq n,\ j \leq l} \subseteq \mathbb{N}$, dacă avem
$\sigma \models^I \bigwedge_{j=1}^l X_j=s_{0j}$ şi, pentru orice $i$ cu
$0 \leq i < n$,
$$\sigma\models^I b[X_1 := s_{i1}]\ldots [X_l := s_{il}]$$ şi
$$\sigma\models^I \left(wp\left(c,\bigwedge_{j=1}^l X_j=s_{(i+1)j}\right) \land \neg wp(c,\textbf{false})\right)[X_1 := s_{i1}]... [X_l := s_{il}],$$
avem
$$\sigma\models^I (b \lor B)[X_1 := s_{n1}]\ldots [X_l := s_{nl}].$$
Practic, acum, dacă scriem ca aserţiune această proprietate a lui $ws$,
îl vom obţine pe $wp$ -- singurul obstacol este faptul că avem
cuantificare după şiruri finite de numere, care nu există în limbajul
nostru.

## Lema beta a lui Gödel

Pentru a exprima idei care se referă la şiruri de numere, se foloseşte
un rezultat tehnic, numit lema beta a lui Gödel, folosit de acesta cu un
scop similar în demonstrarea teoremei sale de incompletitudine (un mod
mai cunoscut de a codifica şiruri de numere ca numere simple este cel
care foloseşte descompunerea în factori primi).

::: block
### Lema beta a lui Gödel
Există o aserţiune $\beta$ astfel încât, pentru
orice $k \in \mathbb{N}$ şi orice şir de numere întregi
$(a_i)_{i \leq k}$ există $n$, $m \in \mathbb{N}$ astfel încât, pentru
orice $j \in \{0,\ldots,k\}$ şi orice $x \in \mathbb{Z}$, avem
$$\beta(n,m,j,x) \Leftrightarrow x=a_j.$$
:::

În acest moment, considerăm că am terminat definirea lui $wp$.

## O variantă

Putem exprima mai uşor $wp(w,B)$, şi îl putem şi implementa fezabil la
laborator, dacă facem următoarele presupuneri:

-   avem disjuncţii infinitare în limbaj;

-   $w$ se termină, adică pentru orice $\sigma$ există $\sigma'$ cu
    $(\sigma,\sigma') \in \llbracket w \rrbracket$.

Definim acum $P_0:=\neg b \land B$ şi, pentru orice $k$,
$$P_{k+1}:= b \land wp(c,P_k).$$

Atunci vom pune
$$wp(w,B) := \bigvee_{k \in \mathbb{N}} P_k.$$

A se observa că, în
această ipoteză, nu mai avem nevoie de cuantificatori, deci nici de
variabile logice, de expresii aritmetice extinse sau de interpretări,
fapt care se va reflecta în suportul de laborator.

## O variantă

Vom demonstra acum că definiţia este adecvată.

Fie $I$ o interpretare. Vom arăta că $wp(w,B)^I=ws^I(w,B)$.

### Demonstraţie
Pentru $\subseteq$", fie $\sigma$ cu
$\sigma \models^I \bigvee_{k \in \mathbb{N}} P_k$, deci există
$k \in \mathbb{N}$ cu $\sigma \models^I P_k$. Facem inducţie după $k$.

Pentru $k=0$, avem $\sigma \models^I \neg b \land B$, deci
$e_\sigma(b)=0$. Fie $\sigma'$ cu
$(\sigma,\sigma') \in \llbracket w \rrbracket$, deci $\sigma'=\sigma$ şi
$\sigma' \models^I B$.

Pentru pasul de inducţie, presupunem
$\sigma \models^I b \land wp(c,P_k)$, deci $e_\sigma(b)=1$. Fie
$\sigma'$ cu $(\sigma,\sigma') \in \llbracket w \rrbracket$, deci există
$\sigma''$ cu $(\sigma,\sigma'') \in \llbracket c \rrbracket$ şi
$(\sigma'',\sigma') \in \llbracket w \rrbracket$. Cum
$\sigma \models^I wp(c,P_k)$, avem $\sigma'' \models^I P_k$. Din ipoteza
de inducţie, avem $\sigma'' \in ws^I(w,B)$, deci $\sigma' \models^I B$.

## O variantă

::: block
### Demonstraţie (cont.)
Pentru $\supseteq$", fie $\sigma \in ws^I(w,B)$.
Vrem $k \in \mathbb{N}$ cu $\sigma \models^I P_k$. Aici aplicăm
presupunerea noastră şi luăm $\sigma'$ cu
$(\sigma,\sigma') \in \llbracket w \rrbracket$, deci
$\sigma' \models^I B$.

Aplicăm primul claim de mai devreme pentru a obţine că, pentru orice
$(\sigma,\sigma') \in \Sigma^2$,
$(\sigma,\sigma')\in \llbracket w \rrbracket$ dacă şi numai dacă există
$n \geq 0$ şi un şir finit de stări $(\sigma_i)_{i \leq n}$ cu
$\sigma_0 = \sigma$, $\sigma_n = \sigma'$,
$\llbracket b \rrbracket(\sigma_n) = 0$ şi, pentru orice $i$ cu
$0 \leq i < n$, $\llbracket b \rrbracket(\sigma_i) = 1$ şi
$(\sigma_i,\sigma_{i+1}) \in \llbracket c \rrbracket$.

Se arată, apoi, că, pentru orice $j$ cu $0 \leq j \leq n$, avem
$\sigma_{n-j} \models^I P_j$, prin inducţie după $j$ (exerciţiu!). Avem,
deci, că $\sigma = \sigma_0 \models^I P_n$.
:::

A se vedea şi cursul de master "Program Verification":
$$\text{\url{https://cs.unibuc.ro/~ddiaconescu/2019/pv/}}$$

## Teorema de completitudine

### Lemă
Fie $c$, $B$ cu $\vdash \{wp(c,B)\}c\{B\}$. Fie $A$ cu
$\models \{A\}c\{B\}$. Atunci $\vdash \{A\}c\{B\}$.

### Demonstraţie
Din regula consecinţei, e suficient să arătăm
$\models A \to wp(c,B)$. Fie $I$. Cum $\models^I \{A\}c\{B\}$, avem
$A^I \subseteq ws^I(c,B) = wp(c,B)^I$, deci $\models^I A \to wp(c,B)$.


### Teorema de completitudine
Pentru orice $A$, $B$, $c$ cu
$\models \{A\}c\{B\}$, avem $\vdash \{A\}c\{B\}$.

### Demonstraţie
Demonstrăm prin inducţie structurală după $c$. Din lema
anterioară, rezultă că este suficient, la fiecare pas, să arătăm că,
pentru orice $B$, $\vdash \{wp(c,B)\}c\{B\}$.

## Demonstraţia teoremei de completitudine

### Demonstraţie (cont.)
Vom trata cazurile instrucţiunilor **if** şi
**while**.

Pentru **if**, notăm $i:=\textbf{if $b$ then $c_0$ else $c_1$}$. Ştim:
$$wp(i,B)=(b \land wp(c_0,B)) \lor (\neg b \land wp(c_1,B)).$$ Este
imediat că $\models wp(i,B) \land b \to wp(c_0,B)$. Din ipoteza de
inducţie, ştim $\vdash \{wp(c_0,B)\}c_0\{B\}$, aşadar, din regula
consecinţei, scoatem $\vdash \{wp(i,B) \land b\}c_0\{B\}$. Analog,
$\vdash \{wp(i,B) \land \neg b\}c_1\{B\}$. Concluzia rezultă aplicând
regula pentru **if**.

Pentru **while**, notăm $w:=\textbf{while $b$ do $c$}$ şi $A:=wp(w,B)$.

## Demonstraţia teoremei de completitudine

### Demonstraţie (cont.)
**Claim 1**: $\models \{A \land b\} c\{A\}$.

**Dem. claim**: Fie $I$ şi
$(\sigma,\sigma'') \in \llbracket c \rrbracket$. Presupunem
$\sigma \models^I A \land b$, deci
$\llbracket b \rrbracket (\sigma) = 1$. Vrem
$\sigma'' \in A^I = wp(w,B)^I = ws^I(w,B)$. Fie $\sigma'$ cu
$(\sigma'',\sigma')\in \llbracket w \rrbracket$. Vrem
$\sigma' \models^I B$. Cum
$(\sigma,\sigma'') \in \llbracket c \rrbracket$ şi
$\llbracket b \rrbracket (\sigma) = 1$, avem
$(\sigma,\sigma') \in \llbracket w \rrbracket$. Cum
$\sigma \models^I A$, adică $\sigma \in ws^I(w,B)$, rezultă
$\sigma' \models^I B$.

**Claim 2**: $\models (A \land \neg b) \to B$.

**Dem. claim**: Fie $\sigma$, $I$ cu $\sigma \models^I A \land \neg b$.
Vrem $\sigma \models^I B$. Cum $\llbracket b \rrbracket (\sigma) = 0$,
$(\sigma,\sigma) \in \llbracket w \rrbracket$, iar cum
$\sigma \in A^I = ws^I(w,B)$, avem $\sigma \models^I B$.

Demonstrăm acum că $\vdash \{A\}w\{B\}$. Aplicând ipoteza de inducţie pe
primul claim, avem $\vdash \{A \land b\} c\{A\}$, deci, din regula
pentru **while**, avem $\vdash \{A\} w\{A \land\neg b\}$. Aplicând
regula consecinţei şi al doilea claim, avem $\vdash \{A\}w\{B\}$.
