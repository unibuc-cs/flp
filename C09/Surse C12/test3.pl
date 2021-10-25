:-include("imp.pl").


 
test3:-program(
  {x0 = 0 ;  while( x0 =< 2, {x0=x0+1;
   x1 = 0 ;  while( x1 =< 2, {x1=x1+1;
   x2 = 0 ;  while( x2 =< 2,  {x2=x2+1;
   x3 = 0 ;  while( x3 =< 2,  x3=x3+1)}
  )}
  )}
  )},
  0
).






