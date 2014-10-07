--# -path=.:../sharedgrammar
abstract ObjAdv = SharedGrammar ** {

  fun
    part_Prep : Preposition ;
    behind_Prep : Preposition ;
    from7behind_Prep : Preposition ;

    taka_N : SimpleNoun ; --Bangladeshi currency
    tree_N : SimpleNoun ;

    come_V : Verb ;


    PossNP  : NounPhrase -> SimpleNoun -> NounPhrase ;
    BasicPP : Preposition -> NounPhrase -> PP ;
    PrepVP  : VerbPhrase -> PP -> VerbPhrase ;



} 