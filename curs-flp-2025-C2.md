---
author: Traian Florin Șerbănuță și Andrei Sipoș
institute: Facultatea de Matematică și Informatică, DL Info
date: Anul II, Semestrul II, 2024/2025
title: Fundamentele limbajelor de programare
subtitle: 2. Programare imperativă. Limbajul IMP. Semantica operațională structurală big-step și small-step.
theme: CambridgeUS
---

# Programare imperativă

## Programarea imperativă

Paradigma de programare cel mai transparent de descris formal este cea
imperativă, având în vedere că posedă foarte puţine construcţii care au
inerent nevoie de un aparat matematic complex (cum ar fi rezoluţia,
funcţiile de ordin înalt etc. pe care le vom vedea în alte paradigme),
şi de aceea poate servi drept caz de jucărie pentru abstracţiunile pe
care le vom dezvolta ulterior.

Vom descrie un limbaj imperativ auster, numit IMP, o variantă
simplificată[^1] a limbajelor imperative folosite în mod uzual (cum ar
fi C, Go etc.).

## Limbajul IMP

Fixăm o mulţime (probabil numărabilă, dar nu intrăm în detalii) $L$, ale
cărei elemente vor fi numite **variabile**, unde cuvântul se vrea să
aibă acelaşi sens ca într-un limbaj de programare imperativ uzual:
practic, ne referim la locuri în memorie.

Descrierea limbajului va cuprinde diverse tipuri de date": expresii
aritmetice, expresii booleene, instrucţiuni (aşa cum aveam şi la logica
de ordinul I întâi termeni şi abia apoi formule), pe care le vom descrie
pe rând.

## Expresii aritmetice

O **expresie aritmetică** are exact una dintre următoarele forme:

-   un număr întreg $n$;

-   o variabilă $X$ (element al lui $L$);

-   $a_0+a_1$, $a_0-a_1$, $a_0*a_1$, unde $a_0$ şi $a_1$ sunt expresii
    aritmetice.

Acesta şi cele care vor urma sunt (la modul informal) tipuri de date
inductive, iar, în genere, principiile exprimate şi demonstrate în
cursul trecut pentru exemplul particular al formulelor logicii
propoziţionale (inducţie structurală, recursie structurală, citire unică
etc.) vor fi valabile şi aici, *mutatis mutandis*, şi ca atare nu le vom
mai menţiona.

## Expresii booleene

O **expresie booleană** are exact una dintre următoarele forme:

-   o valoare booleană (**true** sau **false**);

-   $a_0=a_1$, $a_0 \leq a_1$, unde $a_0$ şi $a_1$ sunt expresii
    aritmetice;

-   $\neg b_0$, $b_0 \land b_1$, $b_0 \lor b_1$, unde $b_0$ şi $b_1$
    sunt expresii booleene.

## Instrucţiuni

O **instrucţiune** are exact una dintre următoarele forme:

-   **skip**;

-   $X:=a$, unde $X \in L$, iar $a$ este o expresie aritmetică;

-   $c_0;c_1$, unde $c_0$ şi $c_1$ sunt instrucţiuni;

-   **if $b$ then $c_0$ else $c_1$**, unde $b$ este expresie booleană,
    iar $c_1$ şi $c_2$ sunt instrucţiuni;

-   **while $b$ do $c$**, unde $b$ este expresie booleană, iar $c$ este
    instrucţiune.

## Stări

Vom numi **stare** o funcţie de la $L$ la $\mathbb{Z}$. Practic,
fiecărui loc din memorie i se va asocia o valoare, în mod asemănător cu
funcţiile de evaluare din logică. Mulţimea stărilor o vom nota cu
$\Sigma$. Aşadar, $\Sigma= \mathbb{Z}^L$.

