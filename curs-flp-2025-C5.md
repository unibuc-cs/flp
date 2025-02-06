---
author: Traian Florin Șerbănuță și Andrei Sipoș
institute: Facultatea de Matematică și Informatică, DL Info
date: Anul II, Semestrul II, 2024/2025
title: Fundamentele limbajelor de programare
subtitle: 3. Programare logică
theme: CambridgeUS
---

## Logică şi programare

În anul I, la disciplina Logică matematică şi computaţională", s-au
studiat, pe de o parte, logica de ordinul I ca teorie matematică, iar,
pe de alta, programarea logică din punct de vedere practic, sub forma
limbajului Prolog. Asemănările dintre sintaxa limbajului şi logica
studiată la cursuri şi seminare au fost evidenţiate doar la modul
intuitiv.

În continuare, vom arăta cum funcţionarea acestui limbaj de programare
poate fi modelată teoretic, extinzând teoria deja dezvoltată pentru
logica de ordinul I. Vom recapitula, dintre lucrurile deja studiate din
logică, pe cele care ne vor folosi acum, eventual introducând notaţii
noi.

## Logica de ordinul I

Vom fixa patru obiecte $\bot$, $\to$, $\forall$, $=$, diferite două câte
două şi o mulţime numărabilă (de **variabile logice**)
$$V=\{x_0,x_1,\ldots\},$$ cu
$V \cap \{\bot,\to,\forall,=\} = \emptyset$.

## Signaturi şi structuri

Definim o **signatură de ordinul I** ca fiind un triplet
$\sigma = (F,R,r)$ astfel încât $F \cap R = \emptyset$,
$(F \cup R) \cap (V \cup \{\bot,\to,\forall,=\}) = \emptyset$ şi
$r : F \cup R \to \mathbb{N}$.

Dacă $\sigma = (F,R,r)$ este o signatură de ordinul I, atunci numim
elementele lui $R$ **simbolurile de relaţie** ale lui $\sigma$, iar
elementele lui $F$ **simbolurile de funcţie** ale lui $\sigma$; pentru
orice $s \in F \cup R$, numim $r(s)$ **aritatea** lui $s$; în
particular, acele $s\in F$ pentru care $r(s)=0$ se numesc
**constantele** lui $\sigma$. Mai definim şi mulţimea
$$S_\sigma := \{\bot,\to,\forall,=\} \cup V \cup F \cup R.$$

Dacă
$\sigma = (F,R,r)$ este o signatură de ordinul I, atunci o
**$\sigma$-structură** va fi o pereche $(A, \{A_s\}_{s \in F \cup R})$,
unde $A \neq \emptyset$ (şi se va numi **universul**, **mulţimea
suport** sau **mulţimea subiacentă** a structurii), pentru orice
$s \in F$, $A_s : A^{r(s)} \to A$ şi pentru orice $s \in R$,
$A_s \subseteq A^{r(s)}$. Structurile vor reprezenta domeniile despre
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



## Termeni

Formulele corespunzătoare unei signaturi $\sigma=(F,R,r)$ vor fi cuvinte
peste alfabetul $S_\sigma$. Înainte de a defini formulele, va trebui să
definim **termenii**. Ei se definesc ca fiind cea mai mică mulţime $A$
de şiruri de simboluri din $S_\sigma$ astfel încât:

-   $V \subseteq A$;

-   pentru orice $s \in F$ şi orice $t_1,\ldots,t_{r(s)} \in A$, avem
    $st_1\ldots t_{r(s)} \in A$ (în particular, dacă $r(s)=0$,
    $s \in A$).

Mulţimea termenilor peste $\sigma$ se va nota cu $T_\sigma$.

## Inducţie şi recursie pe termeni

### Principiul inducţiei pe termeni
Fie $B \subseteq T_\sigma$ astfel încât:

-   $V \subseteq B$;

-   pentru orice $s \in F$ şi orice $t_1,\ldots,t_{r(s)} \in B$, avem
    $st_1\ldots t_{r(s)} \in B$.

Atunci $B=T_\sigma$.

### Principiul recursiei pe termeni
Fie $A$ o mulţime şi $G_0:V\to A$, iar
pentru orice $s \in F$, $G_s : A^{r(s)} \to A$. Atunci există şi este
unică $F:T_\sigma\to A$ astfel încât:

-   pentru orice $x\in V$, $F(x)=G_0(x)$;

