concrete GrammarASConcCompConc of GrammarASConcComp =
{

lincat C0 , C1 = { indep : Str ; attr : Str } ;

lin a1_4_0_ = { indep = "a1" ; attr = "a1" } ;
lin a2_5_0_ = { indep = "a2" ; attr = "a2" } ;
lin the_A_1_8_0 i = { indep = "the_A_1" ++ i.s ; attr = "(" ++ "the_A_1" ++ i.s ++ ")" } ;
lin s1_6_1_0_1 p1 p2 = { indep = "s1" ++p1.attr ++p2.attr ; attr = "(" ++ "s1" ++p1.attr ++p2.attr ++ ")" } ;
lin s2_7_1_ = { indep = "s2" ; attr = "s2" } ;
lin the_S_1_9_1 i = { indep = "the_S_1" ++ i.s ; attr = "(" ++ "the_S_1" ++ i.s ++ ")" } ;


}
