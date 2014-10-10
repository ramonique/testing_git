--# -path=.:../sharedgrammar
abstract WithTelescope3 = SharedGrammar ** {

-- Differs from WithTelescope by having Hear as a fun from NP to VP
-- Expectation: same amount ambiguities


flags startcat=S;

fun BasicPP : Preposition -> NounPhrase -> PP ;
fun PrepNP : NounPhrase -> PP -> NounPhrase ;
fun PrepVP : VerbPhrase -> PP -> VerbPhrase ;
fun Hear : NounPhrase -> VerbPhrase ;

fun Girl : SimpleNoun ; 
fun With : Preposition ;
fun See : Verb2 ;

fun Man : SimpleNoun ;
fun Telescope : SimpleNoun ; 
    
}
