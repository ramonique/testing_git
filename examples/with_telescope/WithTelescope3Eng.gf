--# -path=.:../sharedgrammar
concrete WithTelescope3Eng of WithTelescope3 = WithTelescopeEng ** {

lin Hear np = {s = "hears" ++ np.s ! Obj} ;

}
