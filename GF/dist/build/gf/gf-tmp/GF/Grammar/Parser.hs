{-# OPTIONS_GHC -w #-}
{-# OPTIONS -fglasgow-exts -cpp #-}
{-# OPTIONS -fno-warn-overlapping-patterns #-}
module GF.Grammar.Parser
         ( P, runP
         , pModDef
         , pModHeader
         , pExp
         , pTopDef
         ) where

import GF.Infra.Ident
import GF.Infra.Option
import GF.Data.Operations
import GF.Grammar.Predef
import GF.Grammar.Grammar
import GF.Grammar.Macros
import GF.Grammar.Lexer
import GF.Compile.Update (buildAnyTree)
--import Codec.Binary.UTF8.String(decodeString)
--import Data.Char(toLower)
import qualified Data.Array as Happy_Data_Array
import qualified GHC.Exts as Happy_GHC_Exts

-- parser produced by Happy Version 1.18.10

newtype HappyAbsSyn  = HappyAbsSyn HappyAny
#if __GLASGOW_HASKELL__ >= 607
type HappyAny = Happy_GHC_Exts.Any
#else
type HappyAny = forall a . a
#endif
happyIn7 :: (SourceModule) -> (HappyAbsSyn )
happyIn7 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn7 #-}
happyOut7 :: (HappyAbsSyn ) -> (SourceModule)
happyOut7 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut7 #-}
happyIn8 :: (SourceModule) -> (HappyAbsSyn )
happyIn8 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn8 #-}
happyOut8 :: (HappyAbsSyn ) -> (SourceModule)
happyOut8 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut8 #-}
happyIn9 :: (ModuleStatus) -> (HappyAbsSyn )
happyIn9 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn9 #-}
happyOut9 :: (HappyAbsSyn ) -> (ModuleStatus)
happyOut9 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut9 #-}
happyIn10 :: ((ModuleType,Ident)) -> (HappyAbsSyn )
happyIn10 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn10 #-}
happyOut10 :: (HappyAbsSyn ) -> ((ModuleType,Ident))
happyOut10 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut10 #-}
happyIn11 :: (( [(Ident,MInclude)]
                   , Maybe (Ident,MInclude,[(Ident,Ident)])
                   , [OpenSpec]
                   )) -> (HappyAbsSyn )
happyIn11 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn11 #-}
happyOut11 :: (HappyAbsSyn ) -> (( [(Ident,MInclude)]
                   , Maybe (Ident,MInclude,[(Ident,Ident)])
                   , [OpenSpec]
                   ))
happyOut11 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut11 #-}
happyIn12 :: ([OpenSpec]) -> (HappyAbsSyn )
happyIn12 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn12 #-}
happyOut12 :: (HappyAbsSyn ) -> ([OpenSpec])
happyOut12 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut12 #-}
happyIn13 :: (( [(Ident,MInclude)]
             , Maybe (Ident,MInclude,[(Ident,Ident)])
             , Maybe ([OpenSpec],[(Ident,Info)],Options)
             )) -> (HappyAbsSyn )
happyIn13 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn13 #-}
happyOut13 :: (HappyAbsSyn ) -> (( [(Ident,MInclude)]
             , Maybe (Ident,MInclude,[(Ident,Ident)])
             , Maybe ([OpenSpec],[(Ident,Info)],Options)
             ))
happyOut13 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut13 #-}
happyIn14 :: (([OpenSpec],[(Ident,Info)],Options)) -> (HappyAbsSyn )
happyIn14 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn14 #-}
happyOut14 :: (HappyAbsSyn ) -> (([OpenSpec],[(Ident,Info)],Options))
happyOut14 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut14 #-}
happyIn15 :: ([Either [(Ident,Info)] Options]) -> (HappyAbsSyn )
happyIn15 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn15 #-}
happyOut15 :: (HappyAbsSyn ) -> ([Either [(Ident,Info)] Options])
happyOut15 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut15 #-}
happyIn16 :: ([OpenSpec]) -> (HappyAbsSyn )
happyIn16 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn16 #-}
happyOut16 :: (HappyAbsSyn ) -> ([OpenSpec])
happyOut16 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut16 #-}
happyIn17 :: (OpenSpec) -> (HappyAbsSyn )
happyIn17 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn17 #-}
happyOut17 :: (HappyAbsSyn ) -> (OpenSpec)
happyOut17 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut17 #-}
happyIn18 :: ([(Ident,Ident)]) -> (HappyAbsSyn )
happyIn18 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn18 #-}
happyOut18 :: (HappyAbsSyn ) -> ([(Ident,Ident)])
happyOut18 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut18 #-}
happyIn19 :: ((Ident,Ident)) -> (HappyAbsSyn )
happyIn19 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn19 #-}
happyOut19 :: (HappyAbsSyn ) -> ((Ident,Ident))
happyOut19 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut19 #-}
happyIn20 :: ([(Ident,MInclude)]) -> (HappyAbsSyn )
happyIn20 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn20 #-}
happyOut20 :: (HappyAbsSyn ) -> ([(Ident,MInclude)])
happyOut20 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut20 #-}
happyIn21 :: ((Ident,MInclude)) -> (HappyAbsSyn )
happyIn21 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn21 #-}
happyOut21 :: (HappyAbsSyn ) -> ((Ident,MInclude))
happyOut21 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut21 #-}
happyIn22 :: (Either [(Ident,Info)] Options) -> (HappyAbsSyn )
happyIn22 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn22 #-}
happyOut22 :: (HappyAbsSyn ) -> (Either [(Ident,Info)] Options)
happyOut22 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut22 #-}
happyIn23 :: ([(Ident,Info)]) -> (HappyAbsSyn )
happyIn23 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn23 #-}
happyOut23 :: (HappyAbsSyn ) -> ([(Ident,Info)])
happyOut23 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut23 #-}
happyIn24 :: ([(Ident,Info)]) -> (HappyAbsSyn )
happyIn24 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn24 #-}
happyOut24 :: (HappyAbsSyn ) -> ([(Ident,Info)])
happyOut24 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut24 #-}
happyIn25 :: ([(Ident,Info)]) -> (HappyAbsSyn )
happyIn25 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn25 #-}
happyOut25 :: (HappyAbsSyn ) -> ([(Ident,Info)])
happyOut25 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut25 #-}
happyIn26 :: ([(Ident,Info)]) -> (HappyAbsSyn )
happyIn26 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn26 #-}
happyOut26 :: (HappyAbsSyn ) -> ([(Ident,Info)])
happyOut26 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut26 #-}
happyIn27 :: ([(Ident,Info)]) -> (HappyAbsSyn )
happyIn27 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn27 #-}
happyOut27 :: (HappyAbsSyn ) -> ([(Ident,Info)])
happyOut27 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut27 #-}
happyIn28 :: ([(Ident,Info)]) -> (HappyAbsSyn )
happyIn28 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn28 #-}
happyOut28 :: (HappyAbsSyn ) -> ([(Ident,Info)])
happyOut28 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut28 #-}
happyIn29 :: ([(Ident,Info)]) -> (HappyAbsSyn )
happyIn29 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn29 #-}
happyOut29 :: (HappyAbsSyn ) -> ([(Ident,Info)])
happyOut29 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut29 #-}
happyIn30 :: ([(Ident,L Term)]) -> (HappyAbsSyn )
happyIn30 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn30 #-}
happyOut30 :: (HappyAbsSyn ) -> ([(Ident,L Term)])
happyOut30 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut30 #-}
happyIn31 :: (Options) -> (HappyAbsSyn )
happyIn31 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn31 #-}
happyOut31 :: (HappyAbsSyn ) -> (Options)
happyOut31 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut31 #-}
happyIn32 :: ([Ident]) -> (HappyAbsSyn )
happyIn32 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn32 #-}
happyOut32 :: (HappyAbsSyn ) -> ([Ident])
happyOut32 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut32 #-}
happyIn33 :: (L Param) -> (HappyAbsSyn )
happyIn33 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn33 #-}
happyOut33 :: (HappyAbsSyn ) -> (L Param)
happyOut33 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut33 #-}
happyIn34 :: ([(Ident,Info)]) -> (HappyAbsSyn )
happyIn34 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn34 #-}
happyOut34 :: (HappyAbsSyn ) -> ([(Ident,Info)])
happyOut34 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut34 #-}
happyIn35 :: ([(Ident,Info)]) -> (HappyAbsSyn )
happyIn35 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn35 #-}
happyOut35 :: (HappyAbsSyn ) -> ([(Ident,Info)])
happyOut35 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut35 #-}
happyIn36 :: ([(Ident,Info)]) -> (HappyAbsSyn )
happyIn36 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn36 #-}
happyOut36 :: (HappyAbsSyn ) -> ([(Ident,Info)])
happyOut36 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut36 #-}
happyIn37 :: ([(Ident,Info)]) -> (HappyAbsSyn )
happyIn37 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn37 #-}
happyOut37 :: (HappyAbsSyn ) -> ([(Ident,Info)])
happyOut37 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut37 #-}
happyIn38 :: ([(Ident,Info)]) -> (HappyAbsSyn )
happyIn38 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn38 #-}
happyOut38 :: (HappyAbsSyn ) -> ([(Ident,Info)])
happyOut38 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut38 #-}
happyIn39 :: ([(Ident,Info)]) -> (HappyAbsSyn )
happyIn39 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn39 #-}
happyOut39 :: (HappyAbsSyn ) -> ([(Ident,Info)])
happyOut39 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut39 #-}
happyIn40 :: ([(Ident,Info)]) -> (HappyAbsSyn )
happyIn40 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn40 #-}
happyOut40 :: (HappyAbsSyn ) -> ([(Ident,Info)])
happyOut40 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut40 #-}
happyIn41 :: ([(Ident,L Term)]) -> (HappyAbsSyn )
happyIn41 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn41 #-}
happyOut41 :: (HappyAbsSyn ) -> ([(Ident,L Term)])
happyOut41 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut41 #-}
happyIn42 :: (Options) -> (HappyAbsSyn )
happyIn42 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn42 #-}
happyOut42 :: (HappyAbsSyn ) -> (Options)
happyOut42 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut42 #-}
happyIn43 :: ([L Param]) -> (HappyAbsSyn )
happyIn43 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn43 #-}
happyOut43 :: (HappyAbsSyn ) -> ([L Param])
happyOut43 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut43 #-}
happyIn44 :: ([Ident]) -> (HappyAbsSyn )
happyIn44 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn44 #-}
happyOut44 :: (HappyAbsSyn ) -> ([Ident])
happyOut44 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut44 #-}
happyIn45 :: ([Ident]) -> (HappyAbsSyn )
happyIn45 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn45 #-}
happyOut45 :: (HappyAbsSyn ) -> ([Ident])
happyOut45 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut45 #-}
happyIn46 :: (Ident) -> (HappyAbsSyn )
happyIn46 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn46 #-}
happyOut46 :: (HappyAbsSyn ) -> (Ident)
happyOut46 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut46 #-}
happyIn47 :: (Ident) -> (HappyAbsSyn )
happyIn47 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn47 #-}
happyOut47 :: (HappyAbsSyn ) -> (Ident)
happyOut47 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut47 #-}
happyIn48 :: ([Ident]) -> (HappyAbsSyn )
happyIn48 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn48 #-}
happyOut48 :: (HappyAbsSyn ) -> ([Ident])
happyOut48 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut48 #-}
happyIn49 :: ([(Ident, Maybe Type, Maybe Term)]) -> (HappyAbsSyn )
happyIn49 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn49 #-}
happyOut49 :: (HappyAbsSyn ) -> ([(Ident, Maybe Type, Maybe Term)])
happyOut49 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut49 #-}
happyIn50 :: ([(Ident, Maybe Type, Maybe Term)]) -> (HappyAbsSyn )
happyIn50 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn50 #-}
happyOut50 :: (HappyAbsSyn ) -> ([(Ident, Maybe Type, Maybe Term)])
happyOut50 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut50 #-}
happyIn51 :: (Term) -> (HappyAbsSyn )
happyIn51 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn51 #-}
happyOut51 :: (HappyAbsSyn ) -> (Term)
happyOut51 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut51 #-}
happyIn52 :: (Term) -> (HappyAbsSyn )
happyIn52 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn52 #-}
happyOut52 :: (HappyAbsSyn ) -> (Term)
happyOut52 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut52 #-}
happyIn53 :: (Term) -> (HappyAbsSyn )
happyIn53 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn53 #-}
happyOut53 :: (HappyAbsSyn ) -> (Term)
happyOut53 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut53 #-}
happyIn54 :: (Term) -> (HappyAbsSyn )
happyIn54 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn54 #-}
happyOut54 :: (HappyAbsSyn ) -> (Term)
happyOut54 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut54 #-}
happyIn55 :: (Term) -> (HappyAbsSyn )
happyIn55 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn55 #-}
happyOut55 :: (HappyAbsSyn ) -> (Term)
happyOut55 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut55 #-}
happyIn56 :: (Term) -> (HappyAbsSyn )
happyIn56 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn56 #-}
happyOut56 :: (HappyAbsSyn ) -> (Term)
happyOut56 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut56 #-}
happyIn57 :: (Term) -> (HappyAbsSyn )
happyIn57 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn57 #-}
happyOut57 :: (HappyAbsSyn ) -> (Term)
happyOut57 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut57 #-}
happyIn58 :: ([Term]) -> (HappyAbsSyn )
happyIn58 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn58 #-}
happyOut58 :: (HappyAbsSyn ) -> ([Term])
happyOut58 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut58 #-}
happyIn59 :: ([Term]) -> (HappyAbsSyn )
happyIn59 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn59 #-}
happyOut59 :: (HappyAbsSyn ) -> ([Term])
happyOut59 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut59 #-}
happyIn60 :: (Patt) -> (HappyAbsSyn )
happyIn60 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn60 #-}
happyOut60 :: (HappyAbsSyn ) -> (Patt)
happyOut60 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut60 #-}
happyIn61 :: (Patt) -> (HappyAbsSyn )
happyIn61 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn61 #-}
happyOut61 :: (HappyAbsSyn ) -> (Patt)
happyOut61 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut61 #-}
happyIn62 :: (Patt) -> (HappyAbsSyn )
happyIn62 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn62 #-}
happyOut62 :: (HappyAbsSyn ) -> (Patt)
happyOut62 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut62 #-}
happyIn63 :: (Patt) -> (HappyAbsSyn )
happyIn63 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn63 #-}
happyOut63 :: (HappyAbsSyn ) -> (Patt)
happyOut63 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut63 #-}
happyIn64 :: ([(Label,Patt)]) -> (HappyAbsSyn )
happyIn64 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn64 #-}
happyOut64 :: (HappyAbsSyn ) -> ([(Label,Patt)])
happyOut64 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut64 #-}
happyIn65 :: (Label) -> (HappyAbsSyn )
happyIn65 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn65 #-}
happyOut65 :: (HappyAbsSyn ) -> (Label)
happyOut65 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut65 #-}
happyIn66 :: (Ident) -> (HappyAbsSyn )
happyIn66 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn66 #-}
happyOut66 :: (HappyAbsSyn ) -> (Ident)
happyOut66 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut66 #-}
happyIn67 :: ([(Label,Patt)]) -> (HappyAbsSyn )
happyIn67 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn67 #-}
happyOut67 :: (HappyAbsSyn ) -> ([(Label,Patt)])
happyOut67 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut67 #-}
happyIn68 :: ([Patt]) -> (HappyAbsSyn )
happyIn68 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn68 #-}
happyOut68 :: (HappyAbsSyn ) -> ([Patt])
happyOut68 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut68 #-}
happyIn69 :: (Patt) -> (HappyAbsSyn )
happyIn69 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn69 #-}
happyOut69 :: (HappyAbsSyn ) -> (Patt)
happyOut69 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut69 #-}
happyIn70 :: ([(BindType,Ident)]) -> (HappyAbsSyn )
happyIn70 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn70 #-}
happyOut70 :: (HappyAbsSyn ) -> ([(BindType,Ident)])
happyOut70 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut70 #-}
happyIn71 :: ([(BindType,Ident)]) -> (HappyAbsSyn )
happyIn71 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn71 #-}
happyOut71 :: (HappyAbsSyn ) -> ([(BindType,Ident)])
happyOut71 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut71 #-}
happyIn72 :: ([(BindType,Ident)]) -> (HappyAbsSyn )
happyIn72 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn72 #-}
happyOut72 :: (HappyAbsSyn ) -> ([(BindType,Ident)])
happyOut72 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut72 #-}
happyIn73 :: ([(BindType,Ident)]) -> (HappyAbsSyn )
happyIn73 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn73 #-}
happyOut73 :: (HappyAbsSyn ) -> ([(BindType,Ident)])
happyOut73 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut73 #-}
happyIn74 :: ([Hypo]) -> (HappyAbsSyn )
happyIn74 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn74 #-}
happyOut74 :: (HappyAbsSyn ) -> ([Hypo])
happyOut74 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut74 #-}
happyIn75 :: ([Term]) -> (HappyAbsSyn )
happyIn75 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn75 #-}
happyOut75 :: (HappyAbsSyn ) -> ([Term])
happyOut75 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut75 #-}
happyIn76 :: ([Patt]) -> (HappyAbsSyn )
happyIn76 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn76 #-}
happyOut76 :: (HappyAbsSyn ) -> ([Patt])
happyOut76 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut76 #-}
happyIn77 :: (Case) -> (HappyAbsSyn )
happyIn77 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn77 #-}
happyOut77 :: (HappyAbsSyn ) -> (Case)
happyOut77 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut77 #-}
happyIn78 :: ([Case]) -> (HappyAbsSyn )
happyIn78 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn78 #-}
happyOut78 :: (HappyAbsSyn ) -> ([Case])
happyOut78 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut78 #-}
happyIn79 :: ((Term,Term)) -> (HappyAbsSyn )
happyIn79 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn79 #-}
happyOut79 :: (HappyAbsSyn ) -> ((Term,Term))
happyOut79 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut79 #-}
happyIn80 :: ([(Term,Term)]) -> (HappyAbsSyn )
happyIn80 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn80 #-}
happyOut80 :: (HappyAbsSyn ) -> ([(Term,Term)])
happyOut80 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut80 #-}
happyIn81 :: ([Hypo]) -> (HappyAbsSyn )
happyIn81 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn81 #-}
happyOut81 :: (HappyAbsSyn ) -> ([Hypo])
happyOut81 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut81 #-}
happyIn82 :: ([Hypo]) -> (HappyAbsSyn )
happyIn82 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn82 #-}
happyOut82 :: (HappyAbsSyn ) -> ([Hypo])
happyOut82 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut82 #-}
happyIn83 :: (Posn) -> (HappyAbsSyn )
happyIn83 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyIn83 #-}
happyOut83 :: (HappyAbsSyn ) -> (Posn)
happyOut83 x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOut83 #-}
happyInTok :: (Token) -> (HappyAbsSyn )
happyInTok x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyInTok #-}
happyOutTok :: (HappyAbsSyn ) -> (Token)
happyOutTok x = Happy_GHC_Exts.unsafeCoerce# x
{-# INLINE happyOutTok #-}


happyActOffsets :: HappyAddr
happyActOffsets = HappyA# "\x5e\x05\x14\x06\x5e\x05\x9e\x00\x5e\x05\x11\x02\x00\x00\x44\x05\x62\x05\x76\x05\xf7\x00\xe2\x02\x71\x05\x00\x00\x00\x00\x70\x05\x4f\x02\xff\xff\x9e\x00\x00\x00\xbd\x00\x38\x05\x18\x01\x18\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x9e\x00\xcd\x02\xee\xff\x36\x05\x2b\x05\xcd\x02\x61\x05\x56\x05\xba\x02\x54\x05\x00\x00\x00\x00\x00\x00\x00\x00\x6d\x05\x11\x02\x28\x05\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x8d\x01\x28\x05\x00\x00\x00\x00\x5b\x05\x00\x00\x25\x05\x50\x05\x00\x00\xb5\x00\x4e\x05\x00\x00\xb5\x00\x00\x00\x00\x00\x4c\x05\x00\x00\xb5\x00\x40\x05\x00\x00\x1a\x05\x3e\x05\x00\x00\x18\x05\x3d\x05\x00\x00\xb5\x00\x3c\x05\x00\x00\x16\x05\x2e\x05\x00\x00\xab\x00\x2d\x05\x15\x05\x0a\x05\x06\x05\x05\x05\xfb\x04\x9e\x00\xd4\x00\x9e\x00\x31\x02\x9e\x00\x1a\x02\x30\x05\xa5\x02\xa5\x02\xb6\x01\x2c\x05\x0f\x05\xf5\x04\x26\x05\x4f\x00\xfa\x04\x24\x05\x19\x05\xe8\x04\x00\x00\x00\x00\x1f\x05\x10\x05\x00\x00\x08\x05\xa5\x02\xfd\x01\x09\x05\x0c\x05\x0b\x05\xda\x04\x51\x01\x00\x00\xd9\x04\x13\x02\x13\x02\x00\x00\xd8\x04\xd6\x04\x00\x00\x00\x00\x00\x00\x00\x00\x02\x05\x9e\x00\x01\x00\x01\x05\x69\x00\x08\x01\x08\x01\x08\x01\xd3\x00\x34\x00\xf3\x04\xd3\x00\x34\x00\xf9\x04\xee\x00\x00\x00\x00\x00\x9e\x02\xc8\x04\x00\x00\x00\x00\x92\x02\x92\x02\x92\x02\xf0\x04\x47\x01\x00\x00\xbe\x04\x00\x00\x00\x00\xba\x04\xeb\x04\xec\x04\xe4\x04\xe3\x04\xc1\x00\x00\x00\x00\x00\xf4\x04\xdc\x04\x6b\x02\x4f\x02\x88\x01\xc9\x00\xe2\x04\xaa\x01\x34\x00\x00\x00\x00\x00\x34\x00\x34\x00\x6b\x02\xd5\x04\x00\x00\x00\x00\x34\x00\xd1\x04\x34\x00\x03\x01\xd3\x04\x00\x00\xa9\x04\xc6\x04\x34\x00\xa5\x04\x34\x00\x34\x00\xd2\x04\xd2\x04\x47\x02\xce\x04\xc3\x04\xcc\x04\x64\x01\xcb\x04\xc0\x04\xb5\x04\x4d\x01\x34\x00\x13\x02\xb2\x04\x00\x00\x00\x00\x9b\x04\x98\x04\x00\x00\xd8\xff\x89\x04\x58\x02\x6c\x03\xbc\x04\xf6\x00\x85\x04\x00\x00\x6d\x01\xae\x04\x3d\x04\x7a\x04\x00\x00\x4d\x03\xac\x04\x78\x04\xad\x04\x76\x04\x0d\x00\xa8\x04\x37\x03\xa6\x04\x9d\x04\x18\x03\x0d\x00\x4b\x00\x02\x03\x9c\x04\x1c\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x34\x00\x34\x00\x01\x01\x9a\x04\xa1\x00\x68\x04\x00\x00\x00\x00\x00\x00\x34\x00\x00\x00\x34\x00\x99\x04\x00\x00\x34\x00\x00\x00\x3a\x00\x00\x00\x92\x04\x00\x00\x34\x00\x00\x00\x00\x00\x8e\x04\xde\x01\xcd\x01\xe9\x01\x00\x00\x5a\x04\x34\x00\x00\x00\x00\x00\x58\x02\x00\x00\xff\xff\x58\x02\x00\x00\x00\x00\x95\x04\x42\x00\x02\x00\x9f\x00\x59\x04\x56\x04\x00\x00\x83\x04\x82\x04\x00\x00\x4b\x04\x4f\x02\x00\x00\x00\x00\x34\x00\x34\x00\x34\x00\x00\x00\xbe\x01\xbe\x01\x34\x00\xbe\x01\x00\x00\x7d\x04\x00\x00\x00\x00\x62\x04\x00\x00\xbe\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x79\x04\x81\x04\x00\x00\x88\x04\x45\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xbe\x01\x00\x00\x00\x00\x3b\x04\xbe\x01\x00\x00\x00\x00\x00\x00\x65\x04\x6e\x04\x00\x00\x69\x04\x40\x00\x14\x06\x02\x00\x43\x04\x64\x04\x11\x04\x00\x00\x39\x04\x14\x06\x03\x04\x44\x04\xed\x00\x00\x00\x00\x00\xbc\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x2c\x04\x34\x00\x34\x00\x00\x00\x00\x00\x00\x00\x00\x00\x32\x04\x2b\x04\x20\x04\x15\x04\x00\x00\x00\x00\xa9\x01\x00\x00\x00\x00\x00\x00\x00\x00\x14\x04\xe7\x03\x00\x00\x27\x04\xd8\xff\xfe\x03\x05\x04\x00\x00\x00\x00\x00\x00\x00\x00\xf7\x03\x26\x01\x00\x00\x34\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x34\x00\x00\x00\x00\x00\xf4\x03\xb9\x03\x00\x00\x34\x00\x00\x00\x00\x00\xe6\x03\xd6\x03\x00\x00\xb0\x03\x58\x02\x00\x00\x00\x00\x00\x00\x34\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xa3\x03\x00\x00\x00\x00\x34\x00\xce\x03\x00\x00\x90\x03\xc7\x03\xc3\x03\x7e\x03\x99\x03\x68\x03\x00\x00\x00\x00\x00\x00\x34\x00\x34\x00\x00\x00\x00\x00\x00\x00\x00\x00\x6f\x03\x9f\x03\x00\x00\x92\x03\x00\x00\x00\x00\x93\x03\x02\x00\x6e\x03\x14\x06\x00\x00\x4c\x03\xf3\xff\x71\x03\x00\x00\x00\x00\x4b\x03\x00\x00\x4a\x03\x4f\x03\x09\x03\x2e\x03\x00\x00\xec\x02\x25\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xfc\x02\x12\x03\x00\x00\x00\x00\xbb\x02\x00\x00\xe4\x02\x00\x00\xf6\x02\xde\x02\x00\x00\x00\x00\xf3\xff\xf2\x02\xad\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyGotoOffsets :: HappyAddr
happyGotoOffsets = HappyA# "\x0e\x00\xca\x02\x9a\x03\x07\x06\xd1\x02\xc7\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x68\x02\x00\x00\x00\x00\x00\x00\x00\x00\x75\x02\xd7\x03\x5f\x03\x00\x00\x00\x00\x2e\x04\x42\x03\x30\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf7\x05\x55\x02\x04\x04\x00\x00\x00\x00\x0d\x02\x00\x00\x00\x00\xab\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xb9\x02\x00\x00\x06\x00\x13\x00\x47\x00\xd7\x00\x1c\x00\x7a\x00\xc8\x00\xa6\x00\x9a\x00\x4d\x00\x3b\x00\x00\x00\x00\x00\x88\x00\x7b\x00\x00\x00\x00\x00\x8e\x00\x00\x00\x00\x00\xca\x01\x00\x00\x00\x00\x8f\x01\x00\x00\x00\x00\x00\x00\x00\x00\x7c\x01\x00\x00\x00\x00\x9f\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x70\x01\x00\x00\x00\x00\x6c\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x37\x04\x00\x00\xe7\x05\xd4\x01\x1f\x04\xc6\x03\x00\x00\x09\x02\x3c\x01\x00\x00\x00\x00\x00\x00\xe9\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x5b\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xd3\x01\x00\x00\x00\x00\x00\x00\x00\x00\xa6\x03\x00\x00\x00\x00\x00\x00\x46\x04\x45\x03\x00\x00\x00\x00\x99\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xd7\x05\x48\x02\x00\x00\x8a\x03\x90\x02\x88\x02\x70\x02\x98\x03\xc7\x05\x00\x00\xf6\x03\xb7\x05\x00\x00\x0e\x03\x00\x00\x00\x00\x00\x00\x5f\x02\x00\x00\x00\x00\xf5\x00\xf5\x00\xf5\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x4e\x01\x46\x02\x1e\x04\x00\x00\x00\x00\x00\x00\xa7\x05\x00\x00\x00\x00\x2a\x03\x97\x05\x54\x01\x00\x00\x00\x00\x00\x00\x87\x05\x00\x00\x77\x05\x0d\x03\x00\x00\x00\x00\x4e\x02\x00\x00\x67\x05\xd0\x01\x57\x05\x47\x05\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x1e\x04\x00\x00\x00\x00\x00\x00\x1e\x04\x07\x04\xad\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x5e\x02\x00\x00\x4d\x02\xf5\xff\x00\x00\x00\x00\xf4\xff\x00\x00\x08\x04\x00\x00\x36\x02\x67\x00\x00\x00\xf0\xff\x00\x00\x59\x00\x00\x00\x18\x00\x27\x03\x00\x00\x5a\x00\x00\x00\x00\x00\x66\x00\xfd\x02\x00\x00\xfd\xff\x1c\x02\x14\x00\x00\x00\x00\x00\x00\x00\x00\x00\x7d\x00\x00\x00\x37\x05\x27\x05\xf9\x02\x00\x00\xe2\xff\x34\x02\x00\x00\x00\x00\x00\x00\x17\x05\x00\x00\x07\x05\x00\x00\x00\x00\xf7\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xe7\x04\x00\x00\x00\x00\x00\x00\x06\x04\x74\x03\x00\x00\x00\x00\x4b\x02\xd7\x04\x00\x00\x00\x00\x0a\x02\x06\x02\xbf\x03\xdd\x01\x00\x00\x00\x00\x00\x00\x00\x00\x0f\x03\x00\x00\x00\x00\x3c\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf2\x01\x00\x00\x00\x00\xef\x03\xaf\x03\x91\x03\x00\x00\xa0\x03\xaa\x02\xc7\x04\x97\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xea\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x10\x03\x00\x00\x00\x00\x30\x01\x36\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xd2\x01\x05\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xcf\x01\xe8\x02\xe7\x02\x0e\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xb7\x04\xa7\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xd3\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x2f\x01\x00\x00\x41\x02\x6f\x01\x00\x00\x00\x00\x00\x00\x00\x00\xfa\x01\xf6\x01\x00\x00\x00\x00\x00\x00\x97\x04\xd1\x01\x00\x00\xc8\x01\xba\x01\xb1\x01\x87\x04\x62\x01\x60\x01\x00\x00\x2a\x01\x00\x00\x77\x04\x00\x00\x55\x01\x4f\x01\x00\x00\x49\x01\x00\x00\x52\x01\x00\x00\x52\x00\x00\x00\x67\x04\x00\x00\x35\x01\x00\x00\x00\x00\x00\x00\x00\x00\x0a\x01\x00\x00\x00\x00\x00\x00\x00\x00\xfe\x00\x00\x00\x20\x01\x00\x00\x00\x00\x57\x04\xf8\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x12\x01\x00\x00\x00\x00\x00\x00\xdb\x02\x47\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xdf\x01\x00\x00\x89\x00\x00\x00\x00\x00\x2e\x01\x23\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x01\x2c\x01\xf1\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xe1\x00\x00\x00\xa4\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xcc\x00\x00\x00\x64\x00\xe3\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyDefActions :: HappyAddr
happyDefActions = HappyA# "\xf9\xff\x00\x00\xf9\xff\x00\x00\x00\x00\x00\x00\xf8\xff\x00\x00\x81\xff\x7f\xff\x7d\xff\x76\xff\x69\xff\x67\xff\x65\xff\x00\x00\x00\x00\x00\x00\x21\xff\x61\xff\x00\x00\x8d\xff\x00\x00\x00\x00\x38\xff\x36\xff\x35\xff\x37\xff\x39\xff\x00\x00\x00\x00\x8d\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x63\xff\x62\xff\x64\xff\x66\xff\x00\x00\x00\x00\x00\x00\x11\xff\x11\xff\x11\xff\x11\xff\x11\xff\x11\xff\x11\xff\x11\xff\x11\xff\x11\xff\x11\xff\x00\x00\x00\x00\x11\xff\x11\xff\x00\x00\xcd\xff\x11\xff\x00\x00\xcc\xff\x11\xff\x00\x00\xc9\xff\x11\xff\xca\xff\xcb\xff\x00\x00\xc8\xff\x11\xff\x00\x00\xd0\xff\x00\x00\x00\x00\xc5\xff\x00\x00\x00\x00\xcf\xff\x11\xff\x00\x00\xce\xff\x00\x00\x00\x00\xd1\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x59\xff\x00\x00\x00\x00\x8d\xff\x59\xff\x00\x00\x6c\xff\x00\x00\x00\x00\x00\x00\x8c\xff\x00\x00\x8d\xff\x9a\xff\x00\x00\x00\x00\x25\xff\x00\x00\x00\x00\x27\xff\x28\xff\x00\x00\x00\x00\x60\xff\x00\x00\x56\xff\x20\xff\x00\x00\x00\x00\x00\x00\x8d\xff\x66\xff\x6d\xff\x00\x00\x00\x00\x1e\xff\x49\xff\x00\x00\x34\xff\x45\xff\x42\xff\x41\xff\x40\xff\x44\xff\x00\x00\x00\x00\x75\xff\x8d\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x8a\xff\x80\xff\x7d\xff\x8d\xff\x86\xff\x7e\xff\x77\xff\x78\xff\x7c\xff\x00\x00\x66\xff\x68\xff\x00\x00\x3b\xff\x87\xff\x00\x00\x00\x00\x33\xff\x00\x00\x00\x00\x1d\xff\x52\xff\x4e\xff\x4a\xff\x00\x00\x00\x00\x00\x00\x44\xff\x00\x00\x47\xff\x00\x00\x00\x00\x5a\xff\x5c\xff\x21\xff\x00\x00\x56\xff\x00\x00\x5e\xff\x5d\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x82\xff\x00\x00\x00\x00\x00\x00\x8d\xff\x00\x00\x00\x00\x6a\xff\x6b\xff\x00\x00\x1a\xff\x00\x00\x40\xff\x44\xff\x58\xff\x00\x00\x00\x00\x44\xff\x59\xff\x00\x00\x00\x00\xf6\xff\xf5\xff\x00\x00\x00\x00\xf7\xff\xeb\xff\x00\x00\x13\xff\x11\xff\x00\x00\x9a\xff\xa4\xff\x94\xff\x92\xff\x00\x00\x00\x00\x11\xff\x96\xff\x11\xff\x00\x00\x9e\xff\x00\x00\xa6\xff\x92\xff\x00\x00\x11\xff\x92\xff\x00\x00\x11\xff\x92\xff\x00\x00\x11\xff\x11\xff\xa2\xff\xc6\xff\xc7\xff\xa1\xff\xbb\xff\x11\xff\xa9\xff\x00\x00\x00\x00\x2a\xff\x00\x00\x11\xff\x00\x00\x2c\xff\x2d\xff\x9f\xff\x00\x00\xad\xff\x00\x00\x00\x00\xa5\xff\x00\x00\x9d\xff\x00\x00\xab\xff\x00\x00\x95\xff\x00\x00\x2f\xff\x4a\xff\x00\x00\x31\xff\x34\xff\x44\xff\xa3\xff\x00\x00\x00\x00\xa7\xff\x14\xff\x13\xff\x11\xff\x00\x00\x13\xff\xfa\xff\xec\xff\xef\xff\xd6\xff\x00\x00\xd4\xff\x00\x00\x00\x00\x72\xff\x00\x00\x00\x00\x51\xff\x00\x00\x00\x00\x7b\xff\x6e\xff\x59\xff\x00\x00\x00\x00\x71\xff\x00\x00\x00\x00\x00\x00\x00\x00\x8f\xff\x90\xff\x8b\xff\x84\xff\x00\x00\x99\xff\x00\x00\x24\xff\x88\xff\x26\xff\x89\xff\x5f\xff\x55\xff\x00\x00\x20\xff\x1f\xff\x00\x00\x00\x00\x3d\xff\x4c\xff\x4b\xff\x3e\xff\x4f\xff\x1e\xff\x48\xff\x3f\xff\x34\xff\x00\x00\x43\xff\x3a\xff\x74\xff\x00\x00\xfb\xff\xe3\xff\xe6\xff\xd6\xff\xdf\xff\x00\x00\x00\x00\xdd\xff\x00\x00\xdb\xff\x00\x00\xdf\xff\x00\x00\x00\x00\x00\x00\xe2\xff\x83\xff\x3c\xff\x32\xff\x1c\xff\x46\xff\x23\xff\x5b\xff\x00\x00\x00\x00\x00\x00\x54\xff\x1b\xff\x53\xff\x19\xff\x00\x00\x17\xff\x00\x00\x00\x00\x57\xff\x4d\xff\x43\xff\x79\xff\x7a\xff\xf3\xff\xf4\xff\x00\x00\x00\x00\xea\xff\x00\x00\xeb\xff\x00\x00\x00\x00\xc4\xff\x12\xff\x11\xff\x11\xff\xb1\xff\x00\x00\x30\xff\x00\x00\x11\xff\x93\xff\x11\xff\x11\xff\x11\xff\x00\x00\x11\xff\x11\xff\x00\x00\x98\xff\x91\xff\x00\x00\x29\xff\x11\xff\x11\xff\x9c\xff\x11\xff\x00\x00\x13\xff\xbc\xff\x11\xff\xba\xff\x00\x00\xb9\xff\x11\xff\x97\xff\x2b\xff\xb4\xff\xb6\xff\x11\xff\xc1\xff\xb3\xff\xb2\xff\xc0\xff\x11\xff\x2e\xff\x00\x00\xbe\xff\xbd\xff\x00\x00\x11\xff\xf0\xff\x00\x00\xed\xff\xd9\xff\x00\x00\x00\x00\x00\x00\x50\xff\x6f\xff\x70\xff\x00\x00\x00\x00\x8e\xff\x85\xff\x73\xff\xe7\xff\x00\x00\xe4\xff\xd5\xff\xd6\xff\xde\xff\xe1\xff\x00\x00\x00\x00\x00\x00\xdf\xff\xdc\xff\x00\x00\x00\x00\x00\x00\x18\xff\x16\xff\x00\x00\xd3\xff\x00\x00\x00\x00\xeb\xff\x00\x00\xc3\xff\x00\x00\x00\x00\xb0\xff\xbf\xff\xb5\xff\xb8\xff\x11\xff\x9b\xff\x11\xff\xaf\xff\xb7\xff\x15\xff\x00\x00\xf1\xff\xee\xff\xd8\xff\x00\x00\xd2\xff\xe8\xff\xe5\xff\x00\x00\x00\x00\xe0\xff\xda\xff\x00\x00\x00\x00\xeb\xff\x11\xff\xc2\xff\xf2\xff\xd7\xff\xe9\xff"#

happyCheck :: HappyAddr
happyCheck = HappyA# "\xff\xff\x02\x00\x12\x00\x04\x00\x03\x00\x10\x00\x04\x00\x13\x00\x1a\x00\x27\x00\x28\x00\x29\x00\x1c\x00\x1a\x00\x00\x00\x37\x00\x02\x00\x12\x00\x15\x00\x1e\x00\x20\x00\x16\x00\x10\x00\x18\x00\x0b\x00\x1a\x00\x1d\x00\x1c\x00\x1d\x00\x1e\x00\x46\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x1e\x00\x26\x00\x13\x00\x1a\x00\x14\x00\x11\x00\x37\x00\x1e\x00\x2d\x00\x11\x00\x4c\x00\x4c\x00\x31\x00\x32\x00\x33\x00\x20\x00\x46\x00\x21\x00\x02\x00\x1f\x00\x04\x00\x3a\x00\x3b\x00\x1f\x00\x4c\x00\x3e\x00\x3f\x00\x40\x00\x4c\x00\x4c\x00\x43\x00\x44\x00\x45\x00\x46\x00\x12\x00\x46\x00\x46\x00\x4c\x00\x16\x00\x0b\x00\x18\x00\x0b\x00\x1a\x00\x14\x00\x1c\x00\x1d\x00\x4c\x00\x46\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x12\x00\x26\x00\x10\x00\x21\x00\x0e\x00\x13\x00\x4c\x00\x4c\x00\x2d\x00\x15\x00\x1c\x00\x4c\x00\x31\x00\x32\x00\x33\x00\x4c\x00\x05\x00\x1d\x00\x02\x00\x1a\x00\x04\x00\x3a\x00\x3b\x00\x16\x00\x18\x00\x3e\x00\x3f\x00\x40\x00\x1b\x00\x24\x00\x43\x00\x44\x00\x45\x00\x46\x00\x12\x00\x23\x00\x17\x00\x44\x00\x16\x00\x46\x00\x18\x00\x42\x00\x1a\x00\x42\x00\x1c\x00\x1d\x00\x4c\x00\x22\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x27\x00\x26\x00\x16\x00\x08\x00\x17\x00\x4c\x00\x45\x00\x1b\x00\x2d\x00\x1a\x00\x0f\x00\x4c\x00\x31\x00\x32\x00\x33\x00\x22\x00\x4c\x00\x17\x00\x02\x00\x24\x00\x04\x00\x3a\x00\x3b\x00\x4c\x00\x4c\x00\x3e\x00\x3f\x00\x40\x00\x22\x00\x0c\x00\x43\x00\x44\x00\x45\x00\x46\x00\x12\x00\x17\x00\x4c\x00\x4c\x00\x16\x00\x27\x00\x18\x00\x18\x00\x1a\x00\x18\x00\x1c\x00\x1d\x00\x22\x00\x17\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x18\x00\x26\x00\x09\x00\x4c\x00\x4c\x00\x22\x00\x4c\x00\x09\x00\x2d\x00\x0b\x00\x18\x00\x05\x00\x31\x00\x32\x00\x33\x00\x09\x00\x07\x00\x4c\x00\x02\x00\x19\x00\x04\x00\x3a\x00\x3b\x00\x4c\x00\x1f\x00\x3e\x00\x3f\x00\x40\x00\x17\x00\x1f\x00\x43\x00\x44\x00\x45\x00\x46\x00\x12\x00\x4c\x00\x46\x00\x1f\x00\x16\x00\x22\x00\x18\x00\x18\x00\x1a\x00\x1a\x00\x18\x00\x4c\x00\x46\x00\x4c\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x01\x00\x26\x00\x23\x00\x46\x00\x0b\x00\x0c\x00\x07\x00\x08\x00\x09\x00\x0b\x00\x45\x00\x46\x00\x0d\x00\x32\x00\x33\x00\x1a\x00\x1a\x00\x13\x00\x02\x00\x14\x00\x04\x00\x3a\x00\x3b\x00\x0b\x00\x0c\x00\x3e\x00\x3f\x00\x40\x00\x4c\x00\x07\x00\x43\x00\x44\x00\x45\x00\x46\x00\x12\x00\x1a\x00\x0e\x00\x1a\x00\x16\x00\x1e\x00\x18\x00\x1e\x00\x1a\x00\x4c\x00\x37\x00\x37\x00\x31\x00\x32\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x4c\x00\x26\x00\x09\x00\x3b\x00\x05\x00\x1a\x00\x46\x00\x46\x00\x07\x00\x1e\x00\x25\x00\x41\x00\x19\x00\x32\x00\x33\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x1b\x00\x3a\x00\x3b\x00\x4c\x00\x1f\x00\x3e\x00\x46\x00\x40\x00\x46\x00\x4c\x00\x43\x00\x44\x00\x45\x00\x46\x00\x02\x00\x26\x00\x04\x00\x0b\x00\x06\x00\x25\x00\x25\x00\x4c\x00\x10\x00\x0b\x00\x0c\x00\x13\x00\x0e\x00\x0b\x00\x10\x00\x46\x00\x12\x00\x13\x00\x10\x00\x46\x00\x16\x00\x17\x00\x18\x00\x02\x00\x1a\x00\x04\x00\x39\x00\x06\x00\x1e\x00\x3c\x00\x31\x00\x32\x00\x02\x00\x0c\x00\x04\x00\x0e\x00\x06\x00\x05\x00\x11\x00\x12\x00\x3b\x00\x0b\x00\x0c\x00\x16\x00\x17\x00\x18\x00\x0e\x00\x1a\x00\x12\x00\x32\x00\x4c\x00\x1e\x00\x16\x00\x32\x00\x18\x00\x32\x00\x1a\x00\x34\x00\x3b\x00\x02\x00\x1e\x00\x04\x00\x3b\x00\x06\x00\x3b\x00\x43\x00\x44\x00\x45\x00\x46\x00\x0c\x00\x4c\x00\x0e\x00\x27\x00\x28\x00\x29\x00\x12\x00\x4c\x00\x4a\x00\x4b\x00\x16\x00\x17\x00\x18\x00\x4c\x00\x1a\x00\x27\x00\x28\x00\x29\x00\x1e\x00\x43\x00\x44\x00\x45\x00\x46\x00\x02\x00\x4c\x00\x04\x00\x4c\x00\x06\x00\x43\x00\x44\x00\x45\x00\x46\x00\x27\x00\x0c\x00\x27\x00\x28\x00\x29\x00\x2c\x00\x10\x00\x12\x00\x4c\x00\x13\x00\x25\x00\x16\x00\x02\x00\x18\x00\x04\x00\x1a\x00\x06\x00\x1b\x00\x10\x00\x1e\x00\x4c\x00\x13\x00\x0c\x00\x43\x00\x44\x00\x45\x00\x46\x00\x02\x00\x12\x00\x04\x00\x39\x00\x06\x00\x16\x00\x3c\x00\x18\x00\x08\x00\x1a\x00\x0c\x00\x08\x00\x4c\x00\x1e\x00\x32\x00\x0f\x00\x12\x00\x02\x00\x0f\x00\x04\x00\x16\x00\x06\x00\x18\x00\x3b\x00\x1a\x00\x09\x00\x0a\x00\x0c\x00\x1e\x00\x43\x00\x44\x00\x45\x00\x46\x00\x12\x00\x27\x00\x28\x00\x29\x00\x16\x00\x25\x00\x18\x00\x0e\x00\x1a\x00\x25\x00\x2a\x00\x2b\x00\x1e\x00\x4c\x00\x2a\x00\x2b\x00\x17\x00\x43\x00\x44\x00\x45\x00\x46\x00\x32\x00\x4c\x00\x34\x00\x0b\x00\x35\x00\x36\x00\x37\x00\x38\x00\x10\x00\x3b\x00\x32\x00\x43\x00\x44\x00\x45\x00\x46\x00\x4c\x00\x02\x00\x4c\x00\x04\x00\x3b\x00\x06\x00\x46\x00\x47\x00\x02\x00\x4c\x00\x04\x00\x0c\x00\x06\x00\x43\x00\x44\x00\x45\x00\x46\x00\x12\x00\x0c\x00\x4a\x00\x4b\x00\x16\x00\x38\x00\x18\x00\x12\x00\x1a\x00\x0b\x00\x0c\x00\x16\x00\x1e\x00\x18\x00\x02\x00\x1a\x00\x04\x00\x25\x00\x06\x00\x1e\x00\x28\x00\x31\x00\x32\x00\x32\x00\x0c\x00\x31\x00\x32\x00\x2f\x00\x30\x00\x4c\x00\x12\x00\x3b\x00\x3b\x00\x4c\x00\x16\x00\x3b\x00\x18\x00\x0e\x00\x1a\x00\x0b\x00\x0c\x00\x3d\x00\x1e\x00\x09\x00\x02\x00\x4c\x00\x04\x00\x4a\x00\x4b\x00\x43\x00\x44\x00\x45\x00\x46\x00\x26\x00\x14\x00\x04\x00\x43\x00\x44\x00\x45\x00\x46\x00\x12\x00\x04\x00\x05\x00\x19\x00\x16\x00\x1f\x00\x18\x00\x4c\x00\x1a\x00\x12\x00\x0d\x00\x0e\x00\x1e\x00\x16\x00\x04\x00\x18\x00\x3b\x00\x1a\x00\x25\x00\x43\x00\x44\x00\x45\x00\x46\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x12\x00\x38\x00\x32\x00\x25\x00\x16\x00\x3a\x00\x18\x00\x25\x00\x1a\x00\x31\x00\x32\x00\x3b\x00\x2a\x00\x2b\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x3b\x00\x25\x00\x43\x00\x44\x00\x45\x00\x46\x00\x04\x00\x4a\x00\x4b\x00\x31\x00\x32\x00\x43\x00\x44\x00\x45\x00\x46\x00\x01\x00\x30\x00\x31\x00\x32\x00\x3b\x00\x12\x00\x07\x00\x08\x00\x09\x00\x16\x00\x04\x00\x18\x00\x3b\x00\x1a\x00\x38\x00\x43\x00\x44\x00\x45\x00\x46\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x12\x00\x30\x00\x31\x00\x32\x00\x16\x00\x03\x00\x18\x00\x04\x00\x1a\x00\x30\x00\x31\x00\x32\x00\x3b\x00\x25\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x03\x00\x3b\x00\x12\x00\x36\x00\x37\x00\x38\x00\x16\x00\x04\x00\x18\x00\x02\x00\x1a\x00\x43\x00\x44\x00\x45\x00\x46\x00\x0f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x12\x00\x36\x00\x37\x00\x38\x00\x16\x00\x37\x00\x18\x00\x04\x00\x1a\x00\x43\x00\x44\x00\x45\x00\x46\x00\x08\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x0b\x00\x0c\x00\x12\x00\x0d\x00\x0e\x00\x05\x00\x16\x00\x1b\x00\x18\x00\x05\x00\x1a\x00\x43\x00\x44\x00\x45\x00\x46\x00\x46\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x09\x00\x0a\x00\x43\x00\x44\x00\x45\x00\x46\x00\x06\x00\x07\x00\x3b\x00\x1b\x00\x09\x00\x0a\x00\x08\x00\x0d\x00\x0e\x00\x1b\x00\x43\x00\x35\x00\x36\x00\x37\x00\x38\x00\x48\x00\x49\x00\x43\x00\x44\x00\x45\x00\x46\x00\x27\x00\x05\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x43\x00\x46\x00\x47\x00\x04\x00\x1b\x00\x32\x00\x33\x00\x34\x00\x35\x00\x3f\x00\x40\x00\x38\x00\x39\x00\x3f\x00\x40\x00\x3c\x00\x27\x00\x37\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x35\x00\x36\x00\x37\x00\x38\x00\x47\x00\x32\x00\x33\x00\x34\x00\x35\x00\x41\x00\x42\x00\x38\x00\x39\x00\x1b\x00\x04\x00\x3c\x00\x45\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x13\x00\x27\x00\x47\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x19\x00\x3b\x00\x3f\x00\x40\x00\x1b\x00\x32\x00\x33\x00\x34\x00\x35\x00\x43\x00\x44\x00\x38\x00\x39\x00\x41\x00\x42\x00\x3c\x00\x27\x00\x04\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x35\x00\x36\x00\x37\x00\x38\x00\x47\x00\x32\x00\x33\x00\x34\x00\x35\x00\x41\x00\x42\x00\x38\x00\x39\x00\x1b\x00\x1a\x00\x3c\x00\x45\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x46\x00\x27\x00\x47\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x25\x00\x3b\x00\x01\x00\x02\x00\x0b\x00\x32\x00\x33\x00\x34\x00\x35\x00\x43\x00\x44\x00\x38\x00\x39\x00\x13\x00\x08\x00\x3c\x00\x35\x00\x36\x00\x37\x00\x38\x00\x39\x00\x46\x00\x25\x00\x3c\x00\x42\x00\x19\x00\x47\x00\x2a\x00\x2b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x46\x00\x3b\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x25\x00\x3b\x00\x43\x00\x0b\x00\x08\x00\x2a\x00\x2b\x00\x42\x00\x3b\x00\x43\x00\x35\x00\x36\x00\x37\x00\x38\x00\x48\x00\x49\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x35\x00\x36\x00\x37\x00\x38\x00\x46\x00\x47\x00\x1a\x00\x46\x00\x3b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x43\x00\x46\x00\x47\x00\x1f\x00\x46\x00\x48\x00\x49\x00\x13\x00\x3b\x00\x35\x00\x36\x00\x37\x00\x38\x00\x46\x00\x41\x00\x42\x00\x43\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x37\x00\x38\x00\x46\x00\x47\x00\x25\x00\x1b\x00\x3d\x00\x3e\x00\x3b\x00\x2a\x00\x2b\x00\x10\x00\x1f\x00\x19\x00\x41\x00\x42\x00\x43\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x33\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x25\x00\x3b\x00\x04\x00\x18\x00\x46\x00\x2a\x00\x2b\x00\x1b\x00\x3b\x00\x43\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x33\x00\x1b\x00\x11\x00\x37\x00\x38\x00\x37\x00\x38\x00\x0f\x00\x3b\x00\x3d\x00\x3e\x00\x3d\x00\x3e\x00\x1b\x00\x04\x00\x46\x00\x43\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x33\x00\x25\x00\x1b\x00\x37\x00\x38\x00\x46\x00\x2a\x00\x2b\x00\x3b\x00\x3d\x00\x3e\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x43\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x33\x00\x35\x00\x36\x00\x37\x00\x38\x00\x0b\x00\x2d\x00\x08\x00\x3b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x43\x00\x35\x00\x36\x00\x37\x00\x38\x00\x11\x00\x1b\x00\x46\x00\x3b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x43\x00\x46\x00\x0b\x00\x05\x00\x15\x00\x2d\x00\x13\x00\x46\x00\x3b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x43\x00\x19\x00\x46\x00\x08\x00\x1b\x00\x46\x00\x46\x00\x13\x00\x3b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x43\x00\x19\x00\x13\x00\x13\x00\x46\x00\x13\x00\x13\x00\x0b\x00\x3b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x43\x00\x13\x00\x46\x00\x10\x00\x46\x00\x13\x00\x46\x00\x13\x00\x3b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x43\x00\x46\x00\x10\x00\x1b\x00\x36\x00\x46\x00\x1b\x00\x36\x00\x3b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x43\x00\x1b\x00\x11\x00\x11\x00\x1b\x00\x11\x00\x0e\x00\x1b\x00\x3b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x43\x00\x46\x00\x1b\x00\x1a\x00\x19\x00\x46\x00\x0e\x00\x15\x00\x3b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x43\x00\x07\x00\x19\x00\x11\x00\x13\x00\x1b\x00\x46\x00\x43\x00\x3b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x43\x00\x1b\x00\x13\x00\x1a\x00\x46\x00\x0e\x00\x0e\x00\x05\x00\x3b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x43\x00\x10\x00\x46\x00\x45\x00\x15\x00\x46\x00\x46\x00\x19\x00\x3b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x43\x00\x1b\x00\x0d\x00\x14\x00\x46\x00\x0b\x00\x36\x00\x0b\x00\x3b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x43\x00\x46\x00\x2d\x00\x11\x00\x0e\x00\x11\x00\x13\x00\x46\x00\x3b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x43\x00\x46\x00\x46\x00\x11\x00\x11\x00\x11\x00\x46\x00\x11\x00\x3b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x43\x00\x46\x00\x46\x00\x11\x00\x46\x00\x11\x00\x46\x00\x11\x00\x3b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x43\x00\x46\x00\x11\x00\x00\x00\x1a\x00\x47\x00\x1a\x00\x46\x00\x3b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x43\x00\x1a\x00\x46\x00\x0d\x00\x46\x00\x0e\x00\x0a\x00\x1f\x00\x3b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x43\x00\x47\x00\x2e\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x3b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x43\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x3b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x43\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x3b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x43\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x3b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x43\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x3b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x43\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x3b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x43\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x3b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x43\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x3b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x43\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x3b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x43\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x3b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x43\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x3b\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x30\x00\x31\x00\x32\x00\x43\x00\x27\x00\xff\xff\x29\x00\x2a\x00\x2b\x00\x2c\x00\xff\xff\x3b\x00\xff\xff\xff\xff\xff\xff\x32\x00\x33\x00\x34\x00\x35\x00\x43\x00\xff\xff\x38\x00\x39\x00\xff\xff\xff\xff\x3c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff"#

happyTable :: HappyAddr
happyTable = HappyA# "\x00\x00\x11\x00\x51\x00\x12\x00\xa7\x00\x57\x00\x69\x01\x54\x00\x6d\x00\xe8\x00\xf6\x00\xa2\x01\x15\x01\x65\x01\x3a\x00\x2d\x01\x05\x00\x13\x00\x40\x00\x22\x01\x1f\x01\x14\x00\x57\x00\x15\x00\x09\x01\x7f\x00\x03\x01\x17\x00\x18\x00\x74\x00\x2e\x01\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x58\x00\x1e\x00\x54\x00\x0a\x01\x3d\x00\x4b\x00\x66\x01\x0b\x01\x1f\x00\x4b\x00\xeb\x00\x04\x02\x20\x00\x21\x00\x22\x00\x55\x00\x6e\x00\x00\x01\x11\x00\x11\x01\x12\x00\x23\x00\x24\x00\x4c\x00\x53\x00\x25\x00\x26\x00\x27\x00\x56\x00\x59\x00\x28\x00\x29\x00\x2a\x00\x80\x00\x13\x00\xa8\x00\x6a\x01\x42\x00\x14\x00\x6d\x01\x15\x00\x6d\x01\x16\x00\x3d\x00\x17\x00\x18\x00\x59\x00\x0c\x01\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x51\x00\x1e\x00\x05\x01\x3e\x00\x8e\x00\x06\x01\x56\x00\x3f\x00\x1f\x00\x40\x00\x52\x00\x4d\x00\x20\x00\x21\x00\x22\x00\x4d\x00\x05\x02\x41\x00\x11\x00\xa7\x01\x12\x00\x23\x00\x24\x00\x48\x00\x4e\x00\x25\x00\x26\x00\x27\x00\x0e\x01\xef\x01\x28\x00\x29\x00\x2a\x00\x2b\x00\x13\x00\x13\x01\x43\x00\x9b\x01\x14\x00\x9c\x01\x15\x00\x6e\x01\x16\x00\x8d\x01\x17\x00\x18\x00\x3f\x00\x0c\x01\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x16\x01\x1e\x00\x48\x00\xfd\x01\x43\x00\x53\x00\xc8\x00\x49\x00\x1f\x00\xa7\x01\x6b\x01\x42\x00\x20\x00\x21\x00\x22\x00\xfe\x00\xa9\x01\x43\x00\x11\x00\xa8\x01\x12\x00\x23\x00\x24\x00\x50\x00\x4a\x00\x25\x00\x26\x00\x27\x00\xff\x00\x8a\x01\x28\x00\x29\x00\x2a\x00\xa5\x00\x13\x00\x43\x00\x45\x00\xeb\x00\x14\x00\xfc\x00\x15\x00\x8b\x01\x16\x00\xed\x00\x17\x00\x18\x00\x44\x00\x43\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\xe3\x00\x1e\x00\x3e\x01\x4a\x00\x45\x00\x46\x00\xa9\x01\x3e\x01\x1f\x00\x58\x01\xed\x00\x53\x01\x20\x00\x21\x00\x22\x00\x3e\x01\x07\x02\x45\x00\x11\x00\x78\x00\x63\x00\x23\x00\x24\x00\xeb\x00\x40\x01\x25\x00\x26\x00\x27\x00\x43\x00\x40\x01\x28\x00\x29\x00\x2a\x00\x2b\x00\x13\x00\x45\x00\xee\x00\x40\x01\x14\x00\x47\x00\x15\x00\xda\x00\x16\x00\xdb\x00\x4e\x00\xf1\x01\xe4\x00\x45\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x91\x00\x1e\x00\x4f\x00\xee\x00\xf5\x01\xc4\x01\x92\x00\x93\x00\x94\x00\xc9\x00\x79\x00\x7a\x00\x22\xff\x21\x00\x22\x00\x65\x01\x65\x01\x21\x01\x11\x00\x95\x00\x63\x00\x23\x00\x24\x00\xf7\x01\xc4\x01\x25\x00\x26\x00\x27\x00\x45\x00\xd0\x01\x28\x00\x29\x00\x2a\x00\x2b\x00\x13\x00\x0a\x01\xd1\x01\x73\x00\x14\x00\x0b\x01\x15\x00\x74\x00\x16\x00\x50\x00\x66\x01\x66\x01\x8e\x00\x0d\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\xf2\x01\x1e\x00\x3e\x01\x0e\x00\xf6\x01\x73\x00\x2e\x01\x2e\x01\xfb\x01\x74\x00\xe1\x01\x96\x00\xea\x01\x21\x00\x22\x00\x11\xff\x11\xff\x11\xff\x11\xff\x11\xff\xbc\x01\x23\x00\x24\x00\xe7\x01\x40\x01\x25\x00\x0c\x01\x27\x00\x75\x00\xeb\x01\x28\x00\x29\x00\x2a\x00\x2b\x00\x82\x00\xb1\x01\x83\x00\xc9\x00\xb4\x00\xc6\x01\xaa\x00\xec\x01\x9a\xff\xc9\x00\xb5\x00\x9a\xff\x35\x01\x28\xff\x9a\xff\x75\x00\x84\x00\x9a\xff\x28\xff\x11\xff\x85\x00\x36\x01\x86\x00\x82\x00\x1e\x01\x83\x00\xab\x00\xb4\x00\x88\x00\x72\x01\xce\x00\x0d\x00\x82\x00\xb5\x00\x83\x00\x35\x01\xb4\x00\xc1\x01\x3a\x01\x84\x00\x0e\x00\x09\x01\xb5\x00\x85\x00\x36\x01\x86\x00\xc2\x01\x1e\x01\x84\x00\x54\x01\xed\x01\x88\x00\x85\x00\x23\x01\x86\x00\xbe\x00\x1e\x01\x4c\x01\x0e\x00\x82\x00\x88\x00\x83\x00\x0e\x00\xb4\x00\x0e\x00\x89\x00\x8a\x00\x8b\x00\x1f\x01\xb5\x00\xab\x01\x35\x01\xe8\x00\xe9\x00\xea\x00\x84\x00\xad\x01\x24\x01\xf0\x01\x85\x00\x36\x01\x86\x00\xaf\x01\x1e\x01\xe8\x00\xf3\x00\xf4\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x1f\x01\x82\x00\xb3\x01\x83\x00\xb4\x01\xb4\x00\x89\x00\x8a\x00\x8b\x00\x1f\x01\x3c\x00\xb5\x00\xe8\x00\xf6\x00\xf7\x00\x3d\x00\xcd\x00\x84\x00\xeb\x00\xce\x00\xaa\x00\x85\x00\x82\x00\x86\x00\x83\x00\x1e\x01\xb4\x00\x4a\x01\xcd\x00\x88\x00\xeb\x00\xce\x00\xb5\x00\x89\x00\x8a\x00\x8b\x00\x1f\x01\x82\x00\x84\x00\x83\x00\xab\x00\xb4\x00\x85\x00\xac\x00\x86\x00\xd5\x01\x87\x00\xb5\x00\x6a\x01\xeb\x00\x88\x00\x61\x00\x6b\x01\x84\x00\x82\x00\x6b\x01\x83\x00\x85\x00\xb4\x00\x86\x00\x0e\x00\x87\x00\xdb\x01\x67\x01\xb5\x00\x88\x00\x89\x00\x8a\x00\x8b\x00\x1f\x01\x84\x00\xe8\x00\xf9\x00\xfa\x00\x85\x00\x69\x00\x86\x00\xaa\x00\x1e\x01\x69\x00\x6a\x00\x42\x01\x88\x00\xb6\x01\x6a\x00\x76\x00\x36\x01\x89\x00\x8a\x00\x8b\x00\xb6\x00\xbe\x00\xb7\x01\xbf\x00\xbd\x00\xd0\x00\xaf\x00\xb0\x00\xb1\x00\xbe\x00\x0e\x00\x23\x01\x89\x00\x8a\x00\x8b\x00\xd9\x00\xb8\x01\x82\x00\xeb\x00\x83\x00\x0e\x00\xb4\x00\xd1\x00\xd7\x00\x82\x00\xb9\x01\x83\x00\xb5\x00\xb4\x00\x89\x00\x8a\x00\x8b\x00\x1f\x01\x84\x00\xb5\x00\x24\x01\x8e\x01\x85\x00\x83\x01\x86\x00\x84\x00\x87\x00\xfa\x01\xc4\x01\x85\x00\x88\x00\x86\x00\x82\x00\x87\x00\x83\x00\x5c\x00\xb4\x00\x88\x00\x5d\x00\xcf\x00\x0d\x00\x23\x01\xb5\x00\x66\x00\x0d\x00\x5e\x00\x5f\x00\xbd\x01\x84\x00\x0e\x00\x0e\x00\xbe\x01\x85\x00\x0e\x00\x86\x00\x87\x01\x87\x00\xc3\x01\xc4\x01\x60\x00\x88\x00\x3e\x01\x82\x00\x90\x01\x83\x00\x24\x01\x91\x01\x89\x00\x8a\x00\x8b\x00\xb6\x00\xa0\x01\x3f\x01\x27\x01\x89\x00\x8a\x00\xd4\x00\xd5\x00\x84\x00\x28\x01\x29\x01\x93\x01\x85\x00\x40\x01\x86\x00\x01\x01\x87\x00\x13\x00\x2a\x01\x2b\x01\x88\x00\x14\x00\x63\x00\x15\x00\x17\x01\x16\x00\x45\x01\x89\x00\x8a\x00\x8b\x00\xd9\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x13\x00\x53\x01\x23\x01\xc3\x00\x14\x00\xa5\x00\x15\x00\x69\x00\x16\x00\x6e\x00\x0d\x00\x0e\x00\x6a\x00\x5f\x01\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x0e\x00\xe5\x00\x89\x00\x8a\x00\x8b\x00\x8c\x00\x63\x00\x24\x01\x25\x01\x8e\x00\x0d\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x91\x00\xa0\x00\x0c\x00\x0d\x00\x0e\x00\x13\x00\x92\x00\x93\x00\x94\x00\x14\x00\x63\x00\x15\x00\x0e\x00\x90\x00\x80\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x13\x00\xa1\x00\x0c\x00\x0d\x00\x14\x00\x5a\x00\x15\x00\x63\x00\x16\x00\xa2\x00\x0c\x00\x0d\x00\x0e\x00\xf1\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x98\x00\x0e\x00\x13\x00\x7a\x01\xb0\x00\xb1\x00\x14\x00\x63\x00\x15\x00\x05\x00\x64\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2d\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x13\x00\x7c\x01\xb0\x00\xb1\x00\x14\x00\x2d\x01\x15\x00\x63\x00\x16\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x01\x02\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\xd2\x01\xc4\x01\x13\x00\xd3\x01\xd4\x01\x07\x02\x14\x00\xff\x01\x15\x00\x00\x02\x90\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x02\x02\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x7e\x01\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x66\x01\x67\x01\x28\x00\x29\x00\x2a\x00\x2b\x00\x60\x01\x61\x01\x0e\x00\x04\x02\x8b\x01\x67\x01\x03\x02\x62\x01\x63\x01\xaa\xff\x0f\x00\xd0\x00\xaf\x00\xb0\x00\xb1\x00\x7f\x01\xe0\x01\x28\x00\x29\x00\x2a\x00\x2b\x00\xaa\xff\xf4\x01\xaa\xff\xaa\xff\xaa\xff\xaa\xff\xf5\x01\xd1\x00\x77\x01\xc6\x01\xa0\xff\xaa\xff\xaa\xff\xaa\xff\xaa\xff\x06\x01\xa4\x01\xaa\xff\xaa\xff\x06\x01\x07\x01\xaa\xff\xa0\xff\x2d\x01\xa0\xff\xa0\xff\xa0\xff\xa0\xff\xae\x00\xaf\x00\xb0\x00\xb1\x00\xaa\xff\xa0\xff\xa0\xff\xa0\xff\xa0\xff\x70\x00\x47\x01\xa0\xff\xa0\xff\xae\xff\xc6\x01\xa0\xff\x73\x01\x4e\x01\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\xf9\x01\xae\xff\xa0\xff\xae\xff\xae\xff\xae\xff\xae\xff\xfa\x01\x0e\x00\x06\x01\x10\x01\xac\xff\xae\xff\xae\xff\xae\xff\xae\xff\x0f\x00\x4f\x01\xae\xff\xae\xff\x70\x00\x71\x00\xae\xff\xac\xff\xc6\x01\xac\xff\xac\xff\xac\xff\xac\xff\xae\x00\xaf\x00\xb0\x00\xb1\x00\xae\xff\xac\xff\xac\xff\xac\xff\xac\xff\x70\x00\x75\x00\xac\xff\xac\xff\xa8\xff\xdb\x01\xac\xff\xb2\x00\x7a\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\xfd\x01\xa8\xff\xac\xff\xa8\xff\xa8\xff\xa8\xff\xa8\xff\xaa\x00\x0e\x00\x2b\x00\x2c\x00\x6d\x01\xa8\xff\xa8\xff\xa8\xff\xa8\xff\x0f\x00\x7b\x00\xa8\xff\xa8\xff\xdd\x01\xde\x01\xa8\xff\x95\x01\xaf\x00\xb0\x00\xb1\x00\xab\x00\x6e\x00\x69\x00\xac\x00\xdf\x01\xe3\x01\xa8\xff\x6a\x00\x76\x00\xa3\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x7e\x01\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\xe4\x01\x0e\x00\x9f\x00\x9c\x00\x0b\x00\x0c\x00\x0d\x00\xb8\x00\x0e\x00\x0f\x00\xe5\x01\xe6\x01\x6a\x00\x76\x00\xe7\x01\x0e\x00\x0f\x00\xd0\x00\xaf\x00\xb0\x00\xb1\x00\x7f\x01\x80\x01\x7e\x01\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\xd0\x00\xaf\x00\xb0\x00\xb1\x00\xd1\x00\x7d\x01\xe9\x01\x95\x01\x0e\x00\x7c\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0f\x00\xd1\x00\x31\x01\xad\x01\xab\x01\x7f\x01\x81\x01\xaf\x01\x0e\x00\xd0\x00\xaf\x00\xb0\x00\xb1\x00\xa2\x01\x70\x00\x8f\x01\x0f\x00\x7c\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x19\x01\x1a\x01\xd1\x00\xd2\x00\x69\x00\xb3\x01\xc8\x01\x1c\x01\x0e\x00\x6a\x00\xc9\x00\xc0\x01\xbd\x01\xc1\x01\x70\x00\x7d\x00\x0f\x00\xd5\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x82\x01\x9b\x00\x09\x00\x9c\x00\x0b\x00\x0c\x00\x0d\x00\x69\x00\x0e\x00\xc6\x01\xc8\x01\x6e\x00\x6a\x00\x6b\x00\xca\x01\x0e\x00\x0f\x00\xd5\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x32\x01\xcb\x01\xcc\x01\x19\x01\x1a\x01\x19\x01\x1a\x01\xcd\x01\x0e\x00\x96\x01\x1c\x01\x1b\x01\x1c\x01\xd0\x01\xc6\x01\x2e\x01\x0f\x00\xd5\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\xd6\x00\x69\x00\xd7\x01\x19\x01\x1a\x01\xd8\x01\x6a\x00\x76\x00\x0e\x00\x33\x01\x1c\x01\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x0f\x00\xd5\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\xdb\x00\x71\x01\xaf\x00\xb0\x00\xb1\x00\xd9\x01\xda\x01\x6f\x01\x0e\x00\xdf\x01\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0f\x00\xb6\x00\xaf\x00\xb0\x00\xb1\x00\x70\x01\x71\x01\x6e\x00\x0e\x00\xe9\x01\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0f\x00\x75\x01\xbd\x00\x76\x01\x77\x01\x79\x01\x7a\x01\x85\x01\x0e\x00\xee\x01\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0f\x00\x86\x01\x2e\x01\x8e\x01\x87\x01\x89\x01\x95\x01\x98\x01\x0e\x00\xb0\x01\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0f\x00\x9a\x01\x9e\x01\xa4\x01\xa2\x01\x03\x01\x0e\x01\x09\x01\x0e\x00\xb5\x01\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0f\x00\x10\x01\x11\xff\x13\x01\x11\xff\x15\x01\xee\x00\x19\x01\x0e\x00\xba\x01\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0f\x00\x11\xff\x22\x01\x31\x01\x2f\x01\x28\x01\x37\x01\x30\x01\x0e\x00\xcd\x01\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0f\x00\x38\x01\x39\x01\x3b\x01\x3c\x01\x3d\x01\x8e\x00\x45\x01\x0e\x00\xce\x01\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0f\x00\x6e\x00\x4a\x01\x47\x01\x4c\x01\x6e\x00\x52\x01\x56\x01\x0e\x00\x7b\x01\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0f\x00\x57\x01\x59\x01\x5b\x01\x5c\x01\x5a\x01\x5d\x01\x5e\x01\x0e\x00\x92\x01\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0f\x00\x5f\x01\x9a\x00\x9e\x00\x6e\x00\x8e\x00\xaa\x00\xbb\x00\x0e\x00\x98\x01\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0f\x00\xba\x00\x6e\x00\xae\x00\xbc\x00\xb8\x00\x6e\x00\xc1\x00\x0e\x00\x9c\x01\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0f\x00\xc2\x00\xc3\x00\xc5\x00\x6e\x00\xc6\x00\xc7\x00\xc9\x00\x0e\x00\x9e\x01\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0f\x00\x6e\x00\xcb\x00\xcc\x00\x8e\x00\xe5\x00\xe2\x00\xdd\x00\x0e\x00\x9f\x01\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0f\x00\xde\x00\xdf\x00\xe8\x00\xef\x00\xf1\x00\xe0\x00\xf3\x00\x0e\x00\xa5\x01\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0f\x00\xe1\x00\xe7\x00\xf6\x00\xf0\x00\xf9\x00\x6e\x00\xfc\x00\x0e\x00\xa6\x01\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0f\x00\xee\x00\xfe\x00\xff\xff\x61\x00\xff\xff\x65\x00\x68\x00\x0e\x00\x40\x01\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0f\x00\x66\x00\x69\x00\x8d\x00\x6e\x00\x8e\x00\x97\x00\x98\x00\x0e\x00\x41\x01\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0f\x00\xff\xff\x07\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0e\x00\x43\x01\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0e\x00\x48\x01\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0e\x00\x4a\x01\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0e\x00\x4d\x01\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0e\x00\x50\x01\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0e\x00\x9a\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0e\x00\x9e\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0e\x00\xa8\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0e\x00\x7c\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0e\x00\x6f\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0e\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0f\x00\x2f\x00\x00\x00\x30\x00\x31\x00\x32\x00\x33\x00\x00\x00\x0e\x00\x00\x00\x00\x00\x00\x00\x34\x00\x35\x00\x36\x00\x37\x00\x0f\x00\x00\x00\x38\x00\x39\x00\x00\x00\x00\x00\x3a\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyReduceArr = Happy_Data_Array.array (4, 238) [
	(4 , happyReduce_4),
	(5 , happyReduce_5),
	(6 , happyReduce_6),
	(7 , happyReduce_7),
	(8 , happyReduce_8),
	(9 , happyReduce_9),
	(10 , happyReduce_10),
	(11 , happyReduce_11),
	(12 , happyReduce_12),
	(13 , happyReduce_13),
	(14 , happyReduce_14),
	(15 , happyReduce_15),
	(16 , happyReduce_16),
	(17 , happyReduce_17),
	(18 , happyReduce_18),
	(19 , happyReduce_19),
	(20 , happyReduce_20),
	(21 , happyReduce_21),
	(22 , happyReduce_22),
	(23 , happyReduce_23),
	(24 , happyReduce_24),
	(25 , happyReduce_25),
	(26 , happyReduce_26),
	(27 , happyReduce_27),
	(28 , happyReduce_28),
	(29 , happyReduce_29),
	(30 , happyReduce_30),
	(31 , happyReduce_31),
	(32 , happyReduce_32),
	(33 , happyReduce_33),
	(34 , happyReduce_34),
	(35 , happyReduce_35),
	(36 , happyReduce_36),
	(37 , happyReduce_37),
	(38 , happyReduce_38),
	(39 , happyReduce_39),
	(40 , happyReduce_40),
	(41 , happyReduce_41),
	(42 , happyReduce_42),
	(43 , happyReduce_43),
	(44 , happyReduce_44),
	(45 , happyReduce_45),
	(46 , happyReduce_46),
	(47 , happyReduce_47),
	(48 , happyReduce_48),
	(49 , happyReduce_49),
	(50 , happyReduce_50),
	(51 , happyReduce_51),
	(52 , happyReduce_52),
	(53 , happyReduce_53),
	(54 , happyReduce_54),
	(55 , happyReduce_55),
	(56 , happyReduce_56),
	(57 , happyReduce_57),
	(58 , happyReduce_58),
	(59 , happyReduce_59),
	(60 , happyReduce_60),
	(61 , happyReduce_61),
	(62 , happyReduce_62),
	(63 , happyReduce_63),
	(64 , happyReduce_64),
	(65 , happyReduce_65),
	(66 , happyReduce_66),
	(67 , happyReduce_67),
	(68 , happyReduce_68),
	(69 , happyReduce_69),
	(70 , happyReduce_70),
	(71 , happyReduce_71),
	(72 , happyReduce_72),
	(73 , happyReduce_73),
	(74 , happyReduce_74),
	(75 , happyReduce_75),
	(76 , happyReduce_76),
	(77 , happyReduce_77),
	(78 , happyReduce_78),
	(79 , happyReduce_79),
	(80 , happyReduce_80),
	(81 , happyReduce_81),
	(82 , happyReduce_82),
	(83 , happyReduce_83),
	(84 , happyReduce_84),
	(85 , happyReduce_85),
	(86 , happyReduce_86),
	(87 , happyReduce_87),
	(88 , happyReduce_88),
	(89 , happyReduce_89),
	(90 , happyReduce_90),
	(91 , happyReduce_91),
	(92 , happyReduce_92),
	(93 , happyReduce_93),
	(94 , happyReduce_94),
	(95 , happyReduce_95),
	(96 , happyReduce_96),
	(97 , happyReduce_97),
	(98 , happyReduce_98),
	(99 , happyReduce_99),
	(100 , happyReduce_100),
	(101 , happyReduce_101),
	(102 , happyReduce_102),
	(103 , happyReduce_103),
	(104 , happyReduce_104),
	(105 , happyReduce_105),
	(106 , happyReduce_106),
	(107 , happyReduce_107),
	(108 , happyReduce_108),
	(109 , happyReduce_109),
	(110 , happyReduce_110),
	(111 , happyReduce_111),
	(112 , happyReduce_112),
	(113 , happyReduce_113),
	(114 , happyReduce_114),
	(115 , happyReduce_115),
	(116 , happyReduce_116),
	(117 , happyReduce_117),
	(118 , happyReduce_118),
	(119 , happyReduce_119),
	(120 , happyReduce_120),
	(121 , happyReduce_121),
	(122 , happyReduce_122),
	(123 , happyReduce_123),
	(124 , happyReduce_124),
	(125 , happyReduce_125),
	(126 , happyReduce_126),
	(127 , happyReduce_127),
	(128 , happyReduce_128),
	(129 , happyReduce_129),
	(130 , happyReduce_130),
	(131 , happyReduce_131),
	(132 , happyReduce_132),
	(133 , happyReduce_133),
	(134 , happyReduce_134),
	(135 , happyReduce_135),
	(136 , happyReduce_136),
	(137 , happyReduce_137),
	(138 , happyReduce_138),
	(139 , happyReduce_139),
	(140 , happyReduce_140),
	(141 , happyReduce_141),
	(142 , happyReduce_142),
	(143 , happyReduce_143),
	(144 , happyReduce_144),
	(145 , happyReduce_145),
	(146 , happyReduce_146),
	(147 , happyReduce_147),
	(148 , happyReduce_148),
	(149 , happyReduce_149),
	(150 , happyReduce_150),
	(151 , happyReduce_151),
	(152 , happyReduce_152),
	(153 , happyReduce_153),
	(154 , happyReduce_154),
	(155 , happyReduce_155),
	(156 , happyReduce_156),
	(157 , happyReduce_157),
	(158 , happyReduce_158),
	(159 , happyReduce_159),
	(160 , happyReduce_160),
	(161 , happyReduce_161),
	(162 , happyReduce_162),
	(163 , happyReduce_163),
	(164 , happyReduce_164),
	(165 , happyReduce_165),
	(166 , happyReduce_166),
	(167 , happyReduce_167),
	(168 , happyReduce_168),
	(169 , happyReduce_169),
	(170 , happyReduce_170),
	(171 , happyReduce_171),
	(172 , happyReduce_172),
	(173 , happyReduce_173),
	(174 , happyReduce_174),
	(175 , happyReduce_175),
	(176 , happyReduce_176),
	(177 , happyReduce_177),
	(178 , happyReduce_178),
	(179 , happyReduce_179),
	(180 , happyReduce_180),
	(181 , happyReduce_181),
	(182 , happyReduce_182),
	(183 , happyReduce_183),
	(184 , happyReduce_184),
	(185 , happyReduce_185),
	(186 , happyReduce_186),
	(187 , happyReduce_187),
	(188 , happyReduce_188),
	(189 , happyReduce_189),
	(190 , happyReduce_190),
	(191 , happyReduce_191),
	(192 , happyReduce_192),
	(193 , happyReduce_193),
	(194 , happyReduce_194),
	(195 , happyReduce_195),
	(196 , happyReduce_196),
	(197 , happyReduce_197),
	(198 , happyReduce_198),
	(199 , happyReduce_199),
	(200 , happyReduce_200),
	(201 , happyReduce_201),
	(202 , happyReduce_202),
	(203 , happyReduce_203),
	(204 , happyReduce_204),
	(205 , happyReduce_205),
	(206 , happyReduce_206),
	(207 , happyReduce_207),
	(208 , happyReduce_208),
	(209 , happyReduce_209),
	(210 , happyReduce_210),
	(211 , happyReduce_211),
	(212 , happyReduce_212),
	(213 , happyReduce_213),
	(214 , happyReduce_214),
	(215 , happyReduce_215),
	(216 , happyReduce_216),
	(217 , happyReduce_217),
	(218 , happyReduce_218),
	(219 , happyReduce_219),
	(220 , happyReduce_220),
	(221 , happyReduce_221),
	(222 , happyReduce_222),
	(223 , happyReduce_223),
	(224 , happyReduce_224),
	(225 , happyReduce_225),
	(226 , happyReduce_226),
	(227 , happyReduce_227),
	(228 , happyReduce_228),
	(229 , happyReduce_229),
	(230 , happyReduce_230),
	(231 , happyReduce_231),
	(232 , happyReduce_232),
	(233 , happyReduce_233),
	(234 , happyReduce_234),
	(235 , happyReduce_235),
	(236 , happyReduce_236),
	(237 , happyReduce_237),
	(238 , happyReduce_238)
	]

happy_n_terms = 72 :: Int
happy_n_nonterms = 77 :: Int

happyReduce_4 = happyMonadReduce 4# 0# happyReduction_4
happyReduction_4 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut9 happy_x_1 of { happy_var_1 -> 
	case happyOut10 happy_x_2 of { happy_var_2 -> 
	case happyOut13 happy_x_4 of { happy_var_4 -> 
	(
                                   do let mstat = happy_var_1
                                          (mtype,id) = happy_var_2
                                          (extends,with,content) = happy_var_4
                                          (opens,jments,opts) = case content of { Just c -> c; Nothing -> ([],[],noOptions) }
                                      jments <- mapM (checkInfoType mtype) jments
                                      defs <- buildAnyTree id jments
                                      return (id, ModInfo mtype mstat opts extends with opens [] "" Nothing defs))}}}
	) (\r -> happyReturn (happyIn7 r))

happyReduce_5 = happyReduce 4# 1# happyReduction_5
happyReduction_5 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut9 happy_x_1 of { happy_var_1 -> 
	case happyOut10 happy_x_2 of { happy_var_2 -> 
	case happyOut11 happy_x_4 of { happy_var_4 -> 
	happyIn8
		 (let { mstat = happy_var_1 ;
                                               (mtype,id) = happy_var_2 ;
                                               (extends,with,opens) = happy_var_4 }
                                         in (id, ModInfo mtype mstat noOptions extends with opens [] "" Nothing emptyBinTree)
	) `HappyStk` happyRest}}}

happyReduce_6 = happySpecReduce_0  2# happyReduction_6
happyReduction_6  =  happyIn9
		 (MSComplete
	)

happyReduce_7 = happySpecReduce_1  2# happyReduction_7
happyReduction_7 happy_x_1
	 =  happyIn9
		 (MSIncomplete
	)

happyReduce_8 = happySpecReduce_2  3# happyReduction_8
happyReduction_8 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_2 of { ((T_Ident   happy_var_2)) -> 
	happyIn10
		 ((MTAbstract,      happy_var_2)
	)}

happyReduce_9 = happySpecReduce_2  3# happyReduction_9
happyReduction_9 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_2 of { ((T_Ident   happy_var_2)) -> 
	happyIn10
		 ((MTResource,      happy_var_2)
	)}

happyReduce_10 = happySpecReduce_2  3# happyReduction_10
happyReduction_10 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_2 of { ((T_Ident   happy_var_2)) -> 
	happyIn10
		 ((MTInterface,     happy_var_2)
	)}

happyReduce_11 = happyReduce 4# 3# happyReduction_11
happyReduction_11 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_2 of { ((T_Ident   happy_var_2)) -> 
	case happyOutTok happy_x_4 of { ((T_Ident   happy_var_4)) -> 
	happyIn10
		 ((MTConcrete happy_var_4,   happy_var_2)
	) `HappyStk` happyRest}}

happyReduce_12 = happyReduce 4# 3# happyReduction_12
happyReduction_12 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_2 of { ((T_Ident   happy_var_2)) -> 
	case happyOut21 happy_x_4 of { happy_var_4 -> 
	happyIn10
		 ((MTInstance happy_var_4,   happy_var_2)
	) `HappyStk` happyRest}}

happyReduce_13 = happyReduce 7# 4# happyReduction_13
happyReduction_13 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut20 happy_x_1 of { happy_var_1 -> 
	case happyOut21 happy_x_3 of { happy_var_3 -> 
	case happyOut18 happy_x_5 of { happy_var_5 -> 
	case happyOut12 happy_x_7 of { happy_var_7 -> 
	happyIn11
		 ((happy_var_1, Just (fst happy_var_3,snd happy_var_3,happy_var_5), happy_var_7)
	) `HappyStk` happyRest}}}}

happyReduce_14 = happyReduce 5# 4# happyReduction_14
happyReduction_14 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut20 happy_x_1 of { happy_var_1 -> 
	case happyOut21 happy_x_3 of { happy_var_3 -> 
	case happyOut18 happy_x_5 of { happy_var_5 -> 
	happyIn11
		 ((happy_var_1, Just (fst happy_var_3,snd happy_var_3,happy_var_5), [])
	) `HappyStk` happyRest}}}

happyReduce_15 = happySpecReduce_3  4# happyReduction_15
happyReduction_15 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut20 happy_x_1 of { happy_var_1 -> 
	case happyOut12 happy_x_3 of { happy_var_3 -> 
	happyIn11
		 ((happy_var_1, Nothing,                 happy_var_3)
	)}}

happyReduce_16 = happySpecReduce_1  4# happyReduction_16
happyReduction_16 happy_x_1
	 =  case happyOut20 happy_x_1 of { happy_var_1 -> 
	happyIn11
		 ((happy_var_1, Nothing,                 [])
	)}

happyReduce_17 = happyReduce 5# 4# happyReduction_17
happyReduction_17 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut21 happy_x_1 of { happy_var_1 -> 
	case happyOut18 happy_x_3 of { happy_var_3 -> 
	case happyOut12 happy_x_5 of { happy_var_5 -> 
	happyIn11
		 (([], Just (fst happy_var_1,snd happy_var_1,happy_var_3), happy_var_5)
	) `HappyStk` happyRest}}}

happyReduce_18 = happySpecReduce_3  4# happyReduction_18
happyReduction_18 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut21 happy_x_1 of { happy_var_1 -> 
	case happyOut18 happy_x_3 of { happy_var_3 -> 
	happyIn11
		 (([], Just (fst happy_var_1,snd happy_var_1,happy_var_3), [])
	)}}

happyReduce_19 = happySpecReduce_1  4# happyReduction_19
happyReduction_19 happy_x_1
	 =  case happyOut12 happy_x_1 of { happy_var_1 -> 
	happyIn11
		 (([], Nothing,                 happy_var_1)
	)}

happyReduce_20 = happySpecReduce_0  5# happyReduction_20
happyReduction_20  =  happyIn12
		 ([]
	)

happyReduce_21 = happySpecReduce_2  5# happyReduction_21
happyReduction_21 happy_x_2
	happy_x_1
	 =  case happyOut16 happy_x_2 of { happy_var_2 -> 
	happyIn12
		 (happy_var_2
	)}

happyReduce_22 = happyReduce 7# 6# happyReduction_22
happyReduction_22 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut20 happy_x_1 of { happy_var_1 -> 
	case happyOut21 happy_x_3 of { happy_var_3 -> 
	case happyOut18 happy_x_5 of { happy_var_5 -> 
	case happyOut14 happy_x_7 of { happy_var_7 -> 
	happyIn13
		 ((happy_var_1, Just (fst happy_var_3,snd happy_var_3,happy_var_5), Just happy_var_7)
	) `HappyStk` happyRest}}}}

happyReduce_23 = happyReduce 5# 6# happyReduction_23
happyReduction_23 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut20 happy_x_1 of { happy_var_1 -> 
	case happyOut21 happy_x_3 of { happy_var_3 -> 
	case happyOut18 happy_x_5 of { happy_var_5 -> 
	happyIn13
		 ((happy_var_1, Just (fst happy_var_3,snd happy_var_3,happy_var_5), Nothing)
	) `HappyStk` happyRest}}}

happyReduce_24 = happySpecReduce_3  6# happyReduction_24
happyReduction_24 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut20 happy_x_1 of { happy_var_1 -> 
	case happyOut14 happy_x_3 of { happy_var_3 -> 
	happyIn13
		 ((happy_var_1, Nothing,                 Just happy_var_3)
	)}}

happyReduce_25 = happySpecReduce_1  6# happyReduction_25
happyReduction_25 happy_x_1
	 =  case happyOut20 happy_x_1 of { happy_var_1 -> 
	happyIn13
		 ((happy_var_1, Nothing,                 Nothing)
	)}

happyReduce_26 = happyReduce 5# 6# happyReduction_26
happyReduction_26 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut21 happy_x_1 of { happy_var_1 -> 
	case happyOut18 happy_x_3 of { happy_var_3 -> 
	case happyOut14 happy_x_5 of { happy_var_5 -> 
	happyIn13
		 (([], Just (fst happy_var_1,snd happy_var_1,happy_var_3), Just happy_var_5)
	) `HappyStk` happyRest}}}

happyReduce_27 = happySpecReduce_3  6# happyReduction_27
happyReduction_27 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut21 happy_x_1 of { happy_var_1 -> 
	case happyOut18 happy_x_3 of { happy_var_3 -> 
	happyIn13
		 (([], Just (fst happy_var_1,snd happy_var_1,happy_var_3), Nothing)
	)}}

happyReduce_28 = happySpecReduce_1  6# happyReduction_28
happyReduction_28 happy_x_1
	 =  case happyOut14 happy_x_1 of { happy_var_1 -> 
	happyIn13
		 (([], Nothing,                 Just happy_var_1)
	)}

happyReduce_29 = happySpecReduce_2  6# happyReduction_29
happyReduction_29 happy_x_2
	happy_x_1
	 =  case happyOut13 happy_x_1 of { happy_var_1 -> 
	happyIn13
		 (happy_var_1
	)}

happyReduce_30 = happySpecReduce_3  7# happyReduction_30
happyReduction_30 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut15 happy_x_2 of { happy_var_2 -> 
	happyIn14
		 (([],[d | Left ds <- happy_var_2, d <- ds],concatOptions [o | Right o <- happy_var_2])
	)}

happyReduce_31 = happyReduce 6# 7# happyReduction_31
happyReduction_31 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut16 happy_x_2 of { happy_var_2 -> 
	case happyOut15 happy_x_5 of { happy_var_5 -> 
	happyIn14
		 ((happy_var_2,[d | Left ds <- happy_var_5, d <- ds],concatOptions [o | Right o <- happy_var_5])
	) `HappyStk` happyRest}}

happyReduce_32 = happySpecReduce_0  8# happyReduction_32
happyReduction_32  =  happyIn15
		 ([]
	)

happyReduce_33 = happySpecReduce_2  8# happyReduction_33
happyReduction_33 happy_x_2
	happy_x_1
	 =  case happyOut22 happy_x_1 of { happy_var_1 -> 
	case happyOut15 happy_x_2 of { happy_var_2 -> 
	happyIn15
		 (happy_var_1 : happy_var_2
	)}}

happyReduce_34 = happySpecReduce_1  9# happyReduction_34
happyReduction_34 happy_x_1
	 =  case happyOut17 happy_x_1 of { happy_var_1 -> 
	happyIn16
		 ([happy_var_1]
	)}

happyReduce_35 = happySpecReduce_3  9# happyReduction_35
happyReduction_35 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut17 happy_x_1 of { happy_var_1 -> 
	case happyOut16 happy_x_3 of { happy_var_3 -> 
	happyIn16
		 (happy_var_1 : happy_var_3
	)}}

happyReduce_36 = happySpecReduce_1  10# happyReduction_36
happyReduction_36 happy_x_1
	 =  case happyOutTok happy_x_1 of { ((T_Ident   happy_var_1)) -> 
	happyIn17
		 (OSimple happy_var_1
	)}

happyReduce_37 = happyReduce 5# 10# happyReduction_37
happyReduction_37 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_2 of { ((T_Ident   happy_var_2)) -> 
	case happyOutTok happy_x_4 of { ((T_Ident   happy_var_4)) -> 
	happyIn17
		 (OQualif happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_38 = happySpecReduce_1  11# happyReduction_38
happyReduction_38 happy_x_1
	 =  case happyOut19 happy_x_1 of { happy_var_1 -> 
	happyIn18
		 ([happy_var_1]
	)}

happyReduce_39 = happySpecReduce_3  11# happyReduction_39
happyReduction_39 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut19 happy_x_1 of { happy_var_1 -> 
	case happyOut18 happy_x_3 of { happy_var_3 -> 
	happyIn18
		 (happy_var_1 : happy_var_3
	)}}

happyReduce_40 = happyReduce 5# 12# happyReduction_40
happyReduction_40 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_2 of { ((T_Ident   happy_var_2)) -> 
	case happyOutTok happy_x_4 of { ((T_Ident   happy_var_4)) -> 
	happyIn19
		 ((happy_var_2,happy_var_4)
	) `HappyStk` happyRest}}

happyReduce_41 = happySpecReduce_1  13# happyReduction_41
happyReduction_41 happy_x_1
	 =  case happyOut21 happy_x_1 of { happy_var_1 -> 
	happyIn20
		 ([happy_var_1]
	)}

happyReduce_42 = happySpecReduce_3  13# happyReduction_42
happyReduction_42 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut21 happy_x_1 of { happy_var_1 -> 
	case happyOut20 happy_x_3 of { happy_var_3 -> 
	happyIn20
		 (happy_var_1 : happy_var_3
	)}}

happyReduce_43 = happySpecReduce_1  14# happyReduction_43
happyReduction_43 happy_x_1
	 =  case happyOutTok happy_x_1 of { ((T_Ident   happy_var_1)) -> 
	happyIn21
		 ((happy_var_1,MIAll      )
	)}

happyReduce_44 = happyReduce 4# 14# happyReduction_44
happyReduction_44 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { ((T_Ident   happy_var_1)) -> 
	case happyOut44 happy_x_3 of { happy_var_3 -> 
	happyIn21
		 ((happy_var_1,MIOnly   happy_var_3)
	) `HappyStk` happyRest}}

happyReduce_45 = happyReduce 5# 14# happyReduction_45
happyReduction_45 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { ((T_Ident   happy_var_1)) -> 
	case happyOut44 happy_x_4 of { happy_var_4 -> 
	happyIn21
		 ((happy_var_1,MIExcept happy_var_4)
	) `HappyStk` happyRest}}

happyReduce_46 = happySpecReduce_2  15# happyReduction_46
happyReduction_46 happy_x_2
	happy_x_1
	 =  case happyOut37 happy_x_2 of { happy_var_2 -> 
	happyIn22
		 (Left  happy_var_2
	)}

happyReduce_47 = happySpecReduce_2  15# happyReduction_47
happyReduction_47 happy_x_2
	happy_x_1
	 =  case happyOut38 happy_x_2 of { happy_var_2 -> 
	happyIn22
		 (Left  happy_var_2
	)}

happyReduce_48 = happySpecReduce_2  15# happyReduction_48
happyReduction_48 happy_x_2
	happy_x_1
	 =  case happyOut35 happy_x_2 of { happy_var_2 -> 
	happyIn22
		 (Left  happy_var_2
	)}

happyReduce_49 = happySpecReduce_2  15# happyReduction_49
happyReduction_49 happy_x_2
	happy_x_1
	 =  case happyOut39 happy_x_2 of { happy_var_2 -> 
	happyIn22
		 (Left  happy_var_2
	)}

happyReduce_50 = happySpecReduce_2  15# happyReduction_50
happyReduction_50 happy_x_2
	happy_x_1
	 =  case happyOut40 happy_x_2 of { happy_var_2 -> 
	happyIn22
		 (Left  happy_var_2
	)}

happyReduce_51 = happySpecReduce_2  15# happyReduction_51
happyReduction_51 happy_x_2
	happy_x_1
	 =  case happyOut36 happy_x_2 of { happy_var_2 -> 
	happyIn22
		 (Left  happy_var_2
	)}

happyReduce_52 = happySpecReduce_2  15# happyReduction_52
happyReduction_52 happy_x_2
	happy_x_1
	 =  case happyOut41 happy_x_2 of { happy_var_2 -> 
	happyIn22
		 (Left  [(f, CncCat (Just e) Nothing  Nothing  Nothing Nothing) | (f,e) <- happy_var_2]
	)}

happyReduce_53 = happySpecReduce_2  15# happyReduction_53
happyReduction_53 happy_x_2
	happy_x_1
	 =  case happyOut41 happy_x_2 of { happy_var_2 -> 
	happyIn22
		 (Left  [(f, CncCat Nothing  (Just e) Nothing  Nothing Nothing) | (f,e) <- happy_var_2]
	)}

happyReduce_54 = happySpecReduce_2  15# happyReduction_54
happyReduction_54 happy_x_2
	happy_x_1
	 =  case happyOut41 happy_x_2 of { happy_var_2 -> 
	happyIn22
		 (Left  [(f, CncCat Nothing  Nothing  (Just e) Nothing Nothing) | (f,e) <- happy_var_2]
	)}

happyReduce_55 = happySpecReduce_2  15# happyReduction_55
happyReduction_55 happy_x_2
	happy_x_1
	 =  case happyOut34 happy_x_2 of { happy_var_2 -> 
	happyIn22
		 (Left  happy_var_2
	)}

happyReduce_56 = happySpecReduce_3  15# happyReduction_56
happyReduction_56 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut41 happy_x_3 of { happy_var_3 -> 
	happyIn22
		 (Left  [(f, CncCat Nothing Nothing Nothing (Just e) Nothing) | (f,e) <- happy_var_3]
	)}

happyReduce_57 = happySpecReduce_3  15# happyReduction_57
happyReduction_57 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut41 happy_x_3 of { happy_var_3 -> 
	happyIn22
		 (Left  [(f, CncFun Nothing Nothing (Just e) Nothing) | (f,e) <- happy_var_3]
	)}

happyReduce_58 = happySpecReduce_2  15# happyReduction_58
happyReduction_58 happy_x_2
	happy_x_1
	 =  case happyOut42 happy_x_2 of { happy_var_2 -> 
	happyIn22
		 (Right happy_var_2
	)}

happyReduce_59 = happyReduce 4# 16# happyReduction_59
happyReduction_59 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut83 happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_2 of { ((T_Ident   happy_var_2)) -> 
	case happyOut82 happy_x_3 of { happy_var_3 -> 
	case happyOut83 happy_x_4 of { happy_var_4 -> 
	happyIn23
		 ([(happy_var_2, AbsCat (Just (mkL happy_var_1 happy_var_4 happy_var_3)))]
	) `HappyStk` happyRest}}}}

happyReduce_60 = happyReduce 6# 16# happyReduction_60
happyReduction_60 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut83 happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_3 of { ((T_Ident   happy_var_3)) -> 
	case happyOut82 happy_x_4 of { happy_var_4 -> 
	case happyOut83 happy_x_6 of { happy_var_6 -> 
	happyIn23
		 (listCatDef (mkL happy_var_1 happy_var_6 (happy_var_3,happy_var_4,0))
	) `HappyStk` happyRest}}}}

happyReduce_61 = happyReduce 9# 16# happyReduction_61
happyReduction_61 (happy_x_9 `HappyStk`
	happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut83 happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_3 of { ((T_Ident   happy_var_3)) -> 
	case happyOut82 happy_x_4 of { happy_var_4 -> 
	case happyOutTok happy_x_7 of { ((T_Integer happy_var_7)) -> 
	case happyOut83 happy_x_9 of { happy_var_9 -> 
	happyIn23
		 (listCatDef (mkL happy_var_1 happy_var_9 (happy_var_3,happy_var_4,fromIntegral happy_var_7))
	) `HappyStk` happyRest}}}}}

happyReduce_62 = happyReduce 5# 17# happyReduction_62
happyReduction_62 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut83 happy_x_1 of { happy_var_1 -> 
	case happyOut44 happy_x_2 of { happy_var_2 -> 
	case happyOut51 happy_x_4 of { happy_var_4 -> 
	case happyOut83 happy_x_5 of { happy_var_5 -> 
	happyIn24
		 ([(fun, AbsFun (Just (mkL happy_var_1 happy_var_5 happy_var_4)) Nothing (Just []) (Just True)) | fun <- happy_var_2]
	) `HappyStk` happyRest}}}}

happyReduce_63 = happyReduce 5# 18# happyReduction_63
happyReduction_63 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut83 happy_x_1 of { happy_var_1 -> 
	case happyOut48 happy_x_2 of { happy_var_2 -> 
	case happyOut51 happy_x_4 of { happy_var_4 -> 
	case happyOut83 happy_x_5 of { happy_var_5 -> 
	happyIn25
		 ([(f, AbsFun Nothing (Just 0)           (Just [mkL happy_var_1 happy_var_5 ([],happy_var_4)]) Nothing) | f <- happy_var_2]
	) `HappyStk` happyRest}}}}

happyReduce_64 = happyReduce 6# 18# happyReduction_64
happyReduction_64 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut83 happy_x_1 of { happy_var_1 -> 
	case happyOut47 happy_x_2 of { happy_var_2 -> 
	case happyOut68 happy_x_3 of { happy_var_3 -> 
	case happyOut51 happy_x_5 of { happy_var_5 -> 
	case happyOut83 happy_x_6 of { happy_var_6 -> 
	happyIn25
		 ([(happy_var_2,AbsFun Nothing (Just (length happy_var_3)) (Just [mkL happy_var_1 happy_var_6 (happy_var_3,happy_var_5)]) Nothing)]
	) `HappyStk` happyRest}}}}}

happyReduce_65 = happyReduce 5# 19# happyReduction_65
happyReduction_65 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_2 of { ((T_Ident   happy_var_2)) -> 
	case happyOut32 happy_x_4 of { happy_var_4 -> 
	happyIn26
		 ((happy_var_2,   AbsCat Nothing) :
                                         [(fun, AbsFun Nothing Nothing Nothing  (Just True)) | fun <- happy_var_4]
	) `HappyStk` happyRest}}

happyReduce_66 = happyReduce 5# 19# happyReduction_66
happyReduction_66 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut83 happy_x_1 of { happy_var_1 -> 
	case happyOut44 happy_x_2 of { happy_var_2 -> 
	case happyOut51 happy_x_4 of { happy_var_4 -> 
	case happyOut83 happy_x_5 of { happy_var_5 -> 
	happyIn26
		 (-- (snd (valCat happy_var_4), AbsCat Nothing) :
                                         [(fun, AbsFun (Just (mkL happy_var_1 happy_var_5 happy_var_4)) Nothing Nothing (Just True)) | fun <- happy_var_2]
	) `HappyStk` happyRest}}}}

happyReduce_67 = happyReduce 5# 20# happyReduction_67
happyReduction_67 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut83 happy_x_1 of { happy_var_1 -> 
	case happyOut46 happy_x_2 of { happy_var_2 -> 
	case happyOut43 happy_x_4 of { happy_var_4 -> 
	case happyOut83 happy_x_5 of { happy_var_5 -> 
	happyIn27
		 ((happy_var_2, ResParam (Just (mkL happy_var_1 happy_var_5 [param | L loc param <- happy_var_4])) Nothing) :
                                        [(f, ResValue (L loc (mkProdSimple co (Cn happy_var_2)))) | L loc (f,co) <- happy_var_4]
	) `HappyStk` happyRest}}}}

happyReduce_68 = happySpecReduce_3  20# happyReduction_68
happyReduction_68 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut46 happy_x_2 of { happy_var_2 -> 
	happyIn27
		 ([(happy_var_2, ResParam Nothing Nothing)]
	)}

happyReduce_69 = happyReduce 5# 21# happyReduction_69
happyReduction_69 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut83 happy_x_1 of { happy_var_1 -> 
	case happyOut48 happy_x_2 of { happy_var_2 -> 
	case happyOut51 happy_x_4 of { happy_var_4 -> 
	case happyOut83 happy_x_5 of { happy_var_5 -> 
	happyIn28
		 ([(i, info) | i <- happy_var_2,   info <- mkOverload (Just (mkL happy_var_1 happy_var_5 happy_var_4)) Nothing  ]
	) `HappyStk` happyRest}}}}

happyReduce_70 = happyReduce 5# 21# happyReduction_70
happyReduction_70 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut83 happy_x_1 of { happy_var_1 -> 
	case happyOut48 happy_x_2 of { happy_var_2 -> 
	case happyOut51 happy_x_4 of { happy_var_4 -> 
	case happyOut83 happy_x_5 of { happy_var_5 -> 
	happyIn28
		 ([(i, info) | i <- happy_var_2,   info <- mkOverload Nothing   (Just (mkL happy_var_1 happy_var_5 happy_var_4))]
	) `HappyStk` happyRest}}}}

happyReduce_71 = happyReduce 6# 21# happyReduction_71
happyReduction_71 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut83 happy_x_1 of { happy_var_1 -> 
	case happyOut47 happy_x_2 of { happy_var_2 -> 
	case happyOut71 happy_x_3 of { happy_var_3 -> 
	case happyOut51 happy_x_5 of { happy_var_5 -> 
	case happyOut83 happy_x_6 of { happy_var_6 -> 
	happyIn28
		 ([(i, info) | i <- [happy_var_2], info <- mkOverload Nothing   (Just (mkL happy_var_1 happy_var_6 (mkAbs happy_var_3 happy_var_5)))]
	) `HappyStk` happyRest}}}}}

happyReduce_72 = happyReduce 7# 21# happyReduction_72
happyReduction_72 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut83 happy_x_1 of { happy_var_1 -> 
	case happyOut48 happy_x_2 of { happy_var_2 -> 
	case happyOut51 happy_x_4 of { happy_var_4 -> 
	case happyOut51 happy_x_6 of { happy_var_6 -> 
	case happyOut83 happy_x_7 of { happy_var_7 -> 
	happyIn28
		 ([(i, info) | i <- happy_var_2,   info <- mkOverload (Just (mkL happy_var_1 happy_var_7 happy_var_4)) (Just (mkL happy_var_1 happy_var_7 happy_var_6))]
	) `HappyStk` happyRest}}}}}

happyReduce_73 = happyReduce 5# 22# happyReduction_73
happyReduction_73 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut83 happy_x_1 of { happy_var_1 -> 
	case happyOut48 happy_x_2 of { happy_var_2 -> 
	case happyOut51 happy_x_4 of { happy_var_4 -> 
	case happyOut83 happy_x_5 of { happy_var_5 -> 
	happyIn29
		 ([(f,  CncFun Nothing (Just (mkL happy_var_1 happy_var_5 happy_var_4)) Nothing Nothing) | f <- happy_var_2]
	) `HappyStk` happyRest}}}}

happyReduce_74 = happyReduce 6# 22# happyReduction_74
happyReduction_74 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut83 happy_x_1 of { happy_var_1 -> 
	case happyOut47 happy_x_2 of { happy_var_2 -> 
	case happyOut71 happy_x_3 of { happy_var_3 -> 
	case happyOut51 happy_x_5 of { happy_var_5 -> 
	case happyOut83 happy_x_6 of { happy_var_6 -> 
	happyIn29
		 ([(happy_var_2, CncFun Nothing (Just (mkL happy_var_1 happy_var_6 (mkAbs happy_var_3 happy_var_5))) Nothing Nothing)]
	) `HappyStk` happyRest}}}}}

happyReduce_75 = happyReduce 5# 23# happyReduction_75
happyReduction_75 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut83 happy_x_1 of { happy_var_1 -> 
	case happyOut48 happy_x_2 of { happy_var_2 -> 
	case happyOut51 happy_x_4 of { happy_var_4 -> 
	case happyOut83 happy_x_5 of { happy_var_5 -> 
	happyIn30
		 ([(i,mkL happy_var_1 happy_var_5 happy_var_4) | i <- happy_var_2]
	) `HappyStk` happyRest}}}}

happyReduce_76 = happyMonadReduce 5# 24# happyReduction_76
happyReduction_76 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut83 happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_2 of { ((T_Ident   happy_var_2)) -> 
	case happyOutTok happy_x_4 of { ((T_Ident   happy_var_4)) -> 
	( case parseModuleOptions ["--" ++ showIdent happy_var_2 ++ "=" ++ showIdent happy_var_4] of
                                    Ok  x   -> return x
                                    Bad msg -> failLoc happy_var_1 msg)}}}
	) (\r -> happyReturn (happyIn31 r))

happyReduce_77 = happyMonadReduce 5# 24# happyReduction_77
happyReduction_77 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut83 happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_2 of { ((T_Ident   happy_var_2)) -> 
	case happyOutTok happy_x_4 of { ((T_Double  happy_var_4)) -> 
	( case parseModuleOptions ["--" ++ showIdent happy_var_2 ++ "=" ++ show happy_var_4] of
                                    Ok  x   -> return x
                                    Bad msg -> failLoc happy_var_1 msg)}}}
	) (\r -> happyReturn (happyIn31 r))

