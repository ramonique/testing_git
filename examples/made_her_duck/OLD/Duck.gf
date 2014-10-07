abstract Duck = {

flags startcat = S ;

cat
  NP ; 
  V ;
  V2 ; 
  V2V ; 
  V3 ;
  VP ;
  S ;

fun
  she_Pron : NP ;
  duck_N   : NP ;
  
  duck_V  : V ;
  make_V2 : V2 ;
  make_causative_V2V : V2V ;
  make_benefactive_V3 : V3 ;

  PossNP : NP -> NP -> NP ;
  VtoVP  : V -> VP ;
  V2toVP : V2 -> NP -> VP ;
  V2VtoVP : V2V -> NP -> V -> VP ;
  V3toVP : V3 -> NP -> NP -> VP ;
  MkS : NP -> VP -> S ;
}