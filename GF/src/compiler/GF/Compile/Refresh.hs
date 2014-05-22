----------------------------------------------------------------------
-- |
-- Module      : Refresh
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:22:27 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.6 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module GF.Compile.Refresh ({-refreshTermN, refreshTerm,
		refreshModule-}
	       ) where
{-
import GF.Data.Operations
import GF.Grammar.Grammar
import GF.Infra.Ident
import GF.Grammar.Macros
import Control.Monad

refreshTerm :: Term -> Err Term
refreshTerm = refreshTermN 0

refreshTermN :: Int -> Term -> Err Term
refreshTermN i e = liftM snd $ refreshTermKN i e

refreshTermKN :: Int -> Term -> Err (Int,Term)
refreshTermKN i e = liftM (\ (t,(_,i)) -> (i,t)) $ 
                    appSTM (refresh e) (initIdStateN i)

refresh :: Term -> STM IdState Term
refresh e = case e of

  Vr x    -> liftM  Vr  (lookVar x)
  Abs b x t -> liftM2 (Abs b) (refVarPlus x)  (refresh t)

  Prod b x a t -> do
    a'  <- refresh a
    x'  <- refVar  x
    t'  <- refresh t
    return $ Prod b x' a' t'

  Let (x,(mt,a)) b -> do
    a'  <- refresh a
    mt' <- case mt of
             Just t -> refresh t >>= (return . Just) 
             _ -> return mt
    x'  <- refVar x
    b'  <- refresh b
    return (Let (x',(mt',a')) b')

  R r  -> liftM R $ refreshRecord r

  ExtR r s -> liftM2 ExtR (refresh r)  (refresh s)
  
  T i cc -> liftM2 T (refreshTInfo i) (mapM refreshCase cc)

  App f a -> liftM2 App (inBlockSTM (refresh f)) (refresh a)

  _ -> composOp refresh e

refreshCase :: (Patt,Term) -> STM IdState (Patt,Term)
refreshCase (p,t) = liftM2 (,) (refreshPatt p) (refresh t)

refreshPatt p = case p of
  PV x    -> liftM PV     (refVar x)
  PC c ps -> liftM (PC c) (mapM refreshPatt ps)
  PP c ps -> liftM (PP c) (mapM refreshPatt ps)
  PR r    -> liftM PR     (mapPairsM refreshPatt r)
  PT t p' -> liftM2 PT    (refresh t) (refreshPatt p')

  PAs x p'   -> liftM2 PAs     (refVar x) (refreshPatt p')

  PSeq p' q' -> liftM2 PSeq    (refreshPatt p') (refreshPatt q')
  PAlt p' q' -> liftM2 PAlt    (refreshPatt p') (refreshPatt q')
  PRep p'    -> liftM  PRep    (refreshPatt p')
  PNeg p'    -> liftM  PNeg    (refreshPatt p')

  _ -> return p

refreshRecord r = case r of
  [] -> return r
  (x,(mt,a)):b -> do
    a'  <- refresh a
    mt' <- case mt of
             Just t -> refresh t >>= (return . Just) 
             _ -> return mt
    b'  <- refreshRecord b
    return $ (x,(mt',a')) : b'

refreshTInfo i = case i of
  TTyped t -> liftM TTyped $ refresh t
  TComp t -> liftM TComp $ refresh t
  TWild t -> liftM TWild $ refresh t
  _ -> return i

-- for abstract syntax

refreshEquation :: Equation -> Err ([Patt],Term)
refreshEquation pst = err Bad (return . fst) (appSTM (refr pst) initIdState) where
  refr (ps,t) = liftM2 (,) (mapM refreshPatt ps) (refresh t)

-- for concrete and resource in grammar, before optimizing

--refreshGrammar :: SourceGrammar -> Err SourceGrammar
--refreshGrammar = liftM (mGrammar . snd) . foldM refreshModule (0,[]) . modules

refreshModule :: (Int,SourceGrammar) -> SourceModule -> Err (Int,[SourceModule])
refreshModule (k,sgr) mi@(i,mo)
  | isModCnc mo || isModRes mo = do
      (k',js') <- foldM refreshRes (k,[]) $ tree2list $ jments mo
      return (k', (i,mo{jments=buildTree js'}) : modules sgr)
  | otherwise = return (k, mi:modules sgr)
 where
  refreshRes (k,cs) ci@(c,info) = case info of
    ResOper ptyp (Just (L loc trm)) -> do   ---- refresh ptyp
      (k',trm') <- refreshTermKN k trm
      return $ (k', (c, ResOper ptyp (Just (L loc trm'))):cs)
    ResOverload os tyts -> do
      (k',tyts') <- liftM (\ (t,(_,i)) -> (i,t)) $ 
                    appSTM (mapPairsM (\(L loc t) -> liftM (L loc) (refresh t)) tyts) (initIdStateN k)
      return $ (k', (c, ResOverload os tyts'):cs)
    CncCat mt md mr mn mpmcfg-> do
      (k,md) <- case md of
                  Just (L loc trm) -> do (k,trm) <- refreshTermKN k trm
                                         return (k,Just (L loc trm))
                  Nothing          -> return (k,Nothing)
      (k,mr) <- case mr of
                  Just (L loc trm) -> do (k,trm) <- refreshTermKN k trm
                                         return (k,Just (L loc trm))
                  Nothing          -> return (k,Nothing)
      return (k, (c, CncCat mt md mr mn mpmcfg):cs)
    CncFun mt (Just (L loc trm)) mn mpmcfg -> do   ---- refresh pn
      (k',trm') <- refreshTermKN k trm
      return $ (k', (c, CncFun mt (Just (L loc trm')) mn mpmcfg):cs)
    _ -> return (k, ci:cs)


-- running monad and returning to initial state

inBlockSTM :: STM s a -> STM s a
inBlockSTM mo = do
  s <- readSTM
  v <- mo
  writeSTM s
  return v


-}