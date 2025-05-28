---
author: Traian Florin Șerbănuță și Andrei Sipoș
institute: Facultatea de Matematică și Informatică, DL Info
date: Anul II, Semestrul II, 2024/2025
title: Fundamentele limbajelor de programare
subtitle: Programare funcțională. Lambda-calcul cu tipuri simple. Inferența tipurilor. Normalizare.
theme: CambridgeUS
---

# Algoritmul de inferență a tipurilor

## Reguli de deducție pentru tipuri (a la Curry)

- $\reg[var]{\Gamma \uplus \{x:\sigma\} \vdash x:\sigma}{}{}$

- $\reg[abs]{\Gamma \vdash \lambda x. M : \sigma\to \tau}{\Gamma \oplus \{x:\sigma\} \vdash M : \tau}{}$

- $\reg[app]{\Gamma\vdash M\; N : \tau}{\Gamma\vdash M: \sigma \to \tau \quad \Gamma \vdash N: \sigma}{}$


## Algoritmul de inferență a tipurilor

Pornim cu un $\lambda$ termen fără tipuri în care variabilele au fost redenumite, presupunem că fiecărei variabile $x$ îi asociem un tip $X$, unde $X$ e variabilă.

$$\begin{aligned}
c(x, Z) &:= \{X = Z\}\\
c(\lambda x. M, Z) &:= c(M, W) \cup \{Z = X \to W\}\\
c(M\; N, Z) &:= c(M, W_1) \cup c(N, W_2) \cup \{W_1 = W_2 \to Z\}
\end{aligned}$$

Corectitudine

: Dacă $\theta$ unificator pentru $c(M, Z)$, atunci $\Gamma_\theta \vdash M : \theta(Z)$, unde $\Gamma_\theta = \{x : \theta(X) \mid x \mbox{ variabilă}\}$.

Completitudine

: $\Gamma \vdash M : \sigma$ implică există $\theta$ unificator pentru $c(M, Z)$ cu\
  - $\Gamma(x) = \Gamma_\theta(x)$ pentru orice $x\in FV(M)$ și\
  - $\theta(Z) = \sigma$

## Corectitudinea algoritmului de inferență

Dacă $\theta$ unificator pentru $c(M, Z)$, atunci $\Gamma_\theta \vdash M : \theta(Z)$, unde $\Gamma_\theta = \{x : \theta(X) \mid x \mbox{ variabilă}\}$.

### Demonstrație

Inducție după structura lui $M$

- $M = x$: $c(M, Z) = \{X = Z\}$ evident, deoarece $x : \theta(X) \in \Gamma_\theta$ și $\theta(X) = \theta(Z)$ (regula \textsc{var}).

- $M = \lambda x. N$:  $c(M,Z) = c(N, W) \cup \{Z = X \to W\}$.

  Fie $\theta$ unificator. Atunci unificator pentru $c(N, W)$ și 
  $\theta(Z) = \theta(X) \to \theta(W)$. 

  Din ip. inducție, $\Gamma_\theta \vdash N : \theta(W)$
  Dar $x : \theta(X) \in \Gamma_\theta$, deci
  $\Gamma_\theta \vdash \lambda x. N : \theta(X) \to \theta(W) = \theta(Z)$ (regula \textsc{abs}).

- $M = N\ P$: $c(M, Z) = c(N, W_1) \cup c(P, W_2) \cup \{W_1 = W_2 \to Z\}$

  Fie $\theta$ unificator. Atunci unificator pentru $c(N, W_1)$, $c(P, W_2)$ și 
  $\theta(W_1) = \theta(W_2) \to \theta(Z)$. 

  Din ip. inducție, $\Gamma_\theta \vdash N : \theta(W_1) = \theta(W_2) \to \theta(Z)$ și $\Gamma_\theta \vdash P : \theta(W_2)$, de unde $\Gamma_\theta \vdash N\ P : \theta(Z)$ (regula \textsc{app}).

## Completitudinea algoritmului de inferență

