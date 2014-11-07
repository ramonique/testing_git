--# -path=.:../sharedgrammar
concrete HusSwe of Hus = SharedGrammarSwe - [SimpleNoun] ** open Prelude in {

lincat
  SimpleNoun = {s : Number => Str} ;
  Comp = {s : Number => Str} ;
  
  NumNoun = {s : Str ; n : Number} ;

lin
  CompS numnoun comp = ss (numnoun.s ++ "är" ++ comp.s ! numnoun.n) ;
  MkS n1 v n2 = ss (n1.s ++ v.s ++ n2.s) ;

  Gilla = ss "gillar" ;
  Hus = {s = table {Sg => "hus" ; Pl => "hus"}} ;
  Bra = {s = table {Sg => "bra" ; Pl => "bra"}} ;
  Singular n = {s = n.s ! Sg ; n = Sg} ;
  Plural n = {s = n.s ! Pl   ; n = Pl} ;

param
  Number = Sg | Pl ;

}