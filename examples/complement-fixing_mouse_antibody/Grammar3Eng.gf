concrete Grammar3Eng of Grammar3 = 
{

lincat SimpleNoun, 
    Verb,
    Adjective, 
    NounPhrase = {s : Str};

--lin SimpNP n = n ;
lin SimpCN cn = cn ;
lin GerundNP np v = {s = np.s ++ "-" ++ v.s };
lin Mod a np = {s = a.s ++ np.s } ;
lin Appos np1 np2 = {s = np1.s ++ np2.s} ;

lin Mouse = {s = "mouse"} ; 
lin Monoclonal = {s = "monoclonal"} ; 
lin Fix = {s = "fixing"} ;
lin Complement = {s = "complement"} ;
lin Antibody = {s = "antibody"} ;
 

}
