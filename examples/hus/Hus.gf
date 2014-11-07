--# -path=.:../sharedgrammar
abstract Hus = SharedGrammar ** {
flags startcat = S ;
cat
  NumNoun ; Comp ;

fun
  CompS : NumNoun -> Comp -> S ;
  MkS : NumNoun -> Verb2 -> NumNoun -> S ;


  Hus : SimpleNoun ;
  Bra : Comp ;
  Gilla : Verb2 ;

  Singular : SimpleNoun -> NumNoun ;
  Plural : SimpleNoun -> NumNoun ;

}
-- hus är bra
-- jag gillar hus