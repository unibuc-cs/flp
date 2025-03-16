---
author: Traian Florin Șerbănuță și Andrei Sipoș
institute: Facultatea de Matematică și Informatică, DL Info
date: Anul II, Semestrul II, 2024/2025
title: Fundamentele limbajelor de programare
subtitle: 7. Programare Funcțională. Lambda-calcul fără tipuri. Codări Church. Calculabilitate.
theme: CambridgeUS
---

## Lambda-calcul

Limbajele de programare funcţionale (Haskell, ML etc.) sunt
caracterizate, în primul rând, prin faptul că funcţiile sunt cetăţeni de
prim rang" ("first-class citizens"), ele fiind obiecte ca oricare altele
(cum sunt numerele sau valorile booleene), iar această trăsătură derivă
direct din limbajul din care au fost ele inspirate iniţial, anume
**lambda-calculul ($\lambda$-calculul)** lui Church, pomenit în
Introducerea istorică.

Lambda-calculul a fost conceput, după cum am zis, pentru a reprezenta un
model de calcul universal, capabil să reprezinte toate funcţiile
informal calculabile, şi de aceea a şi fost gândit ca fiind un calcul al
funcţiilor. El este prezent azi în felurite variante, în special cu
tipuri, având diverse restricţii şi expansiuni. Noi vom începe cu
prezentarea calculului original, fără tipuri.

## Lambda-calcul fără tipuri

Fixăm o mulţime numărabilă de variabile
$V = \{x_n \mid n \in \mathbb{N}\}$.

Un **$\lambda$-termen (fără tipuri)** are exact una dintre următoarele
forme:

-   o **variabilă** $x \in V$;

-   o **($\lambda$)-abstracţiune**: dacă $x \in V$ şi $M$ este un
    $\lambda$-termen, atunci $\lambda x.M$ este un $\lambda$-termen;

-   o **aplicaţie**: dacă $M$ şi $N$ sunt $\lambda$-termeni, atunci $MN$
    este un $\lambda$-termen.

Cum arată principiile de inducţie/recursie corespunzătoare?

## Variabile şi variabile libere

Putem defini recursiv mulţimea variabilelor unui termen prin clauzele:

-   $Var(v)=\{v\}$;

-   $Var(\lambda x.M) = Var(M) \cup \{x\}$;

-   $Var(MN) = Var(M) \cup Var(N)$;

iar pe cea a variabilelor libere prin:

-   $FV(v)=\{v\}$;

-   $FV(\lambda x.M) = FV(M) \setminus \{x\}$;

-   $FV(MN) = FV(M) \cup FV(N)$.

## Interpretarea informală

După cum am zis, $\lambda$-termenii au fost gândiţi ca reprezentând
funcţii. Mai exact (fixând $x$, $y$, $z \in V$ distincte două câte
două):

-   Un termen de forma $\lambda x.M$ este gândit ca reprezentând funcţia
    care duce pe $x$ în $M$ ($M$ fiind un termen în a cărui componenţă
    poate sau nu să apară variabila $x$).\
    De exemplu: $\lambda x.x$ ar reprezenta funcţia identitate,
    $\lambda x.y$ ar reprezenta o funcţie constant egală cu $y$.
-   Un termen de forma $MN$ reprezintă rezultatul aplicării funcţiei"
    $M$ pe argumentul" $N$.\
    De exemplu: am vrea ca $(\lambda x.x)z$ să reprezinte $z$, iar
    $(\lambda x.y)z$ să reprezinte $y$.

