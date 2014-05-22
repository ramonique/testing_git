module PGF.Binary(putSplitAbs) where

import PGF.CId
import PGF.Data
import PGF.Optimize
import qualified PGF.OldBinary as Old
import Data.Binary
import Data.Binary.Put
import Data.Binary.Get
import Data.Array.IArray
import qualified Data.ByteString as BS
import qualified Data.Map as Map
import qualified Data.IntMap as IntMap
--import qualified Data.Set as Set
import Control.Monad

pgfMajorVersion, pgfMinorVersion :: Word16
version@(pgfMajorVersion, pgfMinorVersion) = (2,0)

instance Binary PGF where
  put pgf = do putWord16be pgfMajorVersion
               putWord16be pgfMinorVersion
               put (gflags pgf)
               put (absname pgf, abstract pgf)
               put (concretes pgf)
  get = do v1 <- getWord16be
           v2 <- getWord16be
           case (v1,v2) of
             v | v==version -> getPGF'
               | v==Old.version -> Old.getPGF'

getPGF'=do gflags <- get
           (absname,abstract) <- get
           concretes <- get
           return $ updateProductionIndices $
                      (PGF{ gflags=gflags
                          , absname=absname, abstract=abstract
                          , concretes=concretes
                          })

instance Binary CId where
  put (CId bs) = put bs
  get    = liftM CId get

instance Binary Abstr where
  put abs = put (aflags abs, 
                 fmap (\(w,x,y,z,_) -> (w,x,y,z)) (funs abs),
                 fmap (\(x,y,z,_) -> (x,y,z)) (cats abs))
  get = do aflags <- get
           funs <- get
           cats <- get
           return (Abstr{ aflags=aflags
                        , funs=fmap (\(w,x,y,z) -> (w,x,y,z,0)) funs
                        , cats=fmap (\(x,y,z) -> (x,y,z,0)) cats
                        , code=BS.empty                        
                        })

putSplitAbs :: PGF -> Put
putSplitAbs pgf = do
  putWord16be pgfMajorVersion
  putWord16be pgfMinorVersion
  put (Map.insert (mkCId "split") (LStr "true") (gflags pgf))
  put (absname pgf, abstract pgf)
  put [(name,cflags cnc) | (name,cnc) <- Map.toList (concretes pgf)]

instance Binary Concr where
  put cnc = do put (cflags cnc)
               put (printnames cnc)
               putArray2 (sequences cnc)
               putArray (cncfuns cnc)
               put (lindefs cnc)
               put (linrefs cnc)
               put (productions cnc)
               put (cnccats cnc)
               put (totalCats cnc)
  get = do cflags      <- get
           printnames  <- get
           sequences   <- getArray2
           cncfuns     <- getArray
           lindefs     <- get
           linrefs     <- get
           productions <- get
           cnccats     <- get
           totalCats   <- get
           return (Concr{ cflags=cflags, printnames=printnames
                        , sequences=sequences, cncfuns=cncfuns
                        , lindefs=lindefs, linrefs=linrefs
                        , productions=productions
                        , pproductions = IntMap.empty
                        , lproductions = Map.empty
                        , lexicon = IntMap.empty
                        , cnccats=cnccats, totalCats=totalCats
                        })

instance Binary Expr where
  put (EAbs b x exp)  = putWord8 0 >> put (b,x,exp)
  put (EApp e1 e2)    = putWord8 1 >> put (e1,e2)
  put (ELit l)        = putWord8 2 >> put l
  put (EMeta i)       = putWord8 3 >> put i
  put (EFun  f)       = putWord8 4 >> put f
  put (EVar  i)       = putWord8 5 >> put i
  put (ETyped e ty)   = putWord8 6 >> put (e,ty)
  put (EImplArg e)    = putWord8 7 >> put e
  get = do tag <- getWord8
           case tag of
             0 -> liftM3 EAbs get get get
             1 -> liftM2 EApp get get
             2 -> liftM  ELit get
             3 -> liftM  EMeta get
             4 -> liftM  EFun get
             5 -> liftM  EVar get
             6 -> liftM2 ETyped get get
             7 -> liftM  EImplArg get
             _ -> decodingError

