--# -path=.:../sharedgrammar
abstract WithTelescope2 = SharedGrammar ** {

-- Differs from WithTelescope by having one verb more
-- Expectation: same amount ambiguities


flags startcat=S;

fun BasicPP : Preposition -> NounPhrase -> PP ;
fun PrepNP : NounPhrase -> PP -> NounPhrase ;
fun PrepVP : VerbPhrase -> PP -> VerbPhrase ;


fun Girl : SimpleNoun ; 
fun With : Preposition ;
fun See : Verb2 ;
fun Hear : Verb2 ;
fun Man : SimpleNoun ;
fun Telescope : SimpleNoun ; 
    
}
