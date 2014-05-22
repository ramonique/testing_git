----------------------------------------------------------------------
-- |
-- Module      : GF.Speech.SISR
--
-- Abstract syntax and pretty printer for SISR,
-- (Semantic Interpretation for Speech Recognition)
----------------------------------------------------------------------
module GF.Speech.SISR (SISRFormat(..), SISRTag, prSISR, 
                       topCatSISR, profileInitSISR, catSISR, profileFinalSISR) where

import Data.List

--import GF.Data.Utilities
--import GF.Infra.Ident
import GF.Infra.Option (SISRFormat(..))
import GF.Speech.CFG
import GF.Speech.SRG (SRGNT)
import PGF(showCId)

import qualified GF.JavaScript.AbsJS   as JS
import qualified GF.JavaScript.PrintJS as JS

type SISRTag = [JS.DeclOrExpr]


prSISR :: SISRTag -> String
prSISR = JS.printTree

topCatSISR :: String -> SISRFormat -> SISRTag
topCatSISR c fmt = map JS.DExpr [fmtOut fmt `ass` fmtRef fmt c]

profileInitSISR :: CFTerm -> SISRFormat -> SISRTag
profileInitSISR t fmt 
    | null (usedArgs t) = []
    | otherwise = [JS.Decl [JS.DInit args (JS.EArray [])]]

usedArgs :: CFTerm -> [Int]
usedArgs (CFObj _ ts) = foldr union [] (map usedArgs ts)
usedArgs (CFAbs _ x) = usedArgs x
usedArgs (CFApp x y) = usedArgs x `union` usedArgs y
usedArgs (CFRes i) = [i]
usedArgs _ = []

catSISR :: CFTerm -> SRGNT -> SISRFormat -> SISRTag
catSISR t (c,i) fmt
        | i `elem` usedArgs t = map JS.DExpr 
            [JS.EIndex (JS.EVar args) (JS.EInt (fromIntegral i)) `ass` fmtRef fmt c]
        | otherwise = []

profileFinalSISR :: CFTerm -> SISRFormat -> SISRTag
profileFinalSISR term fmt = [JS.DExpr $ fmtOut fmt `ass` f term]
  where 
        f (CFObj n ts) = tree (showCId n) (map f ts)
        f (CFAbs v x) = JS.EFun [var v] [JS.SReturn (f x)]
        f (CFApp x y) = JS.ECall (f x) [f y]
        f (CFRes i) = JS.EIndex (JS.EVar args) (JS.EInt (fromIntegral i))
        f (CFVar v) = JS.EVar (var v)
        f (CFMeta typ) = obj [("name",JS.EStr "?"), ("type",JS.EStr (showCId typ))]

fmtOut SISR_WD20030401 = JS.EVar (JS.Ident "$")
fmtOut SISR_1_0 = JS.EVar (JS.Ident "out")

fmtRef SISR_WD20030401 c = JS.EVar (JS.Ident ("$" ++ c))
fmtRef SISR_1_0 c = field (JS.EVar (JS.Ident "rules")) c

args = JS.Ident "a"

var v = JS.Ident ("x" ++ show v)

field x y = JS.EMember x (JS.Ident y)

ass = JS.EAssign

tree n xs = obj [("name", JS.EStr n), ("args", JS.EArray xs)]

obj ps = JS.EObj [JS.Prop (JS.StringPropName x) y | (x,y) <- ps]