happyReduce_78 = happySpecReduce_1  25# happyReduction_78
happyReduction_78 happy_x_1
	 =  case happyOutTok happy_x_1 of { ((T_Ident   happy_var_1)) -> 
	happyIn32
		 ([happy_var_1]
	)}

happyReduce_79 = happySpecReduce_3  25# happyReduction_79
happyReduction_79 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { ((T_Ident   happy_var_1)) -> 
	case happyOut32 happy_x_3 of { happy_var_3 -> 
	happyIn32
		 (happy_var_1 : happy_var_3
	)}}

happyReduce_80 = happyReduce 4# 26# happyReduction_80
happyReduction_80 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut83 happy_x_1 of { happy_var_1 -> 
	case happyOutTok happy_x_2 of { ((T_Ident   happy_var_2)) -> 
	case happyOut82 happy_x_3 of { happy_var_3 -> 
	case happyOut83 happy_x_4 of { happy_var_4 -> 
	happyIn33
		 (mkL happy_var_1 happy_var_4 (happy_var_2,happy_var_3)
	) `HappyStk` happyRest}}}}

happyReduce_81 = happySpecReduce_2  27# happyReduction_81
happyReduction_81 happy_x_2
	happy_x_1
	 =  case happyOut29 happy_x_1 of { happy_var_1 -> 
	happyIn34
		 (happy_var_1
	)}

