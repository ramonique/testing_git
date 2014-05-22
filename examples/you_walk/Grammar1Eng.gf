concrete Grammar1Eng of Grammar1 = 
{
lincat Pronoun, Verb, Sentence = {s: Str} ;

lin the_Verb = {s = "VERB"} ;
lin the_Pronoun = {s = "PRONOUN"} ;

lin You_Sg = {s = "you"} ;
lin You_Pl = {s = "you"} ;

lin Walk = {s = "walk"} ;

lin PredVP pron verb = {s = pron.s ++ verb.s };

}
