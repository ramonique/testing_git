--# -path=.:../sharedgrammar
concrete WithTelescope3Eng of WithTelescope3 = SharedGrammarEng ** {

lin BasicPP prep np = {s = prep.s ++ np.s ! Obj} ;
lin PrepNP np pp = {s = \\cas => np.s ! cas ++ pp.s} ;

lin PrepVP vp pp = {s = vp.s ++ pp.s } ;
lin Hear np = {s = "hears" ++ np.s ! Obj} ;

lin Girl = mkN "girl" "girl" "girl's" ;
lin With = {s = "with"} ;
lin See = {s = "sees"; obj = Obj} ;
lin Man = mkN "man" "man" "man's" ; 
lin Telescope =  mkN "telescope" "telescope" "telescope's"; 
}