Dacă $\Gamma \vdash M : \sigma$ atunci există $\theta$ unificator pentru $c(M, Z)$ cu

  - $\Gamma(x) = \Gamma_\theta(x)$ pentru orice $x\in FV(M)$ și
  - $\theta(Z) = \sigma$

### Demonstrație (inducție după $\Gamma \vdash M : \sigma$)

- $\reg[var]{\Gamma \uplus \{x:\sigma\} \vdash x:\sigma}{}{}$
  
  $c(x, Z) = \{X = Z\}$, Aleg $\theta(X) = \theta(Z) = \sigma$

- $\reg[abs]{\Gamma \vdash \lambda x. M : \sigma\to \tau}{\Gamma \oplus \{x:\sigma\} \vdash M : \tau}{}$

  $c(\lambda x. M, Z) = c(M, W) \cup \{Z = X \to W\}$

  Din ip. ind, fie $\theta$ unificator pt $c(M, W)$ astfel încât
  $\theta(W) = \tau$ și $\Gamma(x) = \Gamma_\theta(x)$ pentru orice $x\in FV(M)$. Deoarece $Z$ nu apare în $c(M, W)$, pot alege $\theta' = \theta[Z := \theta(X) \to \theta(W)]$ și observa că satisface condițiile.

## Completitudinea algoritmului de inferență

### Demonstrație (cont.)

- $\reg[app]{\Gamma\vdash M\; N : \tau}{\Gamma\vdash M: \sigma \to \tau \quad \Gamma \vdash N: \sigma}{}$

  $c(M\; N, Z) = c(M, W_1) \cup c(N, W_2) \cup \{W_1 = W_2 \to Z\}$

  Fie $\theta_M$ unificator pt $c(M, W_1)$ astfel încât
  $\theta_M(W_1) = \sigma \to \tau$ și $\Gamma(x) = \Gamma_{\theta_M}(x)$ pentru orice $x\in FV(M)$.

  Fie $\theta_N$ unificator pt $c(N, W_2)$ astfel încât
  $\theta_N(W_2) = \sigma$ și $\Gamma(x) = \Gamma_{\theta_N}(x)$ pentru orice $x\in FV(N)$.

  Definesc $\theta(U) := \begin{cases}
    \theta_M(U), & \mbox{dac\u a } U \mbox{ apare în } c(M, W_1), \\
    \theta_N(U), & \mbox{dac\u a } U \mbox{ apare în } c(N, W_2), \\
    \tau, & \mbox{dacă } U = Z
  \end{cases}$

  E bine definit, deoarece variabilele comune între $c(M, W_1)$ și $c(N, W_2)$ pot fi doar variabilele libere, pe care trebuie să fie de acord cu $\Gamma$.

# Normalizare

## Ce este Normalizarea?

- Normalizarea este proprietatea conform căreia orice termen bine format se poate (beta-)reduce la o formă normală.
- În Calculul Lambda cu Tipuri Simple (CLTS), toți termenii bine formați sunt normalizabili.

---

## Obiectivul demonstrației

- Dorim să demonstrăm că **toți termenii bine formați** în CLTS sunt **puternic normalizabili**.
- Aceasta implică că nu există secvențe infinite de reduceri beta pentru astfel de termeni.

---

## Preliminarii

- Sistemul de tipuri este bazat pe:
  - Variabile de tip (tipuri de bază): $\alpha$
  - Tipuri funcționale: $A \rightarrow B$
- Reguli de formare a termenilor:
  - Variabilă
  - Abstracție
  - Aplicație

---

## Reguli de bună formare (a la Church)

1. $\reg[Variabilă]{x : A}{}{x \mbox{ are tipul } A}$

2. $\reg[Abstracție]{\lambda x.\ t : A \rightarrow B}{t : B}{x \mbox{ are tipul } A}$

3. $\reg[Aplicație]{t\ u : B}{t : A \rightarrow B \qquad u : A}{}$

---

## Substituția și $\alpha$-echivalența

Substituția și $\alpha$-echivalența sunt bine definite pentru termeni cu tipuri:

- Substituția $t:A[x := N:B]$ este definită când tipul lui $x$ este $B$ și rezultatul are tipul $A$

   - se demonstrează (relativ) ușor prin inducție asupra lui $t:A$

