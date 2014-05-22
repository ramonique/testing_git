abstract Grammar5 = {

flags startcat = S;

cat A;
    B;
    S; 

fun aA : A ;
fun aB : B ; 

fun AtoS : A -> S ;
fun BtoS : B -> S ;

}