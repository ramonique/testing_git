-- -*- haskell -*-
{
module GF.Grammar.Lexer
         ( Token(..), Posn(..)
         , P, runP, lexer, getPosn, failLoc
         , isReservedWord
         ) where

import GF.Infra.Ident
--import GF.Data.Operations
import qualified Data.ByteString.Char8 as BS
import qualified Data.ByteString as WBS
import qualified Data.ByteString.Internal as BS(w2c)
import qualified Data.ByteString.UTF8 as UTF8
import qualified Data.Map as Map
import Data.Word(Word8)
--import Debug.Trace(trace)
}


$l = [a-zA-Z\192 - \255] # [\215 \247]
$c = [A-Z\192-\221] # [\215]
$s = [a-z\222-\255] # [\247]
$d = [0-9]                -- digit
$i = [$l $d _ ']          -- identifier character
$u = [.\n]                -- universal: any character

@rsyms =    -- symbols and non-identifier-like reserved words
   \; | \= | \{ | \} | \( | \) | \~ | \* \* | \: | \- \> | \, | \[ | \] | \- | \. | \| | \% | \? | \< | \> | \@ | \# | \! | \* | \+ | \+ \+ | \\ | \\\\ | \= \> | \_ | \$ | \/

:-
"--" [.]* ; -- Toss single line comments
"{-" ([$u # \-] | \- [$u # \}])* ("-")+ "}" ; 

$white+ ;
@rsyms                          { tok ident }
\' ([. # [\' \\ \n]] | (\\ (\' | \\)))+ \' { tok (res T_Ident . identS . unescapeInitTail . unpack) }
(\_ | $l)($l | $d | \_ | \')*   { tok ident }

\" ([$u # [\" \\ \n]] | (\\ (\" | \\ | \' | n | t)))* \" { tok (T_String . unescapeInitTail . unpack) }

(\-)? $d+                       { tok (T_Integer . read . unpack) }
(\-)? $d+ \. $d+ (e (\-)? $d+)? { tok (T_Double  . read . unpack) }

{
unpack = UTF8.toString
--unpack = id

ident = res T_Ident . identC . rawIdentC

--tok :: (String->Token) -> Posn -> String -> Token
tok f p s = f s

data Token
 = T_exclmark
 | T_patt
 | T_int_label
 | T_oparen
 | T_cparen
 | T_tilde
 | T_star
 | T_starstar
 | T_plus
 | T_plusplus
 | T_comma
 | T_minus
 | T_rarrow
 | T_dot
 | T_alt
 | T_colon
 | T_semicolon
 | T_less
 | T_equal
 | T_big_rarrow
 | T_great
 | T_questmark
 | T_obrack
 | T_lam
 | T_lamlam
 | T_cbrack
 | T_ocurly
 | T_bar
 | T_ccurly
 | T_underscore
 | T_at
 | T_PType
 | T_Str
 | T_Strs
 | T_Tok
 | T_Type
 | T_abstract
 | T_case
 | T_cat
 | T_concrete
 | T_data
 | T_def
 | T_flags
 | T_fn
 | T_fun
 | T_in
 | T_incomplete
 | T_instance
 | T_interface
 | T_let
 | T_lin
 | T_lincat
 | T_lindef
 | T_linref
 | T_of
 | T_open
 | T_oper
 | T_param
 | T_pattern
 | T_pre
 | T_printname
 | T_resource
 | T_strs
 | T_table
 | T_transfer
 | T_variants
 | T_where
 | T_with
 | T_String  String          -- string literals
 | T_Integer Int             -- integer literals
 | T_Double  Double          -- double precision float literals
 | T_Ident   Ident
 | T_EOF
-- deriving Show -- debug

res = eitherResIdent
eitherResIdent :: (Ident -> Token) -> Ident -> Token
eitherResIdent tv s = 
  case Map.lookup s resWords of
    Just t  -> t
    Nothing -> tv s

isReservedWord :: Ident -> Bool
isReservedWord ident = Map.member ident resWords

resWords = Map.fromList
 [ b "!"  T_exclmark
 , b "#"  T_patt
 , b "$"  T_int_label
 , b "("  T_oparen
 , b ")"  T_cparen
 , b "~"  T_tilde
 , b "*"  T_star
 , b "**" T_starstar
 , b "+"  T_plus
 , b "++" T_plusplus
 , b ","  T_comma
 , b "-"  T_minus
 , b "->" T_rarrow
 , b "."  T_dot
 , b "/"  T_alt
 , b ":"  T_colon
 , b ";"  T_semicolon
 , b "<"  T_less
 , b "="  T_equal
 , b "=>" T_big_rarrow
 , b ">"  T_great
 , b "?"  T_questmark
 , b "["  T_obrack
 , b "]"  T_cbrack
 , b "\\" T_lam
 , b "\\\\" T_lamlam
 , b "{"  T_ocurly
 , b "}"  T_ccurly
 , b "|"  T_bar
 , b "_"  T_underscore
 , b "@"  T_at
 , b "PType"      T_PType
 , b "Str"        T_Str
 , b "Strs"       T_Strs
 , b "Tok"        T_Tok
 , b "Type"       T_Type
 , b "abstract"   T_abstract
 , b "case"       T_case
 , b "cat"        T_cat
 , b "concrete"   T_concrete
 , b "data"       T_data
 , b "def"        T_def
 , b "flags"      T_flags
 , b "fn"         T_fn
 , b "fun"        T_fun
 , b "in"         T_in
 , b "incomplete" T_incomplete
 , b "instance"   T_instance
 , b "interface"  T_interface
 , b "let"        T_let
 , b "lin"        T_lin
 , b "lincat"     T_lincat
 , b "lindef"     T_lindef
 , b "linref"     T_linref
 , b "of"         T_of
 , b "open"       T_open
 , b "oper"       T_oper
 , b "param"      T_param
 , b "pattern"    T_pattern
 , b "pre"        T_pre
 , b "printname"  T_printname
 , b "resource"   T_resource
 , b "strs"       T_strs
 , b "table"      T_table
 , b "transfer"   T_transfer
 , b "variants"   T_variants
 , b "where"      T_where
 , b "with"       T_with
 ]
 where b s t = (identS s, t)

unescapeInitTail :: String -> String
unescapeInitTail = unesc . tail where
  unesc s = case s of
    '\\':c:cs | elem c ['\"', '\\', '\''] -> c : unesc cs
    '\\':'n':cs  -> '\n' : unesc cs
    '\\':'t':cs  -> '\t' : unesc cs
    '\"':[]    -> []
    '\'':[]    -> []
    c:cs      -> c : unesc cs
    _         -> []

-------------------------------------------------------------------
-- Alex wrapper code.
-- A modified "posn" wrapper.
-------------------------------------------------------------------

data Posn = Pn {-# UNPACK #-} !Int
               {-# UNPACK #-} !Int

alexMove :: Posn -> Char -> Posn
alexMove (Pn l c) '\n' = Pn (l+1) 1
alexMove (Pn l c) _    = Pn l     (c+1)

alexGetByte :: AlexInput -> Maybe (Word8,AlexInput)
alexGetByte (AI p _ s) =
  case WBS.uncons s of
    Nothing  -> Nothing
    Just (w,s) ->
             let p' = alexMove p c
                 c = BS.w2c w
              in p' `seq` Just (w, (AI p' c s))

alexInputPrevChar :: AlexInput -> Char
alexInputPrevChar (AI p c s) = c

data AlexInput = AI {-# UNPACK #-} !Posn            -- current position,
                    {-# UNPACK #-} !Char            -- previous char
                    {-# UNPACK #-} !BS.ByteString   -- current input string

data ParseResult a
  = POk a
  | PFailed Posn	-- The position of the error
            String      -- The error message

newtype P a = P { unP :: AlexInput -> ParseResult a }

instance Monad P where
  return a    = a `seq` (P $ \s -> POk a)
  (P m) >>= k = P $ \ s -> case m s of
                             POk a         -> unP (k a) s
                             PFailed posn err -> PFailed posn err
  fail msg    = P $ \(AI posn _ _) -> PFailed posn msg

runP :: P a -> BS.ByteString -> Either (Posn,String) a
runP (P f) txt =
  case f (AI (Pn 1 0) ' ' txt) of
    POk x           -> Right x
    PFailed pos msg -> Left  (pos,msg)

failLoc :: Posn -> String -> P a
failLoc pos msg = P $ \_ -> PFailed pos msg

lexer :: (Token -> P a) -> P a
lexer cont = P go
  where
  --cont' t = trace (show t) (cont t)
    go inp@(AI pos _ str) =
      case alexScan inp 0 of
        AlexEOF                -> unP (cont T_EOF) inp
        AlexError (AI pos _ _) -> PFailed pos "lexical error"
        AlexSkip  inp' len     -> {-trace (show len) $-} go inp'
        AlexToken inp' len act -> unP (cont (act pos ({-UTF8.toString-} (UTF8.take len str)))) inp'

getPosn :: P Posn
getPosn = P $ \inp@(AI pos _ _) -> POk pos

}
