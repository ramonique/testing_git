concrete UnderstandEst of Understand = open CatEst, ParadigmsEst, SyntaxEst, LexiconEst, DictEst in {

   lincat
     S = S ;
     V = V ; 
     V2 = V2 ;
     N  = N ;
     NP = NP ;
     VP = VP ; --}

  lin 
    Pred np vp = mkS (mkCl np vp) ;
    IntransVP v  = mkVP v ;
    TransVP v2 np = mkVP v2 np ;
    understand_V = lin V understand_V2 ;
    get_V2 = saama_V2 ;
    reason_N = mkNP aru_N ;
    dog_N = mkNP koer_N ;

}