-   pentru orice $s \in F$ şi orice $t_1,\ldots,t_{r(s)} \in T_\sigma$,
    $F(st_1\ldots t_{r(s)})=G_s(F(t_1),\ldots,F(t_{r(s)}))$.

## Mulţimea variabilelor unui termen

Ca exemplu, putem defini recursiv mulţimea variabilelor unui termen.
Practic, definim funcţia $Var : T_\sigma \to \mathcal{P}(V)$, prin:

-   pentru orice $x \in V$, $Var(x):=\{x\}$;

-   pentru orice $s \in F$ şi orice $t_1,\ldots,t_{r(s)} \in T_\sigma$,
    $Var(st_1\ldots t_{r(s)}):=Var(t_1) \cup \ldots \cup Var(t_{r(s)})$
    (în particular, dacă $r(s)=0$, $Var(s)=\emptyset$).

Notăm cu $\widetilde{T}_\sigma$ mulţimea termenilor fără variabile.

## Evaluarea termenilor

Fie $\mathcal{A}=(A,(A_s)_{s \in F \cup R})$ o $\sigma$-structură.
Atunci pentru orice $v : V \to A$ există şi este unică o funcţie
$(\cdot)^{\mathcal{A}}_v : T_\sigma \to A$ astfel încât

-   pentru orice $x \in V$, $x^{\mathcal{A}}_v=v(x)$;

-   pentru orice $s \in F$ şi orice $t_1,\ldots,t_{r(s)} \in T_\sigma$,
    $(st_1\ldots t_{r(s)})^{\mathcal{A}}_v=A_s((t_1)^{\mathcal{A}}_v,\ldots,(t_{r(s)})^{\mathcal{A}}_v)$
    (în particular, dacă $r(s)=0$, $s^{\mathcal{A}}_v = A_s$).

**Atenţie**, din nou: funcţia $v$ din definiţia de mai sus **nu** are un
rol similar cu cel al funcţiilor $e : Q\to 2$ din logica propoziţională,
cu toate că ar putea părea astfel.

## Formule

Fie $\sigma=(F,R,r)$ o signatură. Numim **formulă atomică** peste
$\sigma$ un şir de forma $=tu$, cu $t$, $u \in T_\sigma$ (numită formulă
atomică **ecuaţională** sau doar **ecuaţie**) sau un şir de forma
$st_1\ldots t_n$ cu $s\in R$, $n=r(s)$ şi $t_1,\ldots,t_n\in T_\sigma$
(numită formulă atomică **relaţională**). Mulţimea formulelor atomice
peste $\sigma$ se va nota cu $Fa_\sigma$. Mulţimea **formulelor** peste
$\sigma$ se defineşte ca fiind cea mai mică mulţime $A$ de şiruri de
simboluri din $S_\sigma$ astfel încât:

-   formulele atomice aparţin lui $A$;

-   $\bot \in A$;

-   dacă $\varphi$, $\psi \in A$, atunci $\to\varphi\psi \in A$;

-   dacă $\varphi\in A$ şi $x \in V$, atunci $\forall x \varphi\in A$.

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

## Inducţie pe formule

### Principiul inducţiei pe formule
Fie $B \subseteq F_\sigma$ astfel încât:

-   formulele atomice aparţin lui $B$;

-   $\bot \in B$;

-   dacă $\varphi$, $\psi \in B$, atunci $\varphi\to\psi \in B$;

-   dacă $\varphi\in B$ şi $x \in V$, atunci $\forall x \varphi\in B$.

Atunci $B=F_\sigma$.

## Recursie pe formule

### Principiul recursiei pe formule
Fie $A$ o mulţime şi
$G_0:Fa_\sigma\to A$, $G_\bot \in A$, $G_\to:A^2\to A$,
$G_\forall :V \times A \to A$. Atunci există şi este unică
$F:F_\sigma\to A$ astfel încât:

-   pentru orice $\varphi\in Fa_\sigma$, $F(\varphi)=G_0(\varphi)$;

-   $F(\bot)=G_\bot$;

-   pentru orice $\varphi$, $\psi \in F_\sigma$,
    $F(\varphi\to \psi)=G_\to(F(\varphi),F(\psi))$;

-   pentru orice $\varphi\in F_\sigma$ şi $x \in V$,
    $F(\forall x \varphi)=G_\forall(x,F(\varphi))$.

## Mulţimea variabilelor libere ale unei formule

Ca exemplu, putem defini recursiv mulţimea variabilelor **libere** ale
unei formule. Definim funcţia $FV : F_\sigma \to \mathcal{P}(V)$, prin:

