---
author: Traian Florin Șerbănuță și Andrei Sipoș
institute: Facultatea de Matematică și Informatică, DL Info
date: Anul II, Semestrul II, 2024/2025
title: Fundamentele limbajelor de programare
subtitle: Programare funcțională. Lambda-calcul cu tipuri simple. Normalizare.
theme: CambridgeUS
---


## Ce este Normalizarea?

- Normalizarea este proprietatea conform căreia orice termen tipizat se poate reduce (beta-reduce) la o formă normală.
- În Calculul Lambda Tipizat Simplu (CLTS), toți termenii bine formați sunt normalizabili.

---

## Obiectivul demonstrației

- Dorim să demonstrăm că **toți termenii tipizați** în CLTS sunt **puternic normalizabili**.
- Aceasta implică că nu există secvențe infinite de reduceri beta pentru astfel de termeni.

---

## Preliminarii

- Sistemul de tipuri este bazat pe:
  - Variabile de tip (tipuri de bază)
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
  
  - se observă că dacă $x$ are tipul $A$, și $t:B$ atunci și $u:A$ (pentru ca să putem avea termenul $(\lambda x.\ t)\ u : B$
  - deci substituția este bine definită și termenul obținut e de acelaș tip ca redex-ul

- Plus regulile de compatibilitate cu abstracția și aplicație (și ele sunt bine definite)

  Reducerile pot apărea oriunde într-un termen (nu doar la vârf).

  $\reg{\lambda x.\ t \Rightarrow \lambda x.\ t'}{t \Rightarrow t'}{}$ \hfill
  $\reg{t\ u \Rightarrow t'\ u}{t \Rightarrow t'}{}$ \hfill
  $\reg{t\ u \Rightarrow t\ u'}{u \Rightarrow u'}{}$

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
3. Demonstrăm că toți termenii tipizați aparțin acestor mulțimi.

---

## Normalizare Puternică (SN)

- Un termen este **puternic normalizabil** dacă toate secvențele de reduceri beta se termină.
  - Adică: nu există reduceri infinite.
- Inductiv: cea mai mică mulțime care conține formele normale și e închisă la regula:
    dacă pentru orice $t'$ astfel încât $t \rightarrow t'$ avem că $t'$ e în mulțime, atunci și $t$ e în mulțime

- $\reg[SNfn]{SN(t)}{}{FN(t)}$

- $\reg[SNacc]{SN(t)}{SN(t') \mbox{ for all } t' \mbox{ such that } t \Rightarrow t'}{}$
 
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
  - Prin inducție: dacă $t\ u$ normalizabil, atunci și $t$ normalizabil
- Pentru orice variabilă $x$ de tip $A_1 \to \cdots \to A_n \to A$, $n\geq 0$ și orice secvență de
  termeni $t_i \in [[A_i]]$, $x\ t_1 \cdots t_n \in [[A]]$
  
  
  Inducție după $A$.
  
  $A = \alpha$. Reiese din definiție, deoarece
  $SN(x\ t_1 \cdots t_n)$ (nu adaugă redexuri noi față de $t_i$).

  $A = B \to C$. Fie $u \in [[B]]$.
  Instanțiem ipoteza de inducție pentru $C$ cu $n+1$ și $A_{n + 1} = B$ și $t_{n+1} = u$.
  Deci, $x\ t_1 \cdots t_n \ u \in [[C]]$
  Deoarece $u$ ales arbitrar, $x\ t_1 \cdots t_n \in [[B \to C]]$
- Corolar: dacă $x$ e de tip $A$, atunci $x \in [[A]]$

---

## Lemă de substituție

Dacă $t : A$ atunci pentru orice substituție $\sigma$ care asociază fiecărei 
variabile un termen din interpretarea tipului variabilei, $t\sigma$ este bine format și aparține lui $[[A]]$.

Numim o astfel de substituție _compatibilă cu interpretarea_.

### Demonstrație: inducție pe definiția lui $t : A$


- $\reg[Variabilă]{x : A}{}{x \mbox{ are tipul } A}$

  Atunci $t\sigma = \sigma(x) \in [[A]]$

- $\reg[Aplicație]{t\ u : B}{t : A \rightarrow B \qquad u : A}{}$

  Din ipoteza de inducție, $t\sigma \in [[A \rightarrow B]]$ și $u\sigma \in [[A]]$,
  de unde $(t\ u)\sigma = t\sigma\ u\sigma \in [[B]]$

---

## Lemă de substituție

### Demonstrație (continuare)

- $\reg[Abstracție]{\lambda x.\ t : A \rightarrow B}{t : B}{x \mbox{ are tipul } A}$

  Din ipoteza de inducție, pentru orice $\sigma$ ca în enunț, $t\sigma \in [[B]]$.

  Fie $\sigma$ ca în enunț. Vrem ca $(\lambda x.\ t)\sigma \in [[A \rightarrow B]]$
  Avem $(\lambda x.\ t)\sigma = \lambda x.\ (t\sigma')$ unde $\sigma' = \sigma[x := x]$.

  Fie $u \in [[A]]$ arbitrar ales. Vrem $(\lambda x.\ t)\sigma\ u \in [[B]]$.

---

## Lemă ajutătoare:

Pentru orice $t : B$, dacă $t\sigma \in [[B]]$ pentru orice $\sigma$ compatibilă cu interpretarea,
atunci pentru orice $x$ de tip $A$ orice $u \in [[A]]$ și orice substituție $\sigma$ compatibilă cu
interpretarea, $(\lambda x. t)\ u \in [[B]]$.


## Teoremă: Toți termenii cu tipuri simple sunt în SN

Fie $\sigma$ substituția identitate. Am arătat că variabilele fac parte din interpretarea tipurilor lor.

Din lema de substituție, $t : A$ implică $t = t\sigma \in [[A]]$, de unde $SN(t)$.

---

## Consecințe ale normalizării

- Nu există bucle infinite în CLTS.
- CLTS nu este Turing complet.
- Programele scrise în acest sistem se termină întotdeauna.

---

## Concluzie

- Calculul Lambda Tipizat Simplu are proprietatea de normalizare puternică.
- Am demonstrat acest lucru prin interpretare semantică a tipurilor în termeni puternic normalizabili.
- Sistemul oferă garanția că orice funcție este totală.

---

## Referințe

- H. Barendregt, *The Lambda Calculus: Its Syntax and Semantics*
