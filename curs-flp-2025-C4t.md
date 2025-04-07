---
author: Traian Florin Șerbănuță și Andrei Sipoș
institute: Facultatea de Matematică și Informatică, DL Info
date: Anul II, Semestrul II, 2024/2025
title: Fundamentele limbajelor de programare
subtitle: Programare Logică.  Corectitudinea algoritmului de unificare.
theme: CambridgeUS
---

# Programare Logică (de ordinul I)

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

- $r(s)$ **aritatea** lui $s$ – pentru orice $s \in F \cup R$

- **constantele** lui $\sigma$ – acele $f\in F$ pentru care $r(f)=0$

## Termeni

**Termenii** sunt cuvinte peste alfabetul
$$S_\sigma := \{\bot,\to,\forall,=\} \cup V \cup F \cup R.$$
definite prin următoarele două (scheme de) reguli:

- $v$ e termen, pentru orice $v \in V$

- dacă $t_1,\ldots,t_{r(f)}$ sunt termeni, \
  atunci $f\,t_1\ldots t_{r(f)}$ e termen \
  pentru orice $f \in F$.\
  (în particular, dacă $r(f) = 0$, atunci $f$ este termen)

Mulţimea termenilor peste $\sigma$ se va nota cu $T_\sigma$.

### Convenții de scriere

Presupunând că $V$, $F$, $R$ nu conțin simbolurile $($, $)$, și $,$\
putem scrie $f(t_1, \ldots, t_{r(f)})$ în loc de $f\,t_1\cdots t_{r(s)}$ dacă
$r(f) > 0$.

## Mulţimea variabilelor unui termen

$Var : T_\sigma \to \mathcal{P}(V)$, definită prin:

- pentru orice $x \in V$, $Var(x):=\{x\}$;

- pentru orice $f \in F$ şi orice $t_1,\ldots,t_{r(f)} \in T_\sigma$,
  $Var(f\,t_1\cdots t_{r(f)}):=Var(t_1) \cup \ldots \cup Var(t_{r(s)})$ \
  (în particular, dacă $r(f)=0$, $Var(f)=\emptyset$).

Notăm cu $\widetilde{T}_\sigma$ mulţimea termenilor fără variabile.

## Formule atomice

Fie $\sigma=(F,R,r)$ o signatură.

- O formulă atomică **ecuaţională** sau doar **ecuaţie** e un șir de forma\
  ${=}tu$, cu $t$, $u \in T_\sigma$

- O formulă atomică **relațională** e un șir de forma\
  $p\,t_1\cdots t_{r(p)}$ cu $p\in R$ şi $t_1,\ldots,t_n\in T_\sigma$

- O **formulă atomică** este fie o ecuație fie o formulă atomică relațională

Mulţimea formulelor atomice peste $\sigma$ se va nota cu $Fa_\sigma$.

### Convenții de scriere

- Vom scrie $t = u$ în loc de ${=}tu$

- Presupunând că $V$, $F$, $R$ nu conțin simbolurile $($, $)$, și $,$\
  putem scrie $p(t_1, \ldots, t_{r(p)})$ în loc de $p\, t_1\cdots t_{r(p)}$ dacă $r(p) > 0$.

## Formule

Mulţimea **formulelor** peste
$\sigma$ e definită de următoarele (scheme de) reguli:

- $a$ este formulă, pentru orice formulă atomică $a \in Fa_\sigma$;

- $\bot$ este formulă;

- dacă $\varphi$, $\psi$ sunt formula, atunci $\to\varphi\psi$ este formulă;

- dacă $\varphi$ formulă, atunci $\forall x \varphi$ e formulă, pentru orice $x \in V$.

Mulţimea formulelor peste $\sigma$ se va nota cu $F_\sigma$.

De asemenea, vom defini **formulele relaţionale** în acelaşi mod, cu
excepţia că acceptăm în cadrul lor doar formule atomice relaţionale.

### Convenții de scriere

