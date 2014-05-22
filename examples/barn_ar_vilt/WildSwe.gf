concrete WildSwe of Wild = {

  lincat 
    S = {s : Str} ; 
    N = {s : Str ; g : Gender} ; 
    A = {s : Gender => Str } ; 
    Comp = {s : Gender => Str} ;

  lin 
    Pred n comp = {s = n.s ++ "är" ++ comp.s ! n.g} ;
    CompA a = a ;
    CompN n = {s = \\_ => n.s } ;
    game_N = {s = "vilt" ; g = Neutr } ;
    child_N = {s = "barn" ; g = Neutr } ;
    dog_N = {s = "hund" ; g = Utr } ;
    wild_A = {s = table { Utr => "vild" ; Neutr => "vilt" } } ;

  param
    Gender = Neutr | Utr ;
}