happyReduce_82 = happySpecReduce_3  27# happyReduction_82
happyReduction_82 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut29 happy_x_1 of { happy_var_1 -> 
	case happyOut34 happy_x_3 of { happy_var_3 -> 
	happyIn34
		 (happy_var_1 ++ happy_var_3
	)}}

happyReduce_83 = happySpecReduce_2  28# happyReduction_83
happyReduction_83 happy_x_2
	happy_x_1
	 =  case happyOut25 happy_x_1 of { happy_var_1 -> 
	happyIn35
		 (happy_var_1
	)}

happyReduce_84 = happySpecReduce_3  28# happyReduction_84
happyReduction_84 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut25 happy_x_1 of { happy_var_1 -> 
	case happyOut35 happy_x_3 of { happy_var_3 -> 
	happyIn35
		 (happy_var_1 ++ happy_var_3
	)}}

happyReduce_85 = happySpecReduce_2  29# happyReduction_85
happyReduction_85 happy_x_2
	happy_x_1
	 =  case happyOut28 happy_x_1 of { happy_var_1 -> 
	happyIn36
		 (happy_var_1
	)}

happyReduce_86 = happySpecReduce_3  29# happyReduction_86
happyReduction_86 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut28 happy_x_1 of { happy_var_1 -> 
	case happyOut36 happy_x_3 of { happy_var_3 -> 
	happyIn36
		 (happy_var_1 ++ happy_var_3
	)}}

