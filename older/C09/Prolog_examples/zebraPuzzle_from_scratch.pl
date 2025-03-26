
% 1. There are five houses.
stmt1(cons(_, cons(_, cons(_, cons(_, cons(_, nil)))))).

% 2. The Englishman lives in the red house.
stmt2(Strada) :-
  casa_pe_strada(Casa, Strada),
  nationalitate(Casa, englez),
  culoare(Casa, rosie).

% 3. The Spaniard owns the dog.
stmt3(Strada) :-
  casa_pe_strada(Casa, Strada),
  nationalitate(Casa, spaniol),
  animal(Casa, caine).

% 4, Coffee is drunk in the green house.
stmt4(Strada) :-
  casa_pe_strada(Casa, Strada),
  bautura(Casa, cafea),
  culoare(Casa, verde).

% 5. The Ukrainian drinks tea.
stmt5(Strada) :-
  casa_pe_strada(Casa, Strada),
  nationalitate(Casa, ucrainean),
  bautura(Casa, ceai).

% 6. The green house is immediately to the right of the ivory house.
stmt6(Strada) :-
  culoare(Casa1, verde),
  case_alaturate(Casa0, Casa1, Strada),
  culoare(Casa0, fildes).

% 7. The Old Gold smoker owns snails.
stmt7(Strada) :-
  casa_pe_strada(Casa, Strada),
  tigari(Casa, 'Old Gold'),
  animal(Casa, melci).

% 8. Kools are smoked in the yellow house.
stmt8(Strada) :-
  casa_pe_strada(Casa, Strada),
  tigari(Casa, 'Kools'),
  culoare(Casa, galbena).

% 9. Milk is drunk in the middle house.
stmt9(Strada) :-
  bautura(Casa, lapte),
  casa_din_mijloc(Casa, Strada).

% 10. The Norwegian lives in the first house.
stmt10(Strada) :-
  nationalitate(Casa, norvegian),
  prima_casa(Casa, Strada).

% 11. The man who smokes Chesterfields lives in the house next to
% the man with the fox.
stmt11(Strada) :-
  tigari(Casa1, 'Chesterfields'),
  vecin(Casa1, Casa2, Strada),
  animal(Casa2, vulpe).

% 12. Kools are smoked in the house next to the house where
% the horse is kept.
stmt12(Strada) :-
  tigari(Casa1, 'Kools'),
  vecin(Casa1, Casa2, Strada),
  animal(Casa2, cal).

% 13. The Lucky Strike smoker drinks orange juice.
stmt13(Strada) :-
  casa_pe_strada(Casa, Strada),
  tigari(Casa, 'Lucky Strike'),
  bautura(Casa, 'suc de portocoale').

% 14. The Japanese smokes Parliaments.
stmt14(Strada) :-
  casa_pe_strada(Casa, Strada),
  nationalitate(Casa, japonez),
  tigari(Casa, 'Parliaments').

% 15. The Norwegian lives next to the blue house.
stmt15(Strada) :-
  nationalitate(Casa1, norvegian),
  vecin(Casa1, Casa2, Strada),
  culoare(Casa2, albastra).

premize(Strada) :-
  stmt1(Strada),
  stmt2(Strada),
  stmt3(Strada),
  stmt4(Strada),
  stmt5(Strada),
  stmt6(Strada),
  stmt7(Strada),
  stmt8(Strada),
  stmt9(Strada),
  stmt10(Strada),
  stmt11(Strada),
  stmt12(Strada),
  stmt13(Strada),
  stmt14(Strada),
  stmt15(Strada).

cerinta1(Strada, BautorApa) :-
  casa_pe_strada(Casa, Strada),
  nationalitate(Casa, BautorApa),
  bautura(Casa, apa).

cerinta2(Strada, PosesorZebra) :-
  casa_pe_strada(Casa, Strada),
  nationalitate(Casa, PosesorZebra),
  animal(Casa, zebra).

problema(Strada, BautorApa, PosesorZebra) :-
  premize(Strada),
  cerinta1(Strada, BautorApa),
  cerinta2(Strada, PosesorZebra).

% In the interest of clarity, it must be added that each of the five houses
% is painted a different color,
% and their inhabitants are of different national extractions,
% own different pets,
% drink different beverages
% and smoke different brands of American cigarets
%
% casa(_Culoare, _Nationalitate, _Animal, _Bautura, _Tigari).

% Definim functii de proiectie:
culoare(
  casa( Culoare, _Nationalitate, _Animal, _Bautura, _Tigari), Culoare).
nationalitate(
  casa(_Culoare,  Nationalitate, _Animal, _Bautura, _Tigari), Nationalitate).
animal(
  casa(_Culoare, _Nationalitate,  Animal, _Bautura, _Tigari), Animal).
bautura(
  casa(_Culoare, _Nationalitate, _Animal,  Bautura, _Tigari), Bautura).
tigari(
  casa(_Culoare, _Nationalitate, _Animal, _Bautura,  Tigari), Tigari).

casa_pe_strada(Casa, cons(Casa, _)).   % e fie prima casă
casa_pe_strada(Casa, cons(_, Case)) :- % fie una din celelalte
  casa_pe_strada(Casa, Case).

prima_casa(Casa, cons(Casa, _)).

case_alaturate(Stanga, Dreapta, cons(Stanga, cons(Dreapta,  _))). % sunt fie pimele două case
case_alaturate(Stanga, Dreapta, cons(_, Case)) :-                 % fie unele alăturate dintre celelalte
  case_alaturate(Stanga, Dreapta, Case).

vecin(Casa1, Casa2, Strada) :-
  case_alaturate(Casa1, Casa2, Strada).
vecin(Casa1, Casa2, Strada) :-
  case_alaturate(Casa2, Casa1, Strada).

casa_din_mijloc(Casa, cons(Casa, nil)).             % o casă singură e cea din mijloc
casa_din_mijloc(Casa, cons(_, cons(Y, T))) :-       % altfel dacă eliminăm prima casă
  elimină_ultima(cons(Y, T), L),                    % și o eliminăm și pe ultima
  casa_din_mijloc(Casa, L).                         % e casa din mijloc dintre cele rămase

elimină_ultima(cons(_, nil), nil).                   % dacă e o casă și o eliminăm, rămâne lista vidă
elimină_ultima(cons(X, cons(Y, T)), cons(X, L)) :-   % altfel, rezultatul e prima clasă urmată de
  elimină_ultima(cons(Y, T), L).                     % casele obținute prin eliminarea ultimei case din restul.

/** <examples>

?- problema(Strada, BautorApa, PosesorZebra).
*/
