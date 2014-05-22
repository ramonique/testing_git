concrete WildSweCompConc of WildSweComp =
{

lincat C0 , C1 , C2 , C3 , C4 , C5 = { indep : Str ; attr : Str } ;

lin wild_A_15_0_ = { indep = "wild_A" ; attr = "wild_A" } ;
lin the_A_1_16_0 i = { indep = "the_A_1" ++ i.s ; attr = "(" ++ "the_A_1" ++ i.s ++ ")" } ;
lin CompA_8_1_0 p1 = { indep = "CompA" ++p1.attr ; attr = "(" ++ "CompA" ++p1.attr ++ ")" } ;
lin CompN_9_1_5 p1 = { indep = "CompN" ++p1.attr ; attr = "(" ++ "CompN" ++p1.attr ++ ")" } ;
lin the_Comp_1_17_1 i = { indep = "the_Comp_1" ++ i.s ; attr = "(" ++ "the_Comp_1" ++ i.s ++ ")" } ;
lin child_N_12_2_ = { indep = "child_N" ; attr = "child_N" } ;
lin game_N_14_2_ = { indep = "game_N" ; attr = "game_N" } ;
lin the_N_1_18_2 i = { indep = "the_N_1" ++ i.s ; attr = "(" ++ "the_N_1" ++ i.s ++ ")" } ;
lin dog_N_13_3_ = { indep = "dog_N" ; attr = "dog_N" } ;
lin the_N_2_19_3 i = { indep = "the_N_2" ++ i.s ; attr = "(" ++ "the_N_2" ++ i.s ++ ")" } ;
lin Pred_10_4_2_1 p1 p2 = { indep = "Pred" ++p1.attr ++p2.attr ; attr = "(" ++ "Pred" ++p1.attr ++p2.attr ++ ")" } ;
lin Pred_11_4_3_1 p1 p2 = { indep = "Pred" ++p1.attr ++p2.attr ; attr = "(" ++ "Pred" ++p1.attr ++p2.attr ++ ")" } ;
lin the_S_1_20_4 i = { indep = "the_S_1" ++ i.s ; attr = "(" ++ "the_S_1" ++ i.s ++ ")" } ;
lin _2_5 n = n ;
lin _3_5 n = n ;


}