happyReduce_87 = happySpecReduce_2  30# happyReduction_87
happyReduction_87 happy_x_2
	happy_x_1
	 =  case happyOut23 happy_x_1 of { happy_var_1 -> 
	happyIn37
		 (happy_var_1
	)}

happyReduce_88 = happySpecReduce_3  30# happyReduction_88
happyReduction_88 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut23 happy_x_1 of { happy_var_1 -> 
	case happyOut37 happy_x_3 of { happy_var_3 -> 
	happyIn37
		 (happy_var_1 ++ happy_var_3
	)}}

happyReduce_89 = happySpecReduce_2  31# happyReduction_89
happyReduction_89 happy_x_2
	happy_x_1
	 =  case happyOut24 happy_x_1 of { happy_var_1 -> 
	happyIn38
		 (happy_var_1
	)}

happyReduce_90 = happySpecReduce_3  31# happyReduction_90
happyReduction_90 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut24 happy_x_1 of { happy_var_1 -> 
	case happyOut38 happy_x_3 of { happy_var_3 -> 
	happyIn38
		 (happy_var_1 ++ happy_var_3
	)}}

happyReduce_91 = happySpecReduce_2  32# happyReduction_91
happyReduction_91 happy_x_2
	happy_x_1
	 =  case happyOut26 happy_x_1 of { happy_var_1 -> 
	happyIn39
		 (happy_var_1
	)}

