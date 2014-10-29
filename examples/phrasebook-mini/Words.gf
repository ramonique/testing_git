--2 Words and idiomatic phrases of the Phrasebook


-- (c) 2010 Aarne Ranta under LGPL --%

abstract Words = Sentences ** {

  fun

-- kinds of items (so far mostly food stuff)

    Apple : Kind ;
    Beer : DrinkKind ;
    Bread : MassKind ; 

-- properties of kinds (so far mostly of food)

    Delicious : Property ;  

-- kinds of places

    Airport : PlaceKind ;
   
    CitRestaurant : Citizenship -> PlaceKind ;

-- currency units

    DanishCrown : Currency ; 
    Lei : Currency ; -- Romania
    NorwegianCrown : Currency ;
    SwedishCrown : Currency ;
    Zloty : Currency ; -- Poland

  
-- nationalities, countries, languages, citizenships

    Belgian : Citizenship ;
    Belgium : Country ;
    Flemish : LAnguage ;

-- means of transportation 

    Bike : Transport ; 
    ByFoot : ByTransport ;


-- Actions (which can be expressed by different structures in different languages).
-- Notice that also negations and questions can be formed from these.

    AHasAge     : Person -> Number -> Action ;    -- I am seventy years
    AHasChildren: Person -> Number -> Action ;    -- I have six children
    AHasName    : Person -> Name   -> Action ;    -- my name is Bond
    AHasTable   : Person -> Number -> Action ;    -- you have a table for five persons
    AHungry     : Person -> Action ;              -- I am hungry
    AIll        : Person -> Action ;              -- I am ill
    AKnow       : Person -> Action ;              -- I (don't) know
    ALike       : Person -> Item     -> Action ;  -- I like this pizza
    ALive       : Person -> Country  -> Action ;  -- I live in Sweden
    ALove       : Person -> Person   -> Action ;  -- I love you
    AMarried    : Person -> Action ;              -- I am married
    AReady      : Person -> Action ;              -- I am ready
    AScared     : Person -> Action ;              -- I am scared
    ASpeak      : Person -> LAnguage -> Action ;  -- I speak Finnish
    AThirsty    : Person -> Action ;              -- I am thirsty
    ATired      : Person -> Action ;              -- I am tired
    AUnderstand : Person -> Action ;              -- I (don't) understand
    AWant       : Person -> Object -> Action ;    -- I want two apples
    AWantGo     : Person -> Place -> Action ;     -- I want to go to the hospital

-- Miscellaneous phrases. Notice that also negations and questions can be formed from
-- propositions.

    QWhatAge       : Person -> Question ;            -- how old are you
    QWhatName      : Person -> Question ;            -- what is your name
    HowMuchCost    : Item -> Question ;              -- how much does the pizza cost
    ItCost         : Item -> Price -> Proposition ;  -- the pizza costs five euros

    PropOpen       : Place -> Proposition ;          -- the museum is open
    PropClosed     : Place -> Proposition ;          -- the museum is closed
    PropOpenDate   : Place -> Date -> Proposition ;  -- the museum is open today
    PropClosedDate : Place -> Date -> Proposition ;  -- the museum is closed today
    PropOpenDay    : Place -> Day  -> Proposition ;  -- the museum is open on Mondays
    PropClosedDay  : Place -> Day  -> Proposition ;  -- the museum is closed on Mondays

    PSeeYouPlaceDate : Place -> Date -> Greeting ;   -- see you in the bar on Monday
    PSeeYouPlace     : Place         -> Greeting ;   -- see you in the bar
    PSeeYouDate      :          Date -> Greeting ;   -- see you on Monday

-- family relations

    Wife, Husband  : Person -> Person ;              -- my wife, your husband
    Children       : Person -> Person ;              -- my children 

-- week days

    Monday : Day ;

    Tomorrow : Date ;

-- transports

    HowFar : Place -> Question ;                  -- how far is the zoo ?
    HowFarFrom : Place -> Place -> Question ;     -- how far is the center from the hotel ?
    HowFarFromBy : Place -> Place -> ByTransport -> Question ; 
                                            -- how far is the airport from the hotel by taxi ? 
    HowFarBy : Place -> ByTransport -> Question ;   -- how far is the museum by bus ?
                          
    WhichTranspPlace : Transport -> Place -> Question ;   -- which bus goes to the hotel
    IsTranspPlace    : Transport -> Place -> Question ;   -- is there a metro to the airport ?

-- modifiers of places

    TheBest : Superlative ;
    TheClosest : Superlative ;
    SuperlPlace : Superlative -> PlaceKind -> Place ; -- the best bar




}
