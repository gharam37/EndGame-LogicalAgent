:-  include('KB.pl').

/*IronMan*/

/*Up */
ironman(X,Y,result(up,S)):-
    ironman(X,NY,S),
    NY>0,
    Y is ( NY-1),
    \+ thanos(X,Y,_).
    
/*Down*/
ironman(X,Y,result(down,S)):-
    ironman(X,NY,S),
    limits(_,W),
    MaxHeight is W-1,
    NY < MaxHeight,
    Y is ( NY+1),
    \+ thanos(X,Y,_).
    
/*Left*/
ironman(X,Y,result(left,S)):-
    ironman(NX,Y,S),
    NX>0,
    X is ( NX-1),
    \+ thanos(X,Y,_).

/*Right*/
ironman(X,Y,result(right,S)):-
    ironman(NX,Y,S),
    limits(W,_),
    MaxWidth is W-1,
    NX < MaxWidth,
    X is ( NX+1),
    \+ thanos(X,Y,_).

/*collect*/
ironman(X,Y,result(collect,S)):-
    ironman(X,Y,S),
    stone(X,Y,S).



/*stones*/

stone(X,Y,result(A,S)):-
    stone(X,Y,S),
    (
    A = up;
    A = down;
    A = right;
    A= left
    ).
    
stone(X,Y,result(collect,S)):-
    stone(X,Y,S),
    \+ ironman(X,Y,S).
stone_collected(X,Y,result(collect,S)):-
    stone(X,Y,S),
    ironman(X,Y,S).

stone_collected(X,Y,result(A,S)):-
   stone_collected(X,Y,S),
    (
    A = up;
    A = down;
    A = right;
    A = left;
    A = collect
    ).





query(S):-
       foreach(stone(X,Y,s),stone_collected(X,Y,S)).



query_with_depth(S,N,L):-
    (
    call_with_depth_limit(query(S),N,L),
    \+ L = depth_limit_exceeded
    );
    (
    F is N+1,
    query_with_depth(S,F,L)
    ).
start(S):-
    query_with_depth(S,0,_).
    







