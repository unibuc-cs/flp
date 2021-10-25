:-include("imp.pl").


 test0 :- program(
  { x = 10 ; sum = 0; while(0 =< x, {
                                      sum = sum + x;
                                      x = x + (-1)})
                        
  },
 sum).
