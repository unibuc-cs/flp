% ⒈ At least one of them is guilty
stmt1(Suspects) :-
  is_guilty(_, Suspects).

% ⒉ if Chase is guilty and Heath is innocent, then Decker is guilty.
stmt2(Suspects) :-
  is_guilty('Chase', Suspects),
  is_innocent('Heath', Suspects)
  -> is_guilty('Decker', Suspects); true.

% ⒊ if Chase is innocent, then Mullaney is innocent.
stmt3(Suspects) :-
  is_innocent('Chase', Suspects)
  -> is_innocent('Mullaney', Suspects); true.

% ⒋ if Heath is guilty, then Mullaney is guilty.
stmt4(Suspects) :-
  is_guilty('Heath', Suspects)
  -> is_guilty('Mullaney', Suspects); true.

% ⒌ Chase and Heath are not both guilty.
stmt5(Suspects) :-
  is_guilty('Chase', Suspects),
  is_guilty('Heath', Suspects)
  -> fail; true.

% ⒍ Unless Heath is guilty, Decker is innocent.
stmt6(Suspects) :-
  is_guilty('Heath', Suspects)
  -> true; is_innocent('Decker', Suspects).

suspects([
    suspect('Chase', _),
    suspect('Decker', _),
    suspect('Ellis', _),
    suspect('Heath', _),
    suspect('Mullaney', _)]).

problem(Suspects) :-
  suspects(Suspects),
  all_have_verdict(Suspects),
  stmt1(Suspects),
  stmt2(Suspects),
  stmt3(Suspects),
  stmt4(Suspects),
  stmt5(Suspects),
  stmt6(Suspects).


is_guilty(Name, Suspects) :-
  member(suspect(Name, guilty), Suspects).

is_innocent(Name, Suspects) :-
  member(suspect(Name, innocent), Suspects).

all_have_verdict([suspect(_, Verdict) | Suspects]) :-
  (Verdict = guilty ; Verdict = innocent),
  all_have_verdict(Suspects).
all_have_verdict([]).
