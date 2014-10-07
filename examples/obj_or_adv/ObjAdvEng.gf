--# -path=.:../sharedgrammar
concrete ObjAdvEng of ObjAdv = SharedGrammarEng ** open Prelude in {

  lin
    part_Prep = ss "of" ;
    behind_Prep = ss "behind" ;
    from7behind_Prep = ss "from behind" ;

    taka_N = mkN "taka" "taka" "taka's" ; --Bangladeshi currency
    tree_N = mkN "tree" "tree" "tree's" ;

    come_V = mkV "comes" ;

    PossNP  np   n  = {s = \\c => np.s ! Poss ++ n.s ! c} ;
    BasicPP prep np = ss (prep.s ++ np.s ! Subj) ;
    PrepVP = cc2 ;

} 