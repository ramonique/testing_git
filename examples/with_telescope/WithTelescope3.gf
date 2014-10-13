--# -path=.:../sharedgrammar
abstract WithTelescope3 = WithTelescope ** {

-- Differs from WithTelescope by having Hear as a fun from NP to VP
-- Expectation: same amount ambiguities

fun Hear : NounPhrase -> VerbPhrase ;

    
}
