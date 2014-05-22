----------------------------------------------------------------------
-- |
-- Module      : CF
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/11/15 17:56:13 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.13 $
--
-- parsing CF grammars and converting them to GF
-----------------------------------------------------------------------------

module GF.Grammar.CF (getCF,CFItem,CFCat,CFFun,cf2gf,CFRule) where

import GF.Grammar.Grammar
import GF.Grammar.Macros
import GF.Infra.Ident(Ident,identS)
import GF.Infra.Option
import GF.Infra.UseIO

import GF.Data.Operations
import GF.Data.Utilities (nub')

import qualified Data.Set as S
import Data.Char
import Data.List
--import System.FilePath

getCF :: ErrorMonad m => FilePath -> String -> m SourceGrammar
getCF fpath = fmap (cf2gf fpath . uniqueFuns) . pCF

---------------------
-- the parser -------
---------------------

pCF :: ErrorMonad m => String -> m CF
pCF s = do
  rules <- mapM getCFRule $ filter isRule $ lines s
  return $ concat rules
 where
   isRule line = case dropWhile isSpace line of
     '-':'-':_ -> False
     _ -> not $ all isSpace line

-- rules have an amazingly easy parser, if we use the format
-- fun. C -> item1 item2 ... where unquoted items are treated as cats
-- Actually would be nice to add profiles to this.

getCFRule :: ErrorMonad m => String -> m [CFRule]
getCFRule s = getcf (wrds s) where
  getcf ws = case ws of
    fun : cat : a : its | isArrow a -> 
      return [L NoLoc (init fun, (cat, map mkIt its))]
    cat : a : its | isArrow a -> 
      return [L NoLoc (mkFun cat it, (cat, map mkIt it)) | it <- chunk its]
    _ -> raise (" invalid rule:" +++ s)
  isArrow a = elem a ["->", "::="] 
  mkIt w = case w of
    ('"':w@(_:_)) -> Right (init w)
    _             -> Left w
  chunk its = case its of
    [] -> [[]]
    _ -> chunks "|" its
  mkFun cat its = case its of
    [] -> cat ++ "_"
    _ -> concat $ intersperse "_" (cat : map clean its) -- CLE style
  clean = filter isAlphaNum -- to form valid identifiers
  wrds = takeWhile (/= ";") . words -- to permit semicolon in the end

type CF = [CFRule]

type CFRule = L (CFFun, (CFCat, [CFItem]))

type CFItem = Either CFCat String

type CFCat = String
type CFFun = String


--------------------------------
-- make function names unique -- 
--------------------------------

uniqueFuns :: CF -> CF
uniqueFuns = snd . mapAccumL uniqueFun S.empty
  where
    uniqueFun funs (L l (fun,rule)) = (S.insert fun' funs,L l (fun',rule))
      where
        fun' = head [fun'|suffix<-"":map show ([2..]::[Int]),
                          let fun'=fun++suffix,
                          not (fun' `S.member` funs)]


--------------------------
-- the compiler ----------
--------------------------

cf2gf :: FilePath -> CF -> SourceGrammar
cf2gf fpath cf = mGrammar [
  (aname, ModInfo MTAbstract MSComplete (modifyFlags (\fs -> fs{optStartCat = Just cat})) [] Nothing [] [] fpath Nothing abs),
  (cname, ModInfo (MTConcrete aname) MSComplete noOptions [] Nothing [] [] fpath Nothing cnc)
  ]
 where
   name = justModuleName fpath
   (abs,cnc,cat) = cf2grammar cf
   aname = identS $ name ++ "Abs"
   cname = identS name


cf2grammar :: CF -> (BinTree Ident Info, BinTree Ident Info, String)
cf2grammar rules = (buildTree abs, buildTree conc, cat) where
  abs   = cats ++ funs
  conc  = lincats ++ lins
  cat   = case rules of
            (L _ (_,(c,_))):_ -> c  -- the value category of the first rule
            _ -> error "empty CF" 
  cats  = [(cat, AbsCat (Just (L NoLoc []))) | 
             cat <- nub' (concat (map cf2cat rules))] ----notPredef cat
  lincats = [(cat, CncCat (Just (L loc defLinType)) Nothing Nothing Nothing Nothing) | (cat,AbsCat (Just (L loc _))) <- cats]
  (funs,lins) = unzip (map cf2rule rules)

cf2cat :: CFRule -> [Ident]
cf2cat (L loc (_,(cat, items))) = map identS $ cat : [c | Left c <- items]

cf2rule :: CFRule -> ((Ident,Info),(Ident,Info))
cf2rule (L loc (fun, (cat, items))) = (def,ldef) where
  f     = identS fun
  def   = (f, AbsFun (Just (L loc (mkProd args' (Cn (identS cat)) []))) Nothing Nothing (Just True))
  args0 = zip (map (identS . ("x" ++) . show) [0..]) items
  args  = [((Explicit,v), Cn (identS c)) | (v, Left c) <- args0]
  args' = [(Explicit,identS "_", Cn (identS c)) | (_, Left c) <- args0]
  ldef  = (f, CncFun 
               Nothing 
               (Just (L loc (mkAbs (map fst args) 
                      (mkRecord (const theLinLabel) [foldconcat (map mkIt args0)]))))
               Nothing
               Nothing)
  mkIt (v, Left _) = P (Vr v) theLinLabel
  mkIt (_, Right a) = K a
  foldconcat [] = K ""
  foldconcat tt = foldr1 C tt
