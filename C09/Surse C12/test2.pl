:-include("imp.pl").


 



%conjectura lui Collatz
test2:- program(
 {nr = 10 ;
   while(not(nr =< 2),
	 (n = nr ;
	  (nr = nr - 1 ;
     while(not(n == 1),
	   (steps = steps + 1 ;
	    (r = n ;
	     (q =  0 ;
      ((while(not(r =< 1),
	      (r = r - 2 ;
         q = q + 1
	       ))) ;
       (if(r == 0,
         n = q,
         n = (3 * n) + 1)
       )
      ))))
    )
   )))},
   steps).





