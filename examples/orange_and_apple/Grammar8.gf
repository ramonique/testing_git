abstract Grammar8 = {

flags startcat = Thing ;

cat Noun ;
cat Thing ;

fun Apple : Noun ;
fun Orange : Noun ;

fun An : Noun -> Thing ;
fun The : Noun -> Thing ;

fun And : Thing -> Thing -> Thing ;
fun Or : Thing -> Thing -> Thing ;

}