-   pentru orice $t$, $u \in T_\sigma$, $FV(t=u):=Var(t) \cup Var(u)$;

-   pentru orice $s \in R$ şi orice $t_1,\ldots,t_{r(s)} \in T_\sigma$,
    $FV(st_1\ldots t_{r(s)}):=Var(t_1) \cup \ldots \cup Var(t_{r(s)})$;

-   $FV(\bot):=\emptyset$;

-   pentru orice $\varphi$, $\psi \in F_\sigma$,
    $FV(\varphi\to \psi):=FV(\varphi) \cup FV(\psi)$;

-   pentru orice $\varphi\in F_\sigma$ şi $x \in V$,
    $FV(\forall x \varphi):=FV(\varphi) \setminus \{x\}$.

Dacă $\varphi\in F_\sigma$ cu $FV(\varphi)=\emptyset$, atunci $\varphi$
se numeşte **enunţ**. Mulţimea enunţurilor peste $\sigma$ se notează cu
$E_\sigma$.

## Spre evaluarea formulelor

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

## Evaluarea formulelor

Avem că există şi este unică o funcţie
$\|\cdot\|^\mathcal{A} : F_\sigma \to \{0,1\}^{A^V}$ astfel încât,
pentru orice $v: V \to A$, avem:

-   pentru orice $t$, $u \in T_\sigma$,
    $\|t=u\|^\mathcal{A}_v=1 \Leftrightarrow t^\mathcal{A}_v=u^\mathcal{A}_v$;

-   pentru orice $s \in R$ şi orice $t_1,\ldots,t_{r(s)} \in T_\sigma$,
    $\|st_1\ldots t_{r(s)}\|^\mathcal{A}_v = 1 \Leftrightarrow ((t_1)^\mathcal{A}_v,\ldots,(t_{r(s)})^\mathcal{A}_v) \in A_s$;

-   $\|\bot\|^\mathcal{A}_v=\pmb{\bot}=0$;

-   pentru orice $\varphi$, $\psi \in F_\sigma$,
    $\|\varphi\to \psi\|^\mathcal{A}_v= \|\varphi\|^\mathcal{A}_v \pmb{\rightarrow}\|\psi\|^\mathcal{A}_v$;

-   pentru orice $\varphi\in F_\sigma$ şi $x \in V$,
    $\|\forall x \varphi\|^\mathcal{A}_v=1 \Leftrightarrow \text{pentru orice $a \in A$, $\|\varphi\|^\mathcal{A}_{v_{x \leftarrow a}} = 1$}$.

Dacă $\varphi\in F_\sigma$ este astfel încât pentru orice $\mathcal{A}$
şi $v$, $\|\varphi\|^\mathcal{A}_v=1$, spunem că $\varphi$ este
**validă**.

## Evaluarea conectorilor derivaţi

Fie $\mathcal{A}=(A,(A_s)_{s \in F \cup R})$ o $\sigma$-structură. Este
acum imediat că pentru orice $v: V \to A$, avem:

-   $\|\top\|^\mathcal{A}_v=\pmb{\top}=1$;

-   pentru orice $\varphi$, $\psi \in F_\sigma$,
    $\|\varphi\wedge\psi\|^\mathcal{A}_v= \|\varphi\|^\mathcal{A}_v \pmb{\wedge}\|\psi\|^\mathcal{A}_v$;

-   pentru orice $\varphi$, $\psi \in F_\sigma$,
    $\|\varphi\vee\psi\|^\mathcal{A}_v= \|\varphi\|^\mathcal{A}_v \pmb{\vee}\|\psi\|^\mathcal{A}_v$;

-   pentru orice $\varphi$, $\psi \in F_\sigma$,
    $\|\varphi\leftrightarrow\psi\|^\mathcal{A}_v= \|\varphi\|^\mathcal{A}_v \pmb{\leftrightarrow}\|\psi\|^\mathcal{A}_v$;

-   pentru orice $\varphi\in F_\sigma$ şi $x \in V$,
    $\|\exists x \varphi\|^\mathcal{A}_v=1 \Leftrightarrow \text{exist\u a $a \in A$ cu $\|\varphi\|^\mathcal{A}_{v_{x \leftarrow a}} = 1$}$.

## Evaluarea enunţurilor

