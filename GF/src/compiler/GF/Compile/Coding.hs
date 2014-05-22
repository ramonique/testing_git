module GF.Compile.Coding where
{-
import GF.Grammar.Grammar
import GF.Grammar.Macros
import GF.Text.Coding
--import GF.Infra.Option
import GF.Data.Operations

--import Data.Char
import System.IO
import qualified Data.ByteString.Char8 as BS

encodeStringsInModule :: TextEncoding -> SourceModule -> SourceModule
encodeStringsInModule enc = codeSourceModule (BS.unpack . encodeUnicode enc)

decodeStringsInModule :: TextEncoding -> SourceModule -> SourceModule
decodeStringsInModule enc mo = codeSourceModule (decodeUnicode enc . BS.pack) mo

codeSourceModule :: (String -> String) -> SourceModule -> SourceModule
codeSourceModule co (id,mo) = (id,mo{jments = mapTree codj (jments mo)})
 where
    codj (c,info) = case info of
      ResOper     pty pt   -> ResOper (codeLTerms co pty) (codeLTerms co pt) 
      ResOverload es tyts  -> ResOverload es [(codeLTerm co ty,codeLTerm co t) | (ty,t) <- tyts]
      CncCat mcat mdef mref mpr mpmcfg -> CncCat mcat (codeLTerms co mdef) (codeLTerms co mref) (codeLTerms co mpr) mpmcfg
      CncFun mty mt mpr mpmcfg -> CncFun mty (codeLTerms co mt) (codeLTerms co mpr) mpmcfg
      _ -> info

codeLTerms co = fmap (codeLTerm co)

codeLTerm :: (String -> String) -> L Term -> L Term
codeLTerm = fmap . codeTerm

codeTerm :: (String -> String) -> Term -> Term
codeTerm co = codt
  where
    codt t = case t of
      K s -> K (co s)
      T ty cs -> T ty [(codp p,codt v) | (p,v) <- cs]
      EPatt p -> EPatt (codp p)
      _ -> composSafeOp codt t

    codp p = case p of  --- really: composOpPatt
      PR rs -> PR [(l,codp p) | (l,p) <- rs]
      PString s -> PString (co s)
      PChars s -> PChars (co s)
      PT x p -> PT x (codp p)
      PAs x p -> PAs x (codp p)
      PNeg p -> PNeg (codp p)
      PRep p -> PRep (codp p)
      PSeq p q -> PSeq (codp p) (codp q)
      PAlt p q -> PAlt (codp p) (codp q)
      _ -> p

-- | Run an encoding function on all string literals within the given string.
codeStringLiterals :: (String -> String) -> String -> String
codeStringLiterals _ [] = []
codeStringLiterals co ('"':cs) = '"' : inStringLiteral cs
  where inStringLiteral [] = error "codeStringLiterals: unterminated string literal"
        inStringLiteral ('"':ds) = '"' : codeStringLiterals co ds
        inStringLiteral ('\\':d:ds) = '\\' : co [d] ++ inStringLiteral ds
        inStringLiteral (d:ds) = co [d] ++ inStringLiteral ds
codeStringLiterals co (c:cs) = c : codeStringLiterals co cs
-}