---
author: Traian Florin Șerbănuță și Andrei Sipoș
institute: Facultatea de Matematică și Informatică, DL Info
date: Anul II, Semestrul II, 2024/2025
title: Fundamentele limbajelor de programare
subtitle: Programare Logică (de ordinul I). Unificare. Universul Herbrand
theme: CambridgeUS
---

# Termeni de ordinul I

## Logica de ordinul I

Vom fixa patru obiecte $\bot$, $\to$, $\forall$, $=$, diferite două câte
două şi o mulţime numărabilă (de **variabile logice**)
$$V=\{x_0,x_1,\ldots\},$$ cu
$V \cap \{\bot,\to,\forall,=\} = \emptyset$.

## Signaturi de ordinul I

Definim o **signatură de ordinul I** ca fiind un triplet
$\sigma = (F,R,r)$ astfel încât $F \cap R = \emptyset$,
$(F \cup R) \cap (V \cup \{\bot,\to,\forall,=\}) = \emptyset$ şi
$r : F \cup R \to \mathbb{N}$.

Dacă $\sigma = (F,R,r)$ este o signatură de ordinul I, atunci numim:

- **simbolurile de relaţie** ale lui $\sigma$ – elementele lui $R$ 

- **simbolurile de funcţie** ale lui $\sigma$ – elementele lui $F$ 

-  $r(s)$ **aritatea** lui $s$ – pentru orice $s \in F \cup R$

- **constantele** lui $\sigma$ – acele $s\in F$ pentru care $r(s)=0$

## Termeni

**Termenii** sunt cuvinte peste alfabetul
$$S_\sigma := \{\bot,\to,\forall,=\} \cup V \cup F \cup R.$$
definite prin următoarele două (scheme de) reguli:

- $v$ e termen, pentru orice $v \in V$

- dacă $t_1,\ldots,t_{r(s)}$ sunt termeni, \
  atunci $st_1\ldots t_{r(s)}$ e termen \
  pentru orice $s \in F$.\
  (în particular, dacă $r(s) = 0$, atunci $s$ este termen)

Mulţimea termenilor peste $\sigma$ se va nota cu $T_\sigma$.

## Mulţimea variabilelor unui termen

$Var : T_\sigma \to \mathcal{P}(V)$, definită prin:

-   pentru orice $x \in V$, $Var(x):=\{x\}$;

-   pentru orice $s \in F$ şi orice $t_1,\ldots,t_{r(s)} \in T_\sigma$,
    $Var(st_1\ldots t_{r(s)}):=Var(t_1) \cup \ldots \cup Var(t_{r(s)})$ \
    (în particular, dacă $r(s)=0$, $Var(s)=\emptyset$).

Notăm cu $\widetilde{T}_\sigma$ mulţimea termenilor fără variabile.

## Formule

Fie $\sigma=(F,R,r)$ o signatură. Numim **formulă atomică** peste
$\sigma$ un şir de forma ${=}tu$, cu $t$, $u \in T_\sigma$ (numită formulă
atomică **ecuaţională** sau doar **ecuaţie**) sau un şir de forma
$st_1\ldots t_n$ cu $s\in R$, $n=r(s)$ şi $t_1,\ldots,t_n\in T_\sigma$
(numită formulă atomică **relaţională**). Mulţimea formulelor atomice
peste $\sigma$ se va nota cu $Fa_\sigma$. Mulţimea **formulelor** peste
$\sigma$ se defineşte prin următoarele (scheme de) reguli:

-   $a$ este formulă, pentru orice formulă atomică $a \in Fa_\sigma$;

-   $\bot$ este formulă;

-   dacă $\varphi$, $\psi$ sunt formula, atunci $\to\varphi\psi$ este formulă;

-   dacă $\varphi$ formulă, atunci $\forall x \varphi\in A$, pentru orice $x \in V$.

Mulţimea formulelor peste $\sigma$ se va nota cu $F_\sigma$.

De asemenea, vom defini **formulele relaţionale** în acelaşi mod, cu
excepţia că acceptăm în cadrul lor doar formule atomice relaţionale.

## Notaţie infixată şi conectori derivaţi

