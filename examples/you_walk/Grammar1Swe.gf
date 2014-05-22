concrete Grammar1Swe of Grammar1 = 
{

flags coding=utf8;
lincat Pronoun, Verb, Sentence = {s: Str} ;

lin You_Sg = {s = "du"} ;
lin You_Pl = {s = "ni"} ;

lin Walk = {s = "åker"} ;

lin PredVP pron verb = {s = pron.s ++ verb.s };

}
