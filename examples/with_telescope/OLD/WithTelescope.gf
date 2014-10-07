abstract WithTelescope = {

flags startcat=Sentence;

cat SimpleNoun; NounPhrase;
    Verb2; VerbPhrase; 
    PP ; Preposition ;
    Sentence ;

--fun the_SimpleNoun : SimpleNoun ;
--fun the_Verb2 : Verb2 ;

fun BasicPP : Preposition -> NounPhrase -> PP ;
fun DetNP : SimpleNoun -> NounPhrase ;
fun PrepNP : NounPhrase -> PP -> NounPhrase ;

fun PrepVP : VerbPhrase -> PP -> VerbPhrase ;
fun SimpVP : Verb2 -> NounPhrase -> VerbPhrase ;

fun PredVP : NounPhrase -> VerbPhrase -> Sentence ;


fun Girl : SimpleNoun ; 
fun With : Preposition ;
fun See : Verb2 ;
fun Man : SimpleNoun ;
fun Telescope : SimpleNoun ; 
    
}
