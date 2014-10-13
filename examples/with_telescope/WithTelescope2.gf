--# -path=.:../sharedgrammar
abstract WithTelescope2 = WithTelescope ** {

-- Differs from WithTelescope by having one verb more
-- Expectation: same amount ambiguities

fun Hear : Verb2 ;
    
}
