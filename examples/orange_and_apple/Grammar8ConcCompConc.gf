concrete Grammar8ConcCompConc of Grammar8ConcComp =
{

lincat C0 , C1 = { indep : Str ; attr : Str } ;

lin Apple_6_0_ = { indep = "Apple" ; attr = "Apple" } ;
lin Orange_8_0_ = { indep = "Orange" ; attr = "Orange" } ;
lin the_Noun_1_10_0 i = { indep = "the_Noun_1" ++ i.s ; attr = "(" ++ "the_Noun_1" ++ i.s ++ ")" } ;
lin An_4_1_0 p1 = { indep = "An" ++p1.attr ; attr = "(" ++ "An" ++p1.attr ++ ")" } ;
lin And_5_1_1_1 p1 p2 = { indep = "And" ++p1.attr ++p2.attr ; attr = "(" ++ "And" ++p1.attr ++p2.attr ++ ")" } ;
lin Or_7_1_1_1 p1 p2 = { indep = "Or" ++p1.attr ++p2.attr ; attr = "(" ++ "Or" ++p1.attr ++p2.attr ++ ")" } ;
lin The_9_1_0 p1 = { indep = "The" ++p1.attr ; attr = "(" ++ "The" ++p1.attr ++ ")" } ;
lin the_Thing_1_11_1 i = { indep = "the_Thing_1" ++ i.s ; attr = "(" ++ "the_Thing_1" ++ i.s ++ ")" } ;


}