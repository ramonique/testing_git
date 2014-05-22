concrete Grammar6ConcCompConc of Grammar6ConcComp =
{

lincat C0 , C1 , C2 , C3 , C4 = { indep : Str ; attr : Str } ;

lin simpA_12_0_ = { indep = "simpA" ; attr = "simpA" } ;
lin the_A_1_16_0 i = { indep = "the_A_1" ++ i.s ; attr = "(" ++ "the_A_1" ++ i.s ++ ")" } ;
lin simpB_13_1_ = { indep = "simpB" ; attr = "simpB" } ;
lin the_B_1_17_1 i = { indep = "the_B_1" ++ i.s ; attr = "(" ++ "the_B_1" ++ i.s ++ ")" } ;
lin simpC_14_2_ = { indep = "simpC" ; attr = "simpC" } ;
lin the_C_1_18_2 i = { indep = "the_C_1" ++ i.s ; attr = "(" ++ "the_C_1" ++ i.s ++ ")" } ;
lin simpD_15_3_ = { indep = "simpD" ; attr = "simpD" } ;
lin the_D_1_19_3 i = { indep = "the_D_1" ++ i.s ; attr = "(" ++ "the_D_1" ++ i.s ++ ")" } ;
lin s1_10_4_0_1_2 p1 p2 p3 = { indep = "s1" ++p1.attr ++p2.attr ++p3.attr ; attr = "(" ++ "s1" ++p1.attr ++p2.attr ++p3.attr ++ ")" } ;
lin s2_11_4_3_3 p1 p2 = { indep = "s2" ++p1.attr ++p2.attr ; attr = "(" ++ "s2" ++p1.attr ++p2.attr ++ ")" } ;
lin the_S_1_20_4 i = { indep = "the_S_1" ++ i.s ; attr = "(" ++ "the_S_1" ++ i.s ++ ")" } ;


}