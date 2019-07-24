t([num2], []).
t([num3], []).
t([num1], [[num3]]).
t([int],  [[num2],[num1]]).

t([seq,_], []).
t([veq,A], [[seq,A]]).
t([list2,_], []).
t([list,A], [[list2,A],[veq,A]]).

ext_list([], _) :- false.
ext_list([L|LL], Y) :-
    ext(L, Y);
    ext_list(LL, Y).
ext([X], Y) :- t([X],_),[X]=Y.
ext([X|XX], Y) :-
    t([X|_],_),Y=[X|Z],ext(XX,Z);
    t([X|XX], L),ext_list(L, Y).

eval([], D, Y) :- D=Y.
eval([P|PP], [D|DD], Y) :- ext([P],A),A=[D],eval(PP, DD, Y).

main(X) :-
    E = _{t:sum, p:[num3, num3] , w:_{sum: [num3, num3, num3]}},
    T = E.get(t),
    P = E.get(p),
    D = E.get(w).get(T),
    eval(P, D, X).
