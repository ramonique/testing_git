concrete WithTelescopeEng of WithTelescope = {


lincat SimpleNoun, NounPhrase,
    Verb2, VerbPhrase, 
    PP, Preposition,
    Sentence = {s : Str} ;

lin the_SimpleNoun = {s = "NOUN"} ;
lin the_Verb2 = {s = "VERB"} ;

lin BasicPP prep np = {s = prep.s ++ np.s } ;
lin DetNP n = {s = "the" ++ n.s} ;
lin PrepNP np pp = {s = np.s ++ pp.s} ;

lin PrepVP vp pp = {s = vp.s ++ pp.s } ;
lin SimpVP v np = {s = v.s ++ np.s} ;

lin PredVP np vp = {s = np.s ++ vp.s } ;

lin Girl = {s = "girl"} ;
lin With = {s = "with"} ;
lin See = {s = "sees"} ;
lin Man = {s = "man"} ; 
lin Telescope = {s = "telescope"} ; 
}
