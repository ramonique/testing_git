concrete SongIta of Song = {

   lincat
     CN = {s : Str ; g : Gender} ;
     N  = {s : Number => Str ; g : Gender} ;
     A  = {s : Number => Gender => Str } ;

   lin
     song_N = {s = table {Sg => "canzone" ; Pl => "canzone"} ; g = Fem  };
     boy_N =  {s = table {Sg => "ragazzo" ; Pl => "ragazzi"} ; g = Masc };
     beautiful_A =  {s = table {Sg => table {Fem => "bella" ; Masc => "bello"} ; Pl => table {Fem => "belle" ; Masc => "belli"}}};

     AdjN n a = {s = n.s ! Sg ++ a.s ! Sg ! n.g ; g = n.g } ;


   param
     Number = Sg | Pl ;
     Gender = Masc | Fem ;
}