Remarcăm că aceste interpretări sunt aici pur informale: a le face
riguroase a fost mult timp o problemă aproape insurmontabilă. Situaţia
devine mai uşoară dacă nu ne propunem să formalizăm termenii ca funcţii
(semantică denotaţională"), ci doar să stabilim regulile prin care ei
sunt manipulaţi (semantică operaţională").

## Spre substituţie

De exemplu, când spunem că $(\lambda x.x)z$ am vrea să reprezinte $z$,
sugerăm că $x$-ul din corpul funcţiei" am vrea să fie substituit cu $z$.
Pentru aceasta, avem nevoie de o definiţie a substituţiei. Nu putem
substitui **naiv** variabilele cu $\lambda$-termeni din aceleaşi
considerente ca la logica de ordinul I: am putea să ne trezim cu urmări
nedorite, de exemplu, dacă în $\lambda$-termenul $$\lambda x.y,$$
reprezentând funcţia constant egală cu $y$", substituim fără atenţie $y$
cu $x$, ajungem la $\lambda$-termenul $$\lambda x.x,$$ care reprezintă o
funcţie identitate (variabila $x$ fiind capturată accidental" de către
$\lambda x$). Or, aceasta contravine intuiţiei care ne spune că o
funcţie compusă cu una constantă nu poate fi neconstantă.

## Spre substituţie

Observăm următorul fapt: termeni ca $\lambda x.x$ şi $\lambda z.z$ am
dori să denote aceeaşi funcţie, funcţia identitate; la fel şi
$\lambda x.y$ şi $\lambda z.y$ aceeaşi funcţie, funcţia constant egală
cu $y$. Aşadar, vom transforma întâi $\lambda x.y$ în $$\lambda z.y,$$
pentru a putea substitui apoi $y$ cu $x$, obţinând $$\lambda z.x,$$ care
este tot o funcţie constantă.

Practic, ideea este că denumirile variabilelor legate nu contează, atâta
timp cât ele sunt folosite consecvent: de aceea, ele se pot şi substitui
una cu alta atâta timp cât şi substituţia este consecventă. Dat fiind că
în acest principiu se aminteşte de substituţie, el se va putea formaliza
abia după definirea substituţiei. Totuşi, acea parte a sa care este
relevantă pentru definirea substituţiei poate fi inclusă în definiţie,
folosind recursivitatea.

## Definirea substituţiei

Pentru orice $\lambda$-termeni $M$, $N$ şi orice $x \in V$, vom defini
termenul $M[x:=N]$, reprezentând $M$ în care $x$ a fost înlocuit cu $N$.
O vom face recursiv, în felul următor (unde $x$, $y \in V$ cu
$x \neq y$, iar $N$, $P$, $Q$ sunt $\lambda$-termeni):

-   $x[x:=N] := N$;

-   $x[y:=N] := x$;

-   $(PQ)[x:=N] := (P[x:=N])(Q[x:=N])$;

-   $(\lambda x.P)[x:=N] := \lambda x.P$;

-   $(\lambda y.P)[x:=N] := \lambda y.(P[x:=N])$, dacă
    $y \not\in FV(N)$;

-   $(\lambda y.P)[x:=N] := \lambda z.(P[y:=z][x:=N])$, dacă
    $y \in FV(N)$, unde $z$ este variabila de indice minim care nu
    aparţine lui $Var(\lambda x .(NP))$, caz care corespunde fenomenului
    prezentat mai devreme.

## Exemple

Care sunt următorii $\lambda$-termeni (presupunem $u$, $v$, $w$, $x$,
$y$, $z \in V$, distincte două câte două)?

-   $(\lambda y. (x (\lambda w. ((vw)x))))[ x:=uv]$;

-   $(\lambda y. (x (\lambda x.x)))[x:= \lambda y. (xy)]$;

-   $(y (\lambda v.(xv)) ) [x := \lambda y. (vy)]$;

-   $(\lambda x. (zy))[ x:= uv]$.

## Alpha-echivalenţă

În acest moment, putem formaliza intuiţia de mai devreme legată de
substituţia variabilelor legate. Numim $\alpha$-echivalenţă şi o notăm
cu $\equiv_\alpha$ cea mai mică relaţie de echivalenţă $\equiv$ pe
$\lambda$-termeni care satisface următoarele:

-   pentru orice $x$, $y \in V$ şi orice $\lambda$-termen $M$ cu
    $y\notin FV(M)$, $\lambda x.M \equiv \lambda y. (M[x:=y])$;

-   pentru orice $x \in V$ şi orice $\lambda$-termeni $M$, $N$ cu
    $M \equiv N$, avem $\lambda x. M \equiv \lambda x.N$;

-   pentru orice $\lambda$-termeni $M$, $N$, $P$ cu $M \equiv N$, avem
    $MP \equiv NP$ şi $PM \equiv PN$.

## Spre reducţie

Am spus mai devreme că $(\lambda x.x)z$ am vrea să reprezinte $z$, iar
pentru aceasta am introdus o definiţie a substituţiei astfel încât
$x[x:=z]=z$. Totuşi, mai trebuie să spunem şi de ce putem face trecerea
$$(\lambda x.x)z \to x[x:=z]$$ sau, în celălalt exemplu,
$$(\lambda x.y)z \to y[x:=z]$$ şi, în general,
$$(\lambda x.M)N \to M[x:=N].$$

Pentru aceasta, vom introduce o nouă relaţie pe $\lambda$-termeni, care
va reprezenta această procedură de reducţie.

## Beta-reducţie

Numim $\beta$-reducţie şi o notăm cu $\to_\beta$ cea mai mică relaţie
$\to$ pe $\lambda$-termeni care satisface următoarele, pentru orice
$\lambda$-termeni $M$, $N$, $P$ şi orice $x \in V$:

-   $(\lambda x.M)N \to M[x:=N]$;

-   dacă $M \to N$, atunci $\lambda x.M \to \lambda x.N$, $MP \to NP$ şi
    $PM \to PN$.

Notăm cu $\to^*_\beta$ închiderea reflexiv-tranzitivă a lui
$\to_\beta$.

Un $\lambda$-termen $M$ se numeşte **formă normală** dacă nu există $N$
cu $M \to_\beta N$. Dacă $M$ şi $N$ sunt $\lambda$-termeni, $N$ se
numeşte **formă normală a lui $M$** dacă $M \to^*_\beta N$ şi $N$ este
formă normală.

## Normalizare şi confluenţă

Dacă notăm $I:=\lambda x.x$, $\omega:=\lambda x.(xx)$ şi
$\Omega:=\omega\omega$, se observă că, pentru orice $M$,
$$IM = (\lambda x.x)M \to_\beta x[x:=M] = M$$ şi
$$\omega M = (\lambda x.(xx))M \to_\beta (xx)[x:=M] = MM.$$ Aşadar,
$\Omega = \omega\omega \to \omega\omega = \Omega$, deci există şiruri
infinite de $\beta$-reducţii. Aceasta face ca $\lambda$-calculul fără
tipuri să nu fie **normalizant**.

El are, în schimb, o proprietate pozitivă, anume aceea de **confluenţă**
(modulo $\alpha$-echivalenţă): pentru orice $M$, $N_1$, $N_2$ cu
$M \to^*_\beta N_1$ şi $M \to^*_\beta N_2$, există $P_1$, $P_2$ cu
$N_1 \to^*_\beta P_1$, $N_2 \to^*_\beta P_2$ şi $P_1 \equiv_\alpha P_2$.

## Valori booleene

Am spus că $\lambda$-calculul se vrea să fie un model de calcul, aşadar
ne punem problema de a reprezenta date şi operaţii pe ele în el. Cel mai
simplu tip de date este cel boolean. Dacă notăm cu **true**
$\lambda$-termenul $\lambda x.\lambda y.x$, iar cu **false**
$\lambda$-termenul $\lambda x.\lambda y.y$, atunci ideea de **if $M$
then $P$ else $Q$** se poate reprezenta prin $(MP)Q$, având în vedere
că, pentru orice $\lambda$-termeni $M$, $P$, şi $Q$, avem că, dacă
$M \to^*_\beta \textbf{true}$, atunci $$(MP)Q \to^*_\beta P,$$ iar, dacă
$M \to^*_\beta \textbf{false}$, atunci $$(MP)Q \to^*_\beta Q.$$

## Numere naturale

Trecem acum la întrebarea: cum putem reprezenta numere naturale? Dat
fiind că $\lambda$-calculul este un calcul al funcţiilor, întrebarea se
reduce la: cum putem privi un număr ca o funcţie care acţionează asupra
altor funcţii? Un răspuns posibil, dat de Church, este următorul: un
$n \in \mathbb{N}$ este privit ca funcţia $$f \mapsto f^{(n)},$$ unde
notaţia $f^{(n)}$ reprezintă compunerea lui $f$ cu ea însăşi de $n$ ori.
Aşadar, numărul $n$ va fi reprezentat de $\lambda$-termenul
$\lambda f. \lambda x. (f^{(n)}x)$.

## Numere naturale

Riguros vorbind, luăm $f$, $x \in V$ cu $f \neq x$, punem $D_0:=x$ şi,
pentru orice $n \in \mathbb{N}$, $D_{n+1}:=fD_n$. Punem, apoi, pentru
orice $n \in \mathbb{N}$, $C_n := \lambda f. \lambda x. D_n$ şi îl numim
**numeralul Church** asociat lui $n$.

Putem acum defini un predicat" care verifică dacă un număr este zero,
prin:
$$\textbf{iszero} := \lambda n. \lambda x. \lambda y. ((n (\lambda z.y))x).$$

Observăm că, de exemplu, $$\begin{aligned}
\textbf{iszero}\ C_0 &= \textbf{iszero}\ (\lambda f.\lambda x.x) \to_\beta \lambda x.\lambda y. (((\lambda f.\lambda x.x) (\lambda z.y))x)\\
&\to_\beta \lambda x.\lambda y. ((\lambda x.x)x) \to_\beta \lambda x.\lambda y. x = \textbf{true}.
\end{aligned}$$

Similar,
$\textbf{iszero}\ C_1\to^*_\beta\textbf{false}$.

## Succesorul

Dat fiind că, intuitiv vorbind, pentru orice $n$,
$$C_n(f)(x)=f^{(n)}(x)$$ şi
$$C_{n+1}(f)(x) = f^{(n+1)}(x) = f(C_n(f)(x)),$$ putem defini un
$\lambda$-termen care să reprezinte funcţia succesor, prin
$$\textbf{succ} := \lambda n.\lambda f.\lambda x.(f((n f)x)).$$ Testaţi
comportamentul acestui $\lambda$-termen!

## Alte operaţii pe numere

Pentru adunare, observăm că, la fel ca înainte, pentru orice $n$,
$m \in \mathbb{N}$, intuitiv vorbind
$$C_{n+m}(f)(x) = f^{(n+m)}(x) = f^{(n)}(f^{(m)}(x)) = C_n(f)(C_m(f)(x)),$$
ceea ce ne conduce la definiţia:
$$\textbf{add} := \lambda n. \lambda m. \lambda f.\lambda x.((n f)((m f)x)).$$

Similar, putem defini:
$$\textbf{mul} := \lambda n. \lambda m. \lambda f. (n (m f)).$$
$$\textbf{pow} := \lambda b. \lambda e. (e b).$$
$$\textbf{pred} := \lambda n. \lambda f. \lambda x. (((n (\lambda g. \lambda h. (h (g f)))) (\lambda u.x)) (\lambda u.u)).$$

## Recursivitate

Cum definim funcţii recursive? Spre exemplu, funcţia factorial ar
satisface intuitiv ecuaţia
$$\textbf{fact} = \lambda n. (((\textbf{iszero}\ n) C_1)((\textbf{mul}\ n) (\textbf{fact} (\textbf{pred}\ n)))),$$
sau, altfel spus,
$$\textbf{fact} = (\lambda f.(\lambda n. (((\textbf{iszero}\ n) C_1)((\textbf{mul}\ n) (f (\textbf{pred}\ n))))))\textbf{fact}.$$

Dacă am avea la dispoziţie un **operator de punct fix**, adică un
$\lambda$-termen $Y$ astfel încât, pentru orice $M$,
$YM \to^*_\beta M(YM)$, atunci am putea, ca în Laboratorul 3, să definim
$$\textbf{fact} := Y (\lambda f.(\lambda n. (((\textbf{iszero}\ n) C_1)((\textbf{mul}\ n) (f (\textbf{pred}\ n)))))).$$


## Puncte fixe

Dacă punem $U:=\lambda u. \lambda x. (x((uu)x))$, atunci $Y:=UU$ este un
asemenea operator de punct fix, având în vedere că, pentru orice $M$,
avem
$$\begin{aligned}
YM\ =&\ (UU)M \\
   \to_\beta&\ ((\lambda x. (x((uu)x)))[u:=U])M\\
   =&\ (\lambda x. (x((UU)x)))M\\
   =&\ (\lambda x. (x(Yx)))M\\
   \to_\beta&\ (x(Yx))[x:=M] \\
   =&\ M(YM).
\end{aligned}$$

Această soluţie a fost dată de Alan Turing. Altă
soluţie, dată de Haskell Curry, este
$Y:=\lambda u.((\lambda x.u(xx))(\lambda x.u(xx)))$.

## Funcţii reprezentabile

În general, spunem, pentru orice $k \in \mathbb{N}$, că o funcţie
$f:\mathbb{N}^k \to \mathbb{N}\cup \{\bot\}$ este
**$\lambda$-reprezentabilă** dacă există un $\lambda$-termen $M$ astfel
încât, pentru orice $n_1,\ldots,n_k \in \mathbb{N}$, dacă
$f(n_1,\ldots,n_k) \in \mathbb{N}$, atunci
$$M C_{n_1}\ldots C_{n_k} \to_\beta^* C_{f(n_1,\ldots,n_k)},$$ iar, dacă
$f(n_1,\ldots,n_k) = \bot$, atunci $$M C_{n_1}\ldots C_{n_k}$$ nu are
formă normală.

## Calculabilitate

Se poate demonstra că aceste funcţii coincid exact cu funcţiile
calculabile de o maşină Turing (şi, în general, de orice alt model de
calcul universal care a fost conceput de om), ceea ce dă crezare **tezei
Church-Turing**, care spune că această clasă capturează exact clasa
funcţiilor calculabile la modul informal (mai multe despre aceasta se va
spune la cursul Calculabilitate şi complexitate").

Totuşi, vedem că acest $\lambda$-calcul fără tipuri cuprinde în el şi
termeni care nu au formă normală, şi de aceea în definirea funcţiilor
reprezentabile am inclus şi funcţii parţiale. Există, oare, un mod de a
ne restrânge la funcţiile calculabile care sunt totale? Mai multe despre
aceasta vom vedea în cursul următor.
