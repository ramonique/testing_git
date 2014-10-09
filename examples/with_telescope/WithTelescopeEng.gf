--# -path=.:../sharedgrammar
concrete WithTelescopeEng of WithTelescope = SharedGrammarEng ** {

lin BasicPP prep np = {s = prep.s ++ np.s ! Obj} ;
lin PrepNP np pp = {s = \\cas => np.s ! cas ++ pp.s} ;

lin PrepVP vp pp = {s = vp.s ++ pp.s } ;
--lin SimpVP v np = {s = v.s ++ np.s ! v.obj} ;

lin Girl = mkN "girl" "girl" "girl's" ;
lin With = {s = "with"} ;
lin See = {s = "sees"; obj = Obj} ;
lin Man = mkN "man" "man" "man's" ; 
lin Telescope =  mkN "telescope" "telescope" "telescope's"; 
}