Vom folosi aceeaşi metodă pe care am folosit-o la logica propoziţională
pentru a putea nota formulele infixat -- pentru orice $\varphi$,
$\psi \in F_\sigma$, $\varphi\to\psi$ în loc de $\to\varphi\psi$, dar
şi, pentru orice $t$, $u \in T_\sigma$, $t=u$ în loc de $=tu$.

De asemenea, vom nota, ca mai înainte, pentru orice $\varphi$,
$\psi \in F_\sigma$,
$$\top:= \bot\to\bot,\quad \neg \varphi:= \varphi\to \bot,\quad \varphi\wedge\psi:=\neg(\varphi\to \neg\psi),$$
$$\varphi\vee\psi:=(\neg \varphi)\to \psi,\quad \varphi\leftrightarrow\psi := (\varphi\to \psi) \wedge(\psi \to \varphi).$$
dar şi, pentru orice $x\in V$ şi $\varphi\in F_\sigma$,
$$\exists x \varphi:= \neg \forall x \neg \varphi.$$

## Mulţimea variabilelor libere ale unei formule

Definim funcţia $FV : F_\sigma \to \mathcal{P}(V)$, prin:

-   pentru orice $t$, $u \in T_\sigma$, $FV(t=u):=Var(t) \cup Var(u)$;

-   pentru orice $p \in R$ şi orice $t_1,\ldots,t_{r(p)} \in T_\sigma$,
    $FV(pt_1\ldots t_{r(p)}):=Var(t_1) \cup \ldots \cup Var(t_{r(p)})$;

-   $FV(\bot):=\emptyset$;

-   pentru orice $\varphi$, $\psi \in F_\sigma$,
    $FV(\varphi\to \psi):=FV(\varphi) \cup FV(\psi)$;

-   pentru orice $\varphi\in F_\sigma$ şi $x \in V$,
    $FV(\forall x \varphi):=FV(\varphi) \setminus \{x\}$.

Dacă $\varphi\in F_\sigma$ cu $FV(\varphi)=\emptyset$, atunci $\varphi$
se numeşte **enunţ**. Mulţimea enunţurilor peste $\sigma$ se notează cu
$E_\sigma$.


## Clauze

Dacă avem o formulă $\varphi$, $n \in \mathbb{N}$ şi
$k_1 < \ldots < k_n$ cu $FV(\varphi)=\{x_{k_1},\ldots,x_{k_n}\}$, notăm
cu $\forall \varphi$ enunţul
$\forall x_{k_1} \ldots \forall x_{k_n} \varphi$.

Numim **literal** o formulă de forma $\varphi$ sau $\neg \varphi$, unde
$\varphi$ este o formulă atomică relaţională (literalul este, respectiv,
**pozitiv** sau **negativ**). Numim **clauză** o formulă de forma
$\forall(L_1 \lor\ldots\lor L_m)$, unde $L_1,\ldots,L_m$ sunt literali.
Numim **clauză definită** o clauză unde apare exact un literal pozitiv,
anume pe prima poziţie. Dacă $A_0,\ldots A_m$ sunt formule atomice
relaţionale, atunci clauza
$$\forall(A_0 \lor \neg A_1 \lor\ldots\lor \neg A_m)$$ se scrie şi sub
forma (cunoscută din limbajul Prolog) $$A_0 \leftarrow A_1,\ldots,A_m.$$

Un **program** va fi o mulţime finită de clauze definite. Un **scop
definit** este o clauză în care apar doar literali negativi.

# Unificare

## Motivaţia unificării

Să zicem că avem un program Prolog care conţine regula
$$p(f(x),y) \leftarrow p(x,y)$$ şi vrem să interogăm $p(z,f(t))$. Pentru
a găsi o soluţie a acestei interogări folosind regula de mai sus,
trebuie să substituim $x \mapsto x$, $z \mapsto f(x)$, $y \mapsto f(t)$,
$t \mapsto t$, interogarea devenind $p(f(x),f(t))$, care este redusă,
conform regulii, la $p(x,f(t))$, care devine practic o nouă interogare.

