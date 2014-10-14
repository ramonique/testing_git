concrete UnderstandEst of Understand = open Prelude in {

  lincat
     S = SS ;
     V = {s : Str ; p : Str} ; 
     V2 = {s : Str ; p : Str} ;
     VP = SS ; 
     N  = SS ;
     NP = SS ;

  lin 
    Pred np vp = ss (np.s ++ vp.s);
    IntransVP v  = ss (v.s ++ v.p) ;
    TransVP v2 np = ss (v2.s ++ v2.p ++ np.s) ;
    understand_V = {s = "saab" ; p = "aru"} ;
    get_V2 = {s = "saab" ; p = []} ;
    reason_N = ss "aru" ;
    dog_N = ss "koer" ;

}