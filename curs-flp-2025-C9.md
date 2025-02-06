---
author: Traian Florin Șerbănuță și Andrei Sipoș
institute: Facultatea de Matematică și Informatică, DL Info
date: Anul II, Semestrul II, 2024/2025
title: Fundamentele limbajelor de programare
subtitle: 9. Limbajul PCF
theme: CambridgeUS
---

## Feluri de limbaje funcţionale

Până acum am studiat două modele matematice ale programării funcţionale:

-   $\lambda$-calculul fără tipuri

    -   un model de calcul complet, având şi parţialitate

    -   un limbaj de programare modelat oarecum pe baza lui: Lisp

-   $\lambda$-calcul cu tipuri (simple sau mai complicate)

    -   modelează o subclasă strictă a clasei funcţiilor calculabile
        totale

    -   un limbaj de programare oarecum în acest stil: Agda

Pentru a modela limbajul Haskell, avem nevoie de un model de calcul
complet care să includă şi un sistem de tipuri. În continuare, vom
prezenta un exemplu de aşa ceva, anume PCF (Programming Computable
Functions), introdus de Scott şi Plotkin în anii '70.

## Tipuri şi termeni

Tipurile vor fi următoarele:

-   un singur tip de bază, $\mathbb{N}$ (reprezentând numerele
    naturale);
-   pentru orice tipuri $\rho$, $\tau$, avem un tip $\rho\to\tau$
    (reprezentând funcţiile parţiale de la $\rho$ la $\tau$").

Vom defini termenii fără tipuri asociate, şi apoi le vom aloca tipuri à
la Curry":

-   avem variabile, $\lambda$-abstracţiuni şi aplicaţii exact ca la
    $\lambda$-calculul fără tipuri;

-   $z$ este termen (zero");

-   dacă $M$ este termen, atunci $s(M)$ este termen (succesor");

-   dacă $M$, $N$, $P$ sunt termeni, iar $w$ este variabilă, atunci
    $ifz(M,N,w,P)$ este termen;

-   dacă $M$ este termen, iar $w$ este variabilă, atunci $fix(w,M)$ este
    termen.

## Alocarea tipurilor

Acestea sunt regulile de deducţie pentru alocarea de tipuri termenilor:
$$\frac{}{\Gamma \cup \{x:\sigma\} \vdash x:\sigma}$$

$$\frac{\Gamma \cup \{x:\sigma\} \vdash M:\tau}{\Gamma \vdash \lambda x.M :\sigma \to \tau} \qquad \frac{\Gamma\vdash M: \sigma\to \tau \quad \Gamma \vdash N:\sigma}{\Gamma \vdash MN : \tau}$$


$$\frac{}{\Gamma\vdash z:\mathbb{N}} \qquad \frac{\Gamma \vdash M : \mathbb{N}}{\Gamma \vdash s(M):\mathbb{N}}$$


$$\frac{\Gamma \vdash M:\mathbb{N}\quad \Gamma \vdash N:\tau \quad \Gamma \cup \{w:\mathbb{N}\} \vdash P:\tau}{\Gamma \vdash ifz(M,N,w,P) : \tau} \qquad \frac{\Gamma \cup \{w:\tau\} \vdash M:\tau}{\Gamma \vdash fix(w,M):\tau}$$

## Valori

Următoarele reguli stabilesc când ceva este valoare:
$$\frac{}{val(z)}\qquad \frac{val(M)}{val(s(M))}\qquad \frac{}{val(\lambda x.M)}$$

## Reguli de evaluare

Următoarele reguli stabilesc evaluarea termenilor în regim *eager*:

$$\frac{M \to M'}{s(M) \to s(M')} \quad  \frac{M \to M'}{ifz(M,N,w,P) \to ifz(M',N,w,P)}$$

$$\frac{}{ifz(z,N,w,P) \to N} \quad \frac{val(s(M))}{ifz(s(M),N,w,P) \to P[w:=M]}$$

$$\frac{M \to M'}{MN \to M'N} \quad \frac{val(M)\ \ N \to N'}{MN \to MN'}$$

$$\frac{val(N)}{(\lambda x.M)N \to M[x:=N]} \quad \frac{}{fix(w,M) \to M[w:=fix(w,M)]}$$

## Exemple de termeni

Operaţia de adunare este reprezentată de următorul termen PCF (de ce?):
$$fix(f,\lambda x.\lambda y.ifz(y,x,w,s((f\;x)w))).$$

Putem defini operaţia de scădere cu punct", pentru orice $x$,
$y \in \mathbb{N}$, prin:
$$x \dotdiv y = \begin{cases} x-y, & \text{dac\u a $x \geq y$,}\\ 0, &\text{altfel.} \end{cases}$$

Ea se poate reprezenta prin (de ce?):
$$fix(f,\lambda x.\lambda y. ifz(y,x,w,ifz(x,z,u,(f\;u)w))).$$ Notăm acest
termen tot cu $\dotdiv$.

## Exemple de termeni

Un termen care reprezintă funcţia de cel mai mare divizor comun, obţinut
prin algoritmul lui Euclid, este:
$$fix(f,\lambda x. \lambda y. ifz(x,y,w,ifz(y,x,u,ifz((\dotdiv y)x,f((\dotdiv x)y)y,v,$$
$$(f(x))(((\dotdiv y)x)))))).$$

În sfârşit, definim operatorul de
*minimizare nemărginită*, $\mu$, pentru orice funcţie parţială $f$,
punând $\mu(f)$ ca fiind, în caz că există (altfel, rămâne nedefinit),
cel mai mic număr natural $n$ cu proprietatea că $f(n)=0$ şi că $f$ este
definită pentru toate numerele mai mici decât $n$. Un termen care îl
reprezintă pe $\mu$ este:
$$\lambda f.((fix(g,\lambda n.\lambda f. ifz(fn, n, w, (g(Sn))f))z)f).$$