happyReduce_92 = happySpecReduce_3  32# happyReduction_92
happyReduction_92 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut26 happy_x_1 of { happy_var_1 -> 
	case happyOut39 happy_x_3 of { happy_var_3 -> 
	happyIn39
		 (happy_var_1 ++ happy_var_3
	)}}

happyReduce_93 = happySpecReduce_2  33# happyReduction_93
happyReduction_93 happy_x_2
	happy_x_1
	 =  case happyOut27 happy_x_1 of { happy_var_1 -> 
	happyIn40
		 (happy_var_1
	)}

happyReduce_94 = happySpecReduce_3  33# happyReduction_94
happyReduction_94 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut27 happy_x_1 of { happy_var_1 -> 
	case happyOut40 happy_x_3 of { happy_var_3 -> 
	happyIn40
		 (happy_var_1 ++ happy_var_3
	)}}

happyReduce_95 = happySpecReduce_2  34# happyReduction_95
happyReduction_95 happy_x_2
	happy_x_1
	 =  case happyOut30 happy_x_1 of { happy_var_1 -> 
	happyIn41
		 (happy_var_1
	)}

happyReduce_96 = happySpecReduce_3  34# happyReduction_96
happyReduction_96 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut30 happy_x_1 of { happy_var_1 -> 
	case happyOut41 happy_x_3 of { happy_var_3 -> 
	happyIn41
		 (happy_var_1 ++ happy_var_3
	)}}

