---
author: Traian Florin Șerbănuță și Andrei Sipoș
institute: Facultatea de Matematică și Informatică, DL Info
date: Anul II, Semestrul II, 2024/2025
title: Fundamentele limbajelor de programare
subtitle: Programare funcțională. $\lambda$-calcul. Confluență. Normalizare
theme: CambridgeUS
---

# Recapitulare din cursul trecut

## Sintaxă

::: center
  ---------------- ---- ----------------
     lambda termen  =   variabilă
                    \|  aplicare
                    \|  abstractizare
  ---------------- ---- ----------------
:::

$$\alert{M,N ::= x\ |\ (M\, N)\ |\ (\lambda x.\,M)}$$

### Variabile libere

::: center
  --------------------- ----- -------------------------
                $FV(x)$  $=$  $\{x\}$
            $FV(M\, N)$  $=$  $FV(M) \cup FV(N)$
    $FV(\lambda x.\,M)$  $=$  $FV(M) \setminus \{x\}$
  --------------------- ----- -------------------------
:::

## Substituție

### Variabile

- $x[x:=N] := N$;

- $x[y:=N] := x$, dacă $y\neq x$;

### Aplicație

- $(PQ)[x:=N] := (P[x:=N])(Q[x:=N])$;

### Abstracție

- $(\lambda x.P)[x:=N] := \lambda x.P$;

- $(\lambda y.P)[x:=N] := \lambda y.(P[x:=N])$, dacă $y\neq x$ și
  $y \not\in FV(N)$;

- $(\lambda y.P)[x:=N] := \lambda z.(P[y:=z][x:=N])$, dacă
  $y\neq x$ și $y \in FV(N)$, unde $z$ este o variabilă „nouă”

## Alfa-echivalență

- $\reg{\lambda x.M \equiv_\alpha \lambda y. (M[x:=y])}{}{y\notin FV(M)}$

### Echivalență

- $\reg{M \equiv_\alpha M}{}{}$ \hfill $\reg{N \equiv_\alpha M}{M \equiv_\alpha N}{}$ \hfill
  $\reg{M \equiv_\alpha P}{M \equiv_\alpha N \qquad N \equiv_\alpha P}{}$

### Compatibilitate cu operațiile

- $\reg{\lambda x. M \equiv_\alpha \lambda x.N}{M \equiv_\alpha N}{}$ \hfill
  $\reg{M\, P \equiv_\alpha N\, P}{M \equiv_\alpha N}{}$ \hfill
  $\reg{P\, M \equiv_\alpha P\, N}{M \equiv_\alpha N}{}$

## Beta-reducție

- $(\lambda x.M)N \to_\beta M[x:=N]$

### Compatibilitate cu operațiile

- $\reg{\lambda x. M \to_\beta \lambda x.N}{M \to_\beta N}{}$ \hfill
  $\reg{M\, P \to_\beta N\, P}{M \to_\beta N}{}$ \hfill
  $\reg{P\, M \to_\beta P\, N}{M \to_\beta N}{}$

### Reducție în mai mulți pași

- $\reg{M \to^*_\beta N}{}{M \to_\beta N}$ \hfill
  $\reg{M \to^*_\beta M}{}{}$ \hfill
  $\reg{M \to^*_\beta P}{M \to^*_\beta N \qquad N \to^*_\beta P}{}$

### Formă normală

- Dacă $M \to^*_\beta N \not\to_\beta$, atunci $N$ formă normală (pentru $M$)

# Modulo Alfa-echivalență

## Alfa-echivalența este compatibilă cu toate definițiile

- Dacă $M \equiv_\alpha N$ atunci $FV(M) = FV(N)$

- Dacă $M \equiv_\alpha M'$ și $N \equiv_\alpha N'$, atunci $M[x := N] \equiv_\alpha M'[x := N']$

- Dacă $M \to_\beta N$
  - pentru orice $M' \equiv_\alpha M$ există $N' \equiv_\alpha N$ astfel încât $M' \to_\beta N'$
  - pentru orice $N' \equiv_\alpha N$ există $M' \equiv_\alpha M$ astfel încât $M' \to_\beta N'$

- Similar pentru $M \to^*_\beta N$

- Dacă $N$ formă normală și $N' \equiv_\alpha N$ atunci $N'$ formă normală

### Alfa-Beta reducție

$\reg{M \to^*_{\alpha,\beta} N}{}{M \to^*_\beta N' \mbox{ și } N \equiv_\alpha N'}$

- $\to^*_\beta \subseteq \to^*_{\alpha,\beta}$

