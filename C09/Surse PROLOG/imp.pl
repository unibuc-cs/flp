

:- op(100, xf, {}).
:- op(1100, yf, ;).

stmt(skip).

stmt(X = AE) :-
  atom(X),
  aexp(AE).
  
stmt(St1;St2) :-
  stmt(St1),
  stmt(St2).  

stmt((St1;St2)) :-
  stmt(St1),
  stmt(St2).  

stmt({St}) :-
  stmt(St).

stmt(if(BE,St1,St2)) :-
  bexp(BE),
  stmt(St1),
  stmt(St2).
  
stmt(while(BE,St)) :-
  bexp(BE),
  stmt(St).
  
bexp(A1 =< A2) :-
  aexp(A1),
  aexp(A2).
  
bexp(A1 >= A2) :-
  aexp(A1),
  aexp(A2).
  
bexp(A1 == A2) :-
  aexp(A1),
  aexp(A2).
  
bexp(and(BE1,BE2)) :-
  bexp(BE1),
  bexp(BE2).
 
bexp(or(BE1,BE2)) :-
  bexp(BE1),
  bexp(BE2).
  
bexp(not(BE)) :-
  bexp(BE).
  
bexp(true). bexp(false).



aexp(A1 + A2) :-
  aexp(A1),
  aexp(A2).
 
aexp(A1 - A2) :-
  aexp(A1),
  aexp(A2).
  
aexp(A1 * A2) :-
  aexp(A1),
  aexp(A2).
  

aexp(I) :- integer(I).

%% atomii din Prolog sunt identificatorii limbajului IMP
aexp(X) :- atom(X).


program(St,AE) :-
  stmt(St),
  aexp(AE).
 %% expresia AEXP se evalueaza in starea rezultata dupa rularea programului
 
