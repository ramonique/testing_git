concrete SharedGrammarSwe of SharedGrammar = open Prelude in {
lincat
  NounPhrase  = {s : Case => Str ; n : Number} ;
  PP = {s: Str};
  Preposition = {s : Str} ;
  Pronoun = {s : Case => Str ; n : Number} ;
  SimpleNoun = {s : Number => Case => Str ; g : Gender} ;
  Verb   = {s : Str} ;
  Verb2  = {s : Str ; obj : Case} ;
  Verb2Verb = {s : Str ; obj : Case} ;
  Verb3  = {s : Str ; do : Case ; io : Case} ;
  VerbPhrase  = {s : Str} ;
  S  = {s : Str} ;

param
  Number = Sg | Pl ;
  Case   = Subj | Obj | Poss ;
  Gender = Neutr | Utr ;


oper
  mkNoun : (s,o,p : Str) -> {s : Number => Case => Str} = \s,o,p ->
    {s = table {Sg => table {Subj => s ;
	                     Obj  => o ;
	                     Poss => p} ;
		Pl => table {Subj => s ;
	                     Obj  => o ;
	                     Poss => p}}
   } ;

  mkN : (s,o,p : Str) -> SimpleNoun = \s,o,p ->
   lin SimpleNoun ((mkNoun s o p) ** {g = Neutr}) ;

  mkNP : (s,o,p : Str) -> NounPhrase = \s,o,p ->
   let ns = (mkNoun s o p).s ! Sg ;
       singular = {s = ns; n=Sg} ;
   in lin NounPhrase (singular ** {g = Neutr}) ;

  mkPronoun : (s,o,p : Str) -> NounPhrase = \s,o,p ->
   let ns = (mkNoun s o p) ;
       singular = {s = ns.s ! Sg; n=Sg} ;
   in lin NounPhrase (singular ** {g = Neutr}) ;

--  mkNP1 : Str -> NounPhrase = \s ->
--   lin NounPhrase (mkNoun s s s Neutr) ;

  mkV : Str -> Verb =  \v -> lin Verb (ss v) ;


lin

  --Originally from Duck
  VtoVP v = v ;
  V2toVP v2 np = ss (v2.s ++ np.s ! v2.obj) ;
  V2VtoVP v2v np v = ss (v2v.s ++ np.s ! v2v.obj ++ v.s) ;
  V3toVP v3 np1 np2 = ss (v3.s ++ np1.s ! v3.io ++ np2.s ! v3.do) ;
  PredVP np vp = ss (np.s ! Subj ++ vp.s) ;


  --Originally from WithTelescope
  DetNP  n = {s = \\cas => "ett" ++ (n.s ! Sg ! cas); n = Sg} ; ------
  PronNP p = p ;

}