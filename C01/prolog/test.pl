foo(a).
foo(b).
foo(c).
foo(d).

'is foo'(X) :- foo(X).

%fara false la sfarsit
%bar(b).
%bar(c).
%baz(c).


%false la sfarsit
bar(c).
bar(b).
baz(c).



p(X) :- bar(X), baz(X).




/** <examples>

?- p(X).

*/

