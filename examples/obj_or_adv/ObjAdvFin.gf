--# -path=.:../sharedgrammar
concrete ObjAdvFin of ObjAdv = SharedGrammarFin ** open Prelude in {

  lin
    part_Prep = mkPrep Part "" ;
    behind_Prep = mkPrep Gen "takana" ;
    from7behind_Prep = mkPrep Gen "takaa" ;

    taka_N = mkN "taka" "takan" "takaa" ; --Bangladeshi currency
    tree_N = mkN "puu" "puun" "puuta" ;

    come_V = mkV "tulee" ;

    PossNP  np   n = {s = \\c => np.s ! Gen ++ n.s ! c} ;
    BasicPP prep np = ss (np.s ! prep.c ++ prep.s) ;
    PrepVP = cc2 ;

} 