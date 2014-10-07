--# -path=.:../sharedgrammar
concrete DuckEng of Duck = SharedGrammarEng ** open Prelude in {


lin
  she_Pron = mkNP "she" "her" "her" ;
  duck_N = mkNP "duck" "duck" "duck's" ;

  duck_V = ss "duck" ;
  make_V2 = ss "made" ** {obj = Obj} ;
  make_causative_V2V = ss "made" ** {obj = Obj} ;
  make_benefactive_V3 = ss "made" ** {do = Obj ; io = Obj} ;
  
  PossNP np1 np2 = 
   let s = np1.s ! Poss ++ np2.s ! Subj ;
       o = np1.s ! Poss ++ np2.s ! Obj ;
       p = np1.s ! Poss ++ np2.s ! Poss
   in mkNP s o p ;


}