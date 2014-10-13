--# -path=.:../sharedgrammar
abstract WithTelescope = SharedGrammar  ** {

flags startcat=S;

fun BasicPP : Preposition -> NounPhrase -> PP ;
fun PrepNP : NounPhrase -> PP -> NounPhrase ;
fun PrepVP : VerbPhrase -> PP -> VerbPhrase ;


fun Girl : SimpleNoun ; 
fun With : Preposition ;
fun See : Verb2 ;
fun Man : SimpleNoun ;
fun Telescope : SimpleNoun ; 
    
}
