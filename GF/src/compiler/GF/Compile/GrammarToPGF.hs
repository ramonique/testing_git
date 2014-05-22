{-# LANGUAGE BangPatterns #-}
module GF.Compile.GrammarToPGF (mkCanon2pgf) where

--import GF.Compile.Export
import GF.Compile.GeneratePMCFG
import GF.Compile.GenerateBC

import PGF(CId,mkCId,utf8CId,showCId)
import PGF.Data(fidInt,fidFloat,fidString,fidVar)
import PGF.Optimize(updateProductionIndices)
--import qualified PGF.Macros as CM
import qualified PGF.Data as C
import qualified PGF.Data as D
import GF.Grammar.Predef
--import GF.Grammar.Printer
import GF.Grammar.Grammar
import qualified GF.Grammar.Lookup as Look
import qualified GF.Grammar as A
import qualified GF.Grammar.Macros as GM
import qualified PGF.Macros as CM
--import GF.Compile.GeneratePMCFG

import GF.Infra.Ident
import GF.Infra.Option
import GF.Infra.UseIO (IOE)
import GF.Data.Operations
import Data.Maybe 
import Data.List
--import Data.Char (isDigit,isSpace)
import qualified Data.Set as Set
import qualified Data.Map as Map
import qualified Data.IntMap as IntMap
import Data.Array.IArray
import Control.Monad
import Control.Monad.Trans(MonadIO(..))
--import Text.PrettyPrint
--import Control.Monad.Identity

genDebugGrammar ::  D.PGF -> IOE ()
genDebugGrammar old_pgf = 
   
  if length (cs old_pgf) /= 1 then liftIO $ putStrLn $ "there should be just one concrete syntax for debugging the pgf"
     else  
  do
     let (new_abs,new_conc) = (D.abstract old_pgf, head $ Map.elems $ D.concretes old_pgf) --updateConc (D.abstract old_pgf) (head $ Map.elems $ D.concretes old_pgf)
     --putStrLn $ "\n\n\n" ++ show new_abs
     let cname = head $ Map.keys $ D.concretes old_pgf 
     let pgf = old_pgf {D.abstract=new_abs, D.concretes = Map.singleton cname new_conc}
 
     liftIO $ writeFile (abs_gf pgf) $ putAbsGrammar (abs_name pgf) (stcat pgf) (categs pgf) (absfunctions pgf)
     liftIO $ putStrLn $ "\n\nwrote file "++ abs_gf pgf 

     liftIO $ writeFile (conc_gf pgf) $ putConcGrammar (conc_name pgf) (abs_name pgf) (conccategs pgf) (concfunctions pgf)
     liftIO $ putStrLn $ "\nwrote file " ++ conc_gf pgf
     liftIO $ writeFile "RCats.txt" $ catmaps pgf
     liftIO $ putStrLn "\nwrote file RCats.txt"
  where 
   
    catmaps pgf = 
         let c = conc pgf
             cs = Map.toList $ D.cnccats c  
             rs = [("\""++showCId cid++"\"", "("++show bi ++ "," ++ show en ++")") | (cid, D.CncCat bi en _) <- cs]     
         in 
            unlines (map (\(x,y) -> "("++y++","++x++")") rs) 

    conc pgf = head $ Map.elems $ D.concretes pgf     
 
    categs pgf = (filter (/="Int") $ map catName $ Set.toList $ Set.fromList $ concat $ map (\(x,y) -> x : (concat $ map takeFids $ Set.toList y)) $ IntMap.toList $ D.productions $ conc pgf) 
           where takeFids (D.PApply i ags) = [p | D.PArg _ p <- ags]
                 takeFids (D.PCoerce i) = [i]

    conccategs pgf = unwords $ (intersperse "," $ categs pgf) ++ ["=","{","indep",":","Str",";","attr",":","Str","}",";"]

    absfunctions pgf = getFunctions pgf mkFunc ----
     
    concfunctions pgf = getFunctions pgf mkConc

    stcat pgf = 
       let stname = CM.lookStartCat pgf 
           Just (D.CncCat i _ _) = Map.lookup stname (D.cnccats $ head $ Map.elems $ D.concretes pgf)
              in 
               "C"++show i

    getFunctions pgf mkfunc = concat $ map (\(x,y) -> map (mkSig (conc pgf) mkfunc) $ zip (repeat x) (Set.toList y)) $ IntMap.toList $ D.productions (conc pgf)


    abs_gf pgf = abs_name pgf ++ ".gf"    
    conc_gf pgf = conc_name pgf ++ ".gf"

    abs_name pgf = new_name pgf ++ "Comp"
    conc_name pgf = new_name pgf ++ "CompConc"
   
    new_name pgf = showCId $ fst $ head (cs pgf) 

    cs pgf = Map.toList (D.concretes pgf)

    showArg1 ss  i    = if i >= 0 then show i else error $ "We don't handle grammars with literal arguments yet..." ++ ss
  
    isTheFunc = Data.List.isPrefixOf "the_" 

    -- (concat $ intersperse "_" [showArg p | D.PArg _ p <- ags])++
    mkSig conc mkfunc (x,D.PApply i ags) =  
        let ss = lookupName i conc 
          
           in if isTheFunc ss then mkfunc True (ss ++"_"++show i++ "_"++show x) ss ([ p | D.PArg _ p <- ags] ++ [x])
               else mkfunc True (ss ++"_"++show i++ "_"++show x++"_"++(concat $ intersperse "_" [showArg1 ss p | D.PArg _ p <- ags])) ss ([ p | D.PArg _ p <- ags] ++ [x])
    mkSig conc mkfunc (x,D.PCoerce i) = 
        let ss = "_"++show i ++ "_"++show x
           in mkfunc False ss ss [i,x] 
    mkSig conc _ (x,D.PConst _ _ _ ) = error "PConst not implemented yet for compilation"
  

    lookupName i conc = 
         let (D.CncFun ss _) = (D.cncfuns conc) ! i  
             in 
               showCId ss               


    mkFunc :: Bool -> String -> String -> [Int] -> String
    mkFunc _ strN _ lst =
          unwords $ ["fun", strN, ":"] ++ (intersperse "->" $ map catName lst) ++ [";"]

     
    mkConc :: Bool -> String -> String -> [Int] -> String
    mkConc False strN str [_,_] = unwords ["lin",str,"n","=","n",";"]
    mkConc True strN str tl = if length tl == 1 then constantFunc strN
       else
          if isTheFunc strN then unwords $ ["lin",strN,"i","=","{","indep","=","\""++str++"\"","++","i.s",";","attr","=","\"(\"","++","\""++str++"\"","++","i.s","++","\")\"","}",";"] 
           else
         let 
             l = length tl - 1 
             args = ["p"++show i | i <- [1..l]]            
             depArgs = qstr ++ map (\x -> "++" ++ x ++ ".attr") args
          in
         unwords $ ["lin",strN] ++ args ++ ["=","{",
                                           "indep","="] ++ depArgs ++
                                          [";","attr","=","\"(\"","++"] ++ depArgs ++ ["++","\")\"","}",";"]
      
      where 
        constantFunc str = unwords $ ["lin",str,"=","{","indep","="] ++ qstr ++ [";","attr","="] ++ qstr ++ ["}",";"] 
        qstr = ["\""++str++"\""]




    catName (-1) = "Int"
    catName (-2) = "Int" 
    catName (-3) = "Int"
    catName x    = "C"++show x

    putAbsGrammar nm stcat cts fns = 
          unwords ["abstract",nm,"="] ++ "\n" ++ 
             "{" ++ "\n\n" ++
              "flags startcat = "++ stcat ++ ";" ++ "\n\n" ++ 
               "cat " ++ unwords (map (\x -> x ++ ";") cts) ++ "\n\n" ++
                unlines fns ++ "\n\n" ++
              "}"
    
    putConcGrammar nmc nma ccts fns = 
           unwords ["concrete",nmc,"of",nma,"="] ++ "\n" ++
              "{"++"\n\n" ++ 
               "lincat " ++ ccts ++ "\n\n" ++
                unlines fns ++"\n\n"++
               "}"

mkCanon2pgf :: Options -> SourceGrammar -> Ident -> IOE D.PGF
mkCanon2pgf opts gr am = do
  (an,abs) <- mkAbstr am
  cncs     <- mapM mkConcr (allConcretes gr am)
  let fsts = map fst cncs
  let some_pgf = D.PGF Map.empty an abs (Map.fromList cncs)
  if flag optGenDebug opts then 
    if length cncs /= 1 then 
           do liftIO $ putStrLn "cannot debug a grammar that doesn't have only 1 concrete syntax"
              return $ updateProductionIndices some_pgf
     else 
       do (newabs, newcncs) <- updateConc abs  (head $ map snd cncs)
          let new_pgf = D.PGF Map.empty an newabs (Map.fromList [(fst $ head cncs ,newcncs)])
          if flag optGenGrammar opts then do liftIO $ putStrLn "We generate the reflection grammar"
                                             genDebugGrammar new_pgf
                 else liftIO $ putStrLn "no reflection grammar!" 
          liftIO $ putStrLn "Generate abstract categories now!!"
          return $ updateProductionIndices new_pgf     
      else
       do   
         if flag optGenGrammar opts then 
                                   do liftIO $ putStrLn "We generate the reflection grammar"
                                      genDebugGrammar some_pgf
             else liftIO $ putStr ""
         liftIO $ putStrLn "We don't generate any new category!"
         return $ updateProductionIndices some_pgf 
  where
    cenv = resourceValues gr

    mkAbstr am = return (i2i am, D.Abstr flags funs cats bcode)
      where
        aflags = err (const noOptions) mflags (lookupModule gr am)

        (adefs,bcode) =
          generateByteCode $
            [((cPredefAbs,c), AbsCat (Just (L NoLoc []))) | c <- [cFloat,cInt,cString]] ++ 
            Look.allOrigInfos gr am

        flags = Map.fromList [(mkCId f,x) | (f,x) <- optionsPGF aflags]

        funs = Map.fromList [(i2i f, (mkType [] ty, mkArrity ma, mkDef pty, 0, addr)) | 
                                   ((m,f),AbsFun (Just (L _ ty)) ma pty _,addr) <- adefs]
                                   
        cats = Map.fromList [(i2i c, (snd (mkContext [] cont),catfuns c, 0, addr)) |
                                   ((m,c),AbsCat (Just (L _ cont)),addr) <- adefs]

        catfuns cat =
              [(0,i2i f) | ((m,f),AbsFun (Just (L _ ty)) _ _ (Just True),_) <- adefs, snd (GM.valCat ty) == cat]

    mkConcr cm = do
      let cflags  = err (const noOptions) mflags (lookupModule gr cm)

      (ex_seqs,cdefs) <- addMissingPMCFGs
                            Map.empty 
                            ([((cPredefAbs,c), CncCat (Just (L NoLoc GM.defLinType)) Nothing Nothing Nothing Nothing) | c <- [cInt,cFloat,cString]] ++
                             Look.allOrigInfos gr cm)

      let flags = Map.fromList [(mkCId f,x) | (f,x) <- optionsPGF cflags]

          seqs = (mkSetArray . Set.fromList . concat) $
                     (Map.keys ex_seqs : [maybe [] elems (mseqs mi) | (m,mi) <- allExtends gr cm])

          ex_seqs_arr = mkMapArray ex_seqs :: Array SeqId Sequence

          !(!fid_cnt1,!cnccats) = genCncCats gr am cm cdefs
          !(!fid_cnt2,!productions,!lindefs,!linrefs,!cncfuns)
                                = genCncFuns gr am cm ex_seqs_arr seqs cdefs fid_cnt1 cnccats
        
          printnames = genPrintNames cdefs
      return (i2i cm, D.Concr flags 
                              printnames
                              cncfuns
                              lindefs
                              linrefs
                              seqs
                              productions
                              IntMap.empty
                              Map.empty
                              cnccats
                              IntMap.empty
                              fid_cnt2)
      where
        -- if some module was compiled with -no-pmcfg, then
        -- we have to create the PMCFG code just before linking
        addMissingPMCFGs seqs []                  = return (seqs,[])
        addMissingPMCFGs seqs (((m,id), info):is) = do
          (seqs,info) <- addPMCFG opts gr cenv Nothing am cm seqs id info
          (seqs,is  ) <- addMissingPMCFGs seqs is
          return (seqs, ((m,id), info) : is)

mkDummyName cid nn= "the_" ++ showCId cid ++ "_"++show nn

updateConc :: D.Abstr -> D.Concr -> IOE (D.Abstr,D.Concr) 
updateConc abs cn = 
 let   cs = Map.toList $ D.cnccats cn
       arrMap = Map.fromList $ map (\(ci,D.CncCat _ _ arr) -> (ci, map (\x -> concat $ intersperse "_" $ words x) $ elems arr))  cs     
       
       prs = D.productions cn
       newcncf = concat $ map (\(cid,x) -> zip (repeat cid) $ zip [1..] $ newFunc x prs) cs 
         
       tempCncf = map (\(cid, (nn,fid)) -> ((fid, mkDummyName cid nn),(cid, fromJust $ Map.lookup cid arrMap))) newcncf            
   in 
 do (newabs,newcn) <- iterate tempCncf cn abs
    --putStrLn $ show arrMap
    --putStrLn $ show newcncf
    return (newabs,newcn)

 where
   iterate [] cn abs = return (abs,cn) 
   iterate (((fid,name), (cid,len)):rest) cn abs = 
      do (abs',cn') <-  addFunc cn abs fid name cid len 
         iterate rest cn' abs' 

   newFunc (D.CncCat f1 f2 _) prs = if f1 >= 0 && f2 >= 0 then 
                                             filter (\x -> IntMap.member x prs) [f1..f2] 
                                            else []    

--addFunc :: old concrete -> fid of the category that we add -> name of the new function -> name of the category -> list of parameter names -> new concrete // maybe not so efficient ...
addFunc :: D.Concr -> D.Abstr -> FId -> String -> CId -> [String] -> IOE (D.Abstr, D.Concr)
addFunc cn abs fid name cid parnames = 
   let 
       -- add it to the sequences 
       sqs = elems $ D.sequences cn
       oldSeqL = length sqs
       newSeq =  sqs ++ [(mkArray [D.SymKS (name ++ "_" ++ k), D.SymLit 0 0] :: D.Sequence) | k <- parnames] 
       newSeqs' = mkArray newSeq :: Array SeqId D.Sequence

       -- add it to the cncfuns
       cncs = elems $ D.cncfuns cn 
       oldCncL = length cncs 
       newcncs = mkArray (cncs ++ [D.CncFun (mkCId $ name) (mkArray [oldSeqL + k | k <- [0..(length parnames - 1)]])]) :: Array FunId D.CncFun 

       -- add it to the productions 
       prods = D.productions cn
       newprods = IntMap.insertWith (Set.union) fid (Set.singleton $ D.PApply oldCncL [D.PArg [] (-2)]) prods

       -- put changes together in the concrete module
       newcn = cn {D.productions = newprods, D.cncfuns = newcncs, D.sequences = newSeqs'}
       
       -- add it to abstract syntax (funs) 
       fs = D.funs abs 
       newfs = Map.insert (mkCId $ name) (D.mkType [D.mkHypo (D.mkType [] (mkCId "Int") [])] cid [], 0, Just [], 0.0,0) fs

       -- add it to the abstract syntax (cats)            
       cs = D.cats abs
       newcs = Map.insertWith (\(hs,ffs,n,bc) (_,newls,_,_) -> (hs, ffs ++ newls,n,bc)) cid ([],[(0.0,mkCId $ name)],0,0) cs     
  
       -- put changes together in the abstract module
       newabs = abs {D.funs = newfs, D.cats = newcs}  

    in
    do  --putStrLn $ "\nnewSequences :: \n" ++ show newSeqs' 
        --putStrLn $ "\nnewConcrete funcs :: \n" ++ show newcncs
        --putStrLn $ "\nnewProductions :: \n" ++ show newprods 
        return (newabs,newcn)

i2i :: Ident -> CId
i2i = utf8CId . ident2utf8

mkType :: [Ident] -> A.Type -> C.Type
mkType scope t =
  case GM.typeForm t of
    (hyps,(_,cat),args) -> let (scope',hyps') = mkContext scope hyps
                           in C.DTyp hyps' (i2i cat) (map (mkExp scope') args)

