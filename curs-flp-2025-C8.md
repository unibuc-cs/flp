---
author: Traian Florin Șerbănuță și Andrei Sipoș
institute: Facultatea de Matematică și Informatică, DL Info
date: Anul II, Semestrul II, 2024/2025
title: Fundamentele limbajelor de programare
subtitle: 8. Programare funcțională. Lambda-calcul cu tipuri simple.
theme: CambridgeUS
---

## Motivaţie pentru tipuri

Am observat că $\lambda$-calculul fără tipuri are anumite patologii", de
exemplu termenul $(\lambda x.(x\; x))(\lambda x.(x\; x))$, care se rescrie la
infinit".

Ne putem întreba care este sursa acestui fenomen, pentru a şti cum l-am
putea evita. De exemplu, am putea spune că $x\; x$ sugerează că am avea o
funcţie care îşi aparţine propriului său domeniu de definiţie, lucru
care, intuitiv vorbind, nu prea ar avea sens"[^1].

O cale spre a nu face asemenea amestecuri este, de pildă, ideea de a
impune **tipuri** termenilor. Există mai multe moduri de a face aceasta.
Noi îl vom studia pe cel mai simplu, care chiar poartă numele de
**tipuri simple".**

## Tipuri simple
Fixăm o mulţime de tipuri de bază", notată cu $T_0$.

Mulţimea tipurilor simple (numite **tipuri**, de acum încolo), notată cu
$T$, va fi cea mai mică mulţime care:

-   conţine pe $T_0$;

-   pentru orice $\rho$, $\tau \in T$, avem $\rho \to \tau \in T$ (cu
    semnificaţia: tipul funcţiilor de la $\rho$ la $\tau$").

Putem vedea, aşadar, mulţimea tipurilor ca pe mulţimea termenilor peste
o signatură de ordinul I unde avem un singur simbol, anume un simbol de
operaţie de aritate $2$, notat cu $\to$.

## Tipurile, intuitiv

Cum funcţionează, intuitiv, tipurile?

-   În primul rând, variabilele vor avea" tipuri (intenţionat păstrăm
    ambiguitatea asupra sintagmei, vom vedea imediat de ce).

-   Dacă avem o variabilă $x$ de tip $\rho$ şi un termen $M$ de tip
    $\tau$, atunci $\lambda x.M$, cum reprezintă funcţia care duce pe
    $x$ în $M$", va trebui să aibă tipul $\rho \to \tau$.

-   Într-un termen de forma $M\;N$, dacă $\rho$ este tipul lui $N$, atunci
    $M$ va trebui să reprezinte o funcţie care duce ceva de tip $\rho$
    în ceva de alt tip, să zicem $\tau$. Deci $M$ are tipul
    $\rho \to \tau$ şi $M\;N$ are tipul $\tau$. Aşadar, $M\;N$ nu va avea
    sens decât atunci când tipurile lui $M$ şi $N$ se potrivesc".

Vedem acum că, oricum am defini riguros ideea de tip, dacă avem un
termen de forma $x\;x$, $x$ va trebui să aibă şi un tip $\rho$, şi un tip
$\rho \to \tau$. Dar, pentru orice $\rho$ şi $\tau$,
$\rho \neq \rho\to \tau$, deci avem o contradicţie. Aşadar, $x\;x$ nu va
fi bine format".

## Tipuri à la Church

Am menţinut ambiguitatea asupra definiţiei deoarece există două feluri
de a defini modul cum termenii au tipuri. Primul este noţiunea de tip à
la Church.

În acest sistem, termenii sunt din start definiţi ca având tipuri:

-   avem câte o mulţime numărabilă de variabile pentru fiecare tip
    (aceste mulţimi fiind disjuncte două câte două);

-   dacă $x$ este o variabilă de tip $\rho$ şi $M$ este un termen de tip
    $\tau$, atunci $\lambda x.M$ este un termen de tip $\rho\to\tau$;

-   dacă $M$ şi $N$ sunt termeni, iar $\rho$ şi $\tau$ sunt tipuri
    astfel încât $M$ este de tip $\rho\to\tau$, iar $N$ este de tip
    $\rho$, atunci $M\;N$ este un termen de tip $\tau$.

