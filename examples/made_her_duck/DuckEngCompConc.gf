concrete DuckEngCompConc of DuckEngComp =
{

lincat C0 , C1 , C2 , C3 , C4 , C5 , C6 , C7 , C8 , C9 , C10 , C11 , C12 , C13 , C14 , C15 , C16 , C17 , C18 = { indep : Str ; attr : Str } ;

lin PossNP_15_0_0_0 p1 p2 = { indep = "PossNP" ++p1.attr ++p2.attr ; attr = "(" ++ "PossNP" ++p1.attr ++p2.attr ++ ")" } ;
lin duck_N_32_0_ = { indep = "duck_N" ; attr = "duck_N" } ;
lin she_Pron_37_0_ = { indep = "she_Pron" ; attr = "she_Pron" } ;
lin the_NP_1_38_0 i = { indep = "the_NP_1" ++ i.s ; attr = "(" ++ "the_NP_1" ++ i.s ++ ")" } ;
lin MkS_14_1_0_18 p1 p2 = { indep = "MkS" ++p1.attr ++p2.attr ; attr = "(" ++ "MkS" ++p1.attr ++p2.attr ++ ")" } ;
lin the_S_1_39_1 i = { indep = "the_S_1" ++ i.s ; attr = "(" ++ "the_S_1" ++ i.s ++ ")" } ;
lin duck_V_33_2_ = { indep = "duck_V" ; attr = "duck_V" } ;
lin the_V_1_40_2 i = { indep = "the_V_1" ++ i.s ; attr = "(" ++ "the_V_1" ++ i.s ++ ")" } ;
lin make_V2_34_4_ = { indep = "make_V2" ; attr = "make_V2" } ;
lin the_V2_1_41_4 i = { indep = "the_V2_1" ++ i.s ; attr = "(" ++ "the_V2_1" ++ i.s ++ ")" } ;
lin make_causative_V2V_36_7_ = { indep = "make_causative_V2V" ; attr = "make_causative_V2V" } ;
lin the_V2V_1_42_7 i = { indep = "the_V2V_1" ++ i.s ; attr = "(" ++ "the_V2V_1" ++ i.s ++ ")" } ;
lin make_benefactive_V3_35_13_ = { indep = "make_benefactive_V3" ; attr = "make_benefactive_V3" } ;
lin the_V3_1_43_13 i = { indep = "the_V3_1" ++ i.s ; attr = "(" ++ "the_V3_1" ++ i.s ++ ")" } ;
lin V2VtoVP_16_18_6_0_2 p1 p2 p3 = { indep = "V2VtoVP" ++p1.attr ++p2.attr ++p3.attr ; attr = "(" ++ "V2VtoVP" ++p1.attr ++p2.attr ++p3.attr ++ ")" } ;
lin V2VtoVP_17_18_7_0_2 p1 p2 p3 = { indep = "V2VtoVP" ++p1.attr ++p2.attr ++p3.attr ; attr = "(" ++ "V2VtoVP" ++p1.attr ++p2.attr ++p3.attr ++ ")" } ;
lin V2VtoVP_18_18_8_0_2 p1 p2 p3 = { indep = "V2VtoVP" ++p1.attr ++p2.attr ++p3.attr ; attr = "(" ++ "V2VtoVP" ++p1.attr ++p2.attr ++p3.attr ++ ")" } ;
lin V2toVP_19_18_3_0 p1 p2 = { indep = "V2toVP" ++p1.attr ++p2.attr ; attr = "(" ++ "V2toVP" ++p1.attr ++p2.attr ++ ")" } ;
lin V2toVP_20_18_4_0 p1 p2 = { indep = "V2toVP" ++p1.attr ++p2.attr ; attr = "(" ++ "V2toVP" ++p1.attr ++p2.attr ++ ")" } ;
lin V2toVP_21_18_5_0 p1 p2 = { indep = "V2toVP" ++p1.attr ++p2.attr ; attr = "(" ++ "V2toVP" ++p1.attr ++p2.attr ++ ")" } ;
lin V3toVP_22_18_9_0_0 p1 p2 p3 = { indep = "V3toVP" ++p1.attr ++p2.attr ++p3.attr ; attr = "(" ++ "V3toVP" ++p1.attr ++p2.attr ++p3.attr ++ ")" } ;
lin V3toVP_23_18_10_0_0 p1 p2 p3 = { indep = "V3toVP" ++p1.attr ++p2.attr ++p3.attr ; attr = "(" ++ "V3toVP" ++p1.attr ++p2.attr ++p3.attr ++ ")" } ;
lin V3toVP_24_18_11_0_0 p1 p2 p3 = { indep = "V3toVP" ++p1.attr ++p2.attr ++p3.attr ; attr = "(" ++ "V3toVP" ++p1.attr ++p2.attr ++p3.attr ++ ")" } ;
lin V3toVP_25_18_12_0_0 p1 p2 p3 = { indep = "V3toVP" ++p1.attr ++p2.attr ++p3.attr ; attr = "(" ++ "V3toVP" ++p1.attr ++p2.attr ++p3.attr ++ ")" } ;
lin V3toVP_26_18_13_0_0 p1 p2 p3 = { indep = "V3toVP" ++p1.attr ++p2.attr ++p3.attr ; attr = "(" ++ "V3toVP" ++p1.attr ++p2.attr ++p3.attr ++ ")" } ;
lin V3toVP_27_18_14_0_0 p1 p2 p3 = { indep = "V3toVP" ++p1.attr ++p2.attr ++p3.attr ; attr = "(" ++ "V3toVP" ++p1.attr ++p2.attr ++p3.attr ++ ")" } ;
lin V3toVP_28_18_15_0_0 p1 p2 p3 = { indep = "V3toVP" ++p1.attr ++p2.attr ++p3.attr ; attr = "(" ++ "V3toVP" ++p1.attr ++p2.attr ++p3.attr ++ ")" } ;
lin V3toVP_29_18_16_0_0 p1 p2 p3 = { indep = "V3toVP" ++p1.attr ++p2.attr ++p3.attr ; attr = "(" ++ "V3toVP" ++p1.attr ++p2.attr ++p3.attr ++ ")" } ;
lin V3toVP_30_18_17_0_0 p1 p2 p3 = { indep = "V3toVP" ++p1.attr ++p2.attr ++p3.attr ; attr = "(" ++ "V3toVP" ++p1.attr ++p2.attr ++p3.attr ++ ")" } ;
lin VtoVP_31_18_2 p1 = { indep = "VtoVP" ++p1.attr ; attr = "(" ++ "VtoVP" ++p1.attr ++ ")" } ;
lin the_VP_1_44_18 i = { indep = "the_VP_1" ++ i.s ; attr = "(" ++ "the_VP_1" ++ i.s ++ ")" } ;


}