happyReduce_97 = happySpecReduce_2  35# happyReduction_97
happyReduction_97 happy_x_2
	happy_x_1
	 =  case happyOut31 happy_x_1 of { happy_var_1 -> 
	happyIn42
		 (happy_var_1
	)}

happyReduce_98 = happySpecReduce_3  35# happyReduction_98
happyReduction_98 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut31 happy_x_1 of { happy_var_1 -> 
	case happyOut42 happy_x_3 of { happy_var_3 -> 
	happyIn42
		 (addOptions happy_var_1 happy_var_3
	)}}

happyReduce_99 = happySpecReduce_1  36# happyReduction_99
happyReduction_99 happy_x_1
	 =  case happyOut33 happy_x_1 of { happy_var_1 -> 
	happyIn43
		 ([happy_var_1]
	)}

happyReduce_100 = happySpecReduce_3  36# happyReduction_100
happyReduction_100 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut33 happy_x_1 of { happy_var_1 -> 
	case happyOut43 happy_x_3 of { happy_var_3 -> 
	happyIn43
		 (happy_var_1 : happy_var_3
	)}}

happyReduce_101 = happySpecReduce_1  37# happyReduction_101
happyReduction_101 happy_x_1
	 =  case happyOutTok happy_x_1 of { ((T_Ident   happy_var_1)) -> 
	happyIn44
		 ([happy_var_1]
	)}

happyReduce_102 = happySpecReduce_3  37# happyReduction_102
happyReduction_102 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { ((T_Ident   happy_var_1)) -> 
	case happyOut44 happy_x_3 of { happy_var_3 -> 
	happyIn44
		 (happy_var_1 : happy_var_3
	)}}

happyReduce_103 = happySpecReduce_1  38# happyReduction_103
happyReduction_103 happy_x_1
	 =  case happyOutTok happy_x_1 of { ((T_Ident   happy_var_1)) -> 
	happyIn45
		 ([happy_var_1]
	)}

happyReduce_104 = happySpecReduce_2  38# happyReduction_104
happyReduction_104 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { ((T_Ident   happy_var_1)) -> 
	case happyOut45 happy_x_2 of { happy_var_2 -> 
	happyIn45
		 (happy_var_1 : happy_var_2
	)}}

happyReduce_105 = happySpecReduce_1  39# happyReduction_105
happyReduction_105 happy_x_1
	 =  case happyOutTok happy_x_1 of { ((T_Ident   happy_var_1)) -> 
	happyIn46
		 (happy_var_1
	)}

happyReduce_106 = happyMonadReduce 2# 39# happyReduction_106
happyReduction_106 (happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut83 happy_x_1 of { happy_var_1 -> 
	case happyOut66 happy_x_2 of { happy_var_2 -> 
	( failLoc happy_var_1 (showIdent happy_var_2++ " is a predefined constant, it can not be redefined"))}}
	) (\r -> happyReturn (happyIn46 r))

happyReduce_107 = happySpecReduce_1  40# happyReduction_107
happyReduction_107 happy_x_1
	 =  case happyOut46 happy_x_1 of { happy_var_1 -> 
	happyIn47
		 (happy_var_1
	)}

happyReduce_108 = happySpecReduce_3  40# happyReduction_108
happyReduction_108 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut46 happy_x_2 of { happy_var_2 -> 
	happyIn47
		 (mkListId happy_var_2
	)}

happyReduce_109 = happySpecReduce_1  41# happyReduction_109
happyReduction_109 happy_x_1
	 =  case happyOut47 happy_x_1 of { happy_var_1 -> 
	happyIn48
		 ([happy_var_1]
	)}

happyReduce_110 = happySpecReduce_3  41# happyReduction_110
happyReduction_110 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut47 happy_x_1 of { happy_var_1 -> 
	case happyOut48 happy_x_3 of { happy_var_3 -> 
	happyIn48
		 (happy_var_1 : happy_var_3
	)}}

happyReduce_111 = happySpecReduce_3  42# happyReduction_111
happyReduction_111 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut44 happy_x_1 of { happy_var_1 -> 
	case happyOut51 happy_x_3 of { happy_var_3 -> 
	happyIn49
		 ([(lab,Just happy_var_3,Nothing) | lab <- happy_var_1]
	)}}

happyReduce_112 = happySpecReduce_3  42# happyReduction_112
happyReduction_112 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut44 happy_x_1 of { happy_var_1 -> 
	case happyOut51 happy_x_3 of { happy_var_3 -> 
	happyIn49
		 ([(lab,Nothing,Just happy_var_3) | lab <- happy_var_1]
	)}}

happyReduce_113 = happyReduce 5# 42# happyReduction_113
happyReduction_113 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut44 happy_x_1 of { happy_var_1 -> 
	case happyOut51 happy_x_3 of { happy_var_3 -> 
	case happyOut51 happy_x_5 of { happy_var_5 -> 
	happyIn49
		 ([(lab,Just happy_var_3,Just happy_var_5) | lab <- happy_var_1]
	) `HappyStk` happyRest}}}

happyReduce_114 = happySpecReduce_0  43# happyReduction_114
happyReduction_114  =  happyIn50
		 ([]
	)

happyReduce_115 = happySpecReduce_1  43# happyReduction_115
happyReduction_115 happy_x_1
	 =  case happyOut49 happy_x_1 of { happy_var_1 -> 
	happyIn50
		 (happy_var_1
	)}

happyReduce_116 = happySpecReduce_3  43# happyReduction_116
happyReduction_116 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut49 happy_x_1 of { happy_var_1 -> 
	case happyOut50 happy_x_3 of { happy_var_3 -> 
	happyIn50
		 (happy_var_1 ++ happy_var_3
	)}}

happyReduce_117 = happySpecReduce_3  44# happyReduction_117
happyReduction_117 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut52 happy_x_1 of { happy_var_1 -> 
	case happyOut51 happy_x_3 of { happy_var_3 -> 
	happyIn51
		 (FV [happy_var_1,happy_var_3]
	)}}

