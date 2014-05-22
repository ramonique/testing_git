abstract Grammar3 = 
{
flags startcat = NounPhrase ;

cat SimpleNoun ; 
    Verb ;
    Adjective ; 
    NounPhrase ;

fun SimpCN : SimpleNoun -> NounPhrase ;
fun GerundNP : NounPhrase -> Verb -> Adjective ; -- complement - fixing
fun Mod : Adjective -> NounPhrase -> NounPhrase ;
fun Appos : NounPhrase -> NounPhrase -> NounPhrase  ; -- mouse antibody


fun Mouse : SimpleNoun ; 
fun Monoclonal : Adjective ; 
fun Fix : Verb ;
fun Complement : SimpleNoun ;
fun Antibody : SimpleNoun ;
 

}