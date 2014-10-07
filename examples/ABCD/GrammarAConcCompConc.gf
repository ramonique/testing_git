concrete GrammarAConcCompConc of GrammarAConcComp =
{

lincat C0 , C1 , C2 = { indep : Str ; attr : Str } ;

lin aA_8_0_ = { indep = "aA" ; attr = "aA" } ;
lin the_A_1_10_0 i = { indep = "the_A_1" ++ i.s ; attr = "(" ++ "the_A_1" ++ i.s ++ ")" } ;
lin aB_9_1_ = { indep = "aB" ; attr = "aB" } ;
lin the_B_1_11_1 i = { indep = "the_B_1" ++ i.s ; attr = "(" ++ "the_B_1" ++ i.s ++ ")" } ;
lin AtoS_6_2_0 p1 = { indep = "AtoS" ++p1.attr ; attr = "(" ++ "AtoS" ++p1.attr ++ ")" } ;
lin BtoS_7_2_1 p1 = { indep = "BtoS" ++p1.attr ; attr = "(" ++ "BtoS" ++p1.attr ++ ")" } ;
lin the_S_1_12_2 i = { indep = "the_S_1" ++ i.s ; attr = "(" ++ "the_S_1" ++ i.s ++ ")" } ;


}