happyReduce_118 = happyReduce 4# 44# happyReduction_118
happyReduction_118 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut73 happy_x_2 of { happy_var_2 -> 
	case happyOut51 happy_x_4 of { happy_var_4 -> 
	happyIn51
		 (mkAbs happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_119 = happyReduce 4# 44# happyReduction_119
happyReduction_119 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut73 happy_x_2 of { happy_var_2 -> 
	case happyOut51 happy_x_4 of { happy_var_4 -> 
	happyIn51
		 (mkCTable happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_120 = happySpecReduce_3  44# happyReduction_120
happyReduction_120 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut74 happy_x_1 of { happy_var_1 -> 
	case happyOut51 happy_x_3 of { happy_var_3 -> 
	happyIn51
		 (mkProdSimple happy_var_1 happy_var_3
	)}}

happyReduce_121 = happySpecReduce_3  44# happyReduction_121
happyReduction_121 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut54 happy_x_1 of { happy_var_1 -> 
	case happyOut51 happy_x_3 of { happy_var_3 -> 
	happyIn51
		 (Table happy_var_1 happy_var_3
	)}}

happyReduce_122 = happyMonadReduce 6# 44# happyReduction_122
happyReduction_122 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut50 happy_x_3 of { happy_var_3 -> 
	case happyOut51 happy_x_6 of { happy_var_6 -> 
	(
                                        do defs <- mapM tryLoc happy_var_3
                                           return $ mkLet defs happy_var_6)}}
	) (\r -> happyReturn (happyIn51 r))

happyReduce_123 = happyMonadReduce 4# 44# happyReduction_123
happyReduction_123 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut50 happy_x_2 of { happy_var_2 -> 
	case happyOut51 happy_x_4 of { happy_var_4 -> 
	(
                                        do defs <- mapM tryLoc happy_var_2
                                           return $ mkLet defs happy_var_4)}}
	) (\r -> happyReturn (happyIn51 r))

happyReduce_124 = happyMonadReduce 5# 44# happyReduction_124
happyReduction_124 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut54 happy_x_1 of { happy_var_1 -> 
	case happyOut50 happy_x_4 of { happy_var_4 -> 
	(
                                        do defs <- mapM tryLoc happy_var_4
                                           return $ mkLet defs happy_var_1)}}
	) (\r -> happyReturn (happyIn51 r))

happyReduce_125 = happySpecReduce_3  44# happyReduction_125
happyReduction_125 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut56 happy_x_2 of { happy_var_2 -> 
	case happyOutTok happy_x_3 of { ((T_String  happy_var_3)) -> 
	happyIn51
		 (Example happy_var_2 happy_var_3
	)}}

happyReduce_126 = happySpecReduce_1  44# happyReduction_126
happyReduction_126 happy_x_1
	 =  case happyOut52 happy_x_1 of { happy_var_1 -> 
	happyIn51
		 (happy_var_1
	)}

happyReduce_127 = happySpecReduce_3  45# happyReduction_127
happyReduction_127 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut53 happy_x_1 of { happy_var_1 -> 
	case happyOut52 happy_x_3 of { happy_var_3 -> 
	happyIn52
		 (C happy_var_1 happy_var_3
	)}}

happyReduce_128 = happySpecReduce_1  45# happyReduction_128
happyReduction_128 happy_x_1
	 =  case happyOut53 happy_x_1 of { happy_var_1 -> 
	happyIn52
		 (happy_var_1
	)}

happyReduce_129 = happySpecReduce_3  46# happyReduction_129
happyReduction_129 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut54 happy_x_1 of { happy_var_1 -> 
	case happyOut53 happy_x_3 of { happy_var_3 -> 
	happyIn53
		 (Glue happy_var_1 happy_var_3
	)}}

happyReduce_130 = happySpecReduce_1  46# happyReduction_130
happyReduction_130 happy_x_1
	 =  case happyOut54 happy_x_1 of { happy_var_1 -> 
	happyIn53
		 (happy_var_1
	)}

happyReduce_131 = happySpecReduce_3  47# happyReduction_131
happyReduction_131 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut54 happy_x_1 of { happy_var_1 -> 
	case happyOut55 happy_x_3 of { happy_var_3 -> 
	happyIn54
		 (S happy_var_1 happy_var_3
	)}}

happyReduce_132 = happyReduce 4# 47# happyReduction_132
happyReduction_132 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut78 happy_x_3 of { happy_var_3 -> 
	happyIn54
		 (T TRaw happy_var_3
	) `HappyStk` happyRest}

happyReduce_133 = happyReduce 5# 47# happyReduction_133
happyReduction_133 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut57 happy_x_2 of { happy_var_2 -> 
	case happyOut78 happy_x_4 of { happy_var_4 -> 
	happyIn54
		 (T (TTyped happy_var_2) happy_var_4
	) `HappyStk` happyRest}}

happyReduce_134 = happyReduce 5# 47# happyReduction_134
happyReduction_134 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut57 happy_x_2 of { happy_var_2 -> 
	case happyOut58 happy_x_4 of { happy_var_4 -> 
	happyIn54
		 (V happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_135 = happySpecReduce_3  47# happyReduction_135
happyReduction_135 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut54 happy_x_1 of { happy_var_1 -> 
	case happyOut55 happy_x_3 of { happy_var_3 -> 
	happyIn54
		 (case happy_var_1 of
                                         RecType xs -> RecType (xs ++ [(tupleLabel (length xs+1),happy_var_3)])
                                         t          -> RecType [(tupleLabel 1,happy_var_1), (tupleLabel 2,happy_var_3)]
	)}}

happyReduce_136 = happySpecReduce_3  47# happyReduction_136
happyReduction_136 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut54 happy_x_1 of { happy_var_1 -> 
	case happyOut55 happy_x_3 of { happy_var_3 -> 
	happyIn54
		 (ExtR happy_var_1 happy_var_3
	)}}

happyReduce_137 = happySpecReduce_1  47# happyReduction_137
happyReduction_137 happy_x_1
	 =  case happyOut55 happy_x_1 of { happy_var_1 -> 
	happyIn54
		 (happy_var_1
	)}

happyReduce_138 = happySpecReduce_2  48# happyReduction_138
happyReduction_138 happy_x_2
	happy_x_1
	 =  case happyOut55 happy_x_1 of { happy_var_1 -> 
	case happyOut56 happy_x_2 of { happy_var_2 -> 
	happyIn55
		 (App happy_var_1 happy_var_2
	)}}

happyReduce_139 = happyReduce 4# 48# happyReduction_139
happyReduction_139 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut55 happy_x_1 of { happy_var_1 -> 
	case happyOut51 happy_x_3 of { happy_var_3 -> 
	happyIn55
		 (App happy_var_1 (ImplArg happy_var_3)
	) `HappyStk` happyRest}}

happyReduce_140 = happyReduce 6# 48# happyReduction_140
happyReduction_140 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut51 happy_x_2 of { happy_var_2 -> 
	case happyOut78 happy_x_5 of { happy_var_5 -> 
	happyIn55
		 (let annot = case happy_var_2 of
                                             Typed _ t -> TTyped t
                                             _         -> TRaw
                                       in S (T annot happy_var_5) happy_var_2
	) `HappyStk` happyRest}}

happyReduce_141 = happyReduce 4# 48# happyReduction_141
happyReduction_141 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut58 happy_x_3 of { happy_var_3 -> 
	happyIn55
		 (FV happy_var_3
	) `HappyStk` happyRest}

happyReduce_142 = happyMonadReduce 4# 48# happyReduction_142
happyReduction_142 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut78 happy_x_3 of { happy_var_3 -> 
	( mkAlts happy_var_3)}
	) (\r -> happyReturn (happyIn55 r))

happyReduce_143 = happyReduce 6# 48# happyReduction_143
happyReduction_143 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_3 of { ((T_String  happy_var_3)) -> 
	case happyOut80 happy_x_5 of { happy_var_5 -> 
	happyIn55
		 (Alts (K happy_var_3) happy_var_5
	) `HappyStk` happyRest}}

happyReduce_144 = happyReduce 6# 48# happyReduction_144
happyReduction_144 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_3 of { ((T_Ident   happy_var_3)) -> 
	case happyOut80 happy_x_5 of { happy_var_5 -> 
	happyIn55
		 (Alts (Vr happy_var_3) happy_var_5
	) `HappyStk` happyRest}}

happyReduce_145 = happyReduce 4# 48# happyReduction_145
happyReduction_145 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut58 happy_x_3 of { happy_var_3 -> 
	happyIn55
		 (Strs happy_var_3
	) `HappyStk` happyRest}

happyReduce_146 = happySpecReduce_2  48# happyReduction_146
happyReduction_146 happy_x_2
	happy_x_1
	 =  case happyOut63 happy_x_2 of { happy_var_2 -> 
	happyIn55
		 (EPatt happy_var_2
	)}

happyReduce_147 = happySpecReduce_2  48# happyReduction_147
happyReduction_147 happy_x_2
	happy_x_1
	 =  case happyOut56 happy_x_2 of { happy_var_2 -> 
	happyIn55
		 (EPattType happy_var_2
	)}

happyReduce_148 = happySpecReduce_3  48# happyReduction_148
happyReduction_148 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_2 of { ((T_Ident   happy_var_2)) -> 
	case happyOut56 happy_x_3 of { happy_var_3 -> 
	happyIn55
		 (ELincat happy_var_2 happy_var_3
	)}}

happyReduce_149 = happySpecReduce_3  48# happyReduction_149
happyReduction_149 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_2 of { ((T_Ident   happy_var_2)) -> 
	case happyOut56 happy_x_3 of { happy_var_3 -> 
	happyIn55
		 (ELin happy_var_2 happy_var_3
	)}}

happyReduce_150 = happySpecReduce_1  48# happyReduction_150
happyReduction_150 happy_x_1
	 =  case happyOut56 happy_x_1 of { happy_var_1 -> 
	happyIn55
		 (happy_var_1
	)}

happyReduce_151 = happySpecReduce_3  49# happyReduction_151
happyReduction_151 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut56 happy_x_1 of { happy_var_1 -> 
	case happyOut65 happy_x_3 of { happy_var_3 -> 
	happyIn56
		 (P  happy_var_1 happy_var_3
	)}}

happyReduce_152 = happySpecReduce_1  49# happyReduction_152
happyReduction_152 happy_x_1
	 =  case happyOut57 happy_x_1 of { happy_var_1 -> 
	happyIn56
		 (happy_var_1
	)}

happyReduce_153 = happySpecReduce_1  50# happyReduction_153
happyReduction_153 happy_x_1
	 =  case happyOutTok happy_x_1 of { ((T_Ident   happy_var_1)) -> 
	happyIn57
		 (Vr happy_var_1
	)}

happyReduce_154 = happySpecReduce_1  50# happyReduction_154
happyReduction_154 happy_x_1
	 =  case happyOut66 happy_x_1 of { happy_var_1 -> 
	happyIn57
		 (Sort happy_var_1
	)}

happyReduce_155 = happySpecReduce_1  50# happyReduction_155
happyReduction_155 happy_x_1
	 =  case happyOutTok happy_x_1 of { ((T_String  happy_var_1)) -> 
	happyIn57
		 (K happy_var_1
	)}

happyReduce_156 = happySpecReduce_1  50# happyReduction_156
happyReduction_156 happy_x_1
	 =  case happyOutTok happy_x_1 of { ((T_Integer happy_var_1)) -> 
	happyIn57
		 (EInt happy_var_1
	)}

happyReduce_157 = happySpecReduce_1  50# happyReduction_157
happyReduction_157 happy_x_1
	 =  case happyOutTok happy_x_1 of { ((T_Double  happy_var_1)) -> 
	happyIn57
		 (EFloat happy_var_1
	)}

happyReduce_158 = happySpecReduce_1  50# happyReduction_158
happyReduction_158 happy_x_1
	 =  happyIn57
		 (Meta 0
	)

happyReduce_159 = happySpecReduce_2  50# happyReduction_159
happyReduction_159 happy_x_2
	happy_x_1
	 =  happyIn57
		 (Empty
	)

happyReduce_160 = happyReduce 4# 50# happyReduction_160
happyReduction_160 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_2 of { ((T_Ident   happy_var_2)) -> 
	case happyOut59 happy_x_3 of { happy_var_3 -> 
	happyIn57
		 (foldl App (Vr (mkListId happy_var_2)) happy_var_3
	) `HappyStk` happyRest}}

happyReduce_161 = happySpecReduce_3  50# happyReduction_161
happyReduction_161 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_2 of { ((T_String  happy_var_2)) -> 
	happyIn57
		 (K happy_var_2
	)}

happyReduce_162 = happyMonadReduce 3# 50# happyReduction_162
happyReduction_162 (happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest) tk
	 = happyThen (case happyOut50 happy_x_2 of { happy_var_2 -> 
	( mkR happy_var_2)}
	) (\r -> happyReturn (happyIn57 r))

happyReduce_163 = happySpecReduce_3  50# happyReduction_163
happyReduction_163 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut75 happy_x_2 of { happy_var_2 -> 
	happyIn57
		 (R (tuple2record happy_var_2)
	)}

happyReduce_164 = happyReduce 5# 50# happyReduction_164
happyReduction_164 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut51 happy_x_2 of { happy_var_2 -> 
	case happyOut51 happy_x_4 of { happy_var_4 -> 
	happyIn57
		 (Typed happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_165 = happySpecReduce_3  50# happyReduction_165
happyReduction_165 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut51 happy_x_2 of { happy_var_2 -> 
	happyIn57
		 (happy_var_2
	)}

happyReduce_166 = happySpecReduce_0  51# happyReduction_166
happyReduction_166  =  happyIn58
		 ([]
	)

happyReduce_167 = happySpecReduce_1  51# happyReduction_167
happyReduction_167 happy_x_1
	 =  case happyOut51 happy_x_1 of { happy_var_1 -> 
	happyIn58
		 ([happy_var_1]
	)}

happyReduce_168 = happySpecReduce_3  51# happyReduction_168
happyReduction_168 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut51 happy_x_1 of { happy_var_1 -> 
	case happyOut58 happy_x_3 of { happy_var_3 -> 
	happyIn58
		 (happy_var_1 : happy_var_3
	)}}

happyReduce_169 = happySpecReduce_0  52# happyReduction_169
happyReduction_169  =  happyIn59
		 ([]
	)

happyReduce_170 = happySpecReduce_2  52# happyReduction_170
happyReduction_170 happy_x_2
	happy_x_1
	 =  case happyOut57 happy_x_1 of { happy_var_1 -> 
	case happyOut59 happy_x_2 of { happy_var_2 -> 
	happyIn59
		 (happy_var_1 : happy_var_2
	)}}

happyReduce_171 = happySpecReduce_3  53# happyReduction_171
happyReduction_171 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut60 happy_x_1 of { happy_var_1 -> 
	case happyOut61 happy_x_3 of { happy_var_3 -> 
	happyIn60
		 (PAlt happy_var_1 happy_var_3
	)}}

happyReduce_172 = happySpecReduce_3  53# happyReduction_172
happyReduction_172 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut60 happy_x_1 of { happy_var_1 -> 
	case happyOut61 happy_x_3 of { happy_var_3 -> 
	happyIn60
		 (PSeq happy_var_1 happy_var_3
	)}}

happyReduce_173 = happySpecReduce_1  53# happyReduction_173
happyReduction_173 happy_x_1
	 =  case happyOut61 happy_x_1 of { happy_var_1 -> 
	happyIn60
		 (happy_var_1
	)}

happyReduce_174 = happySpecReduce_2  54# happyReduction_174
happyReduction_174 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { ((T_Ident   happy_var_1)) -> 
	case happyOut68 happy_x_2 of { happy_var_2 -> 
	happyIn61
		 (PC happy_var_1 happy_var_2
	)}}

happyReduce_175 = happyReduce 4# 54# happyReduction_175
happyReduction_175 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_1 of { ((T_Ident   happy_var_1)) -> 
	case happyOutTok happy_x_3 of { ((T_Ident   happy_var_3)) -> 
	case happyOut68 happy_x_4 of { happy_var_4 -> 
	happyIn61
		 (PP (happy_var_1,happy_var_3) happy_var_4
	) `HappyStk` happyRest}}}

happyReduce_176 = happySpecReduce_2  54# happyReduction_176
happyReduction_176 happy_x_2
	happy_x_1
	 =  case happyOut63 happy_x_1 of { happy_var_1 -> 
	happyIn61
		 (PRep happy_var_1
	)}

happyReduce_177 = happySpecReduce_1  54# happyReduction_177
happyReduction_177 happy_x_1
	 =  case happyOut62 happy_x_1 of { happy_var_1 -> 
	happyIn61
		 (happy_var_1
	)}

happyReduce_178 = happySpecReduce_3  55# happyReduction_178
happyReduction_178 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { ((T_Ident   happy_var_1)) -> 
	case happyOut63 happy_x_3 of { happy_var_3 -> 
	happyIn62
		 (PAs happy_var_1 happy_var_3
	)}}

happyReduce_179 = happySpecReduce_2  55# happyReduction_179
happyReduction_179 happy_x_2
	happy_x_1
	 =  case happyOut63 happy_x_2 of { happy_var_2 -> 
	happyIn62
		 (PNeg happy_var_2
	)}

happyReduce_180 = happySpecReduce_2  55# happyReduction_180
happyReduction_180 happy_x_2
	happy_x_1
	 =  case happyOut57 happy_x_2 of { happy_var_2 -> 
	happyIn62
		 (PTilde happy_var_2
	)}

happyReduce_181 = happySpecReduce_1  55# happyReduction_181
happyReduction_181 happy_x_1
	 =  case happyOut63 happy_x_1 of { happy_var_1 -> 
	happyIn62
		 (happy_var_1
	)}

happyReduce_182 = happySpecReduce_1  56# happyReduction_182
happyReduction_182 happy_x_1
	 =  happyIn63
		 (PChar
	)

happyReduce_183 = happySpecReduce_3  56# happyReduction_183
happyReduction_183 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_2 of { ((T_String  happy_var_2)) -> 
	happyIn63
		 (PChars happy_var_2
	)}

happyReduce_184 = happySpecReduce_2  56# happyReduction_184
happyReduction_184 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_2 of { ((T_Ident   happy_var_2)) -> 
	happyIn63
		 (PMacro happy_var_2
	)}

happyReduce_185 = happyReduce 4# 56# happyReduction_185
happyReduction_185 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOutTok happy_x_2 of { ((T_Ident   happy_var_2)) -> 
	case happyOutTok happy_x_4 of { ((T_Ident   happy_var_4)) -> 
	happyIn63
		 (PM (happy_var_2,happy_var_4)
	) `HappyStk` happyRest}}

happyReduce_186 = happySpecReduce_1  56# happyReduction_186
happyReduction_186 happy_x_1
	 =  happyIn63
		 (PW
	)

happyReduce_187 = happySpecReduce_1  56# happyReduction_187
happyReduction_187 happy_x_1
	 =  case happyOutTok happy_x_1 of { ((T_Ident   happy_var_1)) -> 
	happyIn63
		 (PV happy_var_1
	)}

happyReduce_188 = happySpecReduce_3  56# happyReduction_188
happyReduction_188 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_1 of { ((T_Ident   happy_var_1)) -> 
	case happyOutTok happy_x_3 of { ((T_Ident   happy_var_3)) -> 
	happyIn63
		 (PP (happy_var_1,happy_var_3) []
	)}}

happyReduce_189 = happySpecReduce_1  56# happyReduction_189
happyReduction_189 happy_x_1
	 =  case happyOutTok happy_x_1 of { ((T_Integer happy_var_1)) -> 
	happyIn63
		 (PInt happy_var_1
	)}

happyReduce_190 = happySpecReduce_1  56# happyReduction_190
happyReduction_190 happy_x_1
	 =  case happyOutTok happy_x_1 of { ((T_Double  happy_var_1)) -> 
	happyIn63
		 (PFloat  happy_var_1
	)}

happyReduce_191 = happySpecReduce_1  56# happyReduction_191
happyReduction_191 happy_x_1
	 =  case happyOutTok happy_x_1 of { ((T_String  happy_var_1)) -> 
	happyIn63
		 (PString happy_var_1
	)}

happyReduce_192 = happySpecReduce_3  56# happyReduction_192
happyReduction_192 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut67 happy_x_2 of { happy_var_2 -> 
	happyIn63
		 (PR happy_var_2
	)}

happyReduce_193 = happySpecReduce_3  56# happyReduction_193
happyReduction_193 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut76 happy_x_2 of { happy_var_2 -> 
	happyIn63
		 ((PR . tuple2recordPatt) happy_var_2
	)}

happyReduce_194 = happySpecReduce_3  56# happyReduction_194
happyReduction_194 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut60 happy_x_2 of { happy_var_2 -> 
	happyIn63
		 (happy_var_2
	)}

happyReduce_195 = happySpecReduce_3  57# happyReduction_195
happyReduction_195 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut44 happy_x_1 of { happy_var_1 -> 
	case happyOut60 happy_x_3 of { happy_var_3 -> 
	happyIn64
		 ([(LIdent (ident2raw i),happy_var_3) | i <- happy_var_1]
	)}}

happyReduce_196 = happySpecReduce_1  58# happyReduction_196
happyReduction_196 happy_x_1
	 =  case happyOutTok happy_x_1 of { ((T_Ident   happy_var_1)) -> 
	happyIn65
		 (LIdent (ident2raw happy_var_1)
	)}

happyReduce_197 = happySpecReduce_2  58# happyReduction_197
happyReduction_197 happy_x_2
	happy_x_1
	 =  case happyOutTok happy_x_2 of { ((T_Integer happy_var_2)) -> 
	happyIn65
		 (LVar (fromIntegral happy_var_2)
	)}

happyReduce_198 = happySpecReduce_1  59# happyReduction_198
happyReduction_198 happy_x_1
	 =  happyIn66
		 (cType
	)

happyReduce_199 = happySpecReduce_1  59# happyReduction_199
happyReduction_199 happy_x_1
	 =  happyIn66
		 (cPType
	)

happyReduce_200 = happySpecReduce_1  59# happyReduction_200
happyReduction_200 happy_x_1
	 =  happyIn66
		 (cTok
	)

happyReduce_201 = happySpecReduce_1  59# happyReduction_201
happyReduction_201 happy_x_1
	 =  happyIn66
		 (cStr
	)

happyReduce_202 = happySpecReduce_1  59# happyReduction_202
happyReduction_202 happy_x_1
	 =  happyIn66
		 (cStrs
	)

happyReduce_203 = happySpecReduce_0  60# happyReduction_203
happyReduction_203  =  happyIn67
		 ([]
	)

happyReduce_204 = happySpecReduce_1  60# happyReduction_204
happyReduction_204 happy_x_1
	 =  case happyOut64 happy_x_1 of { happy_var_1 -> 
	happyIn67
		 (happy_var_1
	)}

happyReduce_205 = happySpecReduce_3  60# happyReduction_205
happyReduction_205 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut64 happy_x_1 of { happy_var_1 -> 
	case happyOut67 happy_x_3 of { happy_var_3 -> 
	happyIn67
		 (happy_var_1 ++ happy_var_3
	)}}

happyReduce_206 = happySpecReduce_1  61# happyReduction_206
happyReduction_206 happy_x_1
	 =  case happyOut69 happy_x_1 of { happy_var_1 -> 
	happyIn68
		 ([happy_var_1]
	)}

happyReduce_207 = happySpecReduce_2  61# happyReduction_207
happyReduction_207 happy_x_2
	happy_x_1
	 =  case happyOut69 happy_x_1 of { happy_var_1 -> 
	case happyOut68 happy_x_2 of { happy_var_2 -> 
	happyIn68
		 (happy_var_1 : happy_var_2
	)}}

happyReduce_208 = happySpecReduce_1  62# happyReduction_208
happyReduction_208 happy_x_1
	 =  case happyOut62 happy_x_1 of { happy_var_1 -> 
	happyIn69
		 (happy_var_1
	)}

happyReduce_209 = happySpecReduce_3  62# happyReduction_209
happyReduction_209 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut60 happy_x_2 of { happy_var_2 -> 
	happyIn69
		 (PImplArg happy_var_2
	)}

happyReduce_210 = happySpecReduce_1  63# happyReduction_210
happyReduction_210 happy_x_1
	 =  case happyOutTok happy_x_1 of { ((T_Ident   happy_var_1)) -> 
	happyIn70
		 ([(Explicit,happy_var_1    )]
	)}

happyReduce_211 = happySpecReduce_1  63# happyReduction_211
happyReduction_211 happy_x_1
	 =  happyIn70
		 ([(Explicit,identW)]
	)

happyReduce_212 = happySpecReduce_3  63# happyReduction_212
happyReduction_212 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut45 happy_x_2 of { happy_var_2 -> 
	happyIn70
		 ([(Implicit,v) | v <- happy_var_2]
	)}

happyReduce_213 = happySpecReduce_1  64# happyReduction_213
happyReduction_213 happy_x_1
	 =  case happyOut70 happy_x_1 of { happy_var_1 -> 
	happyIn71
		 (happy_var_1
	)}

happyReduce_214 = happySpecReduce_2  64# happyReduction_214
happyReduction_214 happy_x_2
	happy_x_1
	 =  case happyOut70 happy_x_1 of { happy_var_1 -> 
	case happyOut71 happy_x_2 of { happy_var_2 -> 
	happyIn71
		 (happy_var_1 ++ happy_var_2
	)}}

happyReduce_215 = happySpecReduce_1  65# happyReduction_215
happyReduction_215 happy_x_1
	 =  case happyOutTok happy_x_1 of { ((T_Ident   happy_var_1)) -> 
	happyIn72
		 ([(Explicit,happy_var_1    )]
	)}

happyReduce_216 = happySpecReduce_1  65# happyReduction_216
happyReduction_216 happy_x_1
	 =  happyIn72
		 ([(Explicit,identW)]
	)

happyReduce_217 = happySpecReduce_3  65# happyReduction_217
happyReduction_217 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut44 happy_x_2 of { happy_var_2 -> 
	happyIn72
		 ([(Implicit,v) | v <- happy_var_2]
	)}

happyReduce_218 = happySpecReduce_1  66# happyReduction_218
happyReduction_218 happy_x_1
	 =  case happyOut72 happy_x_1 of { happy_var_1 -> 
	happyIn73
		 (happy_var_1
	)}

happyReduce_219 = happySpecReduce_3  66# happyReduction_219
happyReduction_219 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut72 happy_x_1 of { happy_var_1 -> 
	case happyOut73 happy_x_3 of { happy_var_3 -> 
	happyIn73
		 (happy_var_1 ++ happy_var_3
	)}}

happyReduce_220 = happyReduce 5# 67# happyReduction_220
happyReduction_220 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut73 happy_x_2 of { happy_var_2 -> 
	case happyOut51 happy_x_4 of { happy_var_4 -> 
	happyIn74
		 ([(b,x,happy_var_4) | (b,x) <- happy_var_2]
	) `HappyStk` happyRest}}

happyReduce_221 = happySpecReduce_1  67# happyReduction_221
happyReduction_221 happy_x_1
	 =  case happyOut54 happy_x_1 of { happy_var_1 -> 
	happyIn74
		 ([mkHypo happy_var_1]
	)}

happyReduce_222 = happySpecReduce_0  68# happyReduction_222
happyReduction_222  =  happyIn75
		 ([]
	)

happyReduce_223 = happySpecReduce_1  68# happyReduction_223
happyReduction_223 happy_x_1
	 =  case happyOut51 happy_x_1 of { happy_var_1 -> 
	happyIn75
		 ([happy_var_1]
	)}

happyReduce_224 = happySpecReduce_3  68# happyReduction_224
happyReduction_224 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut51 happy_x_1 of { happy_var_1 -> 
	case happyOut75 happy_x_3 of { happy_var_3 -> 
	happyIn75
		 (happy_var_1 : happy_var_3
	)}}

happyReduce_225 = happySpecReduce_0  69# happyReduction_225
happyReduction_225  =  happyIn76
		 ([]
	)

happyReduce_226 = happySpecReduce_1  69# happyReduction_226
happyReduction_226 happy_x_1
	 =  case happyOut60 happy_x_1 of { happy_var_1 -> 
	happyIn76
		 ([happy_var_1]
	)}

happyReduce_227 = happySpecReduce_3  69# happyReduction_227
happyReduction_227 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut60 happy_x_1 of { happy_var_1 -> 
	case happyOut76 happy_x_3 of { happy_var_3 -> 
	happyIn76
		 (happy_var_1 : happy_var_3
	)}}

happyReduce_228 = happySpecReduce_3  70# happyReduction_228
happyReduction_228 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut60 happy_x_1 of { happy_var_1 -> 
	case happyOut51 happy_x_3 of { happy_var_3 -> 
	happyIn77
		 ((happy_var_1,happy_var_3)
	)}}

happyReduce_229 = happySpecReduce_1  71# happyReduction_229
happyReduction_229 happy_x_1
	 =  case happyOut77 happy_x_1 of { happy_var_1 -> 
	happyIn78
		 ([happy_var_1]
	)}

happyReduce_230 = happySpecReduce_3  71# happyReduction_230
happyReduction_230 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut77 happy_x_1 of { happy_var_1 -> 
	case happyOut78 happy_x_3 of { happy_var_3 -> 
	happyIn78
		 (happy_var_1 : happy_var_3
	)}}

happyReduce_231 = happySpecReduce_3  72# happyReduction_231
happyReduction_231 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut51 happy_x_1 of { happy_var_1 -> 
	case happyOut51 happy_x_3 of { happy_var_3 -> 
	happyIn79
		 ((happy_var_1,happy_var_3)
	)}}

happyReduce_232 = happySpecReduce_1  73# happyReduction_232
happyReduction_232 happy_x_1
	 =  case happyOut79 happy_x_1 of { happy_var_1 -> 
	happyIn80
		 ([happy_var_1]
	)}

happyReduce_233 = happySpecReduce_3  73# happyReduction_233
happyReduction_233 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut79 happy_x_1 of { happy_var_1 -> 
	case happyOut80 happy_x_3 of { happy_var_3 -> 
	happyIn80
		 (happy_var_1 : happy_var_3
	)}}

happyReduce_234 = happyReduce 5# 74# happyReduction_234
happyReduction_234 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut73 happy_x_2 of { happy_var_2 -> 
	case happyOut51 happy_x_4 of { happy_var_4 -> 
	happyIn81
		 ([(b,x,happy_var_4) | (b,x) <- happy_var_2]
	) `HappyStk` happyRest}}

happyReduce_235 = happySpecReduce_1  74# happyReduction_235
happyReduction_235 happy_x_1
	 =  case happyOut57 happy_x_1 of { happy_var_1 -> 
	happyIn81
		 ([mkHypo happy_var_1]
	)}

happyReduce_236 = happySpecReduce_0  75# happyReduction_236
happyReduction_236  =  happyIn82
		 ([]
	)

happyReduce_237 = happySpecReduce_2  75# happyReduction_237
happyReduction_237 happy_x_2
	happy_x_1
	 =  case happyOut81 happy_x_1 of { happy_var_1 -> 
	case happyOut82 happy_x_2 of { happy_var_2 -> 
	happyIn82
		 (happy_var_1 ++ happy_var_2
	)}}

happyReduce_238 = happyMonadReduce 0# 76# happyReduction_238
happyReduction_238 (happyRest) tk
	 = happyThen (( getPosn)
	) (\r -> happyReturn (happyIn83 r))

happyNewToken action sts stk
	= lexer(\tk -> 
	let cont i = happyDoAction i tk action sts stk in
	case tk of {
	T_EOF -> happyDoAction 71# tk action sts stk;
	T_exclmark -> cont 1#;
	T_patt -> cont 2#;
	T_int_label -> cont 3#;
	T_oparen -> cont 4#;
	T_cparen -> cont 5#;
	T_tilde -> cont 6#;
	T_star -> cont 7#;
	T_starstar -> cont 8#;
	T_plus -> cont 9#;
	T_plusplus -> cont 10#;
	T_comma -> cont 11#;
	T_minus -> cont 12#;
	T_rarrow -> cont 13#;
	T_dot -> cont 14#;
	T_alt -> cont 15#;
	T_colon -> cont 16#;
	T_semicolon -> cont 17#;
	T_less -> cont 18#;
	T_equal -> cont 19#;
	T_big_rarrow -> cont 20#;
	T_great -> cont 21#;
	T_questmark -> cont 22#;
	T_at -> cont 23#;
	T_obrack -> cont 24#;
	T_cbrack -> cont 25#;
	T_ocurly -> cont 26#;
	T_ccurly -> cont 27#;
	T_lam -> cont 28#;
	T_lamlam -> cont 29#;
	T_underscore -> cont 30#;
	T_bar -> cont 31#;
	T_PType -> cont 32#;
	T_Str -> cont 33#;
	T_Strs -> cont 34#;
	T_Tok -> cont 35#;
	T_Type -> cont 36#;
	T_abstract -> cont 37#;
	T_case -> cont 38#;
	T_cat -> cont 39#;
	T_concrete -> cont 40#;
	T_data -> cont 41#;
	T_def -> cont 42#;
	T_flags -> cont 43#;
	T_fun -> cont 44#;
	T_in -> cont 45#;
	T_incomplete -> cont 46#;
	T_instance -> cont 47#;
	T_interface -> cont 48#;
	T_let -> cont 49#;
	T_lin -> cont 50#;
	T_lincat -> cont 51#;
	T_lindef -> cont 52#;
	T_linref -> cont 53#;
	T_of -> cont 54#;
	T_open -> cont 55#;
	T_oper -> cont 56#;
	T_param -> cont 57#;
	T_pattern -> cont 58#;
	T_pre -> cont 59#;
	T_printname -> cont 60#;
	T_resource -> cont 61#;
	T_strs -> cont 62#;
	T_table -> cont 63#;
	T_variants -> cont 64#;
	T_where -> cont 65#;
	T_with -> cont 66#;
	(T_Integer happy_dollar_dollar) -> cont 67#;
	(T_Double  happy_dollar_dollar) -> cont 68#;
	(T_String  happy_dollar_dollar) -> cont 69#;
	(T_Ident   happy_dollar_dollar) -> cont 70#;
	_ -> happyError' tk
	})

happyError_ 71# tk = happyError' tk
happyError_ _ tk = happyError' tk

happyThen :: () => P a -> (a -> P b) -> P b
happyThen = (>>=)
happyReturn :: () => a -> P a
happyReturn = (return)
happyThen1 = happyThen
happyReturn1 :: () => a -> P a
happyReturn1 = happyReturn
happyError' :: () => (Token) -> P a
happyError' tk = (\token -> happyError) tk

pModDef = happySomeParser where
  happySomeParser = happyThen (happyParse 0#) (\x -> happyReturn (happyOut7 x))

pTopDef = happySomeParser where
  happySomeParser = happyThen (happyParse 1#) (\x -> happyReturn (happyOut22 x))

pModHeader = happySomeParser where
  happySomeParser = happyThen (happyParse 2#) (\x -> happyReturn (happyOut8 x))

pExp = happySomeParser where
  happySomeParser = happyThen (happyParse 3#) (\x -> happyReturn (happyOut51 x))

happySeq = happyDontSeq


happyError :: P a
happyError = fail "syntax error"

mkListId,mkConsId,mkBaseId  :: Ident -> Ident
mkListId = prefixIdent "List"
mkConsId = prefixIdent "Cons"
mkBaseId = prefixIdent "Base"

listCatDef :: L (Ident, Context, Int) -> [(Ident,Info)]
listCatDef (L loc (id,cont,size)) = [catd,nilfund,consfund]
  where
    listId = mkListId id
    baseId = mkBaseId id
    consId = mkConsId id

    catd     = (listId, AbsCat (Just (L loc cont')))
    nilfund  = (baseId, AbsFun (Just (L loc niltyp))  Nothing Nothing (Just True))
    consfund = (consId, AbsFun (Just (L loc constyp)) Nothing Nothing (Just True))

    cont' = [(b,mkId x i,ty) | (i,(b,x,ty)) <- zip [0..] cont]
    xs = map (\(b,x,t) -> Vr x) cont'
    cd = mkHypo (mkApp (Vr id) xs)
    lc = mkApp (Vr listId) xs

    niltyp  = mkProdSimple (cont' ++ replicate size cd) lc
    constyp = mkProdSimple (cont' ++ [cd, mkHypo lc]) lc

    mkId x i = if isWildIdent x then (varX i) else x

tryLoc (c,mty,Just e) = return (c,(mty,e))
tryLoc (c,_  ,_     ) = fail ("local definition of" +++ showIdent c +++ "without value")

mkR []       = return $ RecType [] --- empty record always interpreted as record type
mkR fs@(f:_) =
  case f of
    (lab,Just ty,Nothing) -> mapM tryRT fs >>= return . RecType
    _                     -> mapM tryR  fs >>= return . R
  where
    tryRT (lab,Just ty,Nothing) = return (ident2label lab,ty)
    tryRT (lab,_      ,_      ) = fail $ "illegal record type field" +++ showIdent lab --- manifest fields ?!

    tryR (lab,mty,Just t) = return (ident2label lab,(mty,t))
    tryR (lab,_  ,_     ) = fail $ "illegal record field" +++ showIdent lab

mkOverload pdt pdf@(Just (L loc df)) =
  case appForm df of
    (keyw, ts@(_:_)) | isOverloading keyw -> 
       case last ts of
         R fs -> [ResOverload [m | Vr m <- ts] [(L loc ty,L loc fu) | (_,(Just ty,fu)) <- fs]]
         _    -> [ResOper pdt pdf]
    _         -> [ResOper pdt pdf]

     -- to enable separare type signature --- not type-checked
mkOverload pdt@(Just (L _ df)) pdf =
  case appForm df of
    (keyw, ts@(_:_)) | isOverloading keyw ->
       case last ts of
         RecType _ -> [] 
         _         -> [ResOper pdt pdf]
    _              -> [ResOper pdt pdf]
mkOverload pdt pdf = [ResOper pdt pdf]

isOverloading t =
  case t of
    Vr keyw | showIdent keyw == "overload" -> True      -- overload is a "soft keyword"
    _                                      -> False

checkInfoType mt jment@(id,info) =
  case info of
    AbsCat pcont         -> ifAbstract mt (locPerh pcont)
    AbsFun pty _ pde _   -> ifAbstract mt (locPerh pty ++ maybe [] locAll pde)
    CncCat pty pd pr ppn _->ifConcrete mt (locPerh pty ++ locPerh pd ++ locPerh pr ++ locPerh ppn)
    CncFun _   pd ppn _  -> ifConcrete mt (locPerh pd ++ locPerh ppn)
    ResParam pparam _    -> ifResource mt (locPerh pparam)
    ResValue ty          -> ifResource mt (locL ty)
    ResOper  pty pt      -> ifOper mt pty pt
    ResOverload _ xs     -> ifResource mt (concat [[loc1,loc2] | (L loc1 _,L loc2 _) <- xs])
  where
    locPerh = maybe [] locL
    locAll xs = [loc | L loc x <- xs]
    locL (L loc x) = [loc]
    
    illegal (Local s e:_) = failLoc (Pn s 0) "illegal definition"
    illegal _             = return jment

    ifAbstract MTAbstract     locs = return jment
    ifAbstract _              locs = illegal locs

    ifConcrete (MTConcrete _) locs = return jment
    ifConcrete _              locs = illegal locs

    ifResource (MTConcrete _) locs = return jment
    ifResource (MTInstance _) locs = return jment
    ifResource MTInterface    locs = return jment
    ifResource MTResource     locs = return jment
    ifResource _              locs = illegal locs
    
    ifOper MTAbstract pty pt = return (id,AbsFun pty (fmap (const 0) pt) (Just (maybe [] (\(L l t) -> [L l ([],t)]) pt)) (Just False))
    ifOper _          pty pt = return jment

mkAlts cs = case cs of
  _:_ -> do
    def  <- mkDef (last cs)
    alts <- mapM mkAlt (init cs)
    return (Alts def alts)
  _ -> fail "empty alts"
 where
   mkDef (_,t) = return t
   mkAlt (p,t) = do
     ss <- mkStrs p
     return (t,ss)
   mkStrs p = case p of
     PAlt a b -> do
       Strs as <- mkStrs a
       Strs bs <- mkStrs b
       return $ Strs $ as ++ bs
     PString s -> return $ Strs [K s]
     PV x -> return (Vr x) --- for macros; not yet complete
     PMacro x -> return (Vr x) --- for macros; not yet complete
     PM c -> return (Q c) --- for macros; not yet complete
     _ -> fail "no strs from pattern"

mkL :: Posn -> Posn -> x -> L x
mkL (Pn l1 _) (Pn l2 _) x = L (Local l1 l2) x
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command-line>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 

{-# LINE 30 "templates/GenericTemplate.hs" #-}


data Happy_IntList = HappyCons Happy_GHC_Exts.Int# Happy_IntList





{-# LINE 51 "templates/GenericTemplate.hs" #-}

{-# LINE 61 "templates/GenericTemplate.hs" #-}

{-# LINE 70 "templates/GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is 0#, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept 0# tk st sts (_ `HappyStk` ans `HappyStk` _) =
	happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
	(happyTcHack j (happyTcHack st)) (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action



happyDoAction i tk st
	= {- nothing -}


	  case action of
		0#		  -> {- nothing -}
				     happyFail i tk st
		-1# 	  -> {- nothing -}
				     happyAccept i tk st
		n | (n Happy_GHC_Exts.<# (0# :: Happy_GHC_Exts.Int#)) -> {- nothing -}

				     (happyReduceArr Happy_Data_Array.! rule) i tk st
				     where rule = (Happy_GHC_Exts.I# ((Happy_GHC_Exts.negateInt# ((n Happy_GHC_Exts.+# (1# :: Happy_GHC_Exts.Int#))))))
		n		  -> {- nothing -}


				     happyShift new_state i tk st
				     where (new_state) = (n Happy_GHC_Exts.-# (1# :: Happy_GHC_Exts.Int#))
   where (off)    = indexShortOffAddr happyActOffsets st
         (off_i)  = (off Happy_GHC_Exts.+# i)
	 check  = if (off_i Happy_GHC_Exts.>=# (0# :: Happy_GHC_Exts.Int#))
			then (indexShortOffAddr happyCheck off_i Happy_GHC_Exts.==#  i)
			else False
         (action)
          | check     = indexShortOffAddr happyTable off_i
          | otherwise = indexShortOffAddr happyDefActions st

{-# LINE 130 "templates/GenericTemplate.hs" #-}


indexShortOffAddr (HappyA# arr) off =
	Happy_GHC_Exts.narrow16Int# i
  where
        i = Happy_GHC_Exts.word2Int# (Happy_GHC_Exts.or# (Happy_GHC_Exts.uncheckedShiftL# high 8#) low)
        high = Happy_GHC_Exts.int2Word# (Happy_GHC_Exts.ord# (Happy_GHC_Exts.indexCharOffAddr# arr (off' Happy_GHC_Exts.+# 1#)))
        low  = Happy_GHC_Exts.int2Word# (Happy_GHC_Exts.ord# (Happy_GHC_Exts.indexCharOffAddr# arr off'))
        off' = off Happy_GHC_Exts.*# 2#





data HappyAddr = HappyA# Happy_GHC_Exts.Addr#




-----------------------------------------------------------------------------
-- HappyState data type (not arrays)

{-# LINE 163 "templates/GenericTemplate.hs" #-}

-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state 0# tk st sts stk@(x `HappyStk` _) =
     let (i) = (case Happy_GHC_Exts.unsafeCoerce# x of { (Happy_GHC_Exts.I# (i)) -> i }) in
--     trace "shifting the error token" $
     happyDoAction i tk new_state (HappyCons (st) (sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state (HappyCons (st) (sts)) ((happyInTok (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happySpecReduce_0 nt fn j tk st@((action)) sts stk
     = happyGoto nt j tk st (HappyCons (st) (sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@((HappyCons (st@(action)) (_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happySpecReduce_2 nt fn j tk _ (HappyCons (_) (sts@((HappyCons (st@(action)) (_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happySpecReduce_3 nt fn j tk _ (HappyCons (_) ((HappyCons (_) (sts@((HappyCons (st@(action)) (_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k Happy_GHC_Exts.-# (1# :: Happy_GHC_Exts.Int#)) sts of
	 sts1@((HappyCons (st1@(action)) (_))) ->
        	let r = fn stk in  -- it doesn't hurt to always seq here...
       		happyDoSeq r (happyGoto nt j tk st1 sts1 r)

happyMonadReduce k nt fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
        happyThen1 (fn stk tk) (\r -> happyGoto nt j tk st1 sts1 (r `HappyStk` drop_stk))
       where (sts1@((HappyCons (st1@(action)) (_)))) = happyDrop k (HappyCons (st) (sts))
             drop_stk = happyDropStk k stk

happyMonad2Reduce k nt fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
       happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))
       where (sts1@((HappyCons (st1@(action)) (_)))) = happyDrop k (HappyCons (st) (sts))
             drop_stk = happyDropStk k stk

             (off) = indexShortOffAddr happyGotoOffsets st1
             (off_i) = (off Happy_GHC_Exts.+# nt)
             (new_state) = indexShortOffAddr happyTable off_i




happyDrop 0# l = l
happyDrop n (HappyCons (_) (t)) = happyDrop (n Happy_GHC_Exts.-# (1# :: Happy_GHC_Exts.Int#)) t

happyDropStk 0# l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n Happy_GHC_Exts.-# (1#::Happy_GHC_Exts.Int#)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction


happyGoto nt j tk st = 
   {- nothing -}
   happyDoAction j tk new_state
   where (off) = indexShortOffAddr happyGotoOffsets st
         (off_i) = (off Happy_GHC_Exts.+# nt)
         (new_state) = indexShortOffAddr happyTable off_i




-----------------------------------------------------------------------------
-- Error recovery (0# is the error token)

-- parse error if we are in recovery and we fail again
happyFail 0# tk old_st _ stk@(x `HappyStk` _) =
     let (i) = (case Happy_GHC_Exts.unsafeCoerce# x of { (Happy_GHC_Exts.I# (i)) -> i }) in
--	trace "failing" $ 
        happyError_ i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  0# tk old_st (HappyCons ((action)) (sts)) 
						(saved_tok `HappyStk` _ `HappyStk` stk) =
--	trace ("discarding state, depth " ++ show (length stk))  $
	happyDoAction 0# tk action sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (action) sts stk =
--      trace "entering error recovery" $
	happyDoAction 0# tk action sts ( (Happy_GHC_Exts.unsafeCoerce# (Happy_GHC_Exts.I# (i))) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions


happyTcHack :: Happy_GHC_Exts.Int# -> a -> a
happyTcHack x y = y
{-# INLINE happyTcHack #-}


-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--	happySeq = happyDoSeq
-- otherwise it emits
-- 	happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.


{-# NOINLINE happyDoAction #-}
{-# NOINLINE happyTable #-}
{-# NOINLINE happyCheck #-}
{-# NOINLINE happyActOffsets #-}
{-# NOINLINE happyGotoOffsets #-}
{-# NOINLINE happyDefActions #-}

{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
