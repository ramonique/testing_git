concrete SharedGrammarFin of SharedGrammar = open Prelude in {

lincat 
  SimpleNoun = {s : Case => Str} ; -- {a : Agr} ;
  NounPhrase = {s : Case => Str} ; 
  Pronoun =  {s : Case => Str} ;

  Preposition = {s : Str; c : Case} ;
  PP = SS ;

  Verb   = SS ; --{s : Agr => Str} ;
  Verb2  = {s : Str ; obj : Case} ;
  Verb2Verb = Verb ** {obj : Case} ;
  Verb3  = Verb ** { do : Case ; io : Case} ;
  VerbPhrase  = SS ;

  S  = SS ;

param
--  Agr  = SgP2 | SgP3 | PlP2 ; 
  Case = Nom  | Gen | Part ; 

oper
  mkNoun : (s,o,p : Str) ->  {s : Case => Str} = \s,o,p ->
    {s = table {Nom  => s ;
	        Gen  => o ;
	        Part => p}
   } ;

  mkN : (s,o,p : Str) -> SimpleNoun = \s,o,p ->
    lin SimpleNoun (mkNoun s o p) ;

  mkNP : (s,o,p : Str) -> NounPhrase = \s,o,p ->
    lin NounPhrase (mkNoun s o p) ; --** {a = SgP3} ;

  mkPron : (s,o,p : Str) -> NounPhrase = \s,o,p ->
    lin Pronoun (mkNoun s o p) ; --** {a = agr} ;

  mkPrep : Case -> Str -> Preposition = \cas,str ->
    lin Preposition {s = str ; c = cas} ;

  mkV : Str -> Verb = \v -> lin Verb (ss v) ;
 
  mkV2 : Str -> Case -> Verb2 = \v,cas -> 
    lin Verb2 {s = v ; obj = cas} ;

lin

  --Originally from Duck
  VtoVP v = v ; 
  V2toVP v2 np = ss (v2.s ++ np.s ! v2.obj) ;
  PredVP np vp = ss (np.s ! Nom ++ vp.s) ;


  --Originally from WithTelescope
  DetNP n  = n ; -- ** {a=SgP3} ;
  PronNP p = p ;

} ;


{-  If we want to have agreement in verbs later
oper
  mkVerb : (a,b,c : Str) -> {s : Agr => Str} = \a,b,c -> 
    {s = table {SgP2 => a;
		SgP3 => b;
                PlP2 => c}
    } ;

  mkV : (a,b,c : Str) -> Verb = \a,b,c ->
    lin Verb (mkVerb a b c) ;
-}