Tot ca în logică, pentru orice $\sigma \in \Sigma$, $X \in L$ şi
$N \in \mathbb{Z}$, definim starea $\sigma_{X \mapsto N}$, pentru orice
$Y \in L$, prin:
$$\sigma_{X \mapsto N}(Y) := \begin{cases} N, & \mbox{dac\u a } Y=X, \\
\sigma(Y), & \mbox{altfel}.\end{cases}$$

## Evaluarea expresiilor aritmetice

Fie $\sigma \in \Sigma$. Definim o funcţie $e_\sigma$ care evaluează
expresii aritmetice în numere întregi, în mod recursiv, în felul
următor:

-   pentru orice $N \in \mathbb{Z}$, $e_\sigma(N):=N$;

-   pentru orice $X \in L$, $e_\sigma(X):=\sigma(X)$;

-   pentru orice expresii aritmetice $a_0$, $a_1$, avem\
    $e_\sigma(a_0+a_1):=e_\sigma(a_0)+e_\sigma(a_1)$,\
    $e_\sigma(a_0-a_1):=e_\sigma(a_0)-e_\sigma(a_1)$,\
    $e_\sigma(a_0*a_1):=e_\sigma(a_0)*e_\sigma(a_1)$.

## Evaluarea expresiilor booleene

Tot pentru un $\sigma \in \Sigma$, vom defini o funcţie notată tot
$e_\sigma$ care evaluează expresii booleene în mulţimea $\{0,1\}$, în
mod recursiv, în felul următor:

-   $e_\sigma(\text{\bf true})=1$, $e_\sigma(\text{\bf false})=0$;

-   pentru orice expresii aritmetice $a_0$, $a_1$, avem\
    $e_\sigma(a_0=a_1) = 1$ dacă şi numai dacă
    $e_\sigma(a_0)=e_\sigma(a_1)$,\
    $e_\sigma(a_0\leq a_1) = 1$ dacă şi numai dacă
    $e_\sigma(a_0)\leq e_\sigma(a_1)$;

-   pentru orice expresii booleene $b_0$, $b_1$, avem\
    $e_\sigma(\neg b_0)=\pmb{\neg}e_\sigma(b_0)$,\
    $e_\sigma(b_0 \land b_1) = e_\sigma(b_0) \pmb{\wedge}e_\sigma(b_1)$,\
    $e_\sigma(b_0 \lor b_1) = e_\sigma(b_0) \pmb{\vee}e_\sigma(b_1)$.

# Semantica operaţională structurală

## Semantica operaţională structurală

În acest moment, putem trece la definirea primei semantici pentru
limbajul IMP. Ea va fi o **semantică operaţională**, mai precis
semantică operaţională structurală big-step, în sensurile următoare:

-   operaţională: seamănă cu execuţia de către o maşină;

-   structurală: este definită conform principiului de recursie
    structurală (pe instrucţiuni);

-   big-step: se va referi la starea finală după execuţia unui fragment
    de cod (de aceea vom folosi semnul $\Downarrow$).

## Semantica instrucţiunilor

Vom considera aserţiuni de forma $(c,\sigma)\Downarrow \sigma'$, unde
$c$ este o instrucţiune, iar $\sigma$, $\sigma' \in \Sigma$, cu
semnificaţia informală instrucţiunea $c$ executată în starea $\sigma$
produce starea $\sigma'$".

Vom prezenta nişte **reguli de deducţie** (de fapt, scheme de reguli)
care ne vor permite să derivăm asemenea aserţiuni. Am putea nota faptul
că aserţiunea $(c,\sigma)\Downarrow \sigma'$ este derivabilă prin
$\vdash (c,\sigma)\Downarrow \sigma'$, dar o notăm, mai simplu, doar cu
$(c,\sigma)\Downarrow \sigma'$.

Vom putea face şi inducţie pe derivări/demonstraţii (ori structural, ori
după lungime), precum şi pe aserţiuni derivabile (putem face şi
recursie? în ce sens? dacă da/nu în vreun sens, de ce?).

## Regulile de deducţie big-step

