:-  include('KB.pl').

/*IronMan*/

/*Up */
ironman(X,Y,result(left,S)):-
    ironman(X,NY,S),
    NY>0,
    Y is ( NY-1).
    

/*Down*/
ironman(X,Y,result(right,S)):-
    ironman(X,NY,S),
    limits(_,W),
    MaxHeight is W-1,
    NY < MaxHeight,
    Y is ( NY+1).
    
    
/*Left*/
ironman(X,Y,result(up,S)):-
    ironman(NX,Y,S),
    NX>0,
    X is ( NX-1).



/*Right*/
ironman(X,Y,result(down,S)):-
    ironman(NX,Y,S),
    limits(W,_),
    MaxWidth is W-1,
    NX < MaxWidth,
    X is ( NX+1).



ironman(X,Y,result(snap,S)):-
    all_stones_collected(S),
     ironman(X,Y,S),
     thanos(X,Y,S).




/*collect*/
ironman(X,Y,result(collect,S)):-
    ironman(X,Y,S),

    stone(X,Y,S).

/*thanos*/

thanos(X,Y,result(A,S)):-
  thanos(X,Y,S),
    (
    A = up;
    A = down;
    A = right;
    A = left;
    A = collect
    ).


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
    A = left
    ).



all_stones_collected(S):-
 foreach(stone(X,Y,s),stone_collected(X,Y,S)).
 
 
all_stones_collected(result(A,S)):-
   all_stones_collected(S),
    (
    A = up;
    A = down;
    A = right;
    A = left
    ).

 



query(S):-
    ironman(_,_,S).
    /*S = result(snap,_). */



query_with_depth(result(snap,S),N,L):-
    (
    call_with_depth_limit(ironman(_,_,result(snap,S)),N,L),
    \+ L = depth_limit_exceeded
    );
    (
    F is N+1,
    query_with_depth(result(snap,S),F,L)
    ).
start(S):-
    query_with_depth(S,0,_).
    







