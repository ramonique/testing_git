concrete Grammar3Fre of Grammar3 = 
{

lincat SimpleNoun, 
    Verb,
    Adjective, 
    NounPhrase = {s : Str};

--lin SimpNP n = n ;
lin SimpCN n = n ;
lin GerundNP np v = {s = v.s ++ "le" ++ np.s };
lin Mod a np = {s = np.s ++ a.s } ;
lin Appos np1 np2 = {s = np2.s ++ "de" ++ np1.s} ;

lin Mouse = {s = "souris"} ; 
lin Monoclonal = {s = "monoclonal"} ; 
lin Fix = {s = "fixant"} ;
lin Complement = {s = "complement"} ;
lin Antibody = {s = "anticorps"} ;
 

}