$$\frac{}{(\sskip,\sigma)\Downarrow \sigma}$$ $$\begin{aligned}
    \frac{}{(X:=a,\sigma)\Downarrow \sigma_{X \mapsto e_\sigma(a)}} \qquad & \frac{(c_0,\sigma)\Downarrow \sigma'' \quad (c_1,\sigma'')\Downarrow \sigma'}{(c_0;c_1,\sigma)\Downarrow \sigma'}\\[1em]
  \frac{e_\sigma(b)=1\quad(c_0,\sigma)\Downarrow \sigma'  }{(\sif b \sthen c_0 \selse c_1,\sigma)\Downarrow \sigma'
    }\qquad &  \frac{e_\sigma(b)=0 \quad(c_1,\sigma)\Downarrow \sigma'}{(\sif b \sthen c_0 \selse c_1,\sigma)\Downarrow \sigma'
    }
\end{aligned}$$

$$\frac{e_\sigma(b)=0}{(\swhile b \sdo c,\sigma) \Downarrow \sigma}$$

$$\frac{e_\sigma(b)=1 \quad (c,\sigma)\Downarrow \sigma'' \quad (\swhile b \sdo c, \sigma'') \Downarrow \sigma'}{(\swhile b \sdo c,\sigma) \Downarrow \sigma'}$$

## Un exemplu de raţionament

În acest moment, putem vedea cum folosim semantica pentru a raţiona
despre programe.

### Propoziţie
Fie $w:=\textbf{while true do skip}$. Nu există $\sigma$,
$\sigma'$ cu $(w,\sigma)\Downarrow \sigma'$.

### Demonstraţie
Presupunem că ar exista derivări de aserţiuni de acea
formă. Considerăm una de lungime minimă. Ultima regulă a derivării
trebuie să fie a doua regulă pentru **while**, aşadar trebuie să existe
o stare $\sigma''$ astfel încât ultima premisă a regulii să fie
$(w,\sigma'') \Downarrow \sigma'$. Dar aceea este tot o aserţiune de
forma despre care vorbim, contrazicându-se minimalitatea lungimii
derivării.

## Echivalenţa între programe

Pe instrucţiuni, putem defini relaţia de echivalenţă $\sim$ în felul
următor: pentru orice $c_0$, $c_1$, avem $c_0 \sim c_1$ exact atunci
când, pentru orice $\sigma$, $\sigma' \in \Sigma$,
$(c_0,\sigma) \Downarrow \sigma'$ dacă şi numai dacă
$(c_1,\sigma) \Downarrow \sigma'$.

### Propoziţie
Fie $b$ o expresie booleană şi $c$ o instrucţiune. Notăm
$w:=\swhile b \sdo c$. Atunci
$w \sim (\sif b \sthen c;w \selse \sskip)$.

### Demonstraţie
Fie $\sigma$, $\sigma' \in \Sigma$. Vrem să arătăm că
$$(w, \sigma) \Downarrow \sigma' \Leftrightarrow (\sif b \sthen (c;w) \selse \sskip, \sigma)\Downarrow \sigma'.$$
Demonstrăm implicaţia $\Rightarrow$". Presupunem că avem
$(w, \sigma) \Downarrow \sigma'$. În primul caz, avem $e_\sigma(b)=0$ şi
$\sigma=\sigma'$, iar, folosind faptul că
$(\sskip,\sigma) \Downarrow \sigma$, deducem că
$(\sif b \sthen (c;w) \selse \sskip, \sigma)\Downarrow \sigma$.

## Echivalenţa între programe

### Demonstraţie (cont.)
În al doilea caz, avem că $e_\sigma(b)=1$ şi există
$\sigma''$ cu $(c,\sigma)\Downarrow \sigma''$ şi
$(w,\sigma'') \Downarrow \sigma'$. Putem deduce că
$(c;w, \sigma) \Downarrow \sigma'$ şi apoi că
$(\sif b \sthen (c;w) \selse \sskip, \sigma)\Downarrow \sigma'$.