instance Binary Patt where
  put (PApp f ps)  = putWord8 0 >> put (f,ps)
  put (PVar   x)   = putWord8 1 >> put x
  put (PAs x p)    = putWord8 2 >> put (x,p)
  put PWild        = putWord8 3
  put (PLit l)     = putWord8 4 >> put l
  put (PImplArg p) = putWord8 5 >> put p
  put (PTilde p)   = putWord8 6 >> put p
  get = do tag <- getWord8
           case tag of
             0 -> liftM2 PApp get get
             1 -> liftM  PVar get
             2 -> liftM2 PAs get get
             3 -> return PWild
             4 -> liftM  PLit get
             5 -> liftM  PImplArg get
             6 -> liftM  PTilde get
             _ -> decodingError

instance Binary Equation where
  put (Equ ps e) = put (ps,e)
  get = liftM2 Equ get get

instance Binary Type where
  put (DTyp hypos cat exps) = put (hypos,cat,exps)
  get = liftM3 DTyp get get get

instance Binary BindType where
  put Explicit = putWord8 0
  put Implicit = putWord8 1
  get = do tag <- getWord8
           case tag of
             0 -> return Explicit
             1 -> return Implicit
             _ -> decodingError

instance Binary CncFun where
  put (CncFun fun lins) = put fun >> putArray lins
  get = liftM2 CncFun get getArray

instance Binary CncCat where
  put (CncCat s e labels) = do put (s,e)
                               putArray labels
  get = liftM3 CncCat get get getArray

instance Binary Symbol where
  put (SymCat n l)       = putWord8 0 >> put (n,l)
  put (SymLit n l)       = putWord8 1 >> put (n,l)
  put (SymVar n l)       = putWord8 2 >> put (n,l)
  put (SymKS ts)         = putWord8 3 >> put ts
  put (SymKP d vs)       = putWord8 4 >> put (d,vs)
  put SymBIND            = putWord8 5
  put SymSOFT_BIND       = putWord8 6
  put SymNE              = putWord8 7
  get = do tag <- getWord8
           case tag of
             0 -> liftM2 SymCat get get
             1 -> liftM2 SymLit get get
             2 -> liftM2 SymVar get get
             3 -> liftM  SymKS  get
             4 -> liftM2 (\d vs -> SymKP d vs) get get
             5 -> return SymBIND
             6 -> return SymSOFT_BIND
             7 -> return SymNE
             _ -> decodingError

instance Binary PArg where
  put (PArg hypos fid) = put (map snd hypos,fid)
  get = get >>= \(hypos,fid) -> return (PArg (zip (repeat fidVar) hypos) fid)

instance Binary Production where
  put (PApply ruleid args) = putWord8 0 >> put (ruleid,args)
  put (PCoerce fcat)       = putWord8 1 >> put fcat
  get = do tag <- getWord8
           case tag of
             0 -> liftM2 PApply  get get
             1 -> liftM  PCoerce get
             _ -> decodingError

instance Binary Literal where
  put (LStr s) = putWord8 0 >> put s
  put (LInt i) = putWord8 1 >> put i
  put (LFlt d) = putWord8 2 >> put d
  get = do tag <- getWord8
           case tag of
             0 -> liftM  LStr get
             1 -> liftM  LInt get
             2 -> liftM  LFlt get
             _ -> decodingError


putArray :: (Binary e, IArray a e) => a Int e -> Put
putArray a = do put (rangeSize $ bounds a) -- write the length
                mapM_ put (elems a)        -- now the elems.

getArray :: (Binary e, IArray a e) => Get (a Int e)
getArray = do n  <- get                  -- read the length
              xs <- replicateM n get     -- now the elems.
              return (listArray (0,n-1) xs)

putArray2 :: (Binary e, IArray a1 (a2 Int e), IArray a2 e) => a1 Int (a2 Int e) -> Put
putArray2 a = do put (rangeSize $ bounds a) -- write the length
                 mapM_ putArray (elems a)        -- now the elems.

getArray2 :: (Binary e, IArray a1 (a2 Int e), IArray a2 e) => Get (a1 Int (a2 Int e))
getArray2 = do n  <- get                       -- read the length
               xs <- replicateM n getArray     -- now the elems.
               return (listArray (0,n-1) xs)

decodingError = fail "This file was compiled with different version of GF"
