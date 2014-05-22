abstract Grammar1 = {

flags startcat=Sentence ;
cat Pronoun; Verb; Sentence;

--fun the_Pronoun : Pronoun ;
--fun the_Verb : Verb ;

fun You_Sg : Pronoun ;
fun You_Pl : Pronoun ;

fun Walk : Verb ;

fun PredVP : Pronoun -> Verb -> Sentence ;

}