- Alpha-echivalența permite înlocuirea variabilelor legate cu variabile _de același tip_

---

## Beta-reducția

- $\reg[beta]{(\lambda x.\ t)\ u \Rightarrow t[x := u]}{}{}$
  
  - se observă că dacă $x$ are tipul $A$, și $t:B$ atunci și $u:A$, pentru ca să putem avea termenul $(\lambda x.\ t)\ u : B$
  - deci substituția este bine definită și termenul obținut e de acelaș tip ca redex-ul

- Plus regulile de compatibilitate cu abstracția și aplicație (și ele sunt bine definite)

  Reducerile pot apărea oriunde într-un termen (nu doar la vârf).

  $\reg{\lambda x.\ t \Rightarrow \lambda x.\ t'}{t \Rightarrow t'}{}$ \hfill
  $\reg{t\ u \Rightarrow t'\ u}{t \Rightarrow t'}{}$ \hfill
  $\reg{t\ u \Rightarrow t\ u'}{u \Rightarrow u'}{}$

---

## Subject reduction (conservarea tipului)

### Lemă

Dacă $t : A$ și $t \Rightarrow t'$ atunci $t' : A$.

### Demonstrație

Inducție după relația de rescriere, folosind buna definiție a substituției pentru cazul de bază.

---

## Forme normale (sintactic)

O formă normală este un termen care nu are nici un redex. Poate fi definită prin reguli:

- $\reg[FNvar]{FN(x)}{}{}$

- $\reg[FNabs]{FN(\lambda x. t)}{FN(t)}{}$

- $\reg[FNapp1]{FN(x\ u)}{FN(u)}{}$

- $\reg[FNapp2]{FN((t\ u)\ v)}{FN(t\ u) \qquad FN(v)}{}$

---

## Strategia generală

1. Definim noțiunea de **SN (strongly normalizing)**.
2. Definim o interpretare a tipurilor prin mulțimi de termeni SN.
3. Demonstrăm că toți termenii bine formați aparțin acestor mulțimi.

---

## Normalizare Puternică (SN)

- Un termen este **puternic normalizabil** dacă toate secvențele de reduceri beta se termină.
  - Adică: nu există reduceri infinite.
- Inductiv: cea mai mică mulțime care conține formele normale și e închisă la regula:
    dacă pentru orice $t'$ astfel încât $t \rightarrow t'$ avem că $t'$ e în mulțime, atunci și $t$ e în mulțime

- $\reg[SNfn]{SN(t)}{}{FN(t)}$

