concrete Grammar6Conc of Grammar6 = {


lincat A, B, C, D, S = {s : Str} ;

lin s1 a b c = {s = a.s ++ b.s ++ c.s} ;
lin s2 d1 d2 = {s = d1.s ++ d2.s};

lin simpA  = {s = "a b"} ;
lin simpB  = {s = "c a"}  ;
lin simpC = {s = "b c"} ; 
lin simpD = {s = "a b c"} ;

}
