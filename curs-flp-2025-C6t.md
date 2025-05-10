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

- $\reg{(\lambda x. M)\, N \to_\beta^1 M[x := N]}{}{}$

- $\reg{M\, P  \to_\beta^n N\, P}{M \to_\beta^n N}{M \mbox{ nu este o abstracție}}$
  $\reg{M\, P  \to_\beta^{n+1} N\, P}{M \to_\beta^n N}{M \mbox{ este o abstracție}}$

- $\reg{P\, M  \to_\beta^{n+\#r(P)} P\, N}{M \to_\beta^n N}{P \mbox{ nu este o abstracție}}$
  $\reg{P\, M  \to_\beta^{n+\#r(P) + 1} P\, N}{M \to_\beta^n N}{P \mbox{ este o abstracție}}$

- $\reg{\lambda x. M  \to_\beta^{n} \lambda x. N}{M \to_\beta^n N}{}$

[^1]: Pentru un termen $M$, fie $\#r(M)$ numărul de $\beta$-redexuri din $M$.

## Intuiție si proprietăți pentru $\to_\beta^n$

