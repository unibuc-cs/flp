---
author: Traian Florin Șerbănuță și Andrei Sipoș
institute: Facultatea de Matematică și Informatică, DL Info
date: Anul II, Semestrul II, 2024/2025
title: Fundamentele limbajelor de programare
subtitle: Programare Logica. Rezoluție. Completitudine.
theme: CambridgeUS
---

# Semantică

## Structuri de ordinul I

Dacă
$\sigma = (F,R,r)$ este o signatură de ordinul I, atunci \
o **$\sigma$-structură** este o pereche $(A, \{A_s\}_{s \in F \cup R})$,
unde:

- $A \neq \emptyset$ (şi se va numi **universul**, **mulţimea
suport** sau **mulţimea subiacentă** a structurii),

- pentru orice
$s \in F$, $A_s : A^{r(s)} \to A$ şi

- pentru orice $s \in R$,
$A_s \subseteq A^{r(s)}$. 

Structurile vor reprezenta domeniile despre
care vor vorbi formulele corespunzătoare signaturilor.

## Evaluarea termenilor

Fie $\mathcal{A}=(A,(A_s)_{s \in F \cup R})$ o $\sigma$-structură.
Atunci pentru orice __valuație__ $v : V \to A$ există şi este unică o funcţie
$(\cdot)^{\mathcal{A}}_v : T_\sigma \to A$ astfel încât

-   pentru orice $x \in V$, $x^{\mathcal{A}}_v=v(x)$;

-   pentru orice $s \in F$ şi orice $t_1,\ldots,t_{r(s)} \in T_\sigma$,
    $(st_1\ldots t_{r(s)})^{\mathcal{A}}_v=A_s((t_1)^{\mathcal{A}}_v,\ldots,(t_{r(s)})^{\mathcal{A}}_v)$ \
    (în particular, dacă $r(s)=0$, $s^{\mathcal{A}}_v = A_s$).

## Actualizarea valuațiilor

Fie $\mathcal{A}=(A,(A_s)_{s \in F \cup R})$ o $\sigma$-structură.
Pentru orice $v : V\to A$, $x \in V$, $a \in A$, definim
$v_{x \leftarrow a} : V \to A$, pentru orice $y \in V$, prin
$$v_{x \leftarrow a}(y) := \begin{cases} v(y), &\mbox{dac\u a  $y\neq x$,} \\
a, & \mbox{dac\u a $y=x$}. \end{cases}$$

Observăm că pentru orice
variabile $x$, $y$ cu $x \neq y$, orice $v: V \to A$ şi orice $a$,
$b \in A$, avem că
$$(v_{y\leftarrow b})_{x \leftarrow a}=(v_{x\leftarrow a})_{y \leftarrow b}.$$

În acest caz, notăm valoarea lor comună cu
$v_{x\leftarrow a, y\leftarrow b}$. Aşadar, pentru orice $z \in V$,
$$\begin{aligned}
v_{x\leftarrow a, y\leftarrow b}(z)=\begin{cases}
v(z) & \text{dac\u a } z\ne x \text{ \c si } z \ne y,\\
a & \text{dac\u a }  z=x,\\
b & \text{dac\u a } z=y.
\end{cases}
\end{aligned}$$

## Satisfacerea formulelor

Definim o relație $\models$ între structuri, valuații și formule folosind următoarele (scheme de) reguli:

-   $\mathcal{A}\models^v t = u$, dacă $t^\mathcal{A}_v=u^\mathcal{A}_v$;

-   $\mathcal{A}\models^v st_1\ldots t_{r(s)}$ (unde $s \in R$),
    dacă $((t_1)^\mathcal{A}_v,\ldots,(t_{r(s)})^\mathcal{A}_v) \in A_s$;

-   $\mathcal{A}\not\models^v \bot$;

-   $\mathcal{A}\models^v \varphi\to \psi$ dacă
    $\mathcal{A}\models^v \varphi$ implică că $\mathcal{A}\models^v \psi$

-   $\mathcal{A}\models^v \forall x \varphi$, dacă pentru orice $a \in A$, $\mathcal{A}\models^{v_{x \leftarrow a}} \varphi$.

Dacă $\mathcal{A}\models^v \varphi$ pentru orice $v$, scriem $\mathcal{A}\models \varphi$ și spunem că $\mathcal{A}$ **satisface** $\varphi$, sau este **model** pentru $\varphi$. 

Dacă $\mathcal{A}\models \varphi$ pentru orice $\cal A$, scriem $\models \varphi$ și spunem că $\varphi$ este
**validă**.