- Dacă $M \to^*_{\alpha,\beta} N$, $M \equiv_\alpha M'$ și $N\equiv_\alpha N'$, atunci $M' \to^*_{\alpha,\beta} N'$

# Teorema de normalizare

## Identificarea redex-ului într-o Beta-reducție

Definim următoarea relație[^1]:

- $\reg{(\lambda x. M)\, N \xrightarrow{1}_\beta M[x := N]}{}{}$

- $\reg{M\, P  \xrightarrow{n}_\beta N\, P}{M \xrightarrow{n}_\beta N}{M \mbox{ nu este o abstracție}}$
  $\reg{M\, P  \xrightarrow{n+1}_\beta N\, P}{M \xrightarrow{n}_\beta N}{M \mbox{ este o abstracție}}$

- $\reg{P\, M  \xrightarrow{n + \#r(P)}_\beta P\, N}{M \xrightarrow{n}_\beta N}{P \mbox{ nu este o abstracție}}$
  $\reg{P\, M  \xrightarrow{n+\#r(P) + 1}_\beta P\, N}{M \xrightarrow{n}_\beta N}{P \mbox{ este o abstracție}}$

- $\reg{\lambda x. M  \xrightarrow{n}_\beta \lambda x. N}{M \xrightarrow{n}_\beta N}{}$

[^1]: Pentru un termen $M$, fie $\#r(M)$ numărul de $\beta$-redexuri din $M$.

## Intuiție si proprietăți pentru $\to_\beta^n$

$M \xrightarrow{n}_\beta N$ reprezintă faptul că $N$ a fost obținut din $M$ aplicând o beta-reducție
pe al $n$-ulea redex din $M$ în ordinea leftmost-outermost.

### Proprietăți

- $M \to_\beta N$ dacă și numai dacă există $n$ astfel încât $M \xrightarrow{n}_\beta N$

- $M \xrightarrow{1}_\beta N$ reprezintă o reducție folosind strategia normală

## Secvențe de reducție standard

### Definiție

O secvență $M_0 \xrightarrow{n_1} M_1 \xrightarrow{n_2} \cdots  \xrightarrow{n_k} M_k$
se numește __standard__ dacă $n_1 \leq n_2 \leq \cdots \leq n_k$

### Observații

- Într-o secvență standard de reducție, toți redecșii cu index mai mic decât cel folosit la un pas nu vor fi modificați de nici unul din pașii următori.

- O secvență folosind strategia normală este standard (fiecare $n_i$ este $1$)

## Secvențe de reducție standard și forme normale

Următorul rezultat ne arată că pentru a arăta că strategia normală ajunge mereu
la o formă normală (dacă aceasta există) e suficient să arătăm că orice secvență
de reducție poate fi convertită la una standard.

### Propoziție

Orice secvență standard care ajunge intr-o formă normală este conform strategiei normale

### Demonstrație

Ne uităm la ultimul pas de reducție $M_{k-1} \xrightarrow{n_k} M_k$.

Deoarece $M_k$ este formă normală, înseamnă că nu are nici un redex, de unde înseamnă că $n_k = 1$.

Din definiția sevcenței standard, înseamnă că toți $n_i$ sunt $1$.

## Reducția la începutul unei aplicații

Vom defini recursiv o relație care generează secvențe folosind strategia normală.

### Definiție

$\reg{(\lambda x. M) N \to_h M[x := N]}{}{}$ și $\reg{M N \to_h M' N}{M \to_h M'}{}$

### Lemă

Dacă $M \to_h^* N$ atunci $M \xrightarrow{1}_\beta^* N$


## Reducția standard

Vom defini recursiv o relație care generează secvențe standard de reducție.

### Definiție

- $\reg{L \to_{st} x}{}{L \to_h^* x}$

- $\reg{L \to_{st} C\, D}{A \to_{st} C \qquad B \to_{st} D}{L \to_h^* A\, B}$

- $\reg{L \to_{st} \lambda x. B}{A \to_{st} B}{L \to_h^* \lambda x. A}$

### Lemă

Dacă $M \to_st N$ atunci există o secvență standard de la $M$ la $N$.

## Proprietăți

- $M \to_{st} M$

- Dacă $M \to_h^* N$ atunci $M P \to_h^* N P$

- Dacă $L \to_h^* M \to_{st} N$ atunci $L \to_{st} N$

- Dacă $M \to_h^* N$ atunci $M[x := P] \to_h^* N[x := P]$

- Dacă $M \to_{st} N$ și $P \to_{st} Q$, atunci $M[x := P] \to_{st} N[x := Q]$