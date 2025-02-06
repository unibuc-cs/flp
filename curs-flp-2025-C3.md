---
author: Traian Florin Șerbănuță și Andrei Sipoș
institute: Facultatea de Matematică și Informatică, DL Info
date: Anul II, Semestrul II, 2024/2025
title: Fundamentele limbajelor de programare
subtitle: 3. Semantica denotațională. Teoreme de punct fix. Algebre multisortate, semantica algebrei inițiale.
theme: CambridgeUS
---


## Din nou despre echivalenţa între programe

Reamintim că relaţia de echivalenţă pe instrucţiuni $\sim$ a fost
definită în felul următor: pentru orice $c_0$, $c_1$, avem
$c_0 \sim c_1$ exact atunci când, pentru orice $\sigma$,
$\sigma' \in \Sigma$, $(c_0,\sigma) \Downarrow \sigma'$ dacă şi numai
dacă $(c_1,\sigma) \Downarrow \sigma'$.

Observăm că ultima condiţie poate fi exprimată şi ca:
$$\{(\sigma,\sigma') \in \Sigma^2 \mid (c_0,\sigma) \Downarrow \sigma' \} = \{(\sigma,\sigma') \in \Sigma^2 \mid (c_1,\sigma) \Downarrow \sigma' \},$$
sau chiar, notând cele două mulţimi corespunzător,
$$\llbracket c_0 \rrbracket = \llbracket c_1 \rrbracket.$$
Aceasta ne
conduce la ideea de a defini aceste mulţimi fără a face apel la vreo
semantică operaţională, dând practic un înţeles fiecărei instrucţiuni,
înţeles care se va numi **semantică denotaţională**, tradiţional notată
cu semnul $\llbracket \cdot \rrbracket$.

## Definirea semanticii denotaţionale: expresii

Pentru evaluarea expresiilor aritmetice, definim pur şi simplu
$\llbracket \cdot \rrbracket : \textit{ExprArit} \to \mathbb{Z}^\Sigma$,
pentru orice expresie aritmetică $a$ şi orice $\sigma \in \Sigma$, prin
$\llbracket a \rrbracket := \sigma \mapsto e_\sigma(a)$.

Similar, pentru evaluarea expresiilor booleene, definim
$\llbracket \cdot \rrbracket : \textit{ExprBool} \to \{0,1\}^\Sigma$,
pentru orice expresie booleană $b$ şi orice $\sigma \in \Sigma$, prin
$\llbracket b \rrbracket := \sigma \mapsto e_\sigma(b)$.

## Definirea semanticii denotaţionale: instrucţiuni

Pentru instrucţiuni, vom defini o funcţie
$$\llbracket \cdot \rrbracket : \textit{Instruc\c tiuni} \to \mathcal{P}(\Sigma^2),$$
în mod recursiv, în felul următor:
$$\llbracket \sskip \rrbracket := \Delta_\Sigma \qquad \llbracket X:=a \rrbracket := \left\{\left(\sigma, \sigma_{X \mapsto \llbracket a \rrbracket(\sigma)}\right) \mid \sigma \in \Sigma\right\}$$
$$\begin{aligned}
\llbracket c_0 ; c_1 \rrbracket &:= \llbracket c_1 \rrbracket \circ \llbracket c_0 \rrbracket\\
&\ =\{(\sigma,\sigma') \mid \text{exist\u a $\sigma''$ cu $(\sigma,\sigma'') \in \llbracket c_0 \rrbracket$ \c si $(\sigma'',\sigma') \in \llbracket c_1 \rrbracket$}\}
\end{aligned}$$
$$\begin{aligned}
\llbracket \sif b \sthen c_0 \selse c_1 \rrbracket &:= \{ (\sigma, \sigma') \in \llbracket c_0 \rrbracket \mid \llbracket b \rrbracket(\sigma)=1 \} \\
 &\qquad \cup \{ (\sigma, \sigma') \in \llbracket c_1 \rrbracket \mid \llbracket b \rrbracket(\sigma)=0 \}
\end{aligned}$$
Definirea semanticii lui **while** va fi mai
problematică, dat fiind că ambele semantici operaţionale o definesc în
funcţie de ea însăşi, nerespectând principiul recursiei structurale.
Acest lucru a fost posibil doar cu preţul introducerii structurii
inductive a deducţiilor. Avantajul semanticii denotaţionale va fi că se
va baza exclusiv pe principiile de inducţie şi recursie pe instrucţiuni
în sine.

## Despre **while**

Reamintim că am demonstrat (şi apoi am şi inclus în definiţia semanticii
small-step) că, pentru orice expresii potrivite $b$, $c$,
$$\swhile b \sdo c \sim \sif b \sthen (c;(\swhile b \sdo c)) \selse \sskip,$$
aşadar am dori:
$$\llbracket \swhile b \sdo c \rrbracket =  \llbracket\sif b \sthen (c;(\swhile b \sdo c)) \selse \sskip\rrbracket.$$
Notând, ca mai înainte, $w:=\swhile b \sdo c$, am avea:
$$\begin{aligned}
\llbracket w \rrbracket &= \{(\sigma,\sigma') \in \llbracket c;w \rrbracket \mid \llbracket b \rrbracket(\sigma)=1 \} \cup \{(\sigma,\sigma) \mid \llbracket b \rrbracket(\sigma)=0 \}\\
&= \{(\sigma,\sigma') \in \llbracket w \rrbracket \circ\llbracket c \rrbracket  \mid \llbracket b \rrbracket(\sigma)=1 \} \cup \{(\sigma,\sigma) \mid \llbracket b \rrbracket(\sigma)=0 \}\\
&= \{(\sigma,\sigma')  \mid \llbracket b \rrbracket(\sigma)=1, \text{exist\u a $\sigma''$ cu $(\sigma,\sigma'') \in \llbracket c \rrbracket$ \c si $(\sigma'',\sigma') \in \llbracket w \rrbracket$} \}\\
&\qquad \cup \{(\sigma,\sigma) \mid \llbracket b \rrbracket(\sigma)=0 \}.\\
\end{aligned}$$

## Punct fix

Pentru orice $h: \Sigma \to \{0,1\}$ şi orice $C \subseteq\Sigma^2$,
definim un operator
$\Gamma^h_C : \mathcal{P}(\Sigma^2) \to \mathcal{P}(\Sigma^2)$, pentru
orice $A \subseteq\Sigma^2$, prin: $$\begin{aligned}
\Gamma^h_C(A) &:= \{(\sigma,\sigma')  \mid h(\sigma)=1, \text{ exist\u a $\sigma''$ cu $(\sigma,\sigma'') \in C$ \c si $(\sigma'',\sigma') \in A$} \}\\
&\qquad \cup \{(\sigma,\sigma) \mid h(\sigma)=0 \}.\\
\end{aligned}$$
Atunci va trebui să avem
$\Gamma^{\llbracket b \rrbracket}_{\llbracket c \rrbracket}(\llbracket w \rrbracket) = \llbracket w \rrbracket$.

În general, pentru orice mulţime $X$ şi orice
$F: \mathcal{P}(X) \to \mathcal{P}(X)$, spunem că un $Y \subseteq X$
este **punct fix** al lui $F$ dacă $F(Y)=Y$ şi **cel mai mic punct fix**
(**least fixed point**, **lfp**; dacă există, se notează cu $\mu F$)
dacă e punct fix şi, pentru orice punct fix $Z$, avem $Y \subseteq Z$.
Vom vrea, deci, ca $\llbracket \swhile b \sdo c \rrbracket$ să
fie punct fix al lui
$\Gamma^{\llbracket b \rrbracket}_{\llbracket c \rrbracket}$. Vom arăta
că acest operator are chiar lfp şi vom defini
$$\llbracket \swhile b \sdo c \rrbracket := \mu \Gamma^{\llbracket b \rrbracket}_{\llbracket c \rrbracket}.$$
Alegerea va fi justificată prin faptul că semantica astfel definită va
coincide cu semantica operaţională structurală.

## Operatori monotoni

Pentru orice mulţime $X$ şi orice
$F: \mathcal{P}(X) \to \mathcal{P}(X)$, spunem că $F$ este **monoton**
dacă, pentru orice $A$, $B \subseteq X$ cu $A \subseteq B$, avem
$F(A) \subseteq F(B)$. Se observă imediat că, pentru orice
$h: \Sigma \to \{0,1\}$ şi orice $C \subseteq\Sigma^2$, $\Gamma^h_C$
este monoton.

### Teorema Knaster-Tarski
Fie $X$ o mulţime şi
$F: \mathcal{P}(X) \to \mathcal{P}(X)$ monoton. Atunci $F$ are lfp. Mai
mult, pentru orice $Y \subseteq X$ cu $F(Y) \subseteq Y$,
$\mu F \subseteq Y$.

### Demonstraţie
Notăm $Z:= \bigcap \{Y \subseteq X \mid F(Y) \subseteq Y\}$
(bine definită, de ce?). Este suficient să arătăm că $Z$ este punct fix
(ultima parte, şi implicit că este lfp, este imediată). Arătăm că
$F(Z) \subseteq Z$. Fie $x \in F(Z)$ şi $Y \subseteq X$ cu
$F(Y) \subseteq Y$. Vrem $x \in Y$. Cum $Z \subseteq Y$, avem
$F(Z) \subseteq F(Y) \subseteq Y$, deci $x \in Y$. Arătăm că
$Z \subseteq F(Z)$. Fie $x \in Z$, deci, pentru orice $Y \subseteq X$ cu
$F(Y) \subseteq Y$, $x \in Y$. E suficient, deci, să arătăm
$F(F(Z)) \subseteq F(Z)$, care rezultă din monotonie şi din faptul că
$F(Z) \subseteq Z$.

## Din nou despre echivalenţa între semantici

### Teoremă
Fie $c$ o instrucţiune şi $\sigma$, $\sigma' \in \Sigma$. Atunci
$$(c,\sigma)\Downarrow \sigma' \text{ dac\u a \c si numai dac\u a } (\sigma,\sigma') \in \llbracket c \rrbracket.$$

### Demonstraţie
Demonstrăm implicaţia $\Rightarrow$". Facem inducţie după
regulile pentru relaţia $\Downarrow$. Tratăm doar cazul ultimei reguli
pentru **while**.

Fie $b$, $c$, $\sigma$, $\sigma'$, $\sigma''$ ca acolo, cu
$e_\sigma(b)=1$. Notăm $w:=\swhile b \sdo c$. Din ipoteza de
inducţie, avem $(\sigma,\sigma'') \in  \llbracket c \rrbracket$ şi
$(\sigma'', \sigma') \in  \llbracket w \rrbracket$. Vrem
$(\sigma,\sigma') \in  \llbracket w \rrbracket$. Dar aceasta rezultă
exact din ecuaţia de punct fix pe care o satisface
$\llbracket w \rrbracket$ (a se observa că aici nu avem nevoie de faptul
că este chiar cel mai mic punct fix).

## Din nou despre echivalenţa între semantici

### Demonstraţie (cont.)
Demonstrăm implicaţia $\Leftarrow$". Vom arăta,
deci, prin inducţie structurală după $c$, că, pentru orice $\sigma$,
$\sigma' \in \Sigma$ cu $(\sigma,\sigma') \in \llbracket c \rrbracket$,
avem $(c,\sigma)\Downarrow \sigma'$.

Din nou, cazul instrucţiunii **while** este cel mai complex. Fie $b$,
$c$ şi notăm $w:=\swhile b \sdo c$. Notând
$W:=\{(\sigma,\sigma') \mid (w,\sigma)\Downarrow \sigma'\}$, vrem să
arătăm $\llbracket w \rrbracket \subseteq W$. Cum
$\llbracket w \rrbracket = \mu \Gamma^{\llbracket b \rrbracket}_{\llbracket c \rrbracket}$,
e suficient să arătăm
$\Gamma^{\llbracket b \rrbracket}_{\llbracket c \rrbracket}(W) \subseteq W$.

Fie
$(\sigma,\sigma') \in \Gamma^{\llbracket b \rrbracket}_{\llbracket c \rrbracket}(W)$
şi tratăm cazul $e_\sigma(b)=1$. Atunci există $\sigma''$ cu
$(\sigma,\sigma'') \in \llbracket c \rrbracket$ şi
$(\sigma'',\sigma') \in W$. Aplicând ipoteza de inducţie, avem
$(c,\sigma)\Downarrow \sigma''$ şi $(w,\sigma'')\Downarrow \sigma'$, de
unde scoatem $(w,\sigma)\Downarrow \sigma'$, adică
$(\sigma,\sigma') \in W$.

## Domenii

Se poate arăta uşor, prin inducţie după derivări, că, pentru orice
instrucţiune $c$ şi orice $\sigma$, $\sigma'$, $\sigma'' \in \Sigma$ cu
$(c, \sigma) \Downarrow \sigma'$ şi $(c,\sigma) \Downarrow \sigma''$,
avem $\sigma'=\sigma''$. Aşadar, din echivalenţa între semantici,
rezultă că $\llbracket c \rrbracket$ este graficul unei funcţii
parţiale, adică un element al mulţimii $$\begin{aligned}
\mathcal{R} &:= \{R \subseteq\Sigma^2 \mid \text{pentru orice $\sigma$, $\sigma'$, $\sigma'' \in \Sigma$ cu $(\sigma,\sigma')$, $(\sigma,\sigma'') \in R$,}\\
&\qquad\qquad\qquad\ \text{avem $\sigma'=\sigma''$}\}.
\end{aligned}$$
Apare întrebarea: putem defini din start semantica
denotaţională a unei instrucţiuni ca element al lui $\mathcal{R}$? Ideea
este că, în acest caz, nu vom mai putea folosi teorema Knaster-Tarski,
care se aplică (în forma dată aici) doar pentru întreaga mulţime a
părţilor. Ca urmare, va trebui să studiem mai mult structura lui
$\mathcal{R}$. Această observaţie stă la temelia **teoriei domeniilor**.

## Mulţimi parţial ordonate

### Definiţie
O **mulţime parţial ordonată** (**mpo**) este o pereche
$(D,\leq)$, unde $\leq \subseteq D^2$ astfel încât:

-   pentru orice $x \in D$, $x \leq x$;

-   pentru orice $x$, $y \in D$ cu $x \leq y$ şi $y \leq x$, $x=y$;

-   pentru orice $x$, $y$, $z \in D$ cu $x \leq y$ şi $y \leq z$,
    $x \leq z$.

### Definiţie
Fie $(D, \leq)$ o mpo, $X \subseteq D$ şi $x \in D$. Spunem că
$x$ este **supremum** pentru $X$ (şi notăm $x = \sup X$, el fiind unic)
dacă este majorant pentru $X$ (pentru orice $y \in X$, $y \leq x$) şi,
pentru orice majorant $z$ pentru $X$, $x \leq z$.

### Definiţie
Fie $(D, \leq)$ o mpo. Un $\omega$-lanţ este un şir
$(a_n)_{n \in \mathbb{N}}$ în $D$ astfel încât, pentru orice
$n \in \mathbb{N}$, $a_n \leq a_{n+1}$.

## Cpo

::: block
### Definiţie
O mpo $(D, \leq)$ se numeşte **cpo** dacă are minim (notat de
obicei cu $\bot$) şi, pentru orice $\omega$-lanţ $(a_n)$ în $D$, există
$\sup \{a_n \mid n \in \mathbb{N}\}$, notat cu
$\sup_{a\in\mathbb{N}} a_n$.
:::

Exemplu: $(\mathcal{R},\subseteq)$ este cpo (exerciţiu!).

### Definiţie
Fie $(D, \leq)$, $(E,\leq)$ mpo şi $f:D \to E$. Spunem că $f$
este **monotonă** dacă, pentru orice $x$, $y\in D$ cu $x \leq y$, avem
$f(x) \leq f(y)$.

### Definiţie
Fie $(D, \leq)$, $(E,\leq)$ cpo şi $f:D \to E$. Spunem că $f$
este **$\omega$-continuă** dacă este monotonă şi, pentru orice
$\omega$-lanţ $(a_n)$ în $D$,
$f(\sup_{a\in\mathbb{N}} a_n)=\sup_{a\in\mathbb{N}} f(a_n)$.

## Punct fix în cpo

Pentru orice mpo $(D, \leq)$ şi orice $f: D \to D$, spunem că un
$d \in D$ este **punct fix** al lui $f$ dacă $f(d)=d$ şi **cel mai mic
punct fix** (**least fixed point**, **lfp**; dacă există, se notează cu
$\mu f$) dacă e punct fix şi, pentru orice punct fix $e$, avem
$d \leq e$.

### Teorema Kleene
Fie $(D,\leq)$ o cpo şi $f: D \to D$ $\omega$-continuă.
Atunci $f$ are lfp. Mai mult, pentru orice $e \in D$ cu $f(e) \leq e$,
$\mu f \leq e$.

### Demonstraţie
Observăm că $\left(f^{(n)}(\bot)\right)_{n \in \mathbb{N}}$
este lanţ (se arată prin inducţie pornind de la $\bot \leq f(\bot)$).
Notăm $d:=\sup_{n \in \mathbb{N}} f^{(n)}(\bot)$ şi avem:\
$\displaystyle f(d) = f(\sup_{n \in \mathbb{N}} f^{(n)}(\bot)) = \sup_{n \in \mathbb{N}} f^{(n+1)}(\bot) = \sup_{n \in \mathbb{N}} f^{(n)}(\bot) = d,$\
iar, luând un $e$ cu $f(e) \leq e$, se arată prin inducţie că, pentru
orice $n\in\mathbb{N}$, $f^{(n)}(\bot)\leq e$ (pornind de la
$\bot \leq e$), rezultând $d \leq e$.

## Definirea semanticii

În acest moment, putem defini, analog cu tipul precedent de operator,
pentru orice $h: \Sigma \to \{0,1\}$ şi orice $C \in \mathcal{R}$, o
funcţie $\tilde{\Gamma}^h_C : \mathcal{R} \to \mathcal{R}$ (trebuie
arătat că este bine-definită -- exerciţiu!), despre care se arată uşor
că este $\omega$-continuă (exerciţiu!). Aşadar, putem defini o nouă
variantă de semantică denotaţională unde ştim de la bun început că
valorile instrucţiunilor sunt graficele unor funcţii parţiale.

Se pot relua apoi ideile din demonstraţia de echivalenţă cu semantica
big-step (folosind în mod crucial acum că acel $W$ din demonstraţie este
un element al lui $\mathcal{R}$, lucru care rezultă din faptul că
semantica big-step produce funcţii parţiale), aşadar şi această
semantică coincide cu toate cele definite anterior.

## Semantica este un morfism

Reamintim modul cum era definită semantica în logica propoziţională:
pentru orice $e : V \to \{0,1\}$ există şi este unică
$e^+ : Form \to \{0,1\}$ astfel încât:

-   pentru orice $v\in V$, $e^+(v)=e(v)$;
-   pentru orice $\varphi\in Form$,
    $e^+(\neg\varphi) = \pmb{\neg}e^+(\varphi)$;
-   pentru orice $\varphi$, $\psi \in Form$,
    $e^+(\varphi\to \psi)=e^+(\varphi) \pmb{\rightarrow}e^+(\psi)$.

Dacă notăm, pentru orice $\varphi$ şi $e$,
$\llbracket \varphi\rrbracket(e):=e^+(\varphi)$, definind astfel o
funcţie $\llbracket\cdot\rrbracket : Form \to \{0,1\}^{\{0,1\}^V}$, şi
definind corespunzător operaţii $\tilde{\neg}$, $\tilde{\to}$, avem că:

-   pentru orice $v\in V$, $\llbracket v\rrbracket=e \mapsto e(v)$;
-   pentru orice $\varphi\in Form$,
    $\llbracket \neg\varphi\rrbracket = \tilde{\neg} \llbracket \varphi\rrbracket$;
-   pentru orice $\varphi$, $\psi \in Form$,
    $\llbracket \varphi\to \psi \rrbracket =  \llbracket \varphi\rrbracket\tilde{\to} \llbracket \psi \rrbracket$.

Vedem că semantica scoate operaţii în afară", deci are trăsături de
morfism. Ne putem întreba: se poate formaliza această idee, definind
anumite structuri pentru care funcţiile chiar devin morfisme? putem face
aceasta şi pentru semantica denotaţională a lui IMP pe care tocmai am
definit-o?

## Signaturi algebrice

O **signatură algebrică (multisortată)** este un triplet $(S,E,r)$, unde
elementele lui $S$ se vor numi **sorturi**, elementele lui $E$ se vor
numi **simboluri de funcţie**, iar $r:E \to S^* \times S$ este **funcţia
de aritate** (îi notăm componentele cu $r_1$, $r_2$).

Observăm că acestea seamănă cu limbajele logicii de ordinul I, cu
următoarele precizări:

-   putem avea mai multe tipuri de date (sorturi) -- lucru care este
    posibil şi în logica de ordinul I, doar că, în mod tradiţional,
    aceasta nu se face;

-   nu avem simboluri de relaţie, ceea ce simplifică mult studiul
    structurilor corespunzătoare.

## Algebre, morfisme

Fie $(S,E,r)$ o signatură. Numim o **algebră** peste ea un obiect de
forma $\mathcal{A} = (\{A_s\}_{s \in S}, \{A_e\}_{e \in E})$, unde,
pentru orice $e \in E$, $A_e : A_{r_1(e)} \to A_{r_2(e)}$.

Dacă avem două algebre
$\mathcal{A} = (\{A_s\}_{s \in S}, \{A_e\}_{e \in E})$,
$\mathcal{B} = (\{B_s\}_{s \in S}, \{B_e\}_{e \in E})$, numim
**morfism** de la $\mathcal{A}$ la $\mathcal{B}$ o familie de funcţii
$\{f_s : A_s \to B_s\}_{s \in S}$, unde, pentru orice $e \in E$,
$f_{r_2(e)} \circ A_e = B_e \circ f_{r_1(e)}$. Un **izomorfism** va fi
un morfism cu toate componentele bijective (echivalent: un morfism care
are un morfism invers).

Cum se instanţiază acest formalism la structuri algebrice cunoscute (de
exemplu, la grupuri)?

## Logica privită algebric

Cum formalizăm acum logica propoziţională?

Definim signatura corespunzătoare $(S,E,r)$ în felul următor: punem
$S:=\{f\}$ (avem un singur sort, al formulelor), iar
$E:=V \cup \{\neg,\to\}$. Avem: pentru orice $v \in V$,
$r(v)=(\lambda,f)$; $r(\neg)=(f,f)$; $r(\to)=(ff,f)$. Formulele devin
astfel, în mod natural, o structură algebrică notată cu $\mathcal{F}$.

Putem defini şi o algebră $\mathcal{E}$ cu $E_f:=\{0,1\}^{\{0,1\}^V}$,
$E_\neg:=\tilde{\neg}$, $E_\to:=\tilde{\to}$, iar, pentru orice
$v \in V$, $E_v := e \mapsto e(v)$. Funcţia $\llbracket\cdot\rrbracket$
devine astfel, cum preconizam, un morfism (unicul!) de la $\mathcal{F}$
la $\mathcal{E}$.

Ducând aceste idei mult mai departe, ajungem la **logica algebrică**.

## Algebre iniţiale

Se observă şi că Principiul recursiei pe formule poate fi reformulat
astfel (de ce?): pentru orice algebră $\mathcal{B}$ există şi este unic
un morfism $F : \mathcal{F} \to \mathcal{B}$.

Aceasta ne conduce la următoarea definiţie: fixând o signatură oarecare,
o algebră $\mathcal{A}$ se numeşte **iniţială** dacă, pentru orice
algebră $\mathcal{B}$, există şi este unic un morfism
$F : \mathcal{A} \to \mathcal{B}$.

Aşadar, $\mathcal{F}$ este algebră iniţială. În general algebrele de
termeni" vor fi algebre iniţiale, gândindu-ne profund la modul cum am
demonstrat Principiul recursiei.

## Proprietăţile algebrelor iniţiale

### Propoziţie
Fie $\mathcal{A}$, $\mathcal{A}'$ algebre iniţiale. Atunci
ele sunt izomorfe.

### Demonstraţie
Avem morfisme $f: \mathcal{A} \to \mathcal{A}'$ şi
$g: \mathcal{A}' \to \mathcal{A}$. Cum
$g \circ f: \mathcal{A} \to \mathcal{A}$ şi
$\mathrm{id}_\mathcal{A} : \mathcal{A} \to \mathcal{A}$, rezultă că
$g \circ f = \mathrm{id}_\mathcal{A}$. Analog,
$f \circ g = \mathrm{id}_{\mathcal{A}'}$.

### Propoziţie
Fie $\mathcal{A}$, $\mathcal{A}'$ algebre izomorfe. Dacă
$\mathcal{A}$ e iniţială, atunci $\mathcal{A}'$ e iniţială.

### Demonstraţie
Avem un izomorfism $f: \mathcal{A} \to \mathcal{A}'$. Fie
$\mathcal{A}''$ o algebră. Vrem să arătăm că există un unic morfism
$h:\mathcal{A}'\to \mathcal{A}''$. Pentru existenţă, ştim că există un
morfism $g:\mathcal{A} \to \mathcal{A}''$. Luăm $h:=g\circ f^{-1}$.
Pentru unicitate, fie $h$, $h':\mathcal{A}' \to \mathcal{A}''$ morfisme.
Atunci $h \circ f$, $h' \circ f:\mathcal{A} \to \mathcal{A}''$ sunt
morfisme, deci $h \circ f = h' \circ f$. Compunând la dreapta cu
$f^{-1}$, obţinem $h=h'$.

## Algebra [IMP]{.sans-serif}

Cum formalizăm acum limbajul IMP?

Vom pune $S:=\{a,b,i\}$ (sorturi pentru expresii aritmetice, booleene şi
instrucţiuni), iar în $E$ toate operaţiile pe care le-am definit, pe
care nu le vom enumera. Vom spune doar care este aritatea fiecărei
operaţii care produce elemente de sort $i$:

-   $r(\sskip)=(\lambda,i)$;

-   pentru orice $X \in L$, $r(X:=) = (a,i)$;

-   $r(;) = (ii,i)$;

-   $r(\tif)=(bii,i)$;

-   $r(\twhile)=(bi,i)$.

Expresiile aritmetice, booleene şi instrucţiunile, aşa cum le-am
definit, vor forma algebra iniţială peste această signatură, algebră pe
care o vom nota cu [IMP]{.sans-serif}.

## Algebra de valori

Formalizăm acum algebra în care semantica denotaţională ia valori şi o
notăm cu $\mathcal{A}$. Punem $A_a:=\mathbb{Z}^\Sigma$,
$A_b:=\{0,1\}^\Sigma$ şi $A_i:=\mathcal{P}(\Sigma^2)$. Descriem în
continuare operaţiile care produc elemente de sort $i$:

-   $A_{\sskip}:=\Delta_\Sigma$;

-   pt. orice $X \in L$, $j \in \mathbb{Z}^\Sigma$,
    $A_{X:=}(j) := \left\{\left(\sigma,\sigma_{X \mapsto  j(\sigma)}\right) \mid \sigma \in \Sigma\right\}$;

-   pentru orice $C_1$, $C_2 \subseteq\Sigma^2$,
    $A_;(C_1,C_2):=C_2 \circ C_1$;

-   pentru orice $h \in \{0,1\}^\Sigma$, $C_1$, $C_2 \subseteq\Sigma^2$,
    $A_{\tif}(h,C_1,C_2):=\{(\sigma,\sigma') \in C_1 \mid h(\sigma)=1\} \cup \{(\sigma,\sigma') \in C_2 \mid h(\sigma)=0\}$;

-   pentru orice $h \in \{0,1\}^\Sigma$, $C \subseteq\Sigma^2$,
    $A_{\twhile}(h,C):=\mu \Gamma^h_C$.

Atunci semantica
$\llbracket\cdot\rrbracket : \textsf{IMP} \to \mathcal{A}$ va fi unicul
morfism, cel dat de iniţialitate.

Acelaşi lucru îl putem face şi cu grafice de funcţii parţiale, obţinând
o algebră $\mathcal{B}$. Avem o funcţie naturală de incluziune de la
$\mathcal{B}$ la $\mathcal{A}$. Este aceasta morfism? Confirmaţi sau
infirmaţi! (Nu este uşor.)
