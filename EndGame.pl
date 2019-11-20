:-  include('KB.pl').

/*IronMan*/

/*Left if it isn't a Thanos Cell */
ironman(X,Y,result(left,S)):-
    ironman(X,NY,S),
    NY>0,
    Y is ( NY-1),
    \+thanos(X,Y,S).
/*Left if it is a thanos cell .. all stones must be collected*/
ironman(X,Y,result(left,S)):-
    ironman(X,NY,S),
    NY>0,
    Y is ( NY-1),
    all_stones_collected(S),
    thanos(X,Y,S).
    

/*Right*/
ironman(X,Y,result(right,S)):-
    ironman(X,NY,S),
    limits(_,W),
    MaxHeight is W-1,
    NY < MaxHeight,
    Y is ( NY+1),
    \+thanos(X,Y,S).
ironman(X,Y,result(right,S)):-
    ironman(X,NY,S),
    limits(_,W),
    MaxHeight is W-1,
    NY < MaxHeight,
    Y is ( NY+1),
    all_stones_collected(S),
    thanos(X,Y,S).
    
    
/*up*/
ironman(X,Y,result(up,S)):-
    ironman(NX,Y,S),
    NX>0,
    X is ( NX-1),
    \+thanos(X,Y,S).
ironman(X,Y,result(up,S)):-
    ironman(NX,Y,S),
    NX>0,
    X is ( NX-1),
    all_stones_collected(S),
    thanos(X,Y,S).





/*down*/
ironman(X,Y,result(down,S)):-
    ironman(NX,Y,S),
    limits(W,_),
    MaxWidth is W-1,
    NX < MaxWidth,
    X is ( NX+1),
    \+thanos(X,Y,S).
ironman(X,Y,result(down,S)):-
    ironman(NX,Y,S),
    limits(W,_),
    MaxWidth is W-1,
    NX < MaxWidth,
    X is ( NX+1),
    all_stones_collected(S),
    thanos(X,Y,S).


 /*the query used to check the goal state . snap if all stones collected and Thanos in same cell*/
ironman(X,Y,result(snap,S)):-
    all_stones_collected(S),
     ironman(X,Y,S),
     thanos(X,Y,S).


 /*effect of collect on ironman*/

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

/*Change stone state*/
stone(X,Y,result(A,S)):-
    stone(X,Y,S),
    (
    A = up;
    A = down;
    A = right;
    A= left
    ).
/*pesistance state for collect*/
stone(X,Y,result(collect,S)):-
    stone(X,Y,S),
    \+ ironman(X,Y,S).

/*predicates to collect a stone*/
stone_collected(X,Y,result(collect,S)):-
    stone(X,Y,S),
    ironman(X,Y,S).
/*persistence of a collected stone*/

stone_collected(X,Y,result(A,S)):-
   stone_collected(X,Y,S),
    (
    A = up;
    A = down;
    A = right;
    A = left;
    A = collect
    ).


/*check if all stones are collected*/
all_stones_collected(S):-
 foreach(stone(X,Y,s0),stone_collected(X,Y,S)).
 
/*persistance if all stones are collected*/
all_stones_collected(result(A,S)):-
   all_stones_collected(S),
    (
    A = up;
    A = down;
    A = right;
    A = left
    ).

 



dfs_snapped(result(snap,S)):-
     ironman(_,_,result(snap,S)).


/*check if ironman snapped but using Depth limited search*/
depth_snapped(result(snap,S),N,LENGTH):-
    (
    call_with_depth_limit(dfs_snapped(result(snap,S)),N,LENGTH),
    \+ LENGTH = depth_limit_exceeded
    );
    (
    N1 is N+1,
    depth_snapped(result(snap,S),N1,LENGTH)
    ).

/*Start querying from depth 0*/
ids_snapped(S):-
    depth_snapped(S,0,_).
    







