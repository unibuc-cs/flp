
:-include("imp.pl").


get(S,X,I) :- member(vi(X,I),S).
get(_,_,0).
set(S,X,I,[vi(X,I)|S1]) :- del(S,X,S1).
del([vi(X,_)|S],X,S).
del([H|S],X,[H|S1]) :- del(S,X,S1) .
del([],_,[]).

smallstepS(X = AE,S,skip,S1) :-
  integer(AE),set(S,X,AE,S1) .
smallstepS(X = AE1,S,X = AE2,S) :-
  smallstepA(AE1,S,AE2,S) .

smallstepS((skip;St2),S,St2,S).
smallstepS((St1;St),S1,(St2;St),S2) :-
  smallstepS(St1,S1,St2,S2) .

smallstepS({E},S,E,S).

smallstepS(if(true,St1,_),S,St1,S) .
smallstepS(if(false,_,St2),S,St2,S).
smallstepS(if(BE1,St1,St2),S,if(BE2,St1,St2),S) :- 
  smallstepB(BE1,S,BE2,S) .

smallstepS(while(BE,St),S,if(BE,(St;while(BE,St)),skip),S).

smallstepB(I1 =< I2,S,true,S):-
  integer(I1),integer(I2),
  (I1 =< I2).
  smallstepB(I1 =< I2,S,false,S):-
  integer(I1),integer(I2),
  (I1 > I2) .
smallstepB(I =< AE1,S,I =< AE2,S):-
  integer(I),
  smallstepA(AE1,S,AE2,S).
smallstepB(AE1 =< AE,S,AE2 =< AE,S):-
  smallstepA(AE1,S,AE2,S).

smallstepB(I1 >= I2,S,true,S):-
  integer(I1),integer(I2),
  (I1 >= I2) .
smallstepB(I1 >= I2,S,false,S):-
  integer(I1),integer(I2),
  (I1 < I2) .
smallstepB(I >= AE1,S,I >= AE2,S):-
  integer(I),
  smallstepA(AE1,S,AE2,S).
smallstepB(AE1 >= AE,S,AE2 >= AE,S):-
  smallstepA(AE1,S,AE2,S).

smallstepB(I1 == I2,S,true,S):-
  integer(I1),integer(I2),
  (I1 =:= I2) .
smallstepB(I1 == I2,S,false,S):-
  integer(I1),integer(I2),
  (I1 =\= I2) .
smallstepB(I == AE1,S,I == AE2,S):-
  integer(I),
  smallstepA(AE1,S,AE2,S).
smallstepB(AE1 == AE,S,AE2 == AE,S):-
  smallstepA(AE1,S,AE2,S).

smallstepB(and(true,BE2),S,BE2,S).
smallstepB(and(false,_),S,false,S).
smallstepB(and(BE1,BE),S,and(BE2,BE),S) :-
  smallstepB(BE1,S,BE2,S).

smallstepB(or(true,_),S,true,S) .
smallstepB(or(false,BE2),S,BE2,S) .
smallstepB(or(BE1,BE),S,or(BE2,BE),S) :-
  smallstepB(BE1,S,BE2,S).

smallstepB(not(true),S,false,S) .
smallstepB(not(false),S,true,S) .
smallstepB(not(BE1),S,not(BE2),S) :-
  smallstepB(BE1,S,BE2,S).



smallstepA(I1 + I2,S,I,S):-
  integer(I1),integer(I2),
  I is I1 + I2.
smallstepA(I + AE1,S,I + AE2,S):-
  integer(I),
  smallstepA(AE1,S,AE2,S).
smallstepA(AE1 + AE,S,AE2 + AE,S):-
  smallstepA(AE1,S,AE2,S).

smallstepA(I1 - I2,S,I,S):-
  integer(I1),integer(I2),
  I is I1 - I2.
smallstepA(I - AE1,S,I - AE2,S):-
  integer(I),
  smallstepA(AE1,S,AE2,S).
smallstepA(AE1 - AE,S,AE2 - AE,S):-
  smallstepA(AE1,S,AE2,S).

smallstepA(I1 * I2,S,I,S):-
  integer(I1),integer(I2),
  I is I1 * I2.
smallstepA(I * AE1,S,I * AE2,S):-
  integer(I),
  smallstepA(AE1,S,AE2,S).
smallstepA(AE1 * AE,S,AE2 * AE,S):-
  smallstepA(AE1,S,AE2,S).



smallstepA(X,S,I,S) :-
  atom(X),
  get(S,X,I).


smallstepP(skip,AE1,S1,skip,AE2,S2) :- 
  smallstepA(AE1,S1,AE2,S2) .
smallstepP(St1,AE,S1,St2,AE,S2) :-
  smallstepS(St1,S1,St2,S2).

run(skip,I,_,I):- integer(I).
run(St1,AE1,S1,I) :-
  smallstepP(St1,AE1,S1,St2,AE2,S2),
  run(St2,AE2,S2,I). 


run_program(Name) :- defpg(Name,{P},E), run(P,E, [],I), write(I). 



defpg(pg1,
  {nr = 0; while( nr =< 10, nr=nr+1)},
  nr).
  
defpg(pg2, {x = 10 ; sum = 0; while(0 =< x, {
                                      sum = sum + x;
                                      x = x - 1})},sum).
  

mytrace(skip,I,_) :- integer(I).
mytrace(St1,AE1,S1) :- 
  smallstepP(St1,AE1,S1,St2,AE2,S2),
  write(St2),nl,write(AE2),nl,write(S2),nl,
  mytrace(St2,AE2,S2).  


trace_program(Name) :-defpg(Name,{P},E), mytrace(P,E,[]).