mkExp :: [Ident] -> A.Term -> C.Expr
mkExp scope t = 
  case t of
    Q (_,c)  -> C.EFun (i2i c)
    QC (_,c) -> C.EFun (i2i c)
    Vr x     -> case lookup x (zip scope [0..]) of
                  Just i  -> C.EVar  i
                  Nothing -> C.EMeta 0
    Abs b x t-> C.EAbs b (i2i x) (mkExp (x:scope) t)
    App t1 t2-> C.EApp (mkExp scope t1) (mkExp scope t2)
    EInt i   -> C.ELit (C.LInt (fromIntegral i))
    EFloat f -> C.ELit (C.LFlt f)
    K s      -> C.ELit (C.LStr s)
    Meta i   -> C.EMeta i
    _        -> C.EMeta 0

mkPatt scope p = 
  case p of
    A.PP (_,c) ps->let (scope',ps') = mapAccumL mkPatt scope ps
                   in (scope',C.PApp (i2i c) ps')
    A.PV x      -> (x:scope,C.PVar (i2i x))
    A.PAs x p   -> let (scope',p') = mkPatt scope p
                   in (x:scope',C.PAs (i2i x) p')
    A.PW        -> (  scope,C.PWild)
    A.PInt i    -> (  scope,C.PLit (C.LInt (fromIntegral i)))
    A.PFloat f  -> (  scope,C.PLit (C.LFlt f))
    A.PString s -> (  scope,C.PLit (C.LStr s))
    A.PImplArg p-> let (scope',p') = mkPatt scope p
                   in (scope',C.PImplArg p')
    A.PTilde t  -> (  scope,C.PTilde (mkExp scope t))

