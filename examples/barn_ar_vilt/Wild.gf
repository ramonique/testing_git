abstract Wild = {

  flags startcat = S ;

  cat S ; N ; A ; Comp ;

  fun 
    Pred : N -> Comp -> S ;
    CompA : A -> Comp ;
    CompN : N -> Comp ;
    game_N : N ;
    child_N : N ;
    dog_N : N ;
    wild_A : A ;
}