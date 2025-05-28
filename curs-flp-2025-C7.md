---
author: Traian Florin Șerbănuță și Andrei Sipoș
institute: Facultatea de Matematică și Informatică, DL Info
date: Anul II, Semestrul II, 2024/2025
title: Fundamentele limbajelor de programare
subtitle: Programare funcțională. Lambda-calcul cu tipuri simple.
theme: CambridgeUS
---

## Motivaţie pentru tipuri

Proprietăți negative ale lambda calculului fără tipuri:

- Aplicări de forma $x\, x$ sau $M\, M$ sunt pemise,
  deși sunt contraintuitive.

- Existența formelor normale pentru $\lambda$-termeni nu este garantată
  și putem avea „calcule infinite” nedorite

- Orice $\lambda$-termen are un punct fix ceea ce nu este în armonie cu
  ceea ce știam despre funcții oarecare

Vrem să eliminăm aceste proprietăți negative, păstrându-le pe cele
pozitive.

Proprietățile negative sunt eliminate prin adăugarea de __tipuri__ ceea ce
induce restricțiile dorite pe termeni.

# Tipuri simple - noțiuni de bază

## Tipuri simple
Fixăm o mulţime de „tipuri de bază”, notată cu $T_0$. De obicei notăm aceste tipuri cu $\alpha, \beta, \gamma, \ldots$

Mulţimea tipurilor simple (numite **tipuri**, de acum încolo), notată cu
$T$, va fi cea mai mică mulţime care:

-   conţine pe $T_0$;

-   pentru orice $\rho$, $\tau \in T$, avem $\rho \to \tau \in T$ (cu
    semnificaţia: „tipul funcţiilor de la $\rho$ la $\tau$”).

## Tipuri simple – notații

::: center
[Mulțimea tipurilor simple]{.alert}
$T = T_0\ |\ T \rightarrow T$
:::

Exemple de tipuri simple:

-   $\gamma$

-   $(\beta \to \gamma)$

-   $((\gamma \to \alpha) \to (\alpha \to (\beta \to \gamma)))$

În tipurile „săgeată”, parantezele exterioare pot fi omise.

Parantezele în tipurile săgeată sunt asociative la dreapta.\
De exemplu,

-   $\alpha_1 \to \alpha_2 \to \alpha_3 \to \alpha_4$ este abreviere
    pentru $(\alpha_1 \to (\alpha_2 \to (\alpha_3 \to \alpha_4)))$

-   $x_1\, x_2\, x_3\, x_4$ este abreviere pentru
    $(((x_1\, x_2)\, x_3)\, x_4)$


## Tipurile, intuitiv

Cum funcţionează, intuitiv, tipurile?

Variabile

: În primul rând, variabilele „vor avea” tipuri (intenţionat păstrăm
  ambiguitatea asupra sintagmei, vom vedea imediat de ce).

Aplicare

