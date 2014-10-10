--# -path=.:../sharedgrammar
abstract ObjAdv = SharedGrammar ** {

  -- Ambiguity in Finnish but not in English
  -- Problem: part_Prep doesn't have a string linearisation in Finnish,
  -- it just affects the case of the dependent noun.
  -- from7behind_Prep has a string and it affects the case of the dependent noun.
  -- Result: these trees are ambiguous
  --  a) BasicPP from7behind_Prep (the_NounPhrase_1 0)
  --  b) BasicPP part_Prep (PossNP (the_NounPhrase_1 0) taka_N)
  -- in context : PrepVP ( VtoVP ( the_Verb_1 0 ) ) ['*'] ) 
  -- Number of ambiguities as of 14/10/10: 19


  -- This grammar only has intransitive verbs.
  -- Adding transitive verbs adds another ambiguity: the "the_NounPhrase takaa"
  -- can be parsed as a PP, or it can be parsed as a NounPhrase in an object case.



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