Vom scrie $\varphi \to \psi$ în loc de $\to\varphi\psi$ și vom folosi
parenteze pentru dezambiguizare.

## Conectori logici derivaţi


Pentru orice $\varphi$,$\psi \in F_\sigma$

- $\top:= \bot\to\bot$

- $\neg \varphi:= \varphi\to \bot$

- $\varphi\wedge\psi:=\neg(\varphi\to \neg\psi)$

- $\varphi\vee\psi:=(\neg \varphi)\to \psi$

- $\varphi\leftrightarrow\psi := (\varphi\to \psi) \wedge(\psi \to \varphi)$

- $\exists x \varphi:= \neg \forall x \neg \varphi$, pentru orice $x\in V$ şi $\varphi\in F_\sigma$.

## Mulţimea variabilelor libere ale unei formule

Definim funcţia $FV : F_\sigma \to \mathcal{P}(V)$, prin:

- pentru orice $t$, $u \in T_\sigma$, $FV(t=u):=Var(t) \cup Var(u)$;

- pentru orice $p \in R$ şi orice $t_1,\ldots,t_{r(p)} \in T_\sigma$,
  $FV(p\,t_1\cdots t_{r(p)}):=Var(t_1) \cup \ldots \cup Var(t_{r(p)})$;

- $FV(\bot):=\emptyset$;

- pentru orice $\varphi$, $\psi \in F_\sigma$,
  $FV(\varphi\to \psi):=FV(\varphi) \cup FV(\psi)$;

- pentru orice $\varphi\in F_\sigma$ şi $x \in V$,
  $FV(\forall x \varphi):=FV(\varphi) \setminus \{x\}$.

Dacă $\varphi\in F_\sigma$ cu $FV(\varphi)=\emptyset$, atunci $\varphi$
se numeşte **enunţ**. Mulţimea enunţurilor peste $\sigma$ se notează cu
$E_\sigma$.

## Numărul de simboluri funcționale

Pentru un termen $t$ definim $n_F(t)$, numărul de simboluri de funcție din $t$ recursiv prin:

- $n_F(x) = 0$ pentru orice variabilă $x$
- $n_F(f\,t_1\cdots t_{r(f)}) = 1 + n_F(t_1) + \ldots + n_F(t_{r(s)})$

$n_F$ se extinde natural la formule și mulțimi de formule.

- $n_F(t_1 = t_2) = n_F(t_1) + n_F(t_2)$
- $n_F(p\,t_1\cdots t_{r(p)}) = n_F(t_1) + \cdots + n_F(t_{r(p)})$
- \ldots

_Observație:_ $n_F$ numără __doar__ simbolurile de funcție

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
$$\forall(A_0 \lor \neg A_1 \lor\ldots\lor \neg A_m)$$
se scrie şi sub
forma (cunoscută din limbajul Prolog) $$A_0 \leftarrow A_1,\ldots,A_m.$$

Un **program** va fi o mulţime finită de clauze definite. Un **scop
definit** este o clauză în care apar doar literali negativi.

# Unificare

## Motivaţia unificării

Să zicem că avem un program Prolog care conţine regula
$$p(f(X),Y) \leftarrow p(X,Y)$$ şi vrem să interogăm $p(Z,f(T))$. Pentru
a găsi o soluţie a acestei interogări folosind regula de mai sus,
trebuie să substituim $X \mapsto X$, $Z \mapsto f(X)$, $Y \mapsto f(T)$,
$T \mapsto T$, interogarea devenind $p(f(X),f(T))$, care este redusă,
conform regulii, la $p(X,f(T))$, care devine practic o nouă interogare.

Observăm că o parte esenţială a procesului de rulare a unui program
Prolog este găsirea acelei substituţii.

## Substituţia termenilor

Vom numi **substituţie** o funcţie $\theta : V \to T_\sigma$. Folosind
Principiul de recursie pe termeni, ea se extinde natural în mod unic la
o funcţie $\widetilde{\theta} : T_\sigma \to T_\sigma$.

