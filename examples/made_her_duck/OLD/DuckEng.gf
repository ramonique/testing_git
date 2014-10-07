concrete DuckEng of Duck = open Prelude in {

lincat 
  NP  = {s : NPForm => Str} ;
  V   = {s : Str} ;
  V2  = {s : Str ; obj : NPForm} ;
  V2V = {s : Str ; obj : NPForm} ;
  V3  = {s : Str ; do : NPForm ; io : NPForm} ;
  VP  = {s : Str} ;
  S   = {s : Str} ;

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

  VtoVP v = v ;

  V2toVP v2 np = ss (v2.s ++ np.s ! v2.obj) ;

  V2VtoVP v2v np v = ss (v2v.s ++ np.s ! v2v.obj ++ v.s) ;

  V3toVP v3 np1 np2 = ss (v3.s ++ np1.s ! v3.io ++ np2.s ! v3.do) ;

  MkS np vp = ss (np.s ! Subj ++ vp.s) ;
param
  NPForm = Subj | Obj | Poss ;

oper
  mkNP : (s,o,p : Str) -> NP = \s,o,p ->
   lin NP {s = table {Subj => s ;
	       Obj  => o ;
	       Poss => p}
   } ;
}