Aşadar, dacă $\mathcal{A}=(A,(A_s)_{s \in F \cup R})$ este o
$\sigma$-structură şi $\varphi$ este enunţ, pentru orice $v_1$,
$v_2 : V \to A$, avem
$\|\varphi\|^\mathcal{A}_{v_1}=\|\varphi\|^\mathcal{A}_{v_2}$, deci este
echivalent faptul că pentru orice $v:V \to A$,
$\|\varphi\|^\mathcal{A}_v=1$ cu faptul că există $v: V\to A$ cu
$\|\varphi\|^\mathcal{A}_v=1$. Numim această stare de fapt cu
$$\mathcal{A} \models\varphi$$ şi spunem că $\mathcal{A}$ **satisface**
$\varphi$ sau că $\mathcal{A}$ este **model** pentru $\varphi$.

Iată, deci, că structurile de ordinul I reprezintă analogul funcţiilor
de evaluare întâlnite în logica propoziţională. De aici provine şi
numele acelei ramuri a logicii care studiază structurile de ordinul I în
conjuncţie cu enunţurile satisfăcute de ele: **teoria modelelor**.

## Semnul $\models$ în logica de ordinul I

Vom defini următoarele concepte, precum şi noi semnificaţii ale semnului
$\models$, prin analogie cu logica propoziţională:

-   Dacă $\varphi\in E_\sigma$ şi $\varphi$ este valid, vom scrie
    $\models \varphi$.

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

### Proprietăţi
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

### Proprietăţi
Fie $\Gamma \subseteq E_\sigma$, $\Delta \subseteq\Gamma$ şi
$\varphi$, $\psi \in E_\sigma$. Avem următoarele:

-   Dacă $\Delta \models \varphi$, atunci $\Gamma \models \varphi$.

-   Mulţimea $\Gamma$ este nesatisfiabilă dacă şi numai dacă
    $\Gamma \models \bot$.

-   Avem $\Gamma\models\varphi$ dacă şi numai dacă
    $\Gamma \cup \{\neg\varphi\}$ este nesatisfiabilă.

## Substituţia termenilor

Vom numi **substituţie** o funcţie $\theta : V \to T_\sigma$. Folosind
Principiul de recursie pe termeni, ea se extinde natural în mod unic la
o funcţie $\widetilde{\theta} : T_\sigma \to T_\sigma$.

