--# -path=.:../romance:../abstract:../common:../prelude

concrete BigLangFre of BigLang = 
  GrammarFre,
  DictFre
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
