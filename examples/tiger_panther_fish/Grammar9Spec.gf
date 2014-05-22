abstract Grammar9Spec = {

flags startcat = NP ;

cat Noun_s ;
cat Noun_p ;
cat NP ;

fun Tiger_s : Noun_s ;
fun Cat_s : Noun_s ;
fun Dog_s : Noun_s ;
fun Fish_s : Noun_s ;

fun Tiger_p : Noun_p ;
fun Cat_p : Noun_p ;
fun Dog_p : Noun_p ;
fun Fish_p : Noun_p ;

fun A : Noun_s -> NP ;
fun Many : Noun_p -> NP ;
fun Two : Noun_p -> NP ;
fun The1 : Noun_s -> NP ;
fun The2 : Noun_p -> NP ;


}