Se observă, folosind unicitatea, că, pentru orice două substituţii
$\theta$, $\theta'$,
$$\widetilde{\widetilde{\theta'} \circ \theta} = \widetilde{\theta'} \circ \widetilde{\theta}.$$

Pentru o variabilă $x$ și un termen $t$ definim substituția singleton $[x \mapsto t]$ prin
$$[x \mapsto t](y) =  \begin{cases} t, & \mbox{dac\u a } y=x, \\
y, & \mbox{altfel}.\end{cases}$$

Spunem că o substituție $\Theta$ e __mai generală__ decât altă substituție $\Theta'$ dacă \
există o substituție $\Delta$ astfel încât $\Theta' = \widetilde{\Delta} \circ \Theta$

- Notăm cu $\Theta \succ \Theta'$ faptul că $\Theta$ e mai generală decât $\Theta'$

## Unificatori

Dacă $\mathcal{E}$ este o mulţime de ecuaţii, numim **unificator**
pentru ea \
o substituţie $\theta$ astfel încât, pentru orice
$(s=t) \in \mathcal{E}$, avem
$\widetilde{\theta}(s)=\widetilde{\theta}(t)$

Notăm cu $\cal U(E)$ mulțimea unificatorilor lui $\cal E$

Un unificator $\theta$ pentru $\mathcal{E}$ se numeşte
**cel mai general unificator**\
(**cgu**; **most general unifier**, **mgu**) dacă
este mai general (ca substituție) decât orice alt unificator $\theta'$ pentru $\mathcal{E}$.

Formal $\Theta$ e mgu pentru $\mathcal{E}$ ddacă

- $\Theta \in \cal U(E)$ și
- pentru orice $\Theta' \in \cal U(E)$, $\Theta \succ \Theta'$

### Propoziție (definiție alternativă)

$\Theta$ e mgu pentru $\mathcal{E}$ ddacă
$${\cal U(E)} = \{\Theta' : V\to T_\sigma \mid \Theta \succ \Theta' \}$$

## Algoritm de unificare (ușor formalizat)

Algoritmul pornește cu configurația inițială $(\Theta, \mathcal{R}) = (1_V, \mathcal{E})$ și \
constă în aplicarea nedeterministă a regulilor de mai jos[^1]:

SCOATE

: $(\Theta, \mathcal{R} \cup \{t = t\}) \Longrightarrow (\Theta, \mathcal{R})$

DESCOMPUNE

: $(\Theta, \mathcal{R} \cup \{f\,t_1\cdots t_n = f\, t_1'\cdots t_n'\})$ \
  $\Longrightarrow (\Theta, \mathcal{R} \cup \{ t_1 = t_1', \ldots, t_n = t_n' \}$

REZOLVĂ

: $(\Theta, \mathcal{R} \cup \{x = t\})$ \quad __sau__ \quad $(\Theta, \mathcal{R} \cup \{t = x\})$ \
  $\Longrightarrow (\widetilde{[x\mapsto t]}\circ \Theta, \{\widetilde{[x\mapsto t]}(t_1) = \widetilde{[x\mapsto t]}(t_2) \mid t_1 = t_2 \in \mathcal{R}\}$ \
  dacă $x \notin Var(t)$.

\HRule

EȘEC (conflict)

: există în $\cal R$ o ecuaţie de forma\
  $f\, s_1\cdots s_n = g\, t_1\cdots t_m$ cu $f \neq g$.

EȘEC (ciclu)

: există în $\cal R$ o ecuaţie de forma\
  $x = t$ sau $t = x$ cu $t \neq x$ şi $x \in Var(t)$.

[^1]: Condiție suplimentară pentru orice regulă $(\Theta, \mathcal{R} \cup \{e\}) \Longrightarrow (\Theta', \mathcal{R}')$:
      $\structure{e \not\in \cal R}$.

## Accesibilitate

_Definiție_: Configurația $(\Theta', \mathcal{R}')$ e __accesibilă__
din configurația $(\Theta, \mathcal{R})$ dacă\
există $n\in \N$ și o secvență $(\Theta_i, \mathcal{R}_i)_{i\in \overline{1. n}}$, numită __derivare__ astfel încât:

- $(\Theta_0, \mathcal{R}_0) = (\Theta, \mathcal{R})$

- $(\Theta_n, \mathcal{R}_n) = (\Theta', \mathcal{R}')$

- $(\Theta_i, \mathcal{R}_i) \Longrightarrow (\Theta_{i + 1}, \mathcal{R}_{i+1})$ pentru orice $0\leq i < n$.

## Configurații finale

O configurație $(\Theta, \cal R)$ se numește __finală__ dacă\
orice ecuație din $\cal R$ este "de eșec", i.e., de forma:

- $x = t$ sau $t = x$ unde $t\neq x$ și $x\in Var(t)$

- $f\, t_1 \cdots t_{r(f)} = g\, t'_1 \cdots t'_{r(g)}$ cu $f \neq g$

### Teoremă

Dacă $(\Theta, \cal R)$ e finală atunci
${\cal U(R)} = \begin{cases}{T_\sigma}^V & \mbox{dacă } \mathcal{R} = \emptyset\\ \emptyset & \mbox{altfel} \end{cases}$

### Demonstrație

Dacă $\cal R = \emptyset$ afirmația e evidentă din definiția unificatorilor[^2].

Altfel, prin reducere la absurd pentru $\widetilde\Theta(t_1) = \widetilde\Theta(t_2)$ unde $(t_1 = t_2) \in \cal R$

- $\widetilde\Theta(x) = \widetilde\Theta(t)$ contradicție cu $n_F(\widetilde\Theta(x)) < n_F(\widetilde\Theta(t))$

- $\widetilde\Theta(f\, t_1 \cdots t_{r(f)}) = \widetilde\Theta(g\, t'_1 \cdots t'_{r(g)})$ contradicție cu $f\neq g$

[^2]: ${T_\sigma}^V$ este multimea funcțiilor de la $V$ la $T_\sigma$, adică a tuturor substituțiilor.

## Invariant

### Teoremă

Pentru orice configurație $(\Theta, \mathcal{R})$ accesibilă dintr-o configurație $(1_V, \mathcal{E})$:

$$\mathcal{U(E)} = \{\Theta' \in \mathcal{U(R)} \mid \Theta \succ \Theta' \}$$

### Demonstrație (schiță)

Demonstrăm concluzia teoremei împreună cu următoarele afirmații

- $\forall x\in V.\forall y\in Var(\Theta(x)). \Theta(y) = y$

- $\forall x \in Var(\mathcal{R}).\Theta(x) = x$ \
  (unde $Var(\mathcal{R}) = \bigcup_{(t_1 = t_2)\in \cal R} (Var(t_1) \cup Var(t_2))$)

prin inducție după lungimea unei derivări.

### Lemă ajutătoare

Fie $\Theta$ unificator pentru $x = t$, unde $x$ variabilă.

Atunci $\Theta = \widetilde\Theta \circ [x \mapsto t]$.

## Corectitudine parțială

Fie $(\Theta, \cal R)$ configurație finală accesibilă din $(1_V, \cal E)$.

- Dacă $\cal R = \emptyset$ atunci $\Theta$ este mgu pentru $\cal E$.

- Dacă $\cal R \neq \emptyset$ atunci $\cal U(E) = \emptyset$.

### Demonstrație

Folosind teorema despre invariant avem că
$$\mathcal{U(E)} = \{\Theta' \in \mathcal{U(R)} \mid \Theta \succ \Theta' \}$$

Folosim teorema despre configurații finale:

- dacă $\cal R = \emptyset$, atunci $\mathcal{U(R)} = {T_\sigma}^V$, deci
  $\mathcal{U(E)} = \{\Theta' : V \to T_\sigma \mid \Theta \succ \Theta' \}$\
  de unde $\Theta$ mgu pentru $\cal E$.

- dacă $\cal R \neq \emptyset$, atunci $\mathcal{U(R)} = \emptyset$, deci
  $\mathcal{U(E)} = \emptyset$

## Variant

Dată fiind o configurație $(\Theta, \mathcal{R})$ definim
$$variant((\Theta, \mathcal{R})) := (|Var(\mathcal{R})|, n_F(\mathcal{R}), |\mathcal{R}|).$$

Pe $\N\times\N\times \N$ notăm _ordinea lexicografică_ cu $<$

- $(n_1, n_2, n_3) < (m_1, m_2, m_3)$ ddacă 
  $n_1 < m_1 \vee (n_1 = m_1 \wedge n_2 < m_2) \vee (n_1 = m_1 \wedge n_2 = m_2 \wedge n_3 < m_3)$
- $<$ este o _bună ordine_, i.e., nu există secvențe infinite descrescătoare:
  $$\not\exists (a_n)_{n\in \N} \mbox{ cu } a_n > a_{n+1}\mbox{ pentru orice }n\in \N$$

## Variant

### Teoremă

Dacă $(\Theta, \mathcal{R}) \Longrightarrow (\Theta', \mathcal{R}')$ atunci $variant((\Theta, \mathcal{R})) > variant((\Theta', \mathcal{R}'))$

### Demonstrație

Discuție după pasul din algoritm folosit:

SCOATE

: primele două componente nu cresc și ultima sigur scade cu $1$

DESCOMPUNE

: prima componentă rămâne la fel și a doua scade cu $1$

REZOLVĂ

: Prima componentă scade, pentru că:

  - variabila care este rezolvată apărea în $\cal R$ dar nu va mai apare în $\cal R'$ \
  (e substituită peste tot cu un termen în care nu apare)
  - nu apar alte variabile noi

## Terminare

### Teoremă

Algoritmul de unificare nu admite derivări infinite.

### Demonstrație

Presupunem există o derivare infinită $(\Theta_n, \mathcal{R}_n)_{n\in \N}$

Considerăm șirul $(a_n)_{n\in \N}$ definit prin $a_n := variant((\Theta_n, \mathcal{R}_n))$

Deoarece $(\Theta_n, \mathcal{R}_n) \Longrightarrow (\Theta_{n +1}, \mathcal{R}_{n+1})$ pentru orice $n\in \N$,\
reiese că $a_n > a_{n+1}$ pentru orice $n\in \N$ (din teorema de variant).

Contradicție cu faptul că $<$ e bună ordine pe $\N\times \N \times \N$.

## Progres

### Teoremă

Pentru orice configurație ne-finală $(\Theta, \cal R)$ există o configurație $(\Theta', \cal R')$ cu
$$(\Theta, {\cal R}) \Longrightarrow (\Theta', \cal R')$$

### Demonstrație

Există cel puțin o ecuație $(t_1 = t_2) \in \cal R$ care nu e "de eșec".\
Analiză după forma ei. Avem trei cazuri:

$x = x$

: Aplicăm regula ELIMINĂ

$x = t$ sau $t = x$ cu $t \neq x$

: Avem că  $x \not\in Var(t)$ (nu e de eșec).\
  Aplicăm regula REZOLVĂ

$f\, t_1 \cdots t_{r(f)} = g\, t'_1 \cdots t'_{r(g)}$

: Avem că $f = g$ (nu e de eșec).\
  Aplicăm regula DESCOMPUNE

## Corectitudine totală

### Teoremă
Algoritmul de unificare se termină mereu şi produce
rezultatul corect.

### Demonstraţie

- Terminare: din teorema de terminare.

- Admite configurații finale: din teorema de progres (și terminare).

- Produce rezultatul corect: din teorema de corectitudine parțială.