Se observă, folosind unicitatea, că, pentru orice două substituţii
$\theta$, $\theta'$,
$$\widetilde{\widetilde{\theta'} \circ \theta} = \widetilde{\theta'} \circ \widetilde{\theta}.$$

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

## Structuri Herbrand

De acum încolo, vom face presupunerea că există măcar o constantă în
signatură, aşadar $\widetilde{T}_\sigma \neq \emptyset$. Notăm cu
$B_\sigma$ (numită **baza Herbrand**) mulţimea tuturor
$\sigma$-formulelor atomice relaţionale fără variabile.

Spunem că o $\sigma$-structură este **Herbrand** atunci când universul
ei este $\widetilde{T}_\sigma$, iar simbolurile de funcţie sunt
interpretate de ele însele". Observăm că o $\sigma$-structură Herbrand
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
:::

## Proprietăţi

### Teoremă
Pentru orice program $P$,
$M_P = \{\varphi\in B_\sigma \mid P \models \varphi\}$.

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

## Motivaţia unificării

Să zicem că avem un program Prolog care conţine regula
$$p(f(x),y) \leftarrow p(x,y)$$ şi vrem să interogăm $p(z,f(t))$. Pentru
a găsi o soluţie a acestei interogări folosind regula de mai sus,
trebuie să substituim $x \mapsto x$, $z \mapsto f(x)$, $y \mapsto f(t)$,
$t \mapsto t$, interogarea devenind $p(f(x),f(t))$, care este redusă,
conform regulii, la $p(x,f(t))$, care devine practic o nouă interogare.

Observăm că o parte esenţială a procesului de rulare a unui program
Prolog (pe care îl vom studia data viitoare, când vom vedea exact care
este legătura dintre regulile/interogările afişate mai sus şi teoria
prezentată astăzi) este găsirea acelei substituţii. Acest procedeu se va
numi **unificare**.

## Unificatori

Dacă $\mathcal{E}$ este o mulţime de ecuaţii, numim **unificator**
pentru ea o substituţie $\theta$ astfel încât, pentru orice
$(s=t) \in \mathcal{E}$, avem
$\widetilde{\theta}(s)=\widetilde{\theta}(t)$; el se numeşte **cel mai
general unificator** (**cgu**; **most general unifier**, **mgu**) dacă,
pentru orice unificator $\theta'$ pentru $\mathcal{E}$, avem că există o
substituţie $\omega$ cu $\theta' = \widetilde{\omega} \circ \theta$.

### Propoziţie
Fie $n \in \mathbb{N}$, $z_1,\ldots,z_n \in V$ (diferite două
câte două) şi $t_1,\ldots,t_n \in T_\sigma$ astfel încât, pentru orice
$i$, $j$, $z_i \notin Var(t_j)$. Atunci substituţia $\theta$ care duce,
pentru orice $i$, $z_i$ în $t_i$ este cgu pentru
$\{z_i=t_i \mid i \in \{1,\ldots,n\}\}$.

### Demonstraţie
Faptul că este unificator este evident. Fie acum $\theta'$
un unificator. Vrem $\omega$ cu
$\theta' = \widetilde{\omega} \circ \theta$. Luăm $\omega:=\theta'$.
Avem, într-adevăr, că, pentru orice $i$,
$(\widetilde{\theta'} \circ \theta)(z_i) = \widetilde{\theta'}(t_i) = \widetilde{\theta'}(z_i) = \theta'(z_i)$
şi, pentru orice altă variabilă $y$,
$(\widetilde{\theta'} \circ \theta)(y)=\widetilde{\theta'}(y)=\theta'(y)$.

## Algoritm de unificare

Vom descrie acum un algoritm de unificare. El are ca intrare o mulţime
de ecuaţii $\mathcal{E}$, iar la ieşire, un cgu dat de o mulţime de
ecuaţii ca în propoziţia precedentă, sau eşec", dacă un cgu nu există.
Algoritmul trece printr-un ciclu care, la fiecare pas, verifică dacă
există vreo ecuaţie în mulţime căruia i se poate aplica vreuna dintre
următoarele operaţii -- în caz contrar, el se opreşte:

-   o ecuaţie de forma $f(s_1,\ldots,s_n)=f(t_1,\ldots,t_n)$ este
    înlocuită de ecuaţiile $s_1=t_1,\ldots,s_n=t_n$;
-   o ecuaţie de forma $f(s_1,\ldots,s_n)=g(t_1,\ldots,t_m)$, unde
    $f \neq g$, produce eşec";
-   o ecuaţie de forma $x=x$, cu $x \in V$, este eliminată;
-   o ecuaţie de forma $t=x$ cu $x \in V$ şi $t \notin V$ este înlocuită
    cu $x=t$;
-   o ecuaţie de forma $x=t$ cu $x \in V$, $t \neq x$ şi $x \in Var(t)$
    produce eşec";
-   o ecuaţie de forma $x=t$ cu $x \in V$, $t \neq x$,
    $x \not\in Var(t)$, dar cu $x$ apărând şi în alte ecuaţii din
    mulţime, face ca toate celelalte sale apariţii să fie substituite cu
    $t$.

## Corectitudine

### Teoremă
Algoritmul de unificare prezentat se termină mereu şi produce
rezultatul corect.

### Demonstraţie
Pentru terminare, observăm că doar ultimul pas creşte
numărul de simboluri, dar acela poate fi aplicat doar o dată pentru
fiecare variabilă.

Pentru corectitudine, observăm întâi că mulţimile care produc eşec" nu
au unificator şi că, atunci când algoritmul se termină, mulţimea are
exact forma din propoziţia precedentă. Apoi, trebuie să arătăm că la
fiecare pas, mulţimea rezultantă are aceiaşi unificatori ca cea
precedentă. Tratăm ultimul caz doar. Notând cu $\psi$ substituţia
$x \mapsto t$, avem că ecuaţiile $s=u$ care nu sunt $x=t$ sunt înlocuite
de $\widetilde{\psi}(s)=\widetilde{\psi}(u)$.

## Corectitudine

### Demonstraţie (cont.)
Fie $\theta$ un unificator pentru mulţimea
iniţială, în particular $\theta(x)=\widetilde{\theta}(t)$. Fie $s=u$ o
ecuaţie din ea care nu este $x=t$. Vrem
$\widetilde{\theta}(\widetilde{\psi}(s))=\widetilde{\theta}(\widetilde{\psi}(u))$.
Se arată uşor că $\widetilde{\theta} \circ \psi = \theta$, de unde
rezultă concluzia.

Fie acum $\theta$ un unificator pentru mulţimea rezultantă, în
particular (din nou) $\theta(x)=\widetilde{\theta}(t)$. Se arată, din
nou, uşor, că $\widetilde{\theta} \circ \psi = \theta$, iar concluzia
rezultă analog, scriind egalităţile invers.
