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

## Alfa-echivalența este compatibilă cu toate definițiile[^2]

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

[^2]: În restul cursului vom lucra __modulo__ $\alpha$-echivalență.

# Teorema de normalizare

## Scop

În această secțiune vom argumenta veridicitatea următorului rezultat.

### Teoremă (normalizare)

Dacă $M$ are o formă normală $N$ atunci $N$ poate fi obținută din $M$ folosind
strategia normală de reducție, adică, reducând la fiecare pas redex-ul cel mai
din stânga dintre cele exterioare.

## Identificarea redex-ului într-o $\beta$-reducție

Definim relația $\xrightarrow{n}_\beta$ prin următoarele reguli:

- $\reg{(\lambda x. M)\, N \xrightarrow{1}_\beta M[x := N]}{}{}$
- $\reg{M\, P  \xrightarrow{n}_\beta N\, P}{M \xrightarrow{n}_\beta N}{M \mbox{ nu este o abstracție}}$
  $\reg{M\, P  \xrightarrow{n+1}_\beta N\, P}{M \xrightarrow{n}_\beta N}{M \mbox{ este o abstracție}}$
- $\reg{P\, M  \xrightarrow{n + \#r(P)}_\beta P\, N}{M \xrightarrow{n}_\beta N}{P \mbox{ nu este o abstracție}}$[^1]
  $\reg{P\, M  \xrightarrow{n+\#r(P) + 1}_\beta P\, N}{M \xrightarrow{n}_\beta N}{P \mbox{ este o abstracție}}$
- $\reg{\lambda x. M  \xrightarrow{n}_\beta \lambda x. N}{M \xrightarrow{n}_\beta N}{}$

[^1]: Pentru un termen $M$, fie $\#r(M)$ numărul de $\beta$-redexuri din $M$.

## Intuiție si proprietăți pentru $\to_\beta^n$

$M \xrightarrow{n}_\beta N$ reprezintă faptul că $N$ a fost obținut din $M$ aplicând o $\beta$-reducție
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

Următoarele proprietăți se demonstrează ușor prin inducție:

- $M \to_{st} M$

- Dacă $M \to_h^* N$ atunci $M P \to_h^* N P$

- Dacă $L \to_h^* M \to_{st} N$ atunci $L \to_{st} N$

- Dacă $M \to_h^* N$ atunci $M[x := P] \to_h^* N[x := P]$

- Dacă $M \to_{st} N$ și $P \to_{st} Q$, atunci $M[x := P] \to_{st} N[x := Q]$

### Lemă

Dacă $L \to_{st} (\lambda x. M)\, N$, atunci $L \to_{st} M[x := N]$.

### Demonstrație

Explicitând definițiile și folosind proprietățile de mai sus.

## Beta-reducțiile pot fi absorbite în reducții standard

### Lemă

Dacă $L \to_{st} M \to_\beta N$ atunci $L \to_{st} N$

### Demonstrație

Inducție pe regulile de definire ale lui $M \xrightarrow{n}_\beta N$

### Lemă

Dacă $M \to_\beta^* N$ atunci $M \to_{st} N$

### Demonstrație

Inducție pe lungimea secevenței, folosind proprietatea că $\to_{st}$ e reflexivă
și lema de mai sus.

## Teorema de standardizare

### Teoremă (standardizare)

Dacă $M \to_\beta^* N$ atunci există o secvență standard de $\beta$-reducție de la $M$ la $N$.

### Demonstrație

Evident din lema de mai sus și proprietățile reducției standard.

# Confluență

## Scop

În această secțiune vom argumenta că $\lambda$-calculul fără tipuri este confluent.

### Teoremă (Church-Rosser)

Fie $M$, $M_1$, $M_2$ $\lambda$-termeni astfel încât $M \to_\beta^* M_1$ și $M \to_\beta^* M_2$
Atunci există un $\lambda$-termen $M'$ astfel încât (modulo $\alpha$-echivalență)
$M_1 \to_\beta^* M'$ și $M_2 \to_\beta^* M'$

\begin{tikzpicture}
\GraphInit[vstyle=Normal]
\SetGraphUnit{1.5}
\Vertex[L=$M$]{a}
\NOEA[L=$M_1$](a){b}
\SOEA[L=$M_2$](a){c}
\NOEA[L=$M'$](c){d}
\SetUpEdge[style={->}]
\Edge(a)(b)
\Edge(a)(c)
\SetUpEdge[style={->, dashed}]
\Edge(b)(d)
\Edge(c)(d)
\end{tikzpicture}

## Proprietatea diamant (confluență într-un pas)

### Definiție

O relație binară $\to$ are __proprietatea diamant__ dacă, oricând $a \to b$ și $a \to c$,
există $d$ astfel încât $b \to d$ și $c \to d$

### Proprietăți

- Teorema Church-Rosser este echivalentă cu faptul că relația $\to_\beta^*$ are proprietatea diamant.

- Dacă $\to$ are proprietatea diamant, atunci și $\to^*$ are proprietatea diamant.

## Reducție paralelă

Se definește relația $\to_\parallel$ pe $\lambda$-termeni folosind regulile:

- $\reg{M \to_\parallel M}{}{}$

- $\reg{\lambda x. M \to_\parallel \lambda x. M'}{M \to_\parallel M'}{}$

- $\reg{M\, N \to_\parallel M'\, N'}{M \to_\parallel M' \qquad N \to_\parallel N'}{}$

- $\reg{(\lambda x. M)\, N \to_\parallel M'[x := N']}{M \to_\parallel M' \qquad N \to_\parallel N'}{}$

## Reducția paralelă vs $\beta$-reducția

### Proprietăți (demonstrabile prin inducție)

- $\to_\beta \subseteq \to_\parallel$

- $\to_\parallel \subseteq \to_\beta^\ast$

### Corolar

- $\to_\parallel^* = \to_\beta^\ast$

## Proprietăți

### Lemă (Comutativitatea Substituției)

Fie $N$, $N$, $P$ termeni. Dacă $x \neq y$ și $x \notin FV(P)$, atunci
$$M[x := N][y := P] = M [y := P][x := N[y := P]]$$

### Leme

1. Dacă $N \to_\parallel N'$ atunci $M[x := N] \to_\parallel M[x := N']$

2. Dacă $M \to_\parallel M'$ și $N \to_\parallel N'$. Atunci $M[x := N] \to_\parallel M'[x := N']$

3. Dacă $\lambda x. M \to_\parallel N$ atunci $N = \lambda x . M'$ și $M \to_\parallel M'$

4. Dacă $M\, N \to_\parallel L$ atunci fie
  
   - $L = M'\, N'$, $M \to_\parallel M'$ și $N \to_\parallel N'$; sau

   - $M = \lambda x. P$, $L = P'[x := N']$, $P \to_\parallel P'$ și $N \to_\parallel N'$

## Teorema Church-Rosser

### Teoremă (proprietatea diamant)

$\to_\parallel$ are proprietatea diamant

### Corolar (Teorema Church-Rosser)

$\to_\beta^\ast$ are proprietatea diamant

## Referințe

- [Teorema Church-Rosser](https://student.cs.uwaterloo.ca/~cs442/W25/extras/c-r-thm-proof.pdf)

  Gregor Richards.
  [CS442 – Principles of Programming Languages](https://student.cs.uwaterloo.ca/~cs442/W25/).
  Lecture Notes. University of Waterloo.

- [Teorema de standardizare](https://www.is.c.titech.ac.jp/users/kashima/pub/C-145.pdf)

  Ryo Kashima.
  A Proof of the Standardization Theorem in $\lambda$-Calculus.
  Research Reports on Mathematical and Computing Sciences, C-145,
  Tokyo Institute of Technology, 2000.



