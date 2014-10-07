abstract Grammar = {

cat SimpleNoun; 
    NounPhrase;
    Verb;
    Verb2; 
    Verb3;
    Verb2Verb;
    VerbPhrase; 
    PP ; 
    Preposition ;
    Pronoun ;
    S ;

fun

  --Originally from Duck
  VtoVP   : Verb -> VerbPhrase ;
  V2toVP  : Verb2 -> NounPhrase -> VerbPhrase ;
  V2VtoVP : Verb2Verb -> NounPhrase -> Verb -> VerbPhrase ;
  V3toVP  : Verb3 -> NounPhrase -> NounPhrase -> VerbPhrase ;
  PredVP  : NounPhrase -> VerbPhrase -> S ;

  --Originally from WithTelescope
  DetNP  : SimpleNoun -> NounPhrase ;
  MassNP : SimpleNoun -> NounPhrase ;
  PronNP : Pronoun -> NounPhrase ;

  -- PrepVP : VerbPhrase -> PP -> VerbPhrase ;
  -- SimpVP : Verb2 -> NounPhrase -> VerbPhrase ;

}