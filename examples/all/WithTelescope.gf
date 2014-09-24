abstract WithTelescope = Grammar ** {

flags startcat=S;

--fun the_SimpleNoun : SimpleNoun ;
--fun the_Verb2 : Verb2 ;

fun BasicPP : Preposition -> NounPhrase -> PP ;
fun PrepNP : NounPhrase -> PP -> NounPhrase ;
fun PrepVP : VerbPhrase -> PP -> VerbPhrase ;


fun Girl : SimpleNoun ; 
fun With : Preposition ;
fun See : Verb2 ;
fun Man : SimpleNoun ;
fun Telescope : SimpleNoun ; 
    
}
