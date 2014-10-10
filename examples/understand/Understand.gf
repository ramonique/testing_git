abstract Understand = {

  flags startcat = S ;

  cat S ; V ; V2 ; N ; NP ; VP ;

  fun 
    Pred : NP -> VP -> S ;
    IntransVP : V -> VP ;
    TransVP : V2 -> NP -> VP ;
    understand_V : V ;
    get_V2 : V2 ;
    reason_N : NP ;
    dog_N : NP ;
}