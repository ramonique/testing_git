concrete WithTelescopeEngCompConc of WithTelescopeEngComp =
{

lincat C0 , C1 , C2 , C3 , C4 , C5 , C6 = { indep : Str ; attr : Str } ;

lin DetNP_15_0_4 p1 = { indep = "DetNP" ++p1.attr ; attr = "(" ++ "DetNP" ++p1.attr ++ ")" } ;
lin PrepNP_19_0_0_1 p1 p2 = { indep = "PrepNP" ++p1.attr ++p2.attr ; attr = "(" ++ "PrepNP" ++p1.attr ++p2.attr ++ ")" } ;
lin the_NounPhrase_1_25_0 i = { indep = "the_NounPhrase_1" ++ i.s ; attr = "(" ++ "the_NounPhrase_1" ++ i.s ++ ")" } ;
lin BasicPP_14_1_2_0 p1 p2 = { indep = "BasicPP" ++p1.attr ++p2.attr ; attr = "(" ++ "BasicPP" ++p1.attr ++p2.attr ++ ")" } ;
lin the_PP_1_26_1 i = { indep = "the_PP_1" ++ i.s ; attr = "(" ++ "the_PP_1" ++ i.s ++ ")" } ;
lin With_24_2_ = { indep = "With" ; attr = "With" } ;
lin the_Preposition_1_27_2 i = { indep = "the_Preposition_1" ++ i.s ; attr = "(" ++ "the_Preposition_1" ++ i.s ++ ")" } ;
lin PredVP_18_3_0_6 p1 p2 = { indep = "PredVP" ++p1.attr ++p2.attr ; attr = "(" ++ "PredVP" ++p1.attr ++p2.attr ++ ")" } ;
lin the_Sentence_1_28_3 i = { indep = "the_Sentence_1" ++ i.s ; attr = "(" ++ "the_Sentence_1" ++ i.s ++ ")" } ;
lin Girl_16_4_ = { indep = "Girl" ; attr = "Girl" } ;
lin Man_17_4_ = { indep = "Man" ; attr = "Man" } ;
lin Telescope_23_4_ = { indep = "Telescope" ; attr = "Telescope" } ;
lin the_SimpleNoun_1_29_4 i = { indep = "the_SimpleNoun_1" ++ i.s ; attr = "(" ++ "the_SimpleNoun_1" ++ i.s ++ ")" } ;
lin See_21_5_ = { indep = "See" ; attr = "See" } ;
lin the_Verb2_1_30_5 i = { indep = "the_Verb2_1" ++ i.s ; attr = "(" ++ "the_Verb2_1" ++ i.s ++ ")" } ;
lin PrepVP_20_6_6_1 p1 p2 = { indep = "PrepVP" ++p1.attr ++p2.attr ; attr = "(" ++ "PrepVP" ++p1.attr ++p2.attr ++ ")" } ;
lin SimpVP_22_6_5_0 p1 p2 = { indep = "SimpVP" ++p1.attr ++p2.attr ; attr = "(" ++ "SimpVP" ++p1.attr ++p2.attr ++ ")" } ;
lin the_VerbPhrase_1_31_6 i = { indep = "the_VerbPhrase_1" ++ i.s ; attr = "(" ++ "the_VerbPhrase_1" ++ i.s ++ ")" } ;


}
