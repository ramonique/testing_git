--# -path=.:../sharedgrammar
abstract Hus = SharedGrammar - [DetNP] ** {
flags startcat = S ;
cat
  Comp ;
  Det ;

fun
  CompS : NounPhrase -> Comp -> S ;
  DetNP : Det -> SimpleNoun -> NounPhrase ;

  Jag : NounPhrase ;
  Hus : SimpleNoun ;
  Bra : Comp ;
  Gilla : Verb2 ;
  Ett : Det ;
  De  : Det ;
  

}
-- hus är bra
-- jag gillar hus