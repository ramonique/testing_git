concrete Grammar9SpecConc of Grammar9Spec = {

lincat NP = {s : Str};
lincat Noun_s = {s : Str};
lincat Noun_p = {p : Str};

lin Tiger_s = {s = "cat"} ;
lin Cat_s = {s = "cat"} ;
lin Dog_s = {s = "dog"} ;

lin Tiger_p = {p = "tigers"} ;
lin Cat_p = {p = "pets"} ;
lin Dog_p = {p = "pets"} ;

lin Fish_s = {s = "fish"} ;
lin Fish_p = {p = "fish"} ;

lin A n    = {s = "a" ++ n.s} ;
lin Many n = {s = "many" ++ n.p} ;
lin Two n  = {s = "two" ++ n.p} ;
lin The1 n = {s = "the" ++ n.s} ;
lin The2 n = {s = "the" ++ n.p} ;


}
