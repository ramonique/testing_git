concrete Grammar4EngCompConc of Grammar4EngComp =
{

lincat C0 , C1 , C2 , C3 , C4 = { indep : Str ; attr : Str } ;

lin Delicious_8_0_ = { indep = "Delicious" ; attr = "Delicious" } ;
lin the_Adjective_1_15_0 i = { indep = "the_Adjective_1" ++ i.s ; attr = "(" ++ "the_Adjective_1" ++ i.s ++ ")" } ;
lin NounSg_11_1_4 p1 = { indep = "NounSg" ++p1.attr ; attr = "(" ++ "NounSg" ++p1.attr ++ ")" } ;
lin the_NounPhrase_1_16_1 i = { indep = "the_NounPhrase_1" ++ i.s ; attr = "(" ++ "the_NounPhrase_1" ++ i.s ++ ")" } ;
lin NounPl_10_2_4 p1 = { indep = "NounPl" ++p1.attr ; attr = "(" ++ "NounPl" ++p1.attr ++ ")" } ;
lin the_NounPhrase_2_17_2 i = { indep = "the_NounPhrase_2" ++ i.s ; attr = "(" ++ "the_NounPhrase_2" ++ i.s ++ ")" } ;
lin PredVP_13_3_1_0 p1 p2 = { indep = "PredVP" ++p1.attr ++p2.attr ; attr = "(" ++ "PredVP" ++p1.attr ++p2.attr ++ ")" } ;
lin PredVP_14_3_2_0 p1 p2 = { indep = "PredVP" ++p1.attr ++p2.attr ; attr = "(" ++ "PredVP" ++p1.attr ++p2.attr ++ ")" } ;
lin the_Sentence_1_18_3 i = { indep = "the_Sentence_1" ++ i.s ; attr = "(" ++ "the_Sentence_1" ++ i.s ++ ")" } ;
lin Fish_9_4_ = { indep = "Fish" ; attr = "Fish" } ;
lin Potato_12_4_ = { indep = "Potato" ; attr = "Potato" } ;
lin the_SimpleNoun_1_19_4 i = { indep = "the_SimpleNoun_1" ++ i.s ; attr = "(" ++ "the_SimpleNoun_1" ++ i.s ++ ")" } ;


}