Demonstrăm acum implicaţia $\Leftarrow$". Presupunem că avem
$(\sif b \sthen (c;w) \selse \sskip, \sigma)\Downarrow \sigma'$.

În primul caz, avem $e_\sigma(b)=0$ şi $\sigma=\sigma'$, de unde deducem
imediat $(w,\sigma) \Downarrow \sigma$.

În al doilea caz, avem $e_\sigma(b)=1$ şi
$(c;w,\sigma)\Downarrow\sigma'$, de unde scoatem că există $\sigma''$ cu
$(c,\sigma)\Downarrow \sigma''$ şi $(w,\sigma'') \Downarrow \sigma'$.
Putem apoi deduce imediat că $(w, \sigma) \Downarrow \sigma'$.

## Semantica small-step

Există şi un mod small-step" de a defini semantica operaţională
structurală, care se referă la modul în care se modifică starea după
rularea unui pas" din program (cât anume reprezintă un pas este la
latitudinea celui care defineşte semantica; de exemplu, aici am făcut
deja o asemenea alegere prin faptul că expresiile sunt evaluate
funcţional, iar nu prin reguli de deducţie).

Ne vom referi acum la aserţiuni de forma $(c,\sigma) \to (c',\sigma')$
unde $c$ şi $c'$ sunt instrucţiuni, iar $\sigma$, $\sigma' \in \Sigma$,
cu semnificaţia informală după ce executăm instrucţiunea $c$ în starea
$\sigma$, starea devine $\sigma'$, iar instrucţiunea care mai rămâne de
executat este $c'$". Vom nota cu $\to^*$ închiderea reflexiv-tranzitivă
a relaţiei $\to$ (cum o putem defini formal? discuţie!).

Prezentăm în continuare regulile de deducţie.

## Regulile de deducţie small-step

$$\frac{}{(X:=a, \sigma) \to (\sskip, \sigma_{X \mapsto e_\sigma(a)})}$$
$$\begin{aligned}
\frac{}{(\sskip;c_1,\sigma)\to(c_1,\sigma)} \qquad & \frac{(c_0,\sigma)\to(c'_0,\sigma')}{(c_0;c_1,\sigma)\to(c'_0;c_1,\sigma')}
\end{aligned}$$
$$\frac{e_\sigma(b)=1}{(\sif b \sthen c_0 \selse c_1,\sigma) \to (c_0,\sigma)}$$
$$\frac{e_\sigma(b)=0}{(\sif b \sthen c_0 \selse c_1,\sigma) \to (c_1,\sigma)}$$

$$\frac{}{(\swhile b \sdo c,\sigma)\to(\sif b \sthen (c;(\swhile b \sdo c)) \selse \sskip,\sigma)}$$


## Echivalenţa între semantici

### Teoremă
Fie $c$ o instrucţiune şi $\sigma$, $\sigma' \in \Sigma$. Atunci
$$(c,\sigma)\Downarrow \sigma' \text{ dac\u a \c si numai dac\u a } (c,\sigma)\to^*(\sskip,\sigma').$$

### Demonstraţie
Demonstrăm implicaţia $\Rightarrow$". Facem inducţie după
regulile pentru relaţia $\Downarrow$.

Tratăm cazul regulii $(\sskip,\sigma)\Downarrow \sigma$. Atunci,
clar, $(\sskip,\sigma) \to^* (\sskip,\sigma)$. Cazul
regulii pentru atribuire este similar.

