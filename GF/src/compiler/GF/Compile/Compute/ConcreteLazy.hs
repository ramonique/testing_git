----------------------------------------------------------------------
-- |
-- Module      : GF.Compile.Concrete.Compute
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/11/01 15:39:12 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.19 $
--
-- Computation of source terms. Used in compilation and in @cc@ command.
-----------------------------------------------------------------------------

module GF.Compile.Compute.ConcreteLazy ({-computeConcrete, computeTerm,checkPredefError-}) where
{-
import GF.Grammar.Grammar
import GF.Data.Operations
import GF.Infra.Ident
--import GF.Infra.Option
import GF.Data.Str
--import GF.Grammar.ShowTerm
import GF.Grammar.Printer
import GF.Grammar.Predef
import GF.Grammar.Macros
import GF.Grammar.Lookup
--import GF.Compile.Refresh
import GF.Grammar.PatternMatch
import GF.Grammar.Lockfield (isLockLabel,unlockRecord) ----

import GF.Compile.Compute.AppPredefined

import Data.List (nub) --intersperse
--import Control.Monad (liftM2, liftM)
import Control.Monad.Identity
import Text.PrettyPrint

----import Debug.Trace

--type Comp a = Err a -- makes computations (hyper)strict
--errr = id

type Comp a = Identity a -- inherit Haskell's laziness
errr = err runtime_error return -- convert interpreter error to run-time error
no_error = err fail return -- failure caused by interpreter/type checker bug (?)
runtime_error = return . Error -- run-time error term

-- | computation of concrete syntax terms into normal form
-- used mainly for partial evaluation
computeConcrete :: SourceGrammar -> Term -> Err Term
computeConcrete    g t = {- refreshTerm t >>= -} computeTerm g [] t

computeTerm :: SourceGrammar -> Substitution -> Term -> Err Term
computeTerm gr g = return . runIdentity . computeTermOpt gr g

computeTermOpt :: SourceGrammar -> Substitution -> Term -> Comp Term
computeTermOpt gr = comput True where

   -- full = True means full evaluation under Abs
   comput full g t = ---- errIn ("subterm" +++ prt t) $ --- for debugging 
    --trace ("comput "++show (map fst g)++" "++take 65 (show t)) $
    case t of

     Q (p,c) | p == cPredef -> return t    -- qualified constant
             | otherwise    -> look (p,c) 

     Vr x -> do  -- local variable
       t' <- maybe (fail (render (text "no value given to variable" <+> ppIdent x))) 
             return $ lookup x g
       case t' of 
         _ | t == t' -> return t
         _ -> comp g t' --- why compute again? AR 25/8/2011

     -- Abs x@(IA _) b -> do 
     Abs _ _ _ | full -> do   -- \xs -> b
       let (xs,b1) = termFormCnc t   
       b' <- comp ([(x,Vr x) | (_,x) <- xs] ++ g) b1
       return $ mkAbs xs b'
     --  b' <- comp (ext x (Vr x) g) b
     --  return $ Abs x b'
     Abs _ _ _ -> return t -- hnf