## Satisfacerea conectorilor derivaţi

Fie $\mathcal{A}=(A,(A_s)_{s \in F \cup R})$ o $\sigma$-structură. Este
acum imediat că pentru orice $v: V \to A$, avem:

-   $\mathcal{A}\models^v \top$;

-   $\mathcal{A}\models^v \varphi\wedge\psi$ ddacă $\mathcal{A}\models^v \varphi$ și $\mathcal{A}\models^v \psi$;

-   $\mathcal{A}\models^v \varphi\vee\psi$ ddacă $\mathcal{A}\models^v \varphi$ sau $\mathcal{A}\models^v \psi$;

-   $\mathcal{A}\models^v \varphi\leftrightarrow\psi$ ddacă ($\mathcal{A}\models^v \varphi$ ddacă $\mathcal{A}\models^v \psi$);

-   $\mathcal{A}\models^v \exists x \varphi$ ddacă există $a\in A$ cu $\mathcal{A}\models^{v_{x \leftarrow a}} \varphi$.

## Satifacerea enunţurilor

Fie $\mathcal{A}=(A,(A_s)_{s \in F \cup R})$ o
$\sigma$-structură şi $\varphi$ un enunţ.

Atunci, pentru orice $v_1$, $v_2 : V \to A$, avem
$$\mathcal{A}\models^{v_1} \varphi\mbox{ ddacă }\mathcal{A}\models^{v_2} \varphi,$$
deci sunt echivalente următoarele două afirmații:

- $\mathcal{A} \models\varphi$, adică pentru orice $v:V \to A$, $\mathcal{A}\models^{v} \varphi$
- există $v: V\to A$ cu $\mathcal{A}\models^{v} \varphi$.

## Concepte înrudite

Vom defini următoarele concepte, precum şi noi semnificaţii ale semnului
$\models$, prin analogie cu logica propoziţională:

-   Spunem că $\varphi\in E_\sigma$ este **satisfiabil** dacă există
    $\mathcal{A}$ cu $\mathcal{A}\models \varphi$.

-   Spunem că un enunţ $\varphi$ este **nesatisfiabil** dacă $\varphi$
    nu este satisfiabil.

-   Fie $\varphi$, $\psi \in E_\sigma$. Spunem că din $\varphi$ **se
    deduce semantic** $\psi$ şi scriem $\varphi\models \psi$ dacă pentru
    orice $\mathcal{A}$ cu $\mathcal{A}\models \varphi$ avem
    $\mathcal{A} \models \psi$.

Clar, $\bot$ este enunţ, iar pentru orice $\sigma$-structură
$\mathcal{A}$, avem $\mathcal{A} \not\models \bot$, i.e. $\bot$ este
nesatisfiabil.

## Mulţimi de enunţuri

Complet analog celor din logica propoziţională, vom introduce noţiuni de
satisfiabilitate pentru mulţimi de formule, precum şi semnificaţii
corespunzătoare ale semnului $\models$.

Fie $\Gamma \subseteq E_\sigma$. Pentru orice $\sigma$-structură
$\mathcal{A}$, spunem că $\mathcal{A}$ **satisface** $\Gamma$ sau că
$\mathcal{A}$ este **model** pentru $\Gamma$, şi scriem
$\mathcal{A}\models\Gamma$, dacă pentru orice $\varphi\in\Gamma$,
$\mathcal{A} \models \varphi$.

Spunem că $\Gamma$ este **satisfiabilă** dacă există o
$\sigma$-structură $\mathcal{A}$ cu $\mathcal{A}\models\Gamma$; că este
**nesatisfiabilă** dacă nu este satisfiabilă.

## Proprietăţi

Următoarele proprietăţi se demonstrează perfect analog celor din logica
propoziţională.

Fie $\Gamma \subseteq E_\sigma$, $\Delta \subseteq\Gamma$ şi
$\mathcal{A}$ o $\sigma$-structură. Avem următoarele:

-   Dacă $\mathcal{A}\models\Gamma$, atunci $\mathcal{A}\models\Delta$.

-   Dacă $\Delta$ este nesatisfiabilă, atunci $\Gamma$ este
    nesatisfiabilă.

-   Avem că $\mathcal{A} \models \Gamma$ dacă şi numai dacă pentru orice
    $\Sigma \subseteq\Gamma$ finită, $\mathcal{A} \models \Sigma$.

## Deducţie semantică din mulţimi

