--2 Implementations of Words, with English as example

concrete WordsEng of Words = SentencesEng ** 
    open 
      SyntaxEng, 
      ParadigmsEng, 
      (L = LexiconEng), 
      (P = ParadigmsEng), 
      IrregEng, 
      ExtraEng, 
      Prelude in {
  lin

-- Kinds; many of them are in the resource lexicon, others can be built by $mkN$.

    Apple = mkCN L.apple_N ;
    Beer = mkCN L.beer_N ;
    Bread = mkCN L.bread_N ;

-- Properties; many of them are in the resource lexicon, others can be built by $mkA$.

    Delicious = mkA "delicious" ;

-- Places require different prepositions to express location; in some languages 
-- also the directional preposition varies, but in English we use $to$, as
-- defined by $mkPlace$.

    Airport = mkPlace "airport" "at" ;
   
    CitRestaurant cit = mkCNPlace (mkCN cit (mkN "restaurant")) in_Prep to_Prep ;


-- Currencies; $crown$ is ambiguous between Danish and Swedish crowns.

    DanishCrown = mkCN (mkA "Danish") (mkN "crown") | mkCN (mkN "crown") ;
    Lei = mkCN (mkN "leu" "lei") ;
    NorwegianCrown = mkCN (mkA "Norwegian") (mkN "crown") | mkCN (mkN "crown") ;
    SwedishCrown = mkCN (mkA "Swedish") (mkN "crown") | mkCN (mkN "crown") ;
    Zloty = mkCN (mkN "zloty" "zloty") ;

-- Nationalities

    Belgian = mkA "Belgian" ;
    Belgium = mkNP (mkPN "Belgium") ;
    Flemish = mkNP (mkPN "Flemish") ;

-- Means of transportation 

   Bike = mkTransport L.bike_N ;
   ByFoot = P.mkAdv "by foot" ;

-- Actions: the predication patterns are very often language-dependent.

    AHasAge p num = mkCl p.name (mkNP (mkNP num L.year_N) (ParadigmsEng.mkAdv "old"));
    AHasChildren p num = mkCl p.name have_V2 (mkNP num L.child_N) ;
    AHasTable p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (mkN "table")) (SyntaxEng.mkAdv for_Prep (mkNP num (mkN "person")))) ;
    AHasName p name = mkCl (nameOf p) name ;
    AHungry p = mkCl p.name (mkA "hungry") ;
    AIll p = mkCl p.name (mkA "ill") ;
    AKnow p = mkCl p.name IrregEng.know_V ;
    ALike p item = mkCl p.name (mkV2 (mkV "like")) item ;
    ALive p co = mkCl p.name (mkVP (mkVP (mkV "live")) (SyntaxEng.mkAdv in_Prep co)) ;
    ALove p q = mkCl p.name (mkV2 (mkV "love")) q.name ;
    AMarried p = mkCl p.name (mkA "married") ;
    AReady p = mkCl p.name (mkA "ready") ;
    AScared p = mkCl p.name (mkA "scared") ;
    ASpeak p lang = mkCl p.name  (mkV2 IrregEng.speak_V) lang ;
    AThirsty p = mkCl p.name (mkA "thirsty") ;
    ATired p = mkCl p.name (mkA "tired") ;
    AUnderstand p = mkCl p.name IrregEng.understand_V ;
    AWant p obj = mkCl p.name (mkV2 (mkV "want")) obj ;
    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP IrregEng.go_V) place.to) ;

-- miscellaneous

    QWhatName p = mkQS (mkQCl (mkIComp whatSg_IP) (nameOf p)) ;
    QWhatAge p = mkQS (mkQCl (ICompAP (mkAP L.old_A)) p.name) ;
    HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item IrregEng.cost_V)) ; 
    ItCost item price = mkCl item (mkV2 IrregEng.cost_V) price ;

    PropOpen p = mkCl p.name open_Adv ;
    PropClosed p = mkCl p.name closed_Adv ;
    PropOpenDate p d = mkCl p.name (mkVP (mkVP open_Adv) d) ; 
    PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_Adv) d) ; 
    PropOpenDay p d = mkCl p.name (mkVP (mkVP open_Adv) d.habitual) ; 
    PropClosedDay p d = mkCl p.name (mkVP (mkVP closed_Adv) d.habitual) ; 

