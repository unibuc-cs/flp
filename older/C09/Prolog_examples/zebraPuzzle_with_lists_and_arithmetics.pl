la_dreapta(X,Y) :- X is Y + 1.

la_stanga(X,Y) :- la_dreapta(Y,X).

langa(X,Y) :- la_dreapta(X,Y) ; la_stanga(X,Y).

solutie(Strada,PosesorZebra) :- 
  Strada = [
      casa(1,_,_,_,_,_), %sunt 5 case
      casa(2,_,_,_,_,_),
      casa(3,_,_,_,_,_),
      casa(4,_,_,_,_,_),
      casa(5,_,_,_,_,_)],
    member(casa(_,englez,rosie,_,_,_), Strada), %Englezul locuieste in casa rosie.
    member(casa(_,spaniol,_,caine,_,_), Strada), %Spaniolul are un caine.
    member(casa(_,_,verde,_,cafea,_), Strada),  %In casa verde se bea cafea.
    member(casa(_,ucrainean,_,_,ceai,_), Strada),  %Ucraineanul bea ceai.
    member(casa(A,_,verde,_,_,_), Strada), %Casa verde este imediat in dreapta casei bej.
    member(casa(B,_,bej,_,_,_), Strada),
    la_dreapta(B,A),
    member(casa(_,_,_,melci,_,'Old_Gold'), Strada), %Fumatorul de "Old Gold" are melci.
    member(casa(_,_,galben,_,_,'Kools'), Strada), %In casa galbena se fumeaza "Kools"      
    member(casa(3,_,_,_,lapte,_), Strada), %In casa din mjloc se bea lapte.
    member(casa(1,norvegian,_,_,_,_), Strada), %Norvegianul locuieste in prima casa.
    member(casa(C,_,_,_,_,'Chesterfields'), Strada), 
    member(casa(D,_,_,vulpe,_,_), Strada), %Fumatorul de "Chesterelds" locuieste langa cel care are o vulpe.
    langa(C,D),
    member(casa(E,_,_,_,_,'Kools'), Strada), %"Kools" sunt fumate in casa de langa cea in care se tine calul.
    member(casa(F,_,_,cal,_,_), Strada),
    langa(E,F),
    member(casa(_,_,_,_,portocale,'Lucky Strike'),Strada), %Fumatorul de "Lucky Strike" bea suc de portocale.
    member(casa(_,japonez,_,_,_,'Parliaments'), Strada), %Japonezul fumeaza "Parliaments"
    member(casa(G,norvegian,_,_,_,_), Strada), %Norvegianul locuieste langa casa albastra.
    member(casa(H,_,albastra,_,_,_), Strada),
    langa(G,H),
    member(casa(_,PosesorZebra,_,zebra,_,_), Strada).
    
/*
casa(Numar,Nationalitate,Culoare,AnimalCompanie,Bautura,Tigari)

?-  solutie(Strada, P).
?- solutie(Strada, P).
Strada = [casa(1, norvegian, galben, vulpe, _24618, 'Kools'),
 casa(2, ucrainean, albastra, cal, ceai, 'Chesterfields'), 
 casa(3, englez, rosie, melci, lapte, 'Old_Gold'), 
 casa(4, japonez, verde, zebra, cafea, 'Parliaments'), 
 casa(5, spaniol, bej, caine, portocale, 'Lucky Strike')],
P = japonez ;
https://en.wikipedia.org/wiki/Zebra_Puzzle
*/
