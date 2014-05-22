abstract Grammar6 = {

flags startcat = S;

cat A;
    B;
    C;
    D;
    S;

fun s1 : A -> B -> C -> S ;
fun s2 : D -> D -> S ;

fun simpA : A ;
fun simpB : B ;
fun simpC : C ; 
fun simpD : D ;

}