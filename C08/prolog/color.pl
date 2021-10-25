%% Demo coming from https://bernardopires.com/2013/10/try-logic-programming-a-gentle-introduction-to-prolog/
%%


mx(X,Y,Z) :- (X =< Y) -> Z = Y ;  Z = X.

culoare(albastru).
culoare(rosu).
culoare(verde).
culoare(galben).

harta(RO,YU,MD,UA, BG, HU) :- vecin(RO,YU), vecin(RO,UA), vecin(RO,MD), vecin(RO,BG), vecin(RO,HU),
vecin(UA,MD),vecin(BG, YU), vecin(YU,HU) .

vecin(X,Y) :- culoare(X), culoare(Y), X \== Y.  


/* ?- harta(RO,YU,MD,UA, BG, HU).  */