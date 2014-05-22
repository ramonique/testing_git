concrete Grammar9ConcCompConc of Grammar9ConcComp =
{

lincat C0 , C1 = { indep : Str ; attr : Str } ;

lin A_4_0_1 p1 = { indep = "A" ++p1.attr ; attr = "(" ++ "A" ++p1.attr ++ ")" } ;
lin Many_8_0_1 p1 = { indep = "Many" ++p1.attr ; attr = "(" ++ "Many" ++p1.attr ++ ")" } ;
lin The1_9_0_1 p1 = { indep = "The1" ++p1.attr ; attr = "(" ++ "The1" ++p1.attr ++ ")" } ;
lin The2_10_0_1 p1 = { indep = "The2" ++p1.attr ; attr = "(" ++ "The2" ++p1.attr ++ ")" } ;
lin Two_12_0_1 p1 = { indep = "Two" ++p1.attr ; attr = "(" ++ "Two" ++p1.attr ++ ")" } ;
lin the_NP_1_13_0 i = { indep = "the_NP_1" ++ i.s ; attr = "(" ++ "the_NP_1" ++ i.s ++ ")" } ;
lin Cat_5_1_ = { indep = "Cat" ; attr = "Cat" } ;
lin Dog_6_1_ = { indep = "Dog" ; attr = "Dog" } ;
lin Fish_7_1_ = { indep = "Fish" ; attr = "Fish" } ;
lin Tiger_11_1_ = { indep = "Tiger" ; attr = "Tiger" } ;
lin the_Noun_1_14_1 i = { indep = "the_Noun_1" ++ i.s ; attr = "(" ++ "the_Noun_1" ++ i.s ++ ")" } ;


}