De exemplu, dacă $\alpha$, $\beta$, $\gamma \in T$, iar $x$, $y$, $z$ şi
$u$ sunt variabile de tip $\alpha\to\alpha$,
$(\alpha\to\alpha)\to\beta$, $\beta$ şi $\gamma$, respectiv, atunci
$(\lambda z.(\lambda u.z))(yx)$ este un termen de tip
$\gamma \to \beta$.

## Substituţie şi reducţie

Substituţia se defineşte întocmai ca la $\lambda$-calculul fără tipuri,
dar având grijă la tipuri. De exemplu, dacă $\sigma$, $\tau \in T$, $t$
este un termen de tip $\tau$, $x$ este o variabilă de tip $\sigma$, iar
$u$ un termen de tip $\sigma$, atunci va avea sens să definim
$$t[x:=u],$$ care va fi, apoi, un termen de tip $\tau$.

Similar, relaţia de $\beta$-reducţie se defineşte identic, având grijă,
de exemplu, ca, în clauza fundamentală $$(\lambda x.t)u \to t[x:=u],$$
obiectele să aibă tipurile potrivite. (Care sunt acelea? De ce merge?)

## Normalizare şi confluenţă

Se poate arăta (şi chiar vom arăta într-un curs viitor) că acest
$\lambda$-calcul cu tipuri simple nu mai posedă rescrieri infinite
(altfel spus, are proprietatea de **normalizare tare**), i.e. nu există
o familie de termeni $(M_n)_{n \in \mathbb{N}}$ astfel încât pentru
orice $n \in \mathbb{N}$, $M_n \to_\beta M_{n+1}$.

În plus, el păstrează proprietatea de **confluenţă** a
$\lambda$-calculului fără tipuri.

## Tipuri à la Curry

Un al doilea mod de a gândi tipurile este sistemul de tipuri à la Curry.
Aici, termenii sunt fără tipuri, mai exact ei sunt exact termeni din
$\lambda$-calculul fără tipuri, iar lor li se alocă tipuri de către un
sistem de deducţie. Mai precis, vom emite judecăţi de forma
$$\Gamma \vdash M : \tau,$$ însemnând: în contextul $\Gamma$ i se alocă
termenului $M$ tipul $\tau$. Un context va fi o mulţime finită de
obiecte de forma $x:\sigma$, cu $x$ variabilă şi $\sigma \in T$
(simbolizând faptul că variabilei $x$ i se alocă tipul $\sigma$), astfel
încât orice variabilă apare cu cel mult un tip.

## Reguli de deducţie

Regulile de deducţie vor fi următoarele:

$$\frac{}{\Gamma \cup \{x:\sigma\} \vdash x:\sigma}$$

$$\frac{\Gamma \cup \{x:\sigma\} \vdash M : \tau}{\Gamma \vdash \lambda x. M : \sigma\to \tau} \qquad \frac{\Gamma\vdash M: \sigma \to \tau \quad \Gamma \vdash N: \sigma}{\Gamma\vdash M\; N : \tau}$$

Încercaţi să deduceţi tipul termenului de mai devreme"
$(\lambda z.(\lambda u.z))(yx)$ folosind aceste reguli. Acest exemplu ne
arată că, într-un anume fel (în ce fel? detaliaţi!), cele două moduri de
a gândi tipurile sunt echivalente.

## Inferenţa tipurilor

Am dori, ca, dat un termen $M$ în $\lambda$-calculul fără tipuri, să
decidem **algoritmic** dacă există (şi, atunci, să şi găsim) $\Gamma$ şi
$\tau$ cu $\Gamma \vdash M : \tau$. Aceasta se numeşte problema
inferenţei tipurilor. În continuare, vom prezenta un asemenea algoritm.

Algoritmul va avea nevoie, aproape la fiecare pas, de variabile (de tip)
noi, nemaifolosite până atunci (şi, deci, în particular, diferite între
ele). Vom presupune tacit, în prezentarea sa, că variabilele de tip care
apar au această proprietate. (Acesta va fi şi punctul sensibil atunci
când se încearcă implementarea lui.)

Introducem şi noţiunea de **termen adnotat** ca fiind un termen cu tip
undeva între" Church şi Curry, în sensul că termenii nu au tipuri, dar,
la fiecare $\lambda$-abstracţiune, se adaugă şi un tip pentru variabila
abstractizată. Vom scrie un asemenea termen ca: $\lambda x : \sigma.M$.

