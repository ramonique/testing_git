abstract YouWalk_the = {

flags startcat=Sentence ;

cat Pronoun; Verb; Sentence;

fun the_Pronoun : Pronoun ;
fun the_Verb : Verb ;

fun You : Pronoun ;

fun Walk : Verb ;

fun PredVP : Pronoun -> Verb -> Sentence ;

}
