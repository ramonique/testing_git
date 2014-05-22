concrete Grammar1EngCompConc of Grammar1EngComp =
{

lincat C0 , C1 , C2 = { indep : Str ; attr : Str } ;

lin You_Pl_8_0_ = { indep = "You_Pl" ; attr = "You_Pl" } ;
lin You_Sg_9_0_ = { indep = "You_Sg" ; attr = "You_Sg" } ;
lin the_Pronoun_1_10_0 i = { indep = "the_Pronoun_1" ++ i.s ; attr = "(" ++ "the_Pronoun_1" ++ i.s ++ ")" } ;
lin PredVP_6_1_0_2 p1 p2 = { indep = "PredVP" ++p1.attr ++p2.attr ; attr = "(" ++ "PredVP" ++p1.attr ++p2.attr ++ ")" } ;
lin the_Sentence_1_11_1 i = { indep = "the_Sentence_1" ++ i.s ; attr = "(" ++ "the_Sentence_1" ++ i.s ++ ")" } ;
lin Walk_7_2_ = { indep = "Walk" ; attr = "Walk" } ;
lin the_Verb_1_12_2 i = { indep = "the_Verb_1" ++ i.s ; attr = "(" ++ "the_Verb_1" ++ i.s ++ ")" } ;


}