Fie $\Gamma \subseteq E_\sigma$ şi $\varphi\in E_\sigma$. Spunem că din
$\Gamma$ **se deduce semantic** $\varphi$, şi scriem
$\Gamma \models \varphi$, dacă pentru orice $\sigma$-structură
$\mathcal{A}$ cu $\mathcal{A}\models \Gamma$ avem
$\mathcal{A} \models \varphi$. Această noţiune are următoarele
proprietăţi analoage celor din logica propoziţională şi demonstrabile
similar.

__Proprietăți__

Fie $\Gamma \subseteq E_\sigma$, $\Delta \subseteq\Gamma$ şi
$\varphi$, $\psi \in E_\sigma$. Avem următoarele:

-   Dacă $\Delta \models \varphi$, atunci $\Gamma \models \varphi$.

-   Mulţimea $\Gamma$ este nesatisfiabilă dacă şi numai dacă
    $\Gamma \models \bot$.

-   Avem $\Gamma\models\varphi$ dacă şi numai dacă
    $\Gamma \cup \{\neg\varphi\}$ este nesatisfiabilă.

# Corectitudinea rezoluției

## Regula rezoluţiei

Fie $G$, $G'$ scopuri şi $C$ clauză cu $Var(G) \cap Var(C) = \emptyset$.
Fie $m$, $k \in \mathbb{N}$ astfel încât
$G = \forall (\neg A_1 \lor \ldots \lor \neg A_m)$ şi
$C = \forall (B_0 \lor \neg B_1 \lor \ldots \lor \neg B_k)$. Considerăm
$B_0$ ca fiind de forma $p(t_1,\ldots,t_n)$. Fie $i \leq m$ astfel încât
$A_i$ este de forma $p(s_1,\ldots,s_n)$. Fie $\theta$ un cgu al lui
$A_i$ şi $B_0$, adică al mulţimii $\{s_1=t_1,\ldots,s_n=t_n\}$. Spunem
că $G'$ este **derivat prin rezoluţie** din $G$, $C$ şi $\theta$, şi
notăm $G \xRightarrow{C,\theta} G'$, dacă
$$G' = \forall (\neg A_1 \lor \ldots \lor \neg A_{i-1} \lor \neg B_1 \lor \ldots \lor \neg B_k \lor \neg A_{i+1} \lor \ldots \lor \neg A_m)\theta.$$

__Notație__: Pentru orice formulă fără cuantificatori $\varphi$ şi orice substituţie
$\theta$, notăm cu $\varphi\theta$ formula care se obţine din $\varphi$
aplicând pe $\theta$ pe toate variabilele sale libere.

## Derivări

Fie $a \in \mathbb{N}^* \cup \{\mathbb{N}\}$. Numim o **$P$-derivare
(prin rezoluţie)** o secvență
$$G_0 \xRightarrow{C_0,\theta_0} G_1 \xRightarrow{C_1,\theta_1} \cdots  \xRightarrow{C_{n-1},\theta_{n-1}}  G_n$$
astfel încât, pentru orice $i < n$,  $C_i$ este o clauză obţinută dintr-o clauză din $P$ prin redenumirea variabilelor sale.

Spunem că **substituţia calculată** a derivării este 
$\widetilde{\theta}_{n-1} \circ \ldots \circ \widetilde{\theta}_1 \circ \theta_0$.

Fie $G$ un scop, $n \in \mathbb{N}^*$ şi
$G_0 \xRightarrow{C_0,\theta_0} G_1 \xRightarrow{C_1,\theta_1} \cdots  \xRightarrow{C_{n-1},\theta_{n-1}}  G_n$
o $P$-derivare cu
$G_0=G$ şi $G_{n}=\bot$. Atunci spunem că derivarea este o
**$P$-respingere** a lui $G$, iar substituţia sa calculată spunem că
este o **$P$-soluţie** a lui $G$.

Fie $G$ un scop, $n \in \mathbb{N}^*$ şi
$G_0 \xRightarrow{C_0,\theta_0} G_1 \xRightarrow{C_1,\theta_1} \cdots  \xRightarrow{C_{n-1},\theta_{n-1}}  G_n$ o $P$-derivare cu
$G_0=G$ şi $G_n \neq \bot$ care nu admite o prelungire. Atunci spunem că derivarea este o **$P$-derivare eşuată**
a lui $G$.

## Teorema de corectitudine

### Teorema de corectitudine
Fie $m \in \mathbb{N}^*$, $A_1,\ldots,A_m$
formule atomice relaţionale şi $\theta$ o $P$-soluţie a lui
$\forall (\neg A_1  \lor \ldots \lor \neg A_m)$. Atunci
$P \models \forall(A_1 \land \ldots \land A_m)\theta$.

