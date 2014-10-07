--# -path=.:../sharedgrammar
concrete YouWalkEng of YouWalk = SharedGrammarEng ** {


lin the_Verb = {s = "VERB"} ;
lin the_Pronoun = {s = "PRONOUN"} ;

lin You_Sg = mkPronoun "you" "you" "your" ;
lin You_Pl = mkPronoun "you" "you" "your" ;

lin Walk = mkV "walk" ;


}