La regula pentru secvenţiere, deducem, din ipoteza de inducţie,
$(c_0, \sigma) \to^* (\sskip,\sigma'')$ şi
$(c_1, \sigma'') \to^* (\sskip,\sigma')$, de unde scoatem
$$(c_0;c_1,\sigma) \to^* (\sskip;c_1,\sigma'') \to (c_1,\sigma'') \to^* (\sskip,\sigma').$$

## Echivalenţa între semantici

### Demonstraţie (cont.)
La prima regulă pentru **if** (cea de-a doua se
tratează similar), deducem, din ipoteza de inducţie,
$(c_0, \sigma) \to^* (\sskip,\sigma')$, de unde scoatem
$$(\sif b \sthen c_0 \selse c_1,\sigma) \to (c_0, \sigma) \to^* (\sskip,\sigma').$$
Notăm $w:=\swhile b \sdo c$. La prima regulă pentru **while**,
unde $e_\sigma(b)=0$, scoatem
$$(w,\sigma) \to (\sif b \sthen (c;w) \selse \sskip,\sigma) \to (\sskip,\sigma).$$
La a doua, ştim $(c,\sigma)\to^*(\sskip,\sigma'')$ şi
$(w,\sigma'') \to^* (\sskip,\sigma')$ şi scoatem
$$\begin{aligned}
(w,\sigma) &\to (\sif b \sthen (c;w) \selse \sskip,\sigma)\\
&\to (c;w,\sigma)  \to^* (\sskip;w,\sigma'') \to (w,\sigma'') \to^* (\sskip,\sigma').
\end{aligned}$$

## Echivalenţa între semantici

### Demonstraţie (cont.)
Demonstrăm implicaţia $\Leftarrow$". Acum vom face
inducţie structurală după $c$.

Pentru instrucţiunea **skip**, dacă avem
$(\sskip,\sigma) \to^* (\sskip,\sigma')$, atunci neapărat
$\sigma=\sigma'$ şi, clar, avem
$(\sskip,\sigma) \Downarrow \sigma$. Cazul instrucţiunii de
atribuire este similar.

Dacă ştim $(c_0;c_1,\sigma) \to^*(\sskip,\sigma')$, clar trebuie
să avem
$$(c_0;c_1,\sigma) \to^* (\sskip;c_1,\sigma'') \to (c_1,\sigma'') \to^* (\sskip,\sigma')$$
şi în particular $(c_0,\sigma) \to^* (\sskip, \sigma'')$. De aici
scoatem $(c_0,\sigma) \Downarrow \sigma''$ şi
$(c_1,\sigma'') \Downarrow \sigma'$, deci
$(c_0;c_1,\sigma)\Downarrow \sigma'$.

Cazul instrucţiunii **if** rămâne ca exerciţiu.

## Echivalenţa între semantici

### Demonstraţie (cont.)
Tratăm cazul instrucţiunii **while**. Presupunem că
avem $(\swhile b \sdo c,\sigma) \to^* (\sskip,\sigma')$.
Notăm $w:=\swhile b \sdo c$. Vom face inducţie după numărul de
paşi din $\to^*$".

Pentru cazul $e_\sigma(b)=0$, avem
$(\swhile b \sdo c,\sigma) \to^* (\sskip,\sigma)$, deci
$\sigma'=\sigma$ şi scoatem uşor $(w,\sigma) \Downarrow \sigma$.

Pentru cazul $e_\sigma(b)=1$, avem
$(\swhile b \sdo c,\sigma) \to^* (c;w,\sigma) \to^* (\sskip;w, \sigma'') \to (w,\sigma'') \to^* (\sskip,\sigma')$.
În particular, avem $(c,\sigma) \to^* (\sskip,\sigma'')$ şi
$(w,\sigma'') \to^* (\sskip,\sigma')$. Din ipoteza de inducţie
structurală pentru $c$, avem $(c,\sigma) \Downarrow \sigma''$. Din
ipoteza de inducţie pe numărul de paşi, avem
$(w,\sigma'') \Downarrow \sigma'$. Acum scoatem imediat
$(w,\sigma) \Downarrow \sigma'$.

[^1]: Denumirea IMP îşi are originea, cel mai probabil, în cartea
    (indicată în bibliografie): G. Winskel, *The Formal Semantics of
    Programming Languages: An Introduction*, The MIT Press, 1993.
