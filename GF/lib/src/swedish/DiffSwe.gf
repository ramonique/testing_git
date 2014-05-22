--# -coding=latin1
instance DiffSwe of DiffScand = open CommonScand, Prelude in {

-- Parameters.

  oper
    NGender = Gender ; 
    ngen2gen g = g ;
    utrum = Utr ; 
    neutrum = Neutr ;

    detDef : Species = Def ;

    Verb : Type = {
      s : VForm => Str ;
      part : Str ;
      vtype : VType
      } ;

    hasAuxBe _ = False ;



-- Strings.

    conjThat = "att" ;
    conjThan = "�n" ;
    conjAnd = "och" ;
    infMark  = "att" ;
    compMore = "mera" ;

    subjIf = "om" ;

    artIndef : NGender => Str = table {
      Utr => "en" ;
      Neutr => "ett"
      } ;
    detIndefPl = "n�gra" ;

    verbHave = 
      mkVerb9 "ha" "har" "ha" "hade" "haft" "havd" "havt" "havda" "havande" ** noPart ;
    verbBe = 
      mkVerb9 "vara" "�r" "var" "var" "varit" "varen" "varet" "varna" "varande"
      ** noPart ;
    verbBecome = 
      mkVerb9 "bli" "blir" "bli" "blev" "blivit" "bliven" "blivet" "blivna" "blivande"
      ** noPart ;

    -- auxiliary
    noPart = {part = []} ;

    auxFut = "ska" ;      -- "skall" in ExtSwe
    auxFutKommer = "kommer" ; 
    auxFutPart = "" ; 
    auxCond = "skulle" ;

    negation : Polarity => Str = table {
      Pos => [] ;
      Neg => "inte"
      } ;

    genderForms : (x1,x2 : Str) -> NGender => Str = \all,allt -> 
      table {
        Utr => all ;
        Neutr => allt
        } ;

    relPron : Gender => Number => RCase => Str = \\g,n,c => case c of {
      RNom | RPrep False => "som" ;
      RGen  => "vars" ;
      RPrep True => gennumForms "vilken" "vilket" "vilka" ! gennum g n
      } ;

    pronSuch = gennumForms "s�dan" "s�dant" "s�dana" ;

    reflPron : Agr -> Str = \a -> case <a.n,a.p> of {
      <Pl,P1> => "oss" ;
      <Pl,P2> => "er" ;
      <Sg,P1> => "mig" ;
      <Sg,P2> => "dig" ;
      <_, P3> => "sig"
      } ;

    hur_IAdv = {s = "hur"} ;
    av_Prep = "av" ;

}