### Demonstraţie
Demonstrăm după lungimea $P$-respingerii. Pasul de bază are
loc atunci când avem o singură aplicare a rezoluţiei, aşadar trebuie să
avem $m=1$, iar clauza folosită are tot lungime $1$, fie ea
$\forall B_0$. Atunci $\theta$ este cgu pentru $A_1$ şi $B_0$, deci
$A_1\theta=B_0\theta$. Cum $\forall B_0$ este o redenumire a unei clauze
din $P$, avem $P \models\forall B_0$, deci
$P \models \forall B_0\theta$, aşadar $P \models \forall A_1 \theta$,
ceea ce trebuia demonstrat.

## Teorema de corectitudine

### Demonstraţie (cont.)
Pentru pasul de inducţie, notăm  $P$-respingerea cu
$G_0 \xRightarrow{C_0,\theta_0} G_1 \xRightarrow{C_1,\theta_1} \cdots  \xRightarrow{C_{n-1},\theta_{n-1}}  G_n$.
Luăm $C_0$ de forma
$\forall(B_0 \lor \neg B_1 \lor \ldots \lor \neg B_k)$ şi fie $i$ astfel
încât $\theta_0$ este cgu al lui $A_i$ şi $B_0$. Aşadar, $G_1$ este
$$\forall (\neg A_1 \lor \ldots \lor \neg A_{i-1} \lor \neg B_1 \lor \ldots \lor \neg B_k \lor \neg A_{i+1} \lor \ldots \lor \neg A_m)\theta_0.$$
Din ipoteza de inducţie, avem
$$P \models \forall (A_1 \land \ldots \land A_{i-1} \land B_1 \land \ldots \land B_k \land A_{i+1} \land \ldots \land A_m) \theta.$$
Cum $C_0$ este o redenumire a unei clauze din $P$, avem
$$P \models \forall(B_0 \lor \neg B_1 \lor \ldots \lor \neg B_k)\theta,$$
deci
$P \models \forall (A_1 \land \ldots \land A_{i-1} \land B_0 \land A_{i+1} \land \ldots \land A_m) \theta$.
Cum $B_0\theta_0=A_i\theta_0$, $B_0\theta=A_i\theta$, deci
$P \models \forall(A_1 \land \ldots \land A_m)\theta$.

## O propoziţie

### Propoziţie
Fie $G$ un scop astfel încât există o $P$-respingere a lui
$G$. Atunci $P \cup \{G\}$ este nesatisfiabilă.

### Demonstraţie
Scriem $G=\forall (\neg A_1  \lor \ldots \lor \neg A_m)$.
Din teorema de corectitudine, rezultă
$P \models \exists (A_1 \land \ldots \land A_m)$, deci
$$P \models \neg \forall (\neg A_1  \lor \ldots \lor \neg A_m) = \neg G,$$
de unde obţinem concluzia.


# Universul Herbrand

## Structuri Herbrand

De acum încolo, vom face presupunerea că există măcar o constantă în
signatură, aşadar $\widetilde{T}_\sigma \neq \emptyset$. Notăm cu
$B_\sigma$ (numită **baza Herbrand**) mulţimea tuturor
$\sigma$-formulelor atomice relaţionale fără variabile.

Spunem că o $\sigma$-structură este **Herbrand** atunci când universul
ei este $\widetilde{T}_\sigma$, iar simbolurile de funcţie sunt
interpretate "de ele însele". Observăm că o $\sigma$-structură Herbrand
este complet determinată de mulţimea $J$ a acelor formule din $B_\sigma$
adevărate în ea. Pentru orice submulţime $J$ a lui $B_\sigma$ şi orice
enunţ $\varphi$, spunem că $J \models_H \varphi$ atunci când structura
Herbrand asociată lui $J$ satisface $\varphi$.

Dacă $\mathcal{A}$ este o $\sigma$-structură, vom nota
$J_\mathcal{A}:= \{\varphi\in B_\sigma \mid \mathcal{A} \models \varphi\}$.

## Proprietăţi

### Teoremă
Fie $\mathcal{A}$ o $\sigma$-structură şi $\varphi$ o clauză
definită (sau un scop definit) cu $\mathcal{A} \models \varphi$. Atunci
$J_\mathcal{A} \models_H \varphi$.

