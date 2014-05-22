concrete Grammar2Eng of Grammar2 = 
{
lincat Pronoun, Sentence = {s: Number => Str} ;
lincat Verb = {s: Str} ;
param Number = sg | pl ;

lin the_Verb = {s = "VERB"} ;
lin the_Pronoun = {s = table {sg => "PRONOUN_sg"; pl => "PRONOUN_pl"} } ;
lin You = {s = \\ c => "You" } ;

lin Walk = {s = "walk"} ;

lin PredVP pron verb = {s = \\c => pron.s!c ++ verb.s };

}
