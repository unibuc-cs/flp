:-include("imp.pl").


 

test1:- program(
  {nr = 0; while( nr =< 10, nr=nr+1)},
  nr).