Observăm că o parte esenţială a procesului de rulare a unui program
Prolog este găsirea acelei substituţii.


## Substituţia termenilor

Vom numi **substituţie** o funcţie $\theta : V \to T_\sigma$. Folosind
Principiul de recursie pe termeni, ea se extinde natural în mod unic la
o funcţie $\widetilde{\theta} : T_\sigma \to T_\sigma$.

Se observă, folosind unicitatea, că, pentru orice două substituţii
$\theta$, $\theta'$,
$$\widetilde{\widetilde{\theta'} \circ \theta} = \widetilde{\theta'} \circ \widetilde{\theta}.$$

Pentru o variabila $x$ și un termen $t$ definim substituția singleton $[x \mapsto t]$ prin
$$[x \mapsto t](y) =  \begin{cases} t, & \mbox{dac\u a } y=x, \\
y, & \mbox{altfel}.\end{cases}$$

Spunem ca un termen $t$ e __mai general__ decât un termen $t'$ dacă \
există o substituție $\Delta$ astfel încât $t' = \widetilde{\Delta}(t)$

Spunem că o substituție $\Theta$ e __mai generală__ decât altă substituție $\Theta'$ dacă \
există o substituție $\Delta$ astfel încât $\Theta' = \widetilde{\Delta} \circ \Theta$

## Unificatori

Dacă $\mathcal{E}$ este o mulţime de ecuaţii, numim **unificator**
pentru ea o substituţie $\theta$ astfel încât, pentru orice
$(s=t) \in \mathcal{E}$, avem
$\widetilde{\theta}(s)=\widetilde{\theta}(t)$

Un unificator $\theta$ pentru $\mathcal{E}$ se numeşte \
**cel mai general unificator** (**cgu**; **most general unifier**, **mgu**) dacă \
este mai general (ca substituție) decât orice alt unificator $\theta'$ pentru $\mathcal{E}$.

## Algoritm de unificare

Algoritmul pornește cu configurația inițială $(\Theta, \mathcal{R}) = (1_V, \mathcal{E})$ și \
constă în aplicarea nedeterministă a regulilor de mai jos:

SCOATE

: $(\Theta, \mathcal{R} \cup \{t = t\}) \Longrightarrow (\Theta, \mathcal{R})$

DESCOMPUNE

: $(\Theta, \mathcal{R} \cup \{f(t_1,\ldots,t_n) = f(t_1',\ldots,t_n')\})$ \
  $\Longrightarrow (\Theta, \mathcal{R} \cup \{ t_1 = t_1', \ldots, t_n = t_n' \}$

REZOLVĂ

: $(\Theta, \mathcal{R} \cup \{x = t\})$ \hfill sau \hfill $(\Theta, \mathcal{R} \cup \{t = x\})$ \
  $\Longrightarrow (\widetilde{[x\mapsto t]}\circ \Theta, \{\widetilde{[x\mapsto t]}(t_1) = \widetilde{[x\mapsto t]}(t_2) \mid t_1 = t_2 \in \mathcal{R}\}$ \
  dacă $x \notin Var(t)$.

\HRule

EȘEC (conflict)

: există în $\cal R$ o ecuaţie de forma\
  $f(s_1,\ldots,s_n) = g(t_1,\ldots,t_m)$ cu $f \neq g$.

EȘEC (ciclu)

: există în $\cal R$ o ecuaţie de forma\
  $x = t$ sau $t = x$ cu $t \neq x$ şi $x \in Var(t)$.


## Invariant

### Teoremă

Pentru orice configurație $(\Theta, \mathcal{R})$ obținută în execuția algoritmului,
mulțimea unificatorilor lui $\mathcal{R}$ pentru care $\Theta$ e mai generală (ca substituție)
este invariantă. Mai mult, $\widetilde{\Theta}(t) = t$ pentru orice $t$ care apare în $R$.

### Demonstrație

Arătăm că afirmația e păstrată de reguli.

Scoate: orice substituție care unifică $\mathcal{R}$ unifică și $\mathcal{R} \cup \{t = t\}$ și revers

Descompune: Asemănător, folosind proprietatea de citire unică a termenilor.

Rezolvă: Fie $\Theta'$ unificator pentru $R\cup \{x = t\}$ a.î. $\Theta$ e mai generală.
Fie $\Delta$ a.î. $\Theta' = \widetilde{\Delta} \circ \Theta$.
Avem că $\widetilde\Theta(x) = x$ și $\widetilde\Theta(t) = t$, de unde
$\widetilde{\Theta'}(x) = \widetilde{\Delta}(x)$ și $\widetilde{\Theta'}(t) = \widetilde{\Delta}(t)$.
Deci $\widetilde{\Delta}(x) = \widetilde{\Delta}(t)$, de unde $\Delta = \widetilde{\Delta} \circ [x \mapsto t]$, atunci
$\Theta' = \widetilde{\Delta'} \circ \widetilde{[x\mapsto t]} \circ \Theta$.

În plus, $\widetilde\Theta' \circ \widetilde{[x\mapsto t]} = \widetilde{\Delta'} \circ \widetilde{[x\mapsto t]} \circ \widetilde\Theta \circ \widetilde{[x\mapsto t]} =  \widetilde{\Delta'} \circ \widetilde{[x\mapsto t]} \circ \widetilde{[x\mapsto t]} \circ \widetilde\Theta = \widetilde{\Delta'} \circ \widetilde{[x\mapsto t]} \circ \Theta = \widetilde\Theta'$

## Corectitudine

### Teoremă
Algoritmul de unificare se termină mereu şi produce
rezultatul corect.

### Demonstraţie
__Terminare:__ asociem fiecărei configurații $(\Theta, \mathcal{R})$ _variantul_ $(nx, nf)$ unde \

$nx$ e nr. variabile distincte din $\cal R$ și $nf$ e nr. simboluri din $\cal R$.

Observăm că variantul descrește la aplicarea oricărui pas.

__Progress:__ Dacă nu eșec și $\mathcal{R} \neq \emptyset$, atunci mai putem face un pas.

__CGU:__ În starea inițială, mulțimea unificatorilor din proprietatea de invarianță este mulțimea tuturor
unificatorilor lui $\cal E$.

Deoarece aceasta e păstrată de pașii algoritmului, în stare finală avem:

Mulțimea unificatorilor lui $\cal E$ este mulțimea unificatorilor lui $\emptyset$ care sunt mai generali decât $\Theta$.

Deci $\Theta$ este cel mai general unificator pentru $\cal E$.



# Semantică

## Structuri de ordinul I

Dacă
$\sigma = (F,R,r)$ este o signatură de ordinul I, atunci \
o **$\sigma$-structură** este o pereche $(A, \{A_s\}_{s \in F \cup R})$,
unde:

- $A \neq \emptyset$ (şi se va numi **universul**, **mulţimea
suport** sau **mulţimea subiacentă** a structurii),

- pentru orice
$s \in F$, $A_s : A^{r(s)} \to A$ şi

- pentru orice $s \in R$,
$A_s \subseteq A^{r(s)}$. 

Structurile vor reprezenta domeniile despre
care vor vorbi formulele corespunzătoare signaturilor.

## Exemple

Putem obţine diverse signaturi dacă punem $\sigma:=(F,R,r)$, iar $F$,
$R$, $r$ sunt, pe rând:

-   $F=\{\cdot,0,1\}$, $R=\emptyset$, $r(\cdot)=2$, $r(0)=r(1)=0$ --
    atunci $\sigma$-structurile vor fi tuplurile $(A,\cdot,0,1)$ unde
    $\cdot : A^2 \to A$, iar $0$, $1 \in A$, de exemplu
    $(\mathbb{Z},+,2,7)$. Observăm că nu impunem în definiţia structurii
    ca ea să respecte anumite legi -- acest lucru se va face eventual
    ulterior, după ce vom defini riguros formulele şi satisfacerea lor.

-   $F=\emptyset$, $R=\{\leq\}$, $r(\leq)=2$ -- atunci
    $\sigma$-structurile vor fi perechi $(A,\leq)$ unde $\leq$ este o
    relaţie binară pe $A$, de exemplu $(\mathbb{N},>)$.

-   $F=\emptyset$, $R=\{I,A,B\}$, $r(I)=r(A)=r(B)=1$.

Dacă punem $F=R=\emptyset$, atunci obţinem o signatură care, dat fiind
că singurele fapte pe care le vom putea exprima peste ea vor folosi
semnul $=$, se va numi **signatura egalităţii**.

## Signatura aritmeticii

De asemenea, vom defini **signatura aritmeticii** ca fiind
$$\sigma_{\mathrm{ar}} := (\{\dot{+},\dot{\times},\dot{S},\dot{0}\},\{\dot{<}\},r),$$
unde $r(\dot{+})=r(\dot{\times})=r(\dot{<})=2$, $r(\dot{S})=1$, iar
$r(\dot{0})=0$. Dacă definim funcţia $S:\mathbb{N}\to\mathbb{N}$, pentru
orice $n \in \mathbb{N}$, prin $S(n):=n+1$, iar
$$\mathcal{N}:=(\mathbb{N},(N_s)_{s \in F \cup R}),$$ unde
$N_{\dot{+}}=+$, $N_{\dot{\times}} = \cdot$, $N_{\dot{S}} = S$,
$N_{\dot{0}}=0$, iar $N_{\dot{<}}=<$, avem că $\mathcal{N}$ este o
$\sigma_{\mathrm{ar}}$-structură.

De remarcat că există şi alte $\sigma_{\mathrm{ar}}$-structuri, de
exemplu putem înzestra mulţimea $\{0,1\}$ cu $\pmb{\wedge}$,
$\pmb{\vee}$, $\pmb{\neg}$, $0$ şi $<$ pentru a obţine o altă
$\sigma_{\mathrm{ar}}$-structură.

## Evaluarea termenilor

Fie $\mathcal{A}=(A,(A_s)_{s \in F \cup R})$ o $\sigma$-structură.
Atunci pentru orice __valuație__ $v : V \to A$ există şi este unică o funcţie
$(\cdot)^{\mathcal{A}}_v : T_\sigma \to A$ astfel încât

-   pentru orice $x \in V$, $x^{\mathcal{A}}_v=v(x)$;

-   pentru orice $s \in F$ şi orice $t_1,\ldots,t_{r(s)} \in T_\sigma$,
    $(st_1\ldots t_{r(s)})^{\mathcal{A}}_v=A_s((t_1)^{\mathcal{A}}_v,\ldots,(t_{r(s)})^{\mathcal{A}}_v)$ \
    (în particular, dacă $r(s)=0$, $s^{\mathcal{A}}_v = A_s$).

## Actualizarea valuațiilor

Fie $\mathcal{A}=(A,(A_s)_{s \in F \cup R})$ o $\sigma$-structură.
Pentru orice $v : V\to A$, $x \in V$, $a \in A$, definim
$v_{x \leftarrow a} : V \to A$, pentru orice $y \in V$, prin
$$v_{x \leftarrow a}(y) := \begin{cases} v(y), &\mbox{dac\u a  $y\neq x$,} \\
a, & \mbox{dac\u a $y=x$}. \end{cases}$$

Observăm că pentru orice
variabile $x$, $y$ cu $x \neq y$, orice $v: V \to A$ şi orice $a$,
$b \in A$, avem că
$$(v_{y\leftarrow b})_{x \leftarrow a}=(v_{x\leftarrow a})_{y \leftarrow b}.$$

În acest caz, notăm valoarea lor comună cu
$v_{x\leftarrow a, y\leftarrow b}$. Aşadar, pentru orice $z \in V$,
$$\begin{aligned}
v_{x\leftarrow a, y\leftarrow b}(z)=\begin{cases}
v(z) & \text{dac\u a } z\ne x \text{ \c si } z \ne y,\\
a & \text{dac\u a }  z=x,\\
b & \text{dac\u a } z=y.
\end{cases}
\end{aligned}$$

## Satisfacerea formulelor

Definim o relație $\models$ între structuri, valuații și formule folosind următoarele (scheme de) reguli:

-   $\mathcal{A}\models^v t = u$, dacă $t^\mathcal{A}_v=u^\mathcal{A}_v$;

-   $\mathcal{A}\models^v st_1\ldots t_{r(s)}$ (unde $s \in R$),
    dacă $((t_1)^\mathcal{A}_v,\ldots,(t_{r(s)})^\mathcal{A}_v) \in A_s$;

-   $\mathcal{A}\not\models^v \bot$;

-   $\mathcal{A}\models^v \varphi\to \psi$ dacă
    $\mathcal{A}\models^v \varphi$ implică că $\mathcal{A}\models^v \psi$

-   $\mathcal{A}\models^v \forall x \varphi$, dacă pentru orice $a \in A$, $\mathcal{A}\models^{v_{x \leftarrow a}} \varphi$.

Dacă $\mathcal{A}\models^v \varphi$ pentru orice $v$, scriem $\mathcal{A}\models \varphi$ și spunem că $\mathcal{A}$ **satisface** $\varphi$, sau este **model** pentru $\varphi$. 

Dacă $\mathcal{A}\models \varphi$ pentru orice $\cal A$, scriem $\models \varphi$ și spunem că $\varphi$ este
**validă**.

## Satisfacerea conectorilor derivaţi

Fie $\mathcal{A}=(A,(A_s)_{s \in F \cup R})$ o $\sigma$-structură. Este
acum imediat că pentru orice $v: V \to A$, avem:

-   $\mathcal{A}\models^v \top$;

-   $\mathcal{A}\models^v \varphi\wedge\psi$ ddacă $\mathcal{A}\models^v \varphi$ și $\mathcal{A}\models^v \psi$;

-   $\mathcal{A}\models^v \varphi\vee\psi$ ddacă $\mathcal{A}\models^v \varphi$ sau $\mathcal{A}\models^v \psi$;

-   $\mathcal{A}\models^v \varphi\leftrightarrow\psi$ ddacă ($\mathcal{A}\models^v \varphi$ ddacă $\mathcal{A}\models^v \psi$);

-   $\mathcal{A}\models^v \exists x \varphi$ ddacă există $a\in A$ cu $\mathcal{A}\models^{v_{x \leftarrow a}} \varphi$.

## Satifacerea enunţurilor

Fie $\mathcal{A}=(A,(A_s)_{s \in F \cup R})$ o
$\sigma$-structură şi $\varphi$ un enunţ.

Atunci, pentru orice $v_1$, $v_2 : V \to A$, avem
$$\mathcal{A}\models^{v_1} \varphi\mbox{ ddacă }\mathcal{A}\models^{v_2} \varphi,$$
deci sunt echivalente următoarele două afirmații:

- $\mathcal{A} \models\varphi$, adică pentru orice $v:V \to A$, $\mathcal{A}\models^{v} \varphi$
- există $v: V\to A$ cu $\mathcal{A}\models^{v} \varphi$.

## Concepte înrudite

Vom defini următoarele concepte, precum şi noi semnificaţii ale semnului
$\models$, prin analogie cu logica propoziţională:

-   Spunem că $\varphi\in E_\sigma$ este **satisfiabil** dacă există
    $\mathcal{A}$ cu $\mathcal{A}\models \varphi$.

-   Spunem că un enunţ $\varphi$ este **nesatisfiabil** dacă $\varphi$
    nu este satisfiabil.

-   Fie $\varphi$, $\psi \in E_\sigma$. Spunem că din $\varphi$ **se
    deduce semantic** $\psi$ şi scriem $\varphi\models \psi$ dacă pentru
    orice $\mathcal{A}$ cu $\mathcal{A}\models \varphi$ avem
    $\mathcal{A} \models \psi$.

Clar, $\bot$ este enunţ, iar pentru orice $\sigma$-structură
$\mathcal{A}$, avem $\mathcal{A} \not\models \bot$, i.e. $\bot$ este
nesatisfiabil.

## Mulţimi de enunţuri

Complet analog celor din logica propoziţională, vom introduce noţiuni de
satisfiabilitate pentru mulţimi de formule, precum şi semnificaţii
corespunzătoare ale semnului $\models$.

Fie $\Gamma \subseteq E_\sigma$. Pentru orice $\sigma$-structură
$\mathcal{A}$, spunem că $\mathcal{A}$ **satisface** $\Gamma$ sau că
$\mathcal{A}$ este **model** pentru $\Gamma$, şi scriem
$\mathcal{A}\models\Gamma$, dacă pentru orice $\varphi\in\Gamma$,
$\mathcal{A} \models \varphi$.

Spunem că $\Gamma$ este **satisfiabilă** dacă există o
$\sigma$-structură $\mathcal{A}$ cu $\mathcal{A}\models\Gamma$; că este
**nesatisfiabilă** dacă nu este satisfiabilă.

## Proprietăţi

Următoarele proprietăţi se demonstrează perfect analog celor din logica
propoziţională.

Fie $\Gamma \subseteq E_\sigma$, $\Delta \subseteq\Gamma$ şi
$\mathcal{A}$ o $\sigma$-structură. Avem următoarele:

-   Dacă $\mathcal{A}\models\Gamma$, atunci $\mathcal{A}\models\Delta$.

-   Dacă $\Delta$ este nesatisfiabilă, atunci $\Gamma$ este
    nesatisfiabilă.

-   Avem că $\mathcal{A} \models \Gamma$ dacă şi numai dacă pentru orice
    $\Sigma \subseteq\Gamma$ finită, $\mathcal{A} \models \Sigma$.

## Deducţie semantică din mulţimi

Fie $\Gamma \subseteq E_\sigma$ şi $\varphi\in E_\sigma$. Spunem că din
$\Gamma$ **se deduce semantic** $\varphi$, şi scriem
$\Gamma \models \varphi$, dacă pentru orice $\sigma$-structură
$\mathcal{A}$ cu $\mathcal{A}\models \Gamma$ avem
$\mathcal{A} \models \varphi$. Această noţiune are următoarele
proprietăţi analoage celor din logica propoziţională şi demonstrabile
similar.

__Proprietăți__

Fie $\Gamma \subseteq E_\sigma$, $\Delta \subseteq\Gamma$ şi
$\varphi$, $\psi \in E_\sigma$. Avem următoarele:

-   Dacă $\Delta \models \varphi$, atunci $\Gamma \models \varphi$.

-   Mulţimea $\Gamma$ este nesatisfiabilă dacă şi numai dacă
    $\Gamma \models \bot$.

-   Avem $\Gamma\models\varphi$ dacă şi numai dacă
    $\Gamma \cup \{\neg\varphi\}$ este nesatisfiabilă.

# Universul Herbrand

## Structuri Herbrand

De acum încolo, vom face presupunerea că există măcar o constantă în
signatură, aşadar $\widetilde{T}_\sigma \neq \emptyset$. Notăm cu
$B_\sigma$ (numită **baza Herbrand**) mulţimea tuturor
$\sigma$-formulelor atomice relaţionale fără variabile.

Spunem că o $\sigma$-structură este **Herbrand** atunci când universul
ei este $\widetilde{T}_\sigma$, iar simbolurile de funcţie sunt
interpretate "de ele însele". Observăm că o $\sigma$-structură Herbrand
este complet determinată de mulţimea $J$ a acelor formule din $B_\sigma$
adevărate în ea. Pentru orice submulţime $J$ a lui $B_\sigma$ şi orice
enunţ $\varphi$, spunem că $J \models_H \varphi$ atunci când structura
Herbrand asociată lui $J$ satisface $\varphi$.

Dacă $\mathcal{A}$ este o $\sigma$-structură, vom nota
$J_\mathcal{A}:= \{\varphi\in B_\sigma \mid \mathcal{A} \models \varphi\}$.

## Proprietăţi

### Teoremă
Fie $\mathcal{A}$ o $\sigma$-structură şi $\varphi$ o clauză
definită (sau un scop definit) cu $\mathcal{A} \models \varphi$. Atunci
$J_\mathcal{A} \models_H \varphi$.

### Demonstraţie
Presupunem $\varphi$ clauză definită. Avem că există $m$,
$n \in \mathbb{N}$, formule atomice relaţionale $A_0$, $A_1,\ldots,A_m$
şi variabile $x_1,\ldots,x_n$ cu
$$\varphi= \forall x_1\ldots\forall x_n(A_0 \lor \neg A_1 \lor\ldots\lor \neg A_m).$$
Fie $t_1,\ldots,t_n \in \widetilde{T}_\sigma$. Notăm, pentru orice $i$,
$A'_i:=A_i[x_1:=t_1]\ldots[x_n:=t_n]$ şi
$\varphi':=A'_0 \lor \neg A'_1 \lor\ldots\lor \neg A'_m$. Vrem
$J_\mathcal{A}\models_H\varphi'$. Presupunem că, pentru orice
$i \geq 1$, $J_\mathcal{A}\models_H A'_i$. Arătăm că
$J_\mathcal{A} \models_H A'_0$. Deci, pentru orice $i \geq 1$, cum
$A'_i \in B_\sigma$, $A'_i \in J_\mathcal{A}$, deci
$\mathcal{A}\models A'_i$. Cum $\mathcal{A} \models \varphi$, avem
$\mathcal{A} \models \varphi'$, iar, cum, pentru orice $i \geq 1$,
$\mathcal{A}\models A'_i$, avem $\mathcal{A}\models A'_0$. Cum
$A'_0 \in B_\sigma$, $A'_0 \in J_\mathcal{A}$, deci
$J_\mathcal{A} \models_H A'_0$.

## Proprietăţi

### Teoremă
Fie $P$ un program. Atunci
$K_P:=\{J \subseteq B_\sigma \mid J \models_H P\}$ este o mulţime Moore
pe $B_\sigma$.

::: block
### Demonstraţie
Faptul că $B_\sigma \models_H P$ rămâne ca exerciţiu. Fie
acum $K \subseteq K_P$ cu $K \neq\emptyset$. Vrem
$\bigcap K \models_H P$. Fie $\varphi\in P$. Fie
$t_1,\ldots,t_n \in \widetilde{T}_\sigma$. Folosim aceleaşi notaţii ca
în demonstraţia precedentă. Presupunem că, pentru orice $i \geq 1$,
$\bigcap K \models_H A'_i$. Arătăm că $\bigcap K \models_H A'_0$. Deci,
pentru orice $i \geq 1$, cum $A'_i \in B_\sigma$, $A'_i \in \bigcap K$,
deci, pentru orice $J \in K$, $A'_i \in J$, adică $J \models_H A'_i$.
Fie $J \in K$. Avem $J \models_H \varphi$, deci $J \models_H \varphi'$,
iar, cum, pentru orice $i \geq 1$, $J\models_H A'_i$, avem
$J\models_H A'_0$, deci, cum $A'_0 \in B_\sigma$, $A'_0 \in J$. Aşadar,
$A'_0 \in \bigcap K$, deci $\bigcap K\models_H A'_0$.
:::

Pentru orice program $P$, notăm $M_P := \bigcap K_P \in K_P$.

## Proprietăţi

### Teoremă
Pentru orice program $P$,
$M_P = \{\varphi\in B_\sigma \mid P \models \varphi\}$.

::: block
### Demonstraţie
Pentru $\supseteq$", fie $\varphi\in B_\sigma$ cu
$P \models \varphi$. Fie $J \in K_P$. Vrem $\varphi\in J$. Cum
$J \models_H P$, avem $J \models_H \varphi$, iar, cum
$\varphi\in B_\sigma$, $\varphi\in J$.

Pentru $\subseteq$", fie $\varphi\in M_P$. Fie $\mathcal{A}$ cu
$\mathcal{A} \models P$. Vrem $\mathcal{A} \models \varphi$. Cum $P$
este o mulţime de clauze definite, dintr-o teoremă anterioară avem
$J_\mathcal{A} \models_H P$, deci $J_\mathcal{A} \in K_P$. Rezultă
$M_P \subseteq J_\mathcal{A}$, deci $\varphi\in J_\mathcal{A}$, adică
$J_\mathcal{A} \models_H \varphi$. Rezultă
$\mathcal{A} \models \varphi$.
:::

Numim $M_P$ __modelul Herbrand__ asociat programului $P$