: Pentru $M\, N$ este clar că vrem să știm tipurile lui $M$ și $N$.\
  Intuitiv, $M\, N$ înseamnă că (\"funcția\") $M$ este aplicată
  (\"intrării\") $N$.\
  Atunci $M$ trebuie să aibă un tip funcție, adică
  ${\color{True}M\hspace{-.05cm}:}\,{\color{Orchid}\sigma \to \tau}$, iar
  $N$ trebuie să fie \"adecvat\" pentru această funcție, adică
  ${\color{True}N\hspace{-.05cm}:}\,{\color{Orchid}\sigma}$.\
  Dacă ${\color{True}M\hspace{-.05cm}:}\,{\color{Orchid}\sigma \to \tau}$
  și ${\color{True}N\hspace{-.05cm}:}\,{\color{Orchid}\sigma}$, atunci
  ${\color{True}M\, N\hspace{-.05cm}:}\,{\color{Orchid}\tau}$.

Abstractizare

: Dacă ${\color{True}M\hspace{-.05cm}:}\,{\color{Orchid}\tau}$, ce tip trebuie sa aibă $\lambda x.\,M$?\
  Dacă ${\color{True}x\hspace{-.05cm}:}\,{\color{Orchid}\sigma}$ și
  ${\color{True}M\hspace{-.05cm}:}\,{\color{Orchid}\tau}$, atunci
  ${\color{True}\lambda x.\,M\hspace{-.05cm}:}\,{\color{Orchid}\sigma \to \tau}$.


## Termeni și tipuri – Exemple

Variabilă

: ${\color{True}x\hspace{-.05cm}:}\,{\color{Orchid}\sigma}$

Aplicare

: Dacă
  ${\color{True}M\hspace{-.05cm}:}\,{\color{Orchid}\sigma \to \tau}$ și
  ${\color{True}N\hspace{-.05cm}:}\,{\color{Orchid}\sigma}$, atunci
  ${\color{True}M\, N\hspace{-.05cm}:}\,{\color{Orchid}\tau}$.\

Abstractizare

: Dacă
  ${\color{True}x\hspace{-.05cm}:}\,{\color{Orchid}\sigma}$ și
  ${\color{True}M\hspace{-.05cm}:}\,{\color{Orchid}\tau}$, atunci
  ${\color{True}\lambda x.\,M\hspace{-.05cm}:}\,{\color{Orchid}\sigma \to \tau}$.

$M$ *are tip* (este *typeable*) dacă există un tip $\sigma$ astfel încât
${\color{True}M\hspace{-.05cm}:}\,{\color{Orchid}\sigma}$.

### Exemple.

-   Dacă ${\color{True}x\hspace{-.05cm}:}\,{\color{Orchid}\sigma}$,
    atunci funcția identitate are tipul
    ${\color{True}\lambda x.\,x\hspace{-.05cm}:}\,{\color{Orchid}\sigma \to \sigma}$.

-   Conform convențiilor de la aplicare, $y\, x$ poate avea un tip doar
    dacă $y$ are un tip săgeată de forma $\sigma \to \tau$ și tipul lui
    $x$ se potrivește cu tipul domeniu $\sigma$. În acest caz, tipul lui
    ${\color{True}y\, x\hspace{-.05cm}:}\,{\color{Orchid}\tau}$.

-   Termenul $x\, x$ nu poate avea nici un tip (nu este typeable).\
    Pe de o parte, $x$ ar trebui să aibă tipul $\sigma \to \tau$ (pentru
    prima apariție), pe de altă ar trebui să aibă tipul $\sigma$ (pentru
    a doua apariție). Cum am stabilit că orice variabilă are un unic
    tip, obținem $\sigma \to \tau \equiv \sigma$, ceea ce este
    imposibil.

## Discuție despre asocitativitate

Asociativitatea la dreapta pentru tipurile săgeată vs. asociativitatea
la stânga pentru aplicare:

-   Să presupunem că
    ${\color{True}f\hspace{-.05cm}:}\,{\color{Orchid}\rho \to (\sigma \to \tau)}$,
    ${\color{True}x\hspace{-.05cm}:}\,{\color{Orchid}\rho}$ și
    ${\color{True}y\hspace{-.05cm}:}\,{\color{Orchid}\sigma}$.

-   Atunci
    ${\color{True}f\, x\hspace{-.05cm}:}\,{\color{Orchid}\sigma \to \tau}$
    și
    ${\color{True}(f\, x)\, y\hspace{-.05cm}:}\,{\color{Orchid}\tau}$.

-   Folosind ambele convenții pentru asociativitate pentru a elimina
    parantezele, avem

    ::: center
      -----------------------------------------------------------------------------
      ${\color{True}f\hspace{-.05cm}:}\,{\color{Orchid}\rho \to \sigma \to \tau}$
      ${\color{True}f\, x\, y\hspace{-.05cm}:}\,{\color{Orchid}\tau}$
      -----------------------------------------------------------------------------
    :::

    Convențiile pentru asociativitate sunt în armonie una cu cealaltă.

## Church-typing vs. Curry-typing

A găsi tipul unui termen începe cu a găsi tipurile pentru variabile.\
Există două metode prin care putem asocia tipuri variabilelor.

Asociere explicită *(Church-typing)*.

-   Constă în prescrierea unui unic tip pentru fiecare variabilă, la
    introducerea acesteia.

-   Tipurile termenilor mai complecși se obțin natural, ținând cont de
    convențiile pentru aplicare și abstractizare.

Asociere implicită *(Curry-typing)*.

-   Constă în a nu prescriere un tip pentru fiecare variabilă, ci în a
    le lăsa \"deschise\" (implicite).

-   În acest caz, termenii *typeable* sunt descoperiți printr-un proces
    de căutare, care poate presupune \"ghicirea\" anumitor tipuri.

# Tipuri à la Church

## Tipuri à la Church

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

## Exemplu

Aplicare

: Dacă
  ${\color{True}M\hspace{-.05cm}:}\,{\color{Orchid}\sigma \to \tau}$ și
  ${\color{True}N\hspace{-.05cm}:}\,{\color{Orchid}\sigma}$,
  atunci ${\color{True}M\, N\hspace{-.05cm}:}\,{\color{Orchid}\tau}$.

Abstractizare

: Dacă
  ${\color{True}x\hspace{-.05cm}:}\,{\color{Orchid}\sigma}$ și
  ${\color{True}M\hspace{-.05cm}:}\,{\color{Orchid}\tau}$,
  atunci
  ${\color{True}\lambda x.\,M\hspace{-.05cm}:}\,{\color{Orchid}\sigma \to \tau}$.

Vrem să calculăm tipul expresiei $(\lambda zu.\,z)\, (y\, x)$ știind că

1.  ${\color{True}x\hspace{-.05cm}:}\,{\color{Orchid}\alpha \to \alpha}$
2.  ${\color{True}y\hspace{-.05cm}:}\,{\color{Orchid}(\alpha \to \alpha) \to \beta}$
3.  ${\color{True}{\color{True}z\hspace{-.05cm}:}\,{\color{Orchid}\beta}}$
4.  ${\color{True}{\color{True}u\hspace{-.05cm}:}\,{\color{Orchid}\gamma}}$

## Exemplu

Aplicare

: Dacă
  ${\color{True}M\hspace{-.05cm}:}\,{\color{Orchid}\sigma \to \tau}$ și
  ${\color{True}N\hspace{-.05cm}:}\,{\color{Orchid}\sigma}$,
  atunci ${\color{True}M\, N\hspace{-.05cm}:}\,{\color{Orchid}\tau}$.

Abstractizare

: Dacă
  ${\color{True}x\hspace{-.05cm}:}\,{\color{Orchid}\sigma}$ și
  ${\color{True}M\hspace{-.05cm}:}\,{\color{Orchid}\tau}$,
  atunci
  ${\color{True}\lambda x.\,M\hspace{-.05cm}:}\,{\color{Orchid}\sigma \to \tau}$.

Vrem să calculăm tipul expresiei $(\lambda zu.\,z)\, (y\, x)$ știind că

1.  ${\color{True}x\hspace{-.05cm}:}\,{\color{Orchid}\alpha \to \alpha}$
2.  ${\color{True}y\hspace{-.05cm}:}\,{\color{Orchid}(\alpha \to \alpha) \to \beta}$
3.  ${\color{True}{\color{True}z\hspace{-.05cm}:}\,{\color{Orchid}\beta}}$
4.  ${\color{True}{\color{True}u\hspace{-.05cm}:}\,{\color{Orchid}\gamma}}$

Din (2) și (1), prin aplicare obținem (5):
${\color{True}{\color{True}y\, x\hspace{-.05cm}:}\,{\color{Orchid}\beta}}$.

Din (4) și (3), prin abstractizare obținem (6):
${\color{True}{\color{True}\lambda u.\,z\hspace{-.05cm}:}\,{\color{Orchid}\gamma \to \beta}}$.

Din (3) și (6), prin abstractizare obținem (7):
${\color{True}{\color{True}\lambda zu.\,z\hspace{-.05cm}:}\,{\color{Orchid}\beta \to \gamma \to \beta}}$.\
Nu uitați că $\beta \to \gamma \to \beta$ înseamnă
$\beta \to (\gamma \to \beta)$.

Atunci, din (7) și (5), prin aplicare, avem
${\color{True}(\lambda zu.\,z)\, (y\, x)\hspace{-.05cm}:}\,{\color{Orchid}\gamma \to \beta}$.

## Substituţie şi reducţie

Substituţia se defineşte întocmai ca la $\lambda$-calculul fără tipuri,
dar având grijă la tipuri. De exemplu, dacă $\sigma$, $\tau \in T$, $t$
este un termen de tip $\tau$, $x$ este o variabilă de tip $\sigma$, iar
$u$ un termen de tip $\sigma$, atunci va avea sens să definim
$$t[x:=u],$$ care va fi, apoi, un termen de tip $\tau$.

Similar, relaţia de $\beta$-reducţie se defineşte identic, având grijă,
de exemplu, ca, în clauza fundamentală $$(\lambda x.t)u \to t[x:=u],$$
obiectele să aibă tipurile potrivite.

## Normalizare şi confluenţă

Se poate arăta (şi chiar vom arăta într-un curs viitor) că acest
$\lambda$-calcul cu tipuri simple nu mai posedă rescrieri infinite
(altfel spus, are proprietatea de **normalizare tare**), i.e. nu există
o familie de termeni $(M_n)_{n \in \mathbb{N}}$ astfel încât pentru
orice $n \in \mathbb{N}$, $M_n \to_\beta M_{n+1}$.

În plus, el păstrează proprietatea de **confluenţă** a
$\lambda$-calculului fără tipuri.

# Tipuri à la Curry

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

### Operații

$\Gamma \uplus \{x : \sigma\}$

: Reuniune, cu promisiunea că $x$ nu apare în $\Gamma$


$\Gamma \oplus \{x : \sigma\}$

: ${}= \{ y : \tau \mid y : \tau \in \Gamma \wedge y \neq x \} \cup \{ x : \sigma \}$\
  Actualizarea lui $\Gamma$


## Reguli de deducţie

Regulile de deducţie vor fi următoarele:

$$\frac{}{\Gamma \uplus \{x:\sigma\} \vdash x:\sigma}$$

$$\frac{\Gamma \oplus \{x:\sigma\} \vdash M : \tau}{\Gamma \vdash \lambda x. M : \sigma\to \tau} \qquad \frac{\Gamma\vdash M: \sigma \to \tau \quad \Gamma \vdash N: \sigma}{\Gamma\vdash M\; N : \tau}$$

Încercaţi să deduceţi tipul termenului „de mai devreme”
$(\lambda z.(\lambda u.z))(yx)$ folosind aceste reguli. Acest exemplu ne
arată că, într-un anume fel, cele două moduri de
a gândi tipurile sunt echivalente.

## Exemplu

Aplicare

: Dacă
  ${\color{True}M\hspace{-.05cm}:}\,{\color{Orchid}\sigma \to \tau}$ și
  ${\color{True}N\hspace{-.05cm}:}\,{\color{Orchid}\sigma}$, atunci
  ${\color{True}M\, N\hspace{-.05cm}:}\,{\color{Orchid}\tau}$.

Abstractizare

: Dacă
  ${\color{True}x\hspace{-.05cm}:}\,{\color{Orchid}\sigma}$ și
  ${\color{True}M\hspace{-.05cm}:}\,{\color{Orchid}\tau}$, atunci
  ${\color{True}\lambda x.\,M\hspace{-.05cm}:}\,{\color{Orchid}\sigma \to \tau}$.

Considerăm termenul de mai devreme $M = (\lambda zu.\,z)\, (y\, x)$.

Putem să \"ghicim\" tipurile variabilelor astfel încât $M$ să *aibă
tip*?


## Exemplu

Aplicare

: Dacă
  ${\color{True}M\hspace{-.05cm}:}\,{\color{Orchid}\sigma \to \tau}$ și
  ${\color{True}N\hspace{-.05cm}:}\,{\color{Orchid}\sigma}$, atunci
  ${\color{True}M\, N\hspace{-.05cm}:}\,{\color{Orchid}\tau}$.

Abstractizare

: Dacă
  ${\color{True}x\hspace{-.05cm}:}\,{\color{Orchid}\sigma}$ și
  ${\color{True}M\hspace{-.05cm}:}\,{\color{Orchid}\tau}$, atunci
  ${\color{True}\lambda x.\,M\hspace{-.05cm}:}\,{\color{Orchid}\sigma \to \tau}$.

Considerăm termenul de mai devreme $M = (\lambda zu.\,z)\, (y\, x)$.

Putem să \"ghicim\" tipurile variabilelor astfel încât $M$ să *aibă
tip*?

-   Observăm că $M$ este o aplicare a lui $\lambda zu.\,z$ termenului
    $y\, x$.

-   Atunci $\lambda zu.\,z$ trebuie să aibă un tip săgeată, de exemplu
    ${\color{True}\lambda zu.\,z\hspace{-.05cm}:}\,{\color{Orchid}A \to B}$,
    și $y\, x$ să se potrivească, adică
    ${\color{True}y\, x\hspace{-.05cm}:}\,{\color{Orchid}A}$.

-   În acest caz, avem
    ${\color{True}M\hspace{-.05cm}:}\,{\color{Orchid}B}$.

## Exemplu (cont.)

Aplicare

: Dacă
  ${\color{True}M\hspace{-.05cm}:}\,{\color{Orchid}\sigma \to \tau}$ și
  ${\color{True}N\hspace{-.05cm}:}\,{\color{Orchid}\sigma}$, atunci
  ${\color{True}M\, N\hspace{-.05cm}:}\,{\color{Orchid}\tau}$.

Abstractizare

: Dacă
  ${\color{True}x\hspace{-.05cm}:}\,{\color{Orchid}\sigma}$ și
  ${\color{True}M\hspace{-.05cm}:}\,{\color{Orchid}\tau}$, atunci
  ${\color{True}\lambda x.\,M\hspace{-.05cm}:}\,{\color{Orchid}\sigma \to \tau}$.


Știm $M = (\lambda zu.\,z)\, (y\, x)$ și am dedus până acum:

::: center
${\color{True}\lambda zu.\,z\hspace{-.05cm}:}\,{\color{Orchid}A \to B}$
${\color{True}y\, x\hspace{-.05cm}:}\,{\color{Orchid}A}$
${\color{True}M\hspace{-.05cm}:}\,{\color{Orchid}B}$
:::

-   Faptul că
    ${\color{True}\lambda zu.\,z\hspace{-.05cm}:}\,{\color{Orchid}A \to B}$
    implică că ${\color{True}z\hspace{-.05cm}:}\,{\color{Orchid}A}$ și
    ${\color{True}\lambda u.\,z\hspace{-.05cm}:}\,{\color{Orchid}B}$.

-   Deducem că $B$ este tipul unei abstractizări, deci
    $B \equiv C \to D$, și obținem că
    ${\color{True}u\hspace{-.05cm}:}\,{\color{Orchid}C}$ și
    ${\color{True}z\hspace{-.05cm}:}\,{\color{Orchid}D}$.

-   Pe de altă parte, $y\, x$ este o aplicare, deci trebuie să existe
    $E$ și $F$ astfel încât
    ${\color{True}y\hspace{-.05cm}:}\,{\color{Orchid}E \to F}$ și
    ${\color{True}x\hspace{-.05cm}:}\,{\color{Orchid}E}$. Atunci
    ${\color{True}y\, x\hspace{-.05cm}:}\,{\color{Orchid}F}$.

## Exemplu (cont.)

Știm $M = (\lambda zu.\,z)\, (y\, x)$. Am dedus următoarele:

-   ${\color{True}x\hspace{-.05cm}:}\,{\color{Orchid}E}$

-   ${\color{True}y\hspace{-.05cm}:}\,{\color{Orchid}E \to F}$

-   ${\color{True}z\hspace{-.05cm}:}\,{\color{Orchid}A}$ și
    ${\color{True}z\hspace{-.05cm}:}\,{\color{Orchid}D}$, deci
    $A \equiv D$

-   ${\color{True}u\hspace{-.05cm}:}\,{\color{Orchid}C}$

-   $B \equiv C \to D$

-   ${\color{True}y\, x\hspace{-.05cm}:}\,{\color{Orchid}A}$ și
    ${\color{True}y\, x\hspace{-.05cm}:}\,{\color{Orchid}F}$, deci
    $A \equiv F$.

În concluzie, $A \equiv D \equiv F$, și eliminând redundanțele obținem

::: center
$(*)$ ${\color{True}x\hspace{-.05cm}:}\,{\color{Orchid}E}$
${\color{True}y\hspace{-.05cm}:}\,{\color{Orchid}E \to A}$
${\color{True}z\hspace{-.05cm}:}\,{\color{Orchid}A}$
${\color{True}u\hspace{-.05cm}:}\,{\color{Orchid}C}$
:::

Reamintim că aveam ${\color{True}M\hspace{-.05cm}:}\,{\color{Orchid}B}$,
adică ${\color{True}M\hspace{-.05cm}:}\,{\color{Orchid}C \to A}$.

Am obținut o schemă generală $(*)$ pentru tipurile lui $x,y,z,u$ care
induc un tip pentru $M$.

## Exemplu (cont.)

Știm $M = (\lambda zu.\,z)\, (y\, x)$. Am obținut schema generală

::: center
$(*)$ ${\color{True}x\hspace{-.05cm}:}\,{\color{Orchid}E}$
${\color{True}y\hspace{-.05cm}:}\,{\color{Orchid}E \to A}$
${\color{True}z\hspace{-.05cm}:}\,{\color{Orchid}A}$
${\color{True}u\hspace{-.05cm}:}\,{\color{Orchid}C}$
${\color{True}M\hspace{-.05cm}:}\,{\color{Orchid}C \to A}$
:::

În schema de mai sus, putem considera tipuri \"reale\":

-   ${\color{True}x\hspace{-.05cm}:}\,{\color{Orchid}\beta}$,
    ${\color{True}y\hspace{-.05cm}:}\,{\color{Orchid}\beta \to \alpha}$,
    ${\color{True}z\hspace{-.05cm}:}\,{\color{Orchid}\alpha}$,
    ${\color{True}u\hspace{-.05cm}:}\,{\color{Orchid}\delta}$,
    ${\color{True}M\hspace{-.05cm}:}\,{\color{Orchid}\delta \to \alpha}$

-   ${\color{True}x\hspace{-.05cm}:}\,{\color{Orchid}\alpha \to \alpha}$,
    ${\color{True}y\hspace{-.05cm}:}\,{\color{Orchid}(\alpha \to \alpha) \to \beta}$,
    ${\color{True}z\hspace{-.05cm}:}\,{\color{Orchid}\beta}$,
    ${\color{True}u\hspace{-.05cm}:}\,{\color{Orchid}\gamma}$,
    ${\color{True}M\hspace{-.05cm}:}\,{\color{Orchid}\gamma \to \beta}$\
    (soluția discutată la Church-typing)

-   ${\color{True}x\hspace{-.05cm}:}\,{\color{Orchid}\alpha}$,
    ${\color{True}y\hspace{-.05cm}:}\,{\color{Orchid}\alpha \to \alpha \to \beta}$,
    ${\color{True}z\hspace{-.05cm}:}\,{\color{Orchid}\alpha \to \beta}$,
    ${\color{True}u\hspace{-.05cm}:}\,{\color{Orchid}\alpha \to \alpha}$,
    ${\color{True}M\hspace{-.05cm}:}\,{\color{Orchid}(\alpha \to \alpha) \to \alpha \to \beta}$\

# Inferenţa tipurilor

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
undeva „între” Church şi Curry, în sensul că termenii nu au tipuri, dar,
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
c(x,\Gamma \uplus \{x : \tau\}, Z) &:= \{\tau = Z\}\\
c(\lambda x:\sigma. M, \Gamma, Z) &:= c(M , \Gamma \oplus \{x:\sigma\}, W) \cup \{Z = \sigma \to W\}\\
c(M\; N, \Gamma, Z) &:= c(M, \Gamma, W_1) \cup c(N, \Gamma, W_2) \cup \{W_1 = W_2 \to Z\}
\end{aligned}$$

Algoritmul va face apelul $c(M', \Gamma_M, Z)$ şi va
obţine o mulţime de ecuaţii. Pentru ea, se caută un cgu $\theta$. În caz
că nu există, se returnează „eşec”. În caz de succes, rezultatul
algoritmului va fi
$\widetilde{\theta}(\Gamma_M) \vdash M : \widetilde{\theta}(Z)$ (unde
$\widetilde{\theta}$ are semnificaţia firească).

Putem rula algoritmul pe termenii $(\lambda z.(\lambda u.z))(y\; x)$ şi
$x\; x$, evidenţiaţi mai devreme.

# Limitări ale lambda-calculului cu tipuri simple

## Recursie și terminare

Nu mai avem recursie nelimitată deoarece combinatorii de punct fix nu
sunt *typeable*.

De exemplu,
$\mathbf{Y} \triangleq \lambda y.\,(\lambda x.\,y\, (x\, x))\, (\lambda x.\,y\, (x\, x))$
nu este typeable.

Faptul că orice evaluare se termină este important pentru implementări
ale logicilor folosind lambda-calculul.

## Tipurile pot fi prea restrictive.

De exemplu, am putea gândi că termenul
$(\lambda f.\,\mathbf{if}\, (f\, \mathbf{T})\, (f\, 3)\, (f\, 5))\, (\lambda x.\,x)$
ar trebui să aibă un tip. Dar nu are!

Soluții posibile:

-   Let-polymorphism unde variabilele libere din tipul lui $f$ se
    redenumesc la fiecare folosire. De exemplu, am putea scrie

    ::: center
    $\begin{array}[t]{l}
        \mathop{\mathbf{let}} f \mathrel{\mathbf{=}} \lambda x.\,x \mathrel{\mathbf{in}} \\
        \mathbf{if}\, (f\, \mathbf{T})\, (f\, 3)\, (f\, 5)
    \end{array}$
    :::

-    Cuantificatori de tipuri. De exemplu, am avea
    $${\color{IntensColor} \lambda x.\,x : \Pi\alpha\mathrel{.}\alpha \to \alpha}$$
    Operatorul de legare $\Pi$ face explicit faptul că variabila de tip
    $\alpha$ nu este rigidă.