## Algoritmul

Definim, pentru orice termen $M$, contextul
$$\Gamma_M := \{x : X \mid x \in FV(M)\}.$$

De asemenea, pentru orice termen $M$, construim termenul adnotat $M'$,
unde toate $\lambda x$-urile devin $\lambda x :X$.

În continuare, vom defini o funcţie $c$ care primeşte ca argumente: un
termen adnotat, un context şi o variabilă de tip şi care returnează o
mulţime de ecuaţii peste signatura de ordinul I care conţine doar
simbolul săgeată (vezi discuţia de la început).

## Finalizare

Definim: $$\begin{aligned}
c(x,\Gamma \cup \{x : \tau\}, Z) &:= \{\tau = Z\}\\
c(\lambda x:\sigma. M, \Gamma, Z) &:= c(M , \Gamma \cup \{x:\sigma\}, W) \cup \{Z = \sigma \to W\}\\
c(M\; N, \Gamma, Z) &:= c(M, \Gamma, W_1) \cup c(N, \Gamma, W_2) \cup \{W_1 = W_2 \to Z\}
\end{aligned}$$

Algoritmul va face apelul $c(M', \Gamma_M, Z)$ şi va
obţine o mulţime de ecuaţii. Pentru ea, se caută un cgu $\theta$. În caz
că nu există, se returnează eşec". În caz de succes, rezultatul
algoritmului va fi
$\widetilde{\theta}(\Gamma_M) \vdash M : \widetilde{\theta}(Z)$ (unde
$\widetilde{\theta}$ are semnificaţia firească).

Putem rula algoritmul pe termenii $(\lambda z.(\lambda u.z))(y\; x)$ şi
$x\; x$, evidenţiaţi mai devreme.

## Numere naturale

Să vedem acum cum putem vorbi despre $\lambda$-calculul cu tipuri simple
ca model de calcul. Dacă ne uităm la un numeral Church oarecare, să
zicem $C_2$ (care îl reprezintă pe $2$):
$$\lambda f. \lambda x. (f(f\;x)),$$ vedem că, dacă încercăm să îi alocăm
un tip, avem că, notând tipul variabilei $x$ cu $\gamma$, tipul
rezultant va fi $(\gamma \to \gamma) \to (\gamma \to \gamma)$. Vom fixa,
aşadar, un $\gamma \in T_0$ şi vom defini **nat**, tipul numerelor
naturale, ca fiind $(\gamma \to \gamma) \to (\gamma \to \gamma)$.

Vedem acum că, de exemplu, termenului introdus anterior pentru adunare,
$$\lambda n. \lambda m. \lambda f.\lambda x.((n\ f)((m\ f)x)),$$ i se
poate aloca tipul $\textbf{nat} \to (\textbf{nat} \to \textbf{nat})$. Ce
va însemna, deci, acum că o funcţie este reprezentabilă?

## Funcţii calculabile

Vom spune, pentru orice $k \in \mathbb{N}$, că o funcţie
$f:\mathbb{N}^k \to \mathbb{N}$ (observăm că, dată fiind proprietatea de
normalizare, acum lucrăm doar cu funcţii **totale**) este
**$\lambda_\to$-reprezentabilă** dacă există un $\lambda$-termen $M$ de
tipul $\textbf{nat}^k \to \textbf{nat}$ astfel încât, pentru orice
$n_1,\ldots,n_k \in \mathbb{N}$, avem
$$M C_{n_1}\ldots C_{n_k} \to_\beta^* C_{f(n_1,\ldots,n_k)}.$$ Apare
întrebarea: orice funcţie totală care este calculabilă (adică
$\lambda$-reprezentabilă) va fi $\lambda_\to$-reprezentabilă? Răspunsul
va fi unul negativ.

## Caracterizare

### Teoremă (Schwichtenberg, 1976)
Clasa funcţiilor
$\lambda_\to$-reprezentabile este cea mai mică clasă de funcţii totale
care:

-   conţine constantele $0$, $1$, adunarea, înmulţirea şi operaţiile de
    proiecţie pe o componentă;

-   conţine operaţia $\textbf{cond} : \mathbb{N}^3 \to \mathbb{N}$,
    definită, pentru orice $n$, $m$, $p \in \mathbb{N}$ prin
    $$\textbf{cond}(n, m, p) := \begin{cases} m, & \text{dac\u a $n=0$,}\\ p, & \text{altfel}.\end{cases}$$

-   este închisă la compunere, în sensul că, pentru orice $k$,
    $l \in \mathbb{N}$ şi orice funcţii
    $f : \mathbb{N}^l \to \mathbb{N}$,
    $g_1,\ldots,g_l: \mathbb{N}^k \to \mathbb{N}$, conţine, odată cu
    $f$, $g_1,\ldots,g_l$, şi funcţia $h: \mathbb{N}^k \to \mathbb{N}$,
    definită, pentru orice $x_1,\ldots,x_k \in \mathbb{N}$, prin
    $$h(x_1,\ldots,x_k):=f(g_1(x_1,\ldots,x_k),\ldots,g_l(x_1,\ldots,x_k)).$$

## Funcţii nereprezentabile

Următorul rezultat se arată imediat prin inducţie.

### Corolar
Pentru orice $k \in \mathbb{N}$, orice funcţie
$\lambda_\to$-reprezentabilă $f : \mathbb{N}^k \to \mathbb{N}$ există un
polinom $p \in \mathbb{N}[X_1,\ldots,X_k]$ astfel încât, pentru orice
$x_1,\ldots,x_k \in \mathbb{N}$,
$$f(x_1,\ldots,x_k) \leq p(x_1,\ldots,x_k).$$

::: block
### Corolar
Funcţia $n \mapsto 2^n$ nu este $\lambda_\to$-reprezentabilă.
:::

Faptul că avem funcţii calculabile care nu sunt
$\lambda_\to$-reprezentabile nu provine dintr-o slăbiciune în definirea
$\lambda$-calculului cu tipuri, ci este un fapt inerent restricţionării
la funcţii totale, după cum vom vedea imediat.

## Limitarea fundamentală

### Teoremă
Orice limbaj de programare total este incomplet.

### Demonstraţie
Gândim un limbaj de programare ca pe o funcţie calculabilă
$f:\mathbb{N}^2 \to \mathbb{N}$, unde cele două argumente ale lui $f$
reprezintă un program şi un input al său, iar $f$ calculează output-ul
programului relativ la acel input. Presupunem că el ar fi complet, în
sensul că, pentru orice funcţie calculabilă
$h: \mathbb{N}\to \mathbb{N}$, ea este $f$-reprezentabilă", i.e. există
$n \in \mathbb{N}$ (programul" corespunzător) astfel încât, pentru orice
$p \in \mathbb{N}$ (pentru orice input"), $f(n,p)=h(p)$. Încercăm să
ajungem la o contradicţie. Luăm $h: \mathbb{N}\to \mathbb{N}$, definită,
pentru orice $p$, prin $h(p):=f(p,p)+1$. Clar, $h$ este calculabilă.
Deci există $n$ astfel încât, pentru orice $p$, $f(n,p)=h(p)$. Luând
$p:=n$, avem $f(n,n) = h(n)=f(n,n)+1$, ceea ce este o contradicţie.

## Ierarhia Gödel

Aşadar, nu putem avea un singur limbaj de programare total care să
captureze toate funcţiile calculabile totale, ci o **ierarhie** de
asemenea limbaje:

![](ierarhia-Goedel.svg)

Aceasta seamănă, oarecum, cu ierarhia Gödel a sistemelor logice în care
este fundamentată matematica (rezultatul limitativ, în acest caz, este
prima teoremă de incompletitudine a lui Gödel):

![](Goedel2.svg)

Această asemănare nu este întâmplătoare.

## Corespondenţa

Mai precis, există o legătură între sistemele în care este fundamentată
matematica şi limbajele de programare totale -- avem în general, teoreme
de genul următor: dacă într-un sistem $S$ putem demonstra o propoziţie
de forma $\forall x \exists y \varphi(x,y)$ (unde $\varphi$ este o
formulă fără cuantificatori), atunci există un termen (program") $t$
într-un limbaj total corespunzător $T_S$ astfel încât este adevărat că,
pentru orice $n \in \mathbb{N}$, $\varphi(n,t(n))$.

Această corespondenţă reprezintă unul dintre obiectele principale de
studiu ale **teoriei demonstraţiilor** (**proof theory**).

[^1]: De fapt, poate foarte bine să aibă sens, după cum vom vedea în
    cursurile viitoare.