### Demonstraţie
Presupunem $\varphi$ clauză definită. Avem că există $m$,
$n \in \mathbb{N}$, formule atomice relaţionale $A_0$, $A_1,\ldots,A_m$
şi variabile $x_1,\ldots,x_n$ cu
$$\varphi= \forall x_1\ldots\forall x_n(A_0 \lor \neg A_1 \lor\ldots\lor \neg A_m).$$
Fie $t_1,\ldots,t_n \in \widetilde{T}_\sigma$. Notăm, pentru orice $i$,
$A'_i:=A_i[x_1:=t_1]\ldots[x_n:=t_n]$ şi
$\varphi':=A'_0 \lor \neg A'_1 \lor\ldots\lor \neg A'_m$. Vrem
$J_\mathcal{A}\models_H\varphi'$. Presupunem că, pentru orice
$i \geq 1$, $J_\mathcal{A}\models_H A'_i$. Arătăm că
$J_\mathcal{A} \models_H A'_0$. Deci, pentru orice $i \geq 1$, cum
$A'_i \in B_\sigma$, $A'_i \in J_\mathcal{A}$, deci
$\mathcal{A}\models A'_i$. Cum $\mathcal{A} \models \varphi$, avem
$\mathcal{A} \models \varphi'$, iar, cum, pentru orice $i \geq 1$,
$\mathcal{A}\models A'_i$, avem $\mathcal{A}\models A'_0$. Cum
$A'_0 \in B_\sigma$, $A'_0 \in J_\mathcal{A}$, deci
$J_\mathcal{A} \models_H A'_0$.

## Proprietăţi

### Teoremă
Fie $P$ un program. Atunci
$K_P:=\{J \subseteq B_\sigma \mid J \models_H P\}$ este o mulţime Moore
pe $B_\sigma$.

::: block
### Demonstraţie
Faptul că $B_\sigma \models_H P$ rămâne ca exerciţiu. Fie
acum $K \subseteq K_P$ cu $K \neq\emptyset$. Vrem
$\bigcap K \models_H P$. Fie $\varphi\in P$. Fie
$t_1,\ldots,t_n \in \widetilde{T}_\sigma$. Folosim aceleaşi notaţii ca
în demonstraţia precedentă. Presupunem că, pentru orice $i \geq 1$,
$\bigcap K \models_H A'_i$. Arătăm că $\bigcap K \models_H A'_0$. Deci,
pentru orice $i \geq 1$, cum $A'_i \in B_\sigma$, $A'_i \in \bigcap K$,
deci, pentru orice $J \in K$, $A'_i \in J$, adică $J \models_H A'_i$.
Fie $J \in K$. Avem $J \models_H \varphi$, deci $J \models_H \varphi'$,
iar, cum, pentru orice $i \geq 1$, $J\models_H A'_i$, avem
$J\models_H A'_0$, deci, cum $A'_0 \in B_\sigma$, $A'_0 \in J$. Aşadar,
$A'_0 \in \bigcap K$, deci $\bigcap K\models_H A'_0$.
:::

Pentru orice program $P$, notăm $M_P := \bigcap K_P \in K_P$.

## Proprietăţi

### Teoremă
Pentru orice program $P$,
$M_P = \{\varphi\in B_\sigma \mid P \models \varphi\}$.

::: block
### Demonstraţie
Pentru $\supseteq$", fie $\varphi\in B_\sigma$ cu
$P \models \varphi$. Fie $J \in K_P$. Vrem $\varphi\in J$. Cum
$J \models_H P$, avem $J \models_H \varphi$, iar, cum
$\varphi\in B_\sigma$, $\varphi\in J$.

Pentru $\subseteq$", fie $\varphi\in M_P$. Fie $\mathcal{A}$ cu
$\mathcal{A} \models P$. Vrem $\mathcal{A} \models \varphi$. Cum $P$
este o mulţime de clauze definite, dintr-o teoremă anterioară avem
$J_\mathcal{A} \models_H P$, deci $J_\mathcal{A} \in K_P$. Rezultă
$M_P \subseteq J_\mathcal{A}$, deci $\varphi\in J_\mathcal{A}$, adică
$J_\mathcal{A} \models_H \varphi$. Rezultă
$\mathcal{A} \models \varphi$.
:::

Numim $M_P$ __modelul Herbrand__ asociat programului $P$

# Completitudinea rezoluției

## Operatorul $T_P$

