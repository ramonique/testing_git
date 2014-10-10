--# -path=.:../sharedgrammar
abstract Duck = SharedGrammar ** {

flags startcat = S ;

fun
  she_Pron : NounPhrase ;
  duck_N   : SimpleNoun ;
  
  duck_V  : Verb ;
  make_V2 : Verb2 ;
  make_causative_V2V : Verb2Verb ;
  make_benefactive_V3 : Verb3 ;

  PossNP  : NounPhrase -> SimpleNoun -> NounPhrase ; --to allow (NP her duck)
  MassNP : SimpleNoun -> NounPhrase ;  -- to allow (VP make her (NP duck))

}