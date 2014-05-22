concrete Grammar9Conc of Grammar9 = {

lincat NP = {s : Str};
lincat Noun = {s : Str; p : Str};

lin Tiger = {s = "cat"; p = "tigers" } ;
lin Cat = {s = "cat"; p = "pets"} ;
lin Dog = {s = "dog"; p = "pets"} ;

lin Fish = {s = "fish"; p = "fish"} ;

lin A n    = {s = "a" ++ n.s} ;
lin Many n = {s = "many" ++ n.p} ;
lin Two n  = {s = "two" ++ n.p} ;
lin The1 n = {s = "the" ++ n.s} ;
lin The2 n = {s = "the" ++ n.p} ;--


}
