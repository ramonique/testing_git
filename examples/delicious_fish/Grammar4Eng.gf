concrete Grammar4Eng of Grammar4 = 
{

param Num = Sg | Pl ;

lincat SimpleNoun = {s : Num => Str }; 
    NounPhrase = {s : Str ; num : Num};
    Adjective = {s : Str};
    Sentence = {s : Str};

lin NounSg n = {s = n.s  ! Sg; num = Sg};
lin NounPl n = {s = n.s ! Pl ; num = Pl} ;

lin PredVP np a = 
           case np. num of 
             {  Sg => { s = "the" ++ np.s ++ "is" ++ a.s};
                Pl => { s = "the" ++ np.s ++ "are" ++a.s }};


lin Fish = {s = table {Sg => "fish" ;
                                 Pl  => "fish"}} ;
lin Potato =  {s = table {Sg => "potato" ;
                                 Pl  => "potatoes"}} ;
lin Delicious = {s = "delicious"};

}
