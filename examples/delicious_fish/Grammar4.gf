abstract Grammar4 = 
{
flags startcat = Sentence ;

cat SimpleNoun; 
    NounPhrase;
    Adjective;
    Sentence;

fun NounSg : SimpleNoun -> NounPhrase ;
fun NounPl : SimpleNoun -> NounPhrase ;

fun PredVP : NounPhrase -> Adjective -> Sentence ;


fun Fish : SimpleNoun ;
fun Potato : SimpleNoun ; 
fun Delicious : Adjective ;

}