Definim operatorul
$T_P: \mathcal{P}(B_\sigma) \to \mathcal{P}(B_\sigma)$ în felul următor:
pentru orice $J$, $T_P(J)$ este mulţimea acelor $\varphi\in B_\sigma$ cu
proprietatea că există $A_1,\ldots,A_m \in J$ astfel încât
$\varphi\lor\neg A_1 \lor \ldots \lor \neg A_m$ este instanţă a unei
clauze din $P$.

### Propoziţie
Pentru orice $J$, $J \models_H P$ dacă şi numai dacă
$T_P(J) \subseteq J$.

::: block
### Corolar
Pentru orice $\varphi$, $\varphi\in M_P$ dacă şi numai dacă,
pentru orice $J$ cu $T_P(J) \subseteq J$, $\varphi\in J$.
:::

Se observă şi că $T_P$ este monoton şi, deci, din cele de mai sus,

$$M_P = \mu T_P = \bigcap \{J \mid T_P(J) \subseteq J \}.$$

## Mulţimea $S_P$

Definim mulţimea $S_P$ ca fiind submulţimea lui $B_\sigma$ a acelor
$\varphi$ cu proprietatea că există o $P$-respingere a lui
$\neg\varphi$.

### Propoziţie
$S_P \subseteq M_P$.

### Demonstraţie
Fie $\varphi\in S_P$, adică există o $P$-respingere a lui
$\neg\varphi$. Din Teorema de corectitudine, rezultă
$P \models \varphi$, adică $\varphi\in M_P$.

## Spre completitudine

### Propoziţie
$M_P \subseteq S_P$.

### Demonstraţie
Din cele spuse mai devreme, este suficient să arătăm că
$T_P(S_P) \subseteq S_P$. Fie $\varphi\in T_P(S_P)$. Atunci
$\varphi\in B_\sigma$ şi există $A_1,\ldots,A_m \in S_P$ astfel încât
$\varphi\lor\neg A_1 \lor \ldots \lor \neg A_m$ este instanţă a unei
clauze din $P$. Avem că există $P$-respingeri pentru
$\neg A_1,\ldots,\neg A_m$, iar, punându-le cap la cap (nu detaliem cum,
dar este important că sunt toate din $B_\sigma$), obţinem o
$P$-respingere pentru $\neg \varphi$, deci $\varphi\in S_P$.

### Corolar
Pentru orice $\varphi\in B_P$ cu $P \models\varphi$,
$\varphi\in S_P$.

## Spre completitudine

### Lemă
Fie $\varphi$ o formulă atomică relaţională cu
$P \models \forall \varphi$. Atunci există o $P$-respingere a lui
$\neg\varphi$ cu substituţia calculată fiind identitatea.

### Demonstraţie
Scriem $Var(\varphi)=\{z_1,\ldots,z_n\}$. Introducem
constante noi $a_1,\ldots,a_n$ şi considerăm substituţia $\theta$ care
duce, pentru orice $i$, $z_i$ în $a_i$. Atunci
$\varphi\theta \in B_\sigma$, deci, din corolarul anterior, există o
$P$-respingere a lui $\neg\varphi\theta$. Clar, dat fiind că nu apar
variabile, substituţia calculată trebuie să fie identitatea. Schimbăm în
substituţie din nou $a_i$-urile cu $x_i$-uri (de ce putem face asta?) şi
obţinem $P$-respingerea cerută.

## Teorema de completitudine

### Teorema de completitudine
Fie $m \in \mathbb{N}^*$, $A_1,\ldots,A_m$
formule atomice relaţionale şi $\sigma$ o substituţie astfel încât
$P \models \forall(A_1 \land \ldots \land A_m) \sigma$. Atunci există o
$P$-soluţie $\theta$ pentru
$\forall (\neg A_1  \lor \ldots \lor \neg A_m)$ astfel încât
$\forall(A_1 \land \ldots \land A_m) \sigma$ este o instanţă a lui
$\forall(A_1 \land \ldots \land A_m) \theta$.

### Demonstraţie (schiţă)
Pentru orice $i$, avem
$P \models \forall A_i \sigma$, deci, din lemă, există o $P$-respingere
a lui $\neg A_i \sigma$ cu substituţia calculată fiind identitatea. Din
nou, putem pune cap la cap şi obţin o $P$-respingere a lui
$\forall(\neg A_1 \lor\ldots\lor\neg A_m)\sigma$ cu substituţia
calculată fiind identitatea. Aplicând un rezultat tehnic (Lema de
ridicare), putem obţine o $P$-respingere a lui
$\forall (\neg A_1  \lor \ldots \lor \neg A_m)$, din ale cărei
informaţii obţinem substituţia cerută.