-- Building phrases from strings is complicated: the solution is to use
-- mkText : Text -> Text -> Text ;

    PSeeYouDate d = mkText (lin Text (ss ("see you"))) (mkPhrase (mkUtt d)) ;
    PSeeYouPlace p = mkText (lin Text (ss ("see you"))) (mkPhrase (mkUtt p.at)) ;
    PSeeYouPlaceDate p d = 
      mkText (lin Text (ss ("see you"))) 
        (mkText (mkPhrase (mkUtt p.at)) (mkPhrase (mkUtt d))) ;

-- Relations are expressed as "my wife" or "my son's wife", as defined by $xOf$
-- below. Languages without productive genitives must use an equivalent of
-- "the wife of my son" for non-pronouns.

    Wife = xOf sing (mkN "wife") ;
    Husband = xOf sing (mkN "husband") ;
    Children = xOf plur L.child_N ;

-- week days

    Monday = mkDay "Monday" ;
    Tomorrow = P.mkAdv "tomorrow" ;

-- modifiers of places

    TheBest = mkSuperl L.good_A ;
    TheClosest = mkSuperl L.near_A ; 
    SuperlPlace sup p = placeNP sup p ;


-- transports

    HowFar place = mkQS (mkQCl far_IAdv place.name) ;
    HowFarFrom x y = 
      mkQS (mkQCl far_IAdv (mkCl y.name (SyntaxEng.mkAdv from_Prep x.name))) ;
    HowFarFromBy x y t = 
      mkQS (mkQCl far_IAdv (mkCl y.name (SyntaxEng.mkAdv from_Prep (mkNP x.name t)))) ;
    HowFarBy y t = mkQS (mkQCl far_IAdv (mkCl y.name t)) ;
 
    WhichTranspPlace trans place = 
      mkQS (mkQCl (mkIP which_IDet trans.name) (mkVP (mkVP L.go_V) place.to)) ;

    IsTranspPlace trans place =
      mkQS (mkQCl (mkCl (mkCN trans.name place.to))) ;



-- auxiliaries

  oper

    mkNat : Str -> Str -> NPNationality = \nat,co -> 
      mkNPNationality (mkNP (mkPN nat)) (mkNP (mkPN co)) (mkA nat) ;

    mkDay : Str -> {name : NP ; point : Adv ; habitual : Adv} = \d ->
      let day = mkNP (mkPN d) in 
      mkNPDay day (SyntaxEng.mkAdv on_Prep day) 
        (SyntaxEng.mkAdv on_Prep (mkNP a_Quant plNum (mkCN (mkN d)))) ;
    
    mkCompoundPlace : Str -> Str -> Str -> {name : CN ; at : Prep ; to : Prep; isPl : Bool} = \comp, p, i ->
     mkCNPlace (mkCN (P.mkN comp (mkN p))) (P.mkPrep i) to_Prep ;

    mkPlace : Str -> Str -> {name : CN ; at : Prep ; to : Prep; isPl : Bool} = \p,i -> 
      mkCNPlace (mkCN (mkN p)) (P.mkPrep i) to_Prep ;

    open_Adv = P.mkAdv "open" ;
    closed_Adv = P.mkAdv "closed" ;

    xOf : GNumber -> N -> NPPerson -> NPPerson = \n,x,p -> 
      relativePerson n (mkCN x) (\a,b,c -> mkNP (GenNP b) a c) p ;

    nameOf : NPPerson -> NP = \p -> (xOf sing (mkN "name") p).name ;


    mkTransport : N -> {name : CN ; by : Adv} = \n -> {
      name = mkCN n ; 
      by = SyntaxEng.mkAdv by8means_Prep (mkNP n)
      } ;

    mkSuperl : A -> Det = \a -> SyntaxEng.mkDet the_Art (SyntaxEng.mkOrd a) ;
    
   far_IAdv = ExtraEng.IAdvAdv (ss "far") ;

  oper
    mkProfession : N -> NPPerson -> Cl = \n,p -> mkCl p.name n ;
}