mkContext :: [Ident] -> A.Context -> ([Ident],[C.Hypo])
mkContext scope hyps = mapAccumL (\scope (bt,x,ty) -> let ty' = mkType scope ty
                                                      in if x == identW
                                                           then (  scope,(bt,i2i x,ty'))
                                                           else (x:scope,(bt,i2i x,ty'))) scope hyps 

mkDef (Just eqs) = Just [C.Equ ps' (mkExp scope' e) | L _ (ps,e) <- eqs, let (scope',ps') = mapAccumL mkPatt [] ps]
mkDef Nothing    = Nothing

mkArrity (Just a) = a
mkArrity Nothing  = 0

data PattTree
  = Ret  C.Expr
  | Case (Map.Map QIdent [PattTree]) [PattTree]

compilePatt :: [Equation] -> [PattTree]
compilePatt (([],t):_) = [Ret (mkExp [] t)]
compilePatt eqs        = whilePP eqs Map.empty
  where
    whilePP []                         cns     = [mkCase cns []]
    whilePP (((PP c ps' : ps), t):eqs) cns     = whilePP eqs (Map.insertWith (++) c [(ps'++ps,t)] cns)
    whilePP eqs                        cns     = whilePV eqs cns []

    whilePV []                         cns vrs = [mkCase cns (reverse vrs)]
    whilePV (((PV x     : ps), t):eqs) cns vrs = whilePV eqs cns ((ps,t) : vrs)
    whilePV eqs                        cns vrs = mkCase cns (reverse vrs) : compilePatt eqs

    mkCase cns vrs = Case (fmap compilePatt cns) (compilePatt vrs)


genCncCats gr am cm cdefs =
  let (index,cats) = mkCncCats 0 cdefs
  in (index, Map.fromList cats)
  where
    mkCncCats index []                                                = (index,[])
    mkCncCats index (((m,id),CncCat (Just (L _ lincat)) _ _ _ _):cdefs) 
      | id == cInt    = 
            let cc            = pgfCncCat gr lincat fidInt
                (index',cats) = mkCncCats index cdefs
            in (index', (i2i id,cc) : cats)
      | id == cFloat  = 
            let cc            = pgfCncCat gr lincat fidFloat
                (index',cats) = mkCncCats index cdefs
            in (index', (i2i id,cc) : cats)
      | id == cString = 
            let cc            = pgfCncCat gr lincat fidString
                (index',cats) = mkCncCats index cdefs
            in (index', (i2i id,cc) : cats)
      | otherwise     =
            let cc@(C.CncCat s e _) = pgfCncCat gr lincat index
                (index',cats)       = mkCncCats (e+1) cdefs
            in (index', (i2i id,cc) : cats)
    mkCncCats index (_                      :cdefs) = mkCncCats index cdefs

genCncFuns :: SourceGrammar
           -> Ident
           -> Ident
           -> Array SeqId Sequence
           -> Array SeqId Sequence
           -> [(QIdent, Info)]
           -> FId
           -> Map.Map CId D.CncCat
           -> (FId,
               IntMap.IntMap (Set.Set D.Production),
               IntMap.IntMap [FunId],
               IntMap.IntMap [FunId],
               Array FunId D.CncFun)
genCncFuns gr am cm ex_seqs seqs cdefs fid_cnt cnccats =
  let (fid_cnt1,funs_cnt1,funs1,lindefs,linrefs) = mkCncCats cdefs fid_cnt  0 [] IntMap.empty IntMap.empty
      (fid_cnt2,funs_cnt2,funs2,prods)           = mkCncFuns cdefs fid_cnt1 funs_cnt1 funs1 lindefs Map.empty IntMap.empty
  in (fid_cnt2,prods,lindefs,linrefs,array (0,funs_cnt2-1) funs2)
  where
    mkCncCats []                                                        fid_cnt funs_cnt funs lindefs linrefs =
      (fid_cnt,funs_cnt,funs,lindefs,linrefs)
    mkCncCats (((m,id),CncCat _ _ _ _ (Just (PMCFG prods0 funs0))):cdefs) fid_cnt funs_cnt funs lindefs linrefs =
      let !funs_cnt' = let (s_funid, e_funid) = bounds funs0
                       in funs_cnt+(e_funid-s_funid+1)
          lindefs'   = foldl' (toLinDef (am,id) funs_cnt) lindefs prods0
          linrefs'   = foldl' (toLinRef (am,id) funs_cnt) linrefs prods0
          funs'      = foldl' (toCncFun funs_cnt (m,mkLinDefId id)) funs (assocs funs0)
      in mkCncCats cdefs fid_cnt funs_cnt' funs' lindefs' linrefs'
    mkCncCats (_                                                :cdefs) fid_cnt funs_cnt funs lindefs linrefs =
      mkCncCats cdefs fid_cnt funs_cnt funs lindefs linrefs

    mkCncFuns []                                                        fid_cnt funs_cnt funs lindefs crc prods =
      (fid_cnt,funs_cnt,funs,prods)
    mkCncFuns (((m,id),CncFun _ _ _ (Just (PMCFG prods0 funs0))):cdefs) fid_cnt funs_cnt funs lindefs crc prods =
      let ---Ok ty_C        = fmap GM.typeForm (Look.lookupFunType gr am id)
          ty_C           = err error (\x -> x) $ fmap GM.typeForm (Look.lookupFunType gr am id)
          !funs_cnt'     = let (s_funid, e_funid) = bounds funs0
                           in funs_cnt+(e_funid-s_funid+1)
          !(fid_cnt',crc',prods') 
                         = foldl' (toProd lindefs ty_C funs_cnt)
                                  (fid_cnt,crc,prods) prods0
          funs'          = foldl' (toCncFun funs_cnt (m,id)) funs (assocs funs0)
      in mkCncFuns cdefs fid_cnt' funs_cnt' funs' lindefs crc' prods'
    mkCncFuns (_                                                :cdefs) fid_cnt funs_cnt funs lindefs crc prods = 
      mkCncFuns cdefs fid_cnt funs_cnt funs lindefs crc prods

    toProd lindefs (ctxt_C,res_C,_) offs st (Production fid0 funid0 args0) =
      let !((fid_cnt,crc,prods),args) = mapAccumL mkArg st (zip ctxt_C args0) 
          set0    = Set.fromList (map (C.PApply (offs+funid0)) (sequence args))
          fid     = mkFId res_C fid0
          !prods' = case IntMap.lookup fid prods of
                     Just set -> IntMap.insert fid (Set.union set0 set) prods
                     Nothing  -> IntMap.insert fid set0 prods
      in (fid_cnt,crc,prods')
      where
        mkArg st@(fid_cnt,crc,prods) ((_,_,ty),fid0s ) =
          case fid0s of
            [fid0] -> (st,map (flip C.PArg (mkFId arg_C fid0)) ctxt)
            fid0s  -> case Map.lookup fids crc of
                        Just fid -> (st,map (flip C.PArg fid) ctxt)
                        Nothing  -> let !crc'   = Map.insert fids fid_cnt crc
                                        !prods' = IntMap.insert fid_cnt (Set.fromList (map C.PCoerce fids)) prods
                                    in ((fid_cnt+1,crc',prods'),map (flip C.PArg fid_cnt) ctxt)
          where
            (hargs_C,arg_C) = GM.catSkeleton ty
            ctxt = mapM (mkCtxt lindefs) hargs_C
            fids = map (mkFId arg_C) fid0s

    mkLinDefId id = prefixIdent "lindef " id

    toLinDef res offs lindefs (Production fid0 funid0 args) =
      if args == [[fidVar]]
        then IntMap.insertWith (++) fid [offs+funid0] lindefs
        else lindefs
      where
        fid = mkFId res fid0

    toLinRef res offs linrefs (Production fid0 funid0 [fargs]) =
      if fid0 == fidVar
        then foldr (\fid -> IntMap.insertWith (++) fid [offs+funid0]) linrefs fids
        else linrefs
      where
        fids = map (mkFId res) fargs

    mkFId (_,cat) fid0 =
      case Map.lookup (i2i cat) cnccats of
        Just (C.CncCat s e _) -> s+fid0
        Nothing               -> error ("GrammarToPGF.mkFId: missing category "++showIdent cat)

    mkCtxt lindefs (_,cat) =
      case Map.lookup (i2i cat) cnccats of
        Just (C.CncCat s e _) -> [(C.fidVar,fid) | fid <- [s..e], Just _ <- [IntMap.lookup fid lindefs]]
        Nothing               -> error "GrammarToPGF.mkCtxt failed"

    toCncFun offs (m,id) funs (funid0,lins0) =
      let mseqs = case lookupModule gr m of
                    Ok (ModInfo{mseqs=Just mseqs}) -> mseqs
                    _                              -> ex_seqs
      in (offs+funid0,C.CncFun (i2i id) (amap (newIndex mseqs) lins0)):funs                                          
      where
        newIndex mseqs i = binSearch (mseqs ! i) seqs (bounds seqs)
           
        binSearch v arr (i,j)
          | i <= j    = case compare v (arr ! k) of
                          LT -> binSearch v arr (i,k-1)
                          EQ -> k
                          GT -> binSearch v arr (k+1,j)
          | otherwise = error "binSearch"
          where
            k = (i+j) `div` 2

genPrintNames cdefs =
  Map.fromAscList [(i2i id, name) | ((m,id),info) <- cdefs, name <- prn info]
  where
    prn (CncFun _ _   (Just (L _ tr)) _) = [flatten tr]
    prn (CncCat _ _ _ (Just (L _ tr)) _) = [flatten tr]
    prn _                                = []

    flatten (K s)      = s
    flatten (Alts x _) = flatten x
    flatten (C x y)    = flatten x +++ flatten y

mkArray    lst = listArray (0,length lst-1) lst
mkMapArray map = array (0,Map.size map-1) [(v,k) | (k,v) <- Map.toList map]
mkSetArray set = listArray (0,Set.size set-1) [v | v <- Set.toList set]
