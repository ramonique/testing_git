concrete Grammar8Conc of Grammar8 = {

lincat Thing = {s : Str};
lincat Noun = {s : Str};

lin Apple = {s = "apple"} ;
lin Orange = {s = "orange"} ;

lin An x = {s = "an" ++ x.s} ;
lin The x = {s = "the" ++ x.s} ;

lin And x y = {s = x.s ++ "and" ++ y.s} ;
lin Or x y = {s = x.s ++ "or" ++ y.s} ;

}
