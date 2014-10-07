abstract YouWalk = Grammar ** {

flags startcat=S ;

-- fun the_Pronoun : Pronoun ;
-- fun the_Verb : Verb ;

fun You_Sg : Pronoun ;
fun You_Pl : Pronoun ;

fun Walk : Verb ;

fun PredVPPron : Pronoun -> Verb -> S ;

}
