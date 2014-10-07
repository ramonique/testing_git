concrete SharedGrammarEng of SharedGrammar = open Prelude in {

lincat 
  NounPhrase  = {s : NPForm => Str} ;
  PP = {s: Str};
  Preposition = {s : Str} ;
  Pronoun = {s : NPForm => Str} ;
  SimpleNoun = {s : NPForm => Str} ;
  Verb   = {s : Str} ;
  Verb2  = {s : Str ; obj : NPForm} ;
  Verb2Verb = {s : Str ; obj : NPForm} ;
  Verb3  = {s : Str ; do : NPForm ; io : NPForm} ;
  VerbPhrase  = {s : Str} ;
  S  = {s : Str} ;

param
  NPForm = Subj | Obj | Poss ;



oper
  mkNoun : (s,o,p : Str) ->  {s : NPForm => Str} = \s,o,p ->
    {s = table {Subj => s ;
	       Obj  => o ;
	       Poss => p}
   } ;

  mkN : (s,o,p : Str) -> SimpleNoun = \s,o,p ->
   lin SimpleNoun (mkNoun s o p) ;

  mkNP : (s,o,p : Str) -> NounPhrase = \s,o,p ->
   lin NounPhrase (mkNoun s o p) ;

  mkPronoun : (s,o,p : Str) -> NounPhrase = \s,o,p ->
   lin Pronoun (mkNoun s o p) ;

  mkNP1 : Str -> NounPhrase = \s ->
   lin NounPhrase (mkNoun s s s) ;

  mkV : Str -> Verb =  \v -> lin Verb (ss v) ;


lin

  --Originally from Duck
  VtoVP v = v ;
  V2toVP v2 np = ss (v2.s ++ np.s ! v2.obj) ;
  V2VtoVP v2v np v = ss (v2v.s ++ np.s ! v2v.obj ++ v.s) ;
  V3toVP v3 np1 np2 = ss (v3.s ++ np1.s ! v3.io ++ np2.s ! v3.do) ;
  PredVP np vp = ss (np.s ! Subj ++ vp.s) ;


  --Originally from WithTelescope
  DetNP n  = {s = \\cas => "the" ++ (n.s ! cas)} ;
  MassNP n = n ;
  PronNP p = p ;

  -- PrepVP vp pp = {s = vp.s ++ pp.s } ;
  -- SimpVP v np = {s = v.s ++ np.s ! v.obj} ;
    
}
