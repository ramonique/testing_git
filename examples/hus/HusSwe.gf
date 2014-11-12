--# -path=.:../sharedgrammar
concrete HusSwe of Hus = SharedGrammarSwe - [DetNP] ** open Prelude in {

lincat
  Comp = {s : Number => Str} ;
  Det = SS ** {n : Number} ;

lin
  CompS np comp = ss (np.s ! Subj ++ "är" ++ comp.s ! np.n) ;

  Jag = mkNP "jag" "mig" "min" ;
  Gilla = mkV "gillar" ** {obj = Obj};
  Hus = mkN "hus" "hus" "hus" ;
  Bra = {s = table {Sg => "bra" ; Pl => "bra"}} ;
  Ett = {s = "" ; n = Sg} ;
  De  = {s = ""; n = Pl} ;

  DetNP det noun = {s = \\cas => det.s ++ (noun.s ! det.n ! cas) ;
		    n = det.n} ;


}