     Let (x,(ty,a)) b -> do  -- let x : ty = a in b
       a' <- comp g a
       comp (ext x a' g) b

{- -- trying to prevent Let expansion with non-evaluated exps. AR 19/8/2011
     Let (x,(ty,a)) b -> do
       a' <- comp g a
       let ea' = checkNoArgVars a'
       case ea' of
         Ok v -> comp (ext x v g) b
         _ -> return $ Let (x,(ty,a')) b
-}

     Prod b x a t -> do  -- (x : a) -> t ; b for hiding
       a' <- comp g a
       t' <- comp (ext x (Vr x) g) t
       return $ Prod b x a' t'

     -- beta-convert: simultaneous for as many arguments as possible
     App f a -> case appForm t of   -- (f a) --> (h as)
      (h,as) | length as > 1 -> do
        h' <- hnf g h
        as' <- mapM (comp g) as
        case h' of
          Error{} -> return h'
          _ | not (null [() | FV _ <- as']) -> compApp g (mkApp h' as')
          c@(QC _) -> do
            return $ mkApp c as'
          Q (mod,f) | mod == cPredef ->
            case appPredefined (mkApp h' as') of
              Ok (t',b) -> if b then return t' else comp g t'
              Bad s -> runtime_error s

          Abs _ _ _ -> do
            let (xs,b) = termFormCnc h'
            let g' = (zip (map snd xs) as') ++ g
            let as2 = drop (length xs) as'
            let xs2 = drop (length as') xs
            b' <- comp g' (mkAbs xs2 b)
            if null as2 then return b' else comp g (mkApp b' as2)

          _ -> compApp g (mkApp h' as')
      _ -> compApp g t

     P t l | isLockLabel l -> return $ R []  -- t.lock_C
     ---- a workaround 18/2/2005: take this away and find the reason
     ---- why earlier compilation destroys the lock field


     P t l  -> do     -- t.l
       t' <- comp g t
       case t' of
         Error{} -> return t'
         FV rs -> mapM (\c -> comp g (P c l)) rs >>= returnC . variants -- (r| r').l
         R r   -> project l r --{...}.l

         ExtR a (R b) ->    -- (a ** {...}).l             
           maybe (comp g (P a l)) (comp g) (try_project l b)

--- { - --- this is incorrect, since b can contain the proper value
         ExtR (R a) b ->                 -- NOT POSSIBLE both a and b records!
           maybe (comp g (P b l)) (comp g) (try_project l a)
--- - } ---

         S (T i cs) e -> prawitz  g i (flip P l) cs e  -- ((table i branches) ! e).l
         S (V i cs) e -> prawitzV g i (flip P l) cs e  -- ((table i values) ! e).l

         _   -> returnC $ P t' l

     S t v -> do         -- t ! v
       t' <- compTable g t
       v' <- comp g v
       t1 <- case t' of
----           V (RecType fs) _         -> uncurrySelect g fs t' v'
----           T (TComp (RecType fs)) _ -> uncurrySelect g fs t' v'
           _ -> return $ S t' v'
       compSelect g t1

     -- normalize away empty tokens
     K "" -> return Empty  -- []

     -- glue if you can
     Glue x0 y0 -> do  -- x0 + y0
       x <- comp g x0
       y <- comp g y0
       case (x,y) of
         (Error{},_)       -> return x
         (_,Error{})       -> return y
         (FV ks,_)         -> do                               -- (k|k') + y
           kys <- mapM (comp g . flip Glue y) ks
           return $ variants kys
         (_,FV ks)         -> do                               -- x + (k|k')
           xks <- mapM (comp g . Glue x) ks
           return $ variants xks

         (S (T i cs) e, s) -> prawitz g i (flip Glue s) cs e   -- (table cs ! e) + s
         (s, S (T i cs) e) -> prawitz g i (Glue s) cs e        -- s + (table cs ! e)
         (S (V i cs) e, s) -> prawitzV g i (flip Glue s) cs e  -- same with values
         (s, S (V i cs) e) -> prawitzV g i (Glue s) cs e
         (_,Empty)         -> return x                         -- x + []
         (Empty,_)         -> return y
         (K a, K b)        -> return $ K (a ++ b)              -- "foo" + "bar"
         (_, Alts d vs)    -> do                               -- x + pre {...}
----         (K a, Alts (d,vs)) -> do
            let glx = Glue x
            comp g $ Alts (glx d) [(glx v,c) | (v,c) <- vs]
         (Alts _ _, ka) -> errr $ checks [do                          -- pre {...} + ka
            y' <- strsFromTerm ka
----         (Alts _, K a) -> checks [do
            x' <- strsFromTerm x -- this may fail when compiling opers
            return $ variants [
              foldr1 C (map K (str2strings (glueStr v u))) | v <- x', u <- y']
----              foldr1 C (map K (str2strings (glueStr v (str a)))) | v <- x']
           ,return $ Glue x y
           ]
         (C u v,_) -> comp g $ C u (Glue v y)    -- (u ++ v) + y
         (_,C u v) -> comp g $ C (Glue x u) v    -- x ++ (u ++ v)

         _ -> do
           mapM_ checkNoArgVars [x,y]
           r <- composOp (comp g) t
           returnC r

     Alts d aa -> do   -- pre {...}
       d' <- comp g d
       aa' <- mapM (compInAlts g) aa
       returnC (Alts d' aa')

     -- remove empty
     C a b    -> do    -- a ++ b
       a0 <- comp g a
       b0 <- comp g b
       let (a',b') = strForm (C a0 b0)
       case (a',b') of
         (Error{},_) -> return a'
         (_,Error{}) -> return b'

         (Alts _ _, K d) -> errr $ checks [do                      -- pre {...} ++ "d"
            as <- strsFromTerm a' -- this may fail when compiling opers
            return $ variants [
              foldr1 C (map K (str2strings (plusStr v (str d)))) | v <- as]
            ,
            return $ C a' b'
           ]
         (Alts _ _, C (K d) e) -> errr $ checks [do                -- pre {...} ++ ("d" ++ e)
            as <- strsFromTerm a' -- this may fail when compiling opers
            return $ C (variants [
              foldr1 C (map K (str2strings (plusStr v (str d)))) | v <- as]) e
            ,
            return $ C a' b'
           ]

         (Empty,_) -> returnC b'        -- [] ++ b'
         (_,Empty) -> returnC a'        -- a' ++ []
         _     -> returnC $ C a' b'

     -- reduce free variation as much as you can
     FV ts -> mapM (comp g) ts >>= returnC . variants   -- variants {...}

     -- merge record extensions if you can
     ExtR r s -> do                                     -- r ** s
       r' <- comp g r
       s' <- comp g s
       case (r',s') of
         (Error{},_) -> return r'
         (_,Error{}) -> return s'
         (R rs, R ss) -> errr $ plusRecord r' s'
         (RecType rs, RecType ss) -> errr $ plusRecType r' s'
         _ -> return $ ExtR r' s'

     ELin c r -> do                                     -- lin c r
       r' <- comp g r
       unlockRecord c r'

     T _ _ -> compTable g t         -- table { ... p => t ... }
     V _ _ -> compTable g t         -- table [ ... v ... ]

     -- otherwise go ahead
     _ -> composOp (comp g) t >>= returnC

    where
     --{...}.l
     project l = maybe (fail_project l) (comp g) . try_project l
     try_project l = fmap snd . lookup l
     fail_project l = fail (render (text "no value for label" <+> ppLabel l))

     compApp g (App f a) = do    -- (f a)
       f' <- hnf g f
       a' <- comp g a
       case (f',a') of
         (Error{},_) -> return f'
         (Abs _ x b, FV as) ->   -- (\x -> b) (variants {...})
           liftM variants $ mapM (\c -> comp (ext x c g) b) as
         (_, FV as)  -> liftM variants $ mapM (\c -> comp g (App f' c)) as
         (FV fs, _)  -> liftM variants $ mapM (\c -> comp g (App c a')) fs
         (Abs _ x b,_) -> comp (ext x a' g) b  -- (\x -> b) a -- normal beta conv.

         (QC _,_)  -> returnC $ App f' a'  -- (C a') -- constructor application

         (S (T i cs) e,_) -> prawitz g i (flip App a') cs e  -- (table cs ! e) a'
         (S (V i cs) e,_) -> prawitzV g i (flip App a') cs e

	 _ -> case appPredefined (App f' a') of
                Ok (t',b) -> if b then return t' else comp g t'
                Bad s -> runtime_error s

     hnf, comp :: Substitution -> Term -> Comp Term
     hnf  = comput False
     comp = comput True

     look c = errr (lookupResDef gr c)
     {- -- This seems to loop in the greek example:
     look c = --trace ("look "++show c) $
              optcomp =<< errr (lookupResDef gr c)
       where
         optcomp t = if t==Q c
                     then --trace "looking up undefined oper" $
                          return t
                     else comp [] t -- g or []?
     -}          

     ext x a g = (x,a):g  -- extend environment with new variable and its value

     returnC = return --- . computed

     variants ts = case nub ts of
       [t] -> t
       ts  -> FV ts

     isCan v = case v of    -- is canonical (and should be matched by a pattern)
       Con _    -> True
       QC _     -> True
       App f a  -> isCan f && isCan a
       R rs     -> all (isCan . snd . snd) rs
       _        -> False

     compPatternMacro p = case p of
       PM c -> case look c of
         Identity (EPatt p') -> compPatternMacro p'
      -- _ -> fail (render (text "pattern expected as value of" $$ nest 2 (ppPatt Unqualified 0 p)))
       PAs x p -> do
         p' <- compPatternMacro p
         return $ PAs x p'
       PAlt p q -> do
         p' <- compPatternMacro p
         q' <- compPatternMacro q
         return $ PAlt p' q'
       PSeq p q -> do
         p' <- compPatternMacro p
         q' <- compPatternMacro q
         return $ PSeq p' q'
       PRep p -> do
         p' <- compPatternMacro p
         return $ PRep p'
       PNeg p -> do
         p' <- compPatternMacro p
         return $ PNeg p'
       PR rs -> do
         rs' <- mapPairsM compPatternMacro rs
         return $ PR rs'

       _ -> return p

     compSelect g (S t' v') = case v' of  -- t' ! v'
       FV vs -> mapM (\c -> comp g (S t' c)) vs >>= returnC . variants    

----       S (T i cs) e -> prawitz g i (S t') cs e  -- AR 8/7/2010 sometimes better
----       S (V i cs) e -> prawitzV g i (S t') cs e -- sometimes much worse 

    
       _ -> case t' of
         Error{} -> return t'
         FV ccs -> mapM (\c -> comp g (S c v')) ccs >>= returnC . variants

         T _ [(PW,c)] -> comp g c           -- (\\_ => c) ! v'
         T _ [(PT _ PW,c)] -> comp g c      -- (\\(_ : typ) => c) ! v'

         T _ [(PV z,c)] -> comp (ext z v' g) c        -- (\\z => c) ! v'
         T _ [(PT _ (PV z),c)] -> comp (ext z v' g) c

         -- course-of-values table: look up by index, no pattern matching needed

         V ptyp ts -> do                      -- (table [...ts...]) ! v'
             vs <- no_error $ allParamValues gr ptyp
             case lookupR v' (zip vs [0 .. length vs - 1]) of
               Just i -> comp g $ ts !! i
               _ -> return $ S t' v' -- if v' is not canonical
         T _ cc -> do                         -- (table {...cc...}) ! v'
           case matchPattern cc v' of
             Ok (c,g') -> comp (g' ++ g) c
             _ | isCan v' -> fail (render (text "missing case" <+> ppTerm Unqualified 0 v' <+> text "in" <+> ppTerm Unqualified 0 t))
             _ -> return $ S t' v' -- if v' is not canonical

         S (T i cs) e -> prawitz g i (flip S v') cs e  -- (table {...cs...} ! e) ! v'
         S (V i cs) e -> prawitzV g i (flip S v') cs e
         _    -> returnC $ S t' v'

     --- needed to match records with and without type information
     ---- todo: eliminate linear search in a list of records!
     lookupR v vs = case v of
       R rs -> lookup ([(x,y) | (x,(_,y)) <- rs]) 
                                [([(x,y) | (x,(_,y)) <- rs],v) | (R rs,v) <- vs]
       _ -> lookup v vs

     -- case-expand tables: branches for every value of argument type
     -- if already expanded, don't expand again
     compTable g t = case t of
         T i@(TComp ty) cs -> do
           -- if there are no variables, don't even go inside
           cs' <- if (null g) then return cs else mapPairsM (comp g) cs
----           return $ V ty (map snd cs')
           return $ T i cs'
         V ty cs -> do
           ty' <- comp g ty
           -- if there are no variables, don't even go inside
           cs' <- if (null g) then return cs else mapM (comp g) cs
           return $ V ty' cs'

         T i cs -> do
           pty0 <- errr $ getTableType i
           ptyp <- comp g pty0
           case allParamValues gr ptyp of
             Ok vs0 -> do
               let vs = vs0 ---- [Val v ptyp i | (v,i) <- zip vs0 [0..]]
               ps0  <- mapM (compPatternMacro . fst) cs
               cs'  <- mapM (compBranchOpt g) (zip ps0 (map snd cs))
               sts  <- no_error $ mapM (matchPattern cs') vs 
               ts   <- mapM (\ (c,g') -> comp (g' ++ g) c) sts
               ps   <- no_error $ mapM term2patt vs
               let ps' = ps --- PT ptyp (head ps) : tail ps
----               return $ V ptyp ts -- to save space, just course of values
               return $ T (TComp ptyp) (zip ps' ts)
             _ -> do
               ps0  <- mapM (compPatternMacro . fst) cs

               cs'  <- mapM (compBranch g) (zip ps0 (map snd cs))
-----               cs'  <- return (zip ps0 (map snd cs)) --- probably right AR 22/8/2011 but can leave uninstantiated variables :-(

----               cs' <- mapM (compBranch g) cs
               return $ T i cs'  -- happens with variable types
         _ -> comp g t

     compBranch g (p,v) = do  -- compute a branch in a table
       let g' = contP p ++ g  -- add the pattern's variables to environment
       v' <- comp g' v
       return (p,v')

     compBranchOpt g c@(p,v) = case contP p of
       [] -> return c
       _ -> {-err (const (return c)) return $-} compBranch g c

     -- collect the context of variables of a pattern
     contP p = case p of
       PV x -> [(x,Vr x)]
       PC _ ps -> concatMap contP ps
       PP _ ps -> concatMap contP ps
       PT _ p -> contP p
       PR rs -> concatMap (contP . snd) rs

       PAs x p -> (x,Vr x) : contP p

       PSeq p q -> concatMap contP [p,q]
       PAlt p q -> concatMap contP [p,q]
       PRep p   -> contP p
       PNeg p   -> contP p

       _ -> []

     prawitz g i f cs e = do
       cs' <- mapM (compBranch g) [(p, f v) | (p,v) <- cs]
       return $ S (T i cs') e
     prawitzV g i f cs e = do
       cs' <- mapM (comp g) [(f v) | v <- cs]
       return $ S (V i cs') e

     compInAlts g (v,c) = do
       v' <- comp g v
       c' <- comp g c
       c2 <- case c' of
         EPatt p -> liftM Strs $ getPatts p
         _ -> return c'
       return (v',c2)
      where
       getPatts p = case p of
         PAlt a b  -> liftM2 (++) (getPatts a) (getPatts b)
         PString s -> return [K s]
         PSeq a b  -> do
           as <- getPatts a
           bs <- getPatts b
           return [K (s ++ t) | K s <- as, K t <- bs]
         _ -> fail (render (text "not valid pattern in pre expression" <+> ppPatt Unqualified 0 p))

     strForm s = case s of
       C (C a b) c -> let (a1,a2) = strForm a in (a1, ccStr a2 (ccStr b c))
       C a b -> (a,b)
       _ -> (s,Empty)

     ccStr a b = case (a,b) of
       (Empty,_) -> b
       (_,Empty) -> a
       _ -> C a b

{- ----
     uncurrySelect g fs t v = do
       ts <- mapM (allParamValues gr . snd) fs
       vs <- mapM (comp g) [P v r | r <- map fst fs]
       return $ reorderSelect t fs ts vs

     reorderSelect t fs pss vs = case (t,fs,pss,vs) of
       (V _ ts, f:fs1, ps:pss1, v:vs1) -> 
         S (V (snd f) 
             [reorderSelect (V (RecType fs1) t) fs1 pss1 vs1 | 
               t <- segments (length ts `div` length ps) ts]) v 
       (T (TComp _) cs, f:fs1, ps:pss1, v:vs1) -> 
         S (T (TComp (snd f)) 
             [(p,reorderSelect (T (TComp (RecType fs1)) c) fs1 pss1 vs1) | 
               (ep,c) <- zip ps (segments (length cs `div` length ps) cs),
               let Ok p = term2patt ep]) v 
       _ -> t

     segments i xs = 
       let (x0,xs1) = splitAt i xs in x0 : takeWhile (not . null) (segments i xs1)
-}


-- | argument variables cannot be glued
checkNoArgVars :: Term -> Comp Term
checkNoArgVars t = case t of
  Vr x | isArgIdent x -> fail $ glueErrorMsg $ ppTerm Unqualified 0 t
  _ -> composOp checkNoArgVars t

glueErrorMsg s = 
  render (text "Cannot glue (+) term with run-time variable" <+> s <> char '.' $$
          text "Use Prelude.bind instead.")

getArgType t = case t of
  V ty _ -> return ty
  T (TComp ty) _ -> return ty
  _ -> fail (render (text "cannot get argument type of table" $$ nest 2 (ppTerm Unqualified 0 t)))
  
{-
-- Old
checkPredefError sgr t = case t of
  App (Q (mod,f)) s | mod == cPredef && f == cError -> fail $ showTerm sgr TermPrintOne Unqualified s
  _ -> composOp (checkPredefError sgr) t
  
predef_error s = App (Q (cPredef,cError)) (K s)
-}
-}