- $\reg[SNacc]{SN(t)}{SN(t') \mbox{ pentru orice } t' \mbox{ pentru care } t \Rightarrow t'}{}$
 
---

## Interpretarea tipurilor

Fie $[[ A ]]$ interpretarea semantică a unui tip A, definită recursiv astfel:

Tipuri de bază

: $[[ \alpha ]]$ conține exact termeni puternic normalizabili de tip $\alpha$

  $$[[\alpha]] = \{t:\alpha \mid SN(t) \}$$

Tipuri săgeată

: $[[A \rightarrow B]]$ conține acei termeni care aplicați tuturor termenilor din $[[A]]$ sunt în $[[B]]$
  
  $$[[A \rightarrow B]] := \{ t\mid \forall u \in [[A]],\ t\ u \in [[B]] \}$$


---

## Proprietăți ale interpretării

- Dacă $t \in [[A \rightarrow B]]$ și $u \in [[A]]$, atunci $t\ u \in [[B]]$.
- Dacă $t \in [[A]]$ atunci $t: A$
- Toți termenii din interpretare sunt puternic normalizabili.
  - Prin inducție: dacă $SN(t\ u)$ atunci și $SN(t)$ normalizabil

---

## $[[A]]$ conține variabilele de tip $A$

### Lema

Pentru orice variabilă $x$ de tip $A_1 \to \cdots \to A_n \to A$, $n\geq 0$ și orice secvență de
  termeni $t_i \in [[A_i]]$, $x\ t_1 \cdots t_n \in [[A]]$
  
### Demonstrație: inducție după $A$.
  
- $A = \alpha$. Reiese din definiție, deoarece
  $SN(x\ t_1 \cdots t_n)$ (nu adaugă redexuri noi față de $t_i$).

- $A = B \to C$. Fie $u \in [[B]]$.
  Instanțiem ipoteza de inducție pentru $C$ cu $n+1$ și $A_{n + 1} = B$ și $t_{n+1} = u$.
  Deci, $x\ t_1 \cdots t_n \ u \in [[C]]$
  Deoarece $u$ ales arbitrar, $x\ t_1 \cdots t_n \in [[B \to C]]$

### Corolar

Dacă $x$ e de tip $A$, atunci $x \in [[A]]$

---

## $[[A]]$ e închisă la reducție

### Lema

Dacă $t \in [[A]]$ și $t \Rightarrow t'$ atunci $t' \in [[A]]$.

### Demonstrație: inducție după $A$.

- Dacă $A = \alpha$, atunci $SN(t)$ și deci și $SN(t')$

- Dacă $A = B \to C$, fie $u \in [[B]]$, arbitrar.
  Avem că $t\ u \in [[C]]$.
  
  Aplicând ipoteza de inducție pentru $C$ și 
  $t\ u \Rightarrow t'\ u$, reiese că $t'\ u \in [[B]]$

  Deoarece $u$ arbitrar ales, reiese că $t' \in [[B \to C]]$

---

## Substituție compatibilă

### Definiție

O substituție de la variabile la termeni se numește compatibilă (cu interpretarea) dacă duce orice variabilă de tip $A$ într-un termen din $[[A]]$, interpretarea lui $A$.

### Observație

Substituția identitate este compatibilă.

---

## Teoremă: Toți termenii cu tipuri simple sunt în SN

### Demonstrație

Deoarece substituția identitate este compatibilă și interpretarea
unui tip conține doar termeni în SN, este suficient să demonstrăm următorul rezultat:

Dacă $t : A$ atunci pentru orice substituție compatibilă $\sigma$, $t\sigma$ este bine format și aparține lui $[[A]]$.

---

## Teoremă: Toți termenii cu tipuri simple sunt în SN

_Suficient:_ Dacă $t : A$ atunci pentru orice substituție compatibilă $\sigma$, $t\sigma$ este bine format și aparține lui $[[A]]$.

### Demonstrație: inducție pe definiția lui $t : A$


- $\reg[Variabilă]{x : A}{}{x \mbox{ are tipul } A}$

  Atunci $t\sigma = \sigma(x) \in [[A]]$ din definiția lui $\sigma$

- $\reg[Aplicație]{t\ u : B}{t : A \rightarrow B \qquad u : A}{}$

  Din ipoteza de inducție, $t\sigma \in [[A \rightarrow B]]$ și $u\sigma \in [[A]]$,
  de unde $(t\ u)\sigma = t\sigma\ u\sigma \in [[B]]$

---

## Teoremă: Toți termenii cu tipuri simple sunt în SN

### Demonstrație (continuare)

$\reg[Abstracție]{\lambda x.\ t : A \rightarrow B}{t : B}{x \mbox{ are tipul } A}$

Din ipoteza de inducție, pentru orice $\sigma$ compatibilă, $t\sigma \in [[B]]$.

Fie $\sigma$ compatibilă. Vrem ca $(\lambda x.\ t)\sigma \in [[A \rightarrow B]]$

E suficient să arătăm următorul rezultat mai general (instanțiat pentru $n=0$):

Dacă $t\sigma \in [[A_1 \to \cdots A_n \to B]]$ pentru orice $\sigma$ compatibilă și $x$ de tip $A_0$ și $u_i \in [[A_i]]$ pentru $0\leq i \leq n$,
atunci pentru orice $\sigma$, $(\lambda x.\ t)\sigma u_0 u_1 \cdots u_n \in [[B]]$.

---

## Teoremă: Toți termenii cu tipuri simple sunt în SN

_Suficient:_ Dacă $t\sigma \in [[A_1 \to \cdots A_n \to B]]$ pentru orice $\sigma$ compatibilă și $x$ de tip $A_0$ și $u_i \in [[A_i]]$ pentru $0\leq i \leq n$,
atunci pentru orice $\sigma$, $(\lambda x.\ t)\sigma u_0\ u_1 \cdots u_n \in [[B]]$

### Demonstrație

Demonstrație prin inducție după $B$

$B = A_{n+1} \to B'$:

: trebuie să arăt că pentru orice $\sigma$, $(\lambda x.\ t)\sigma u_0 u_1 \cdots u_n \in [[A_{n+1}\to B']]$.\
  Fie $u_{n+1}$ arbitrar ales. Aplic ipoteza de inducție pentru $B'$ și $t\sigma \in [[A_1 \to \cdots A_n \to A_{n+1} \to B']]$ și $x$ de tip $A_0$ și $u_i$, $0\leq i \leq n+1$ și obțin
  $(\lambda x.\ t)\sigma u_0\ u_1 \cdots u_n\ u_{n+1} \in [[B']]$\
  Concluzia urmează din faptul că $u_{n+1}$ arbitrar ales.

---

## Teoremă: Toți termenii cu tipuri simple sunt în SN

_Suficient:_ Dacă $t\sigma \in [[A_1 \to \cdots A_n \to B]]$ pentru orice $\sigma$ compatibilă și $x$ de tip $A_0$ și $u_i \in [[A_i]]$ pentru $0\leq i \leq n$,
atunci pentru orice $\sigma$, $((\lambda x.\ t)\sigma) u_0\ u_1 \cdots u_n \in [[B]]$

### Demonstrație (continuare)

Dacă $B = \alpha$, trebuie să arăt că
$SN(((\lambda x.\ t)\sigma) u_0 u_1 \cdots u_n)$.

Reducere la absurd.
Avem $(\lambda x.\ t)\sigma = \lambda x.\ (t\sigma')$ unde $\sigma' = \sigma[x := x]$.

Fie $(\lambda x.\ t\sigma') u_0 u_1 \cdots u_n = t_0 \xRightarrow{n_0} t_1 \xRightarrow{n_1} \cdots$ o secvență infinită.

Fie $t_k \xRightarrow{n_k} t_{k+1}$ primul pas pentru care $n_k = 1$
(trebuie să existe, pentru că toți ceilalți redecși sunt în $t\sigma'$ șau $u_i$ pentru vreun $i$ și ei sunt in $SN$.

Atunci $t_k$ e de forma $(\lambda x.\ t'\sigma'') u_0' u_1' \cdots u_n'$ unde $t \Rightarrow^* t'$, $u_i \Rightarrow^* u_i'$ și pentru orice $y\in FV(t)\setminus \{x\}$, $\sigma'(y) \Rightarrow^* \sigma''(y)$, iar pentru orice alt $y$, $\sigma''(y) = \sigma'(y)$.
Deci $t_{k + 1} = (t'\sigma''[x := u_0']) u_1'\cdots u_n'$.

Din $t\sigma \in [[A_1 \to \cdots A_n \to \alpha]]$ pentru orice $\sigma$, iese că $t'\sigma \in [[A_1 \to \cdots A_n \to \alpha]]$ pentru orice $\sigma$ și aleg $\sigma = \sigma''[x := u_0']$, apoi
folosind definiția interpretării iese că $(t'\sigma''[x := u_0']) u_1'\cdots u_n' \in [[\alpha]]$ deci în SN, contradicție.


---

## Consecințe ale normalizării

- Nu există bucle infinite în CLTS.
- Programele scrise în acest sistem se termină întotdeauna.
- CLTS nu este Turing complet.
- Putem demonstra confluența mai simplu
  - Local confluență și terminare implică confluență

---

## Concluzie

- Calculul Lambda cu Tipuri Simple are proprietatea de normalizare puternică.
- Am demonstrat acest lucru prin interpretarea semantică a tipurilor în termeni puternic normalizabili (Metoda lui Tait).
- Sistemul oferă garanția că orice funcție este totală.

---

## Referințe

- H. Barendregt, *The Lambda Calculus: Its Syntax and Semantics*
