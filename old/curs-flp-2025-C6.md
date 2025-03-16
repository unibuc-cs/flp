---
author: Traian Florin Șerbănuță și Andrei Sipoș
institute: Facultatea de Matematică și Informatică, DL Info
date: Anul II, Semestrul II, 2024/2025
title: Fundamentele limbajelor de programare
subtitle: 6. Programare logică. Rezoluție. Completitudine.
theme: CambridgeUS
---

## Clauze şi scopuri

Reamintim că o **clauză (definită)** era o formulă de forma
$$\forall (A_0 \lor \neg A_1 \lor \ldots \lor \neg A_m),$$ unde
$A_0,\ldots,A_m$ erau formule atomice relaţionale, un **program** era o
mulţime finită de clauze, iar un **scop** era o formulă de forma
$$\forall (\neg A_1  \lor \ldots \lor \neg A_m).$$ Formula de mai sus
este echivalentă semantic cu
$$\neg \exists (A_1 \land \ldots \land A_m),$$ care corespunde intuitiv
ideii de a căuta o soluţie.

Pentru orice formulă fără cuantificatori $\varphi$ şi orice substituţie
$\theta$, notăm cu $\varphi\theta$ formula care se obţine din $\varphi$
aplicând pe $\theta$ pe toate variabilele sale libere.

## Regula rezoluţiei

Fie $G$, $G'$ scopuri şi $C$ clauză cu $Var(G) \cap Var(C) = \emptyset$.
Fie $m$, $k \in \mathbb{N}$ astfel încât
$G = \forall (\neg A_1 \lor \ldots \lor \neg A_m)$ şi
$C = \forall (B_0 \lor \neg B_1 \lor \ldots \lor \neg B_k)$. Considerăm
$B_0$ ca fiind de forma $p(t_1,\ldots,t_n)$. Fie $i \leq m$ astfel încât
$A_i$ este de forma $p(s_1,\ldots,s_n)$. Fie $\theta$ un cgu al lui
$A_i$ şi $B_0$, adică al mulţimii $\{s_1=t_1,\ldots,s_n=t_n\}$. Spunem
că $G'$ este **derivat prin rezoluţie** din $G$, $C$ şi $\theta$, şi
notăm $(G,C,\theta) \triangleright G'$, dacă
$$G' = \forall (\neg A_1 \lor \ldots \lor \neg A_{i-1} \lor \neg B_1 \lor \ldots \lor \neg B_k \lor \neg A_{i+1} \lor \ldots \lor \neg A_m)\theta.$$


De acum încolo, vom fixa $P$ un program.


## Derivări

Fie $a \in \mathbb{N}^* \cup \{\mathbb{N}\}$. Numim o **$P$-derivare
(prin rezoluţie)** un triplet
$((G_i)_{i <a}, (C_i)_{i+1<a}, (\theta_i)_{i+1<a})$, astfel încât,
pentru orice $i$ cu $i+1<a$, $C_i$ este o clauză obţinută dintr-o clauză
din $P$ prin redenumirea variabilelor sale şi
$(G_i,C_i,\theta_i) \triangleright G_{i+1}$.

Fie $n \in \mathbb{N}^*$ şi
$((G_i)_{i <n}, (C_i)_{i+1<n}, (\theta_i)_{i+1<n})$ o $P$-derivare.
Spunem că **substituţia calculată** a sa este
$\widetilde{\theta}_{n-2} \circ \ldots \circ \widetilde{\theta}_1 \circ \theta_0$.

Fie $G$ un scop, $n \in \mathbb{N}^*$ şi
$((G_i)_{i <n}, (C_i)_{i+1<n}, (\theta_i)_{i+1<n})$ o $P$-derivare cu
$G_0=G$ şi $G_{n-1}=\bot$. Atunci spunem că derivarea este o
**$P$-respingere** a lui $G$, iar substituţia sa calculată spunem că
este o **$P$-soluţie** a lui $G$.

Fie $G$ un scop, $n \in \mathbb{N}^*$ şi
$((G_i)_{i <n}, (C_i)_{i+1<n}, (\theta_i)_{i+1<n})$ o $P$-derivare cu
$G_0=G$ şi $G_{n-1} \neq \bot$ care nu admite o prelungire la una de
lungime $n+1$. Atunci spunem că derivarea este o **$P$-derivare eşuată**
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
Pentru pasul de inducţie, notăm cu
$((G_i)_{i <n}, (C_i)_{i+1<n}, (\theta_i)_{i+1<n})$ $P$-respingerea.
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

## Operatorul $T_P$

Putem defini operatorul
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
$M_P = \mu T_P$.

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
