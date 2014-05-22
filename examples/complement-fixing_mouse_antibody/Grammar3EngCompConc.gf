concrete Grammar3EngCompConc of Grammar3EngComp =
{

lincat C0 , C1 , C2 , C3 = { indep : Str ; attr : Str } ;

lin GerundNP_12_0_1_3 p1 p2 = { indep = "GerundNP" ++p1.attr ++p2.attr ; attr = "(" ++ "GerundNP" ++p1.attr ++p2.attr ++ ")" } ;
lin Monoclonal_14_0_ = { indep = "Monoclonal" ; attr = "Monoclonal" } ;
lin the_Adjective_1_17_0 i = { indep = "the_Adjective_1" ++ i.s ; attr = "(" ++ "the_Adjective_1" ++ i.s ++ ")" } ;
lin Appos_9_1_1_1 p1 p2 = { indep = "Appos" ++p1.attr ++p2.attr ; attr = "(" ++ "Appos" ++p1.attr ++p2.attr ++ ")" } ;
lin Mod_13_1_0_1 p1 p2 = { indep = "Mod" ++p1.attr ++p2.attr ; attr = "(" ++ "Mod" ++p1.attr ++p2.attr ++ ")" } ;
lin SimpCN_16_1_2 p1 = { indep = "SimpCN" ++p1.attr ; attr = "(" ++ "SimpCN" ++p1.attr ++ ")" } ;
lin the_NounPhrase_1_18_1 i = { indep = "the_NounPhrase_1" ++ i.s ; attr = "(" ++ "the_NounPhrase_1" ++ i.s ++ ")" } ;
lin Antibody_8_2_ = { indep = "Antibody" ; attr = "Antibody" } ;
lin Complement_10_2_ = { indep = "Complement" ; attr = "Complement" } ;
lin Mouse_15_2_ = { indep = "Mouse" ; attr = "Mouse" } ;
lin the_SimpleNoun_1_19_2 i = { indep = "the_SimpleNoun_1" ++ i.s ; attr = "(" ++ "the_SimpleNoun_1" ++ i.s ++ ")" } ;
lin Fix_11_3_ = { indep = "Fix" ; attr = "Fix" } ;
lin the_Verb_1_20_3 i = { indep = "the_Verb_1" ++ i.s ; attr = "(" ++ "the_Verb_1" ++ i.s ++ ")" } ;


}