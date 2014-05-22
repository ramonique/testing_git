import System.IO
import Data.IORef
import Data.List
import System.Environment (getArgs)
import Data.Map(Map)
import qualified Data.Map as Map
import Data.Set(Set)
import qualified Data.Set as Set
import Data.Maybe
import System.Random
import PGF
import Test.QuickCheck
import Test.QuickCheck.Gen( Gen(..) )



type NewFunctions = Map.Map CId (Set.Set CId)


main :: IO ()
main = do args <- getArgs
          case args of
           [file] -> checkTrees file    
           --[file, "lex"] -> checkLex file  
           _    -> do putStrLn "usage TestAmbiguity file_name [|lex] - for brute force checking/lexical ambiguity"

number_of_trees = 10
depth = 4


newFuncs cids pgf = 
  let tys = map (\x -> typeName $ fromJust $ functionType pgf x) cids
      fstMap = Map.fromListWith Set.union $ zip tys (map Set.singleton cids)
      
      fcs = functions pgf
      compFcs1 =  Map.toList $ Map.fromList $ zip (map (fromJust . functionType pgf) fcs) fcs 
      compFcs  = Map.fromListWith Set.union $ map (\(x,y) -> (typeName x, Set.singleton y)) $ compFcs1 

      --prelMap = Map.unionWith Set.union fstMap compFcs

      --allCats = filter (\x -> not $ Map.member x prelMap) $ categories pgf

      --newMap = Map.fromList $ map (\(x,y) -> (x, Set.singleton $ fromJust y)) $ filter (isJust . snd) $  map (\x -> (x, listToMaybe $ filter (\y -> x == (typeName $ fromJust $ functionType pgf y)) fcs)) allCats

      finMap =  Map.unionWith Set.union fstMap compFcs
      finSet = Set.unions (Map.elems finMap)
     in 
 do putStrLn $ "list with potentially problematic cases" ++ (show $ length cids) ++ "   " ++(show $ Set.size $ Set.unions $ Map.elems fstMap)
    putStrLn $ "number of complex functions" ++ (show $ length compFcs1) ++ "   " ++ (show $ Set.size $ Set.unions $ Map.elems compFcs)
    --putStrLn $ "not covered : \n" ++ show allCats ++ "\nfinal number of functions to consider : " ++ (show $ Set.size finSet)  ++ "   " ++ (show $ length $ Map.toList finMap)
    return finSet

checkLex file =
  do pgf <- readPGF file
     let lang = head $ languages pgf -- to do : add a user-chosen language instead
     let morpho = buildMorpho pgf lang
     let lex = filter (\x -> (length $ snd x) > 1) $ map (\(x,y) -> (x, map fst y)) $ fullFormLexicon morpho
     let cids = Set.toList $ Set.fromList $ concat $ map snd lex
     --putStrLn $ "the lexicon is "++ show lex
     fset <- newFuncs cids pgf
     putStrLn $ "total number of functions from the grammar" ++ (show $ length $ functions pgf)
     putStrLn $ "fset is " ++ show fset
     returnAmb pgf lang fset


returnAmb pgf lang fset =
  do g <- newStdGen 
     let sc = startCat pgf
     putStrLn $ "fset is " ++ show fset
     putStrLn $ "all the functions are " ++ (show $ functions pgf)
     let trees = take number_of_trees $ generateRandomDepthRestr g pgf fset sc (Just depth)
     let rez = filter (\x -> 1 < (length $ parse pgf lang sc (linearize pgf lang x))) trees
     let fin_rez = Set.toList $ Set.fromList rez
     putStrLn $ "\nthe trees considered are " ++ (unlines $ map (showExpr []) trees)    
     --putStrLn $ "\n\nthe ambiguous trees are \n\n" ++ (unlines $ map (showExpr []) fin_rez)  
  


typeName :: Type -> CId 
typeName ty = let (_,n,_) = unType ty in n
--mkCId $ showType [] ty


isSimpleType :: Type -> Bool
isSimpleType ty =
  let (hs,_,_) = unType ty in null hs


-- (unwords $ intersperse "," $ map (showExpr []) z)
-- (show $ length z)
-- (showExpr [] $ fst z) ++ "\n" ++(showExpr [] $ snd z) ++ "\n" ++
checkTrees file = 
  do pgf <- readPGF file
     let lang = head $ languages pgf
     let justStart = startCat pgf
     let morpho = buildMorpho pgf lang
     let lex = filter (\x -> (length $ snd x) > 1) $ map (\(x,y) -> (x, map fst y)) $ fullFormLexicon morpho
     let cids = Set.toList $ Set.fromList $ concat $ map snd lex
     fset <- newFuncs cids pgf
     g <- newStdGen
     let trees = take number_of_trees (generateRandomDepthRestr g pgf fset justStart (Just depth))
     putStrLn $ unlines $ map (showExpr []) trees
     putStrLn $ "\n\n\n\n"
     putStrLn $ unlines $ map (\(x, Just (y,z)) -> let rez =  minimizeAmb pgf lang z 
                                                       --rez2 = fromJust rez --generalize pgf $ fromJust rez 
                      in 
                        if isNothing rez then y 
                    else y ++ "  <--  ("++  (showExpr [] $ fst $ fromJust rez) ++ " , " ++ (showExpr [] $ snd $ fromJust rez) ++")") $ filter (isJust . snd) $ zip trees $ map (isAmbiguous pgf justStart lang) trees
  where 
     isAmbiguous pgf startCat lang t = 
               let ss = linearize pgf lang t
                   pTrees = parse pgf lang startCat ss                              
                  in 
                if length pTrees > 1 then Just (ss, (head pTrees, head $ tail pTrees)) else Nothing
                

minimizeAmb :: PGF -> Language -> (Expr,Expr) -> Maybe (Expr,Expr)
minimizeAmb pgf lang (tree1,tree2) = 
  let sbtr = zip (subtrees tree1) (subtrees tree2) 
   in
  if not $ maybeSame tree1 tree2 then Just (tree1,tree2)   
    else if null sbtr then Nothing 
          else if extraCheck pgf lang sbtr then 
               let em = take 1 $ mapMaybe (minimizeAmb pgf lang) $ zip (subtrees tree1) (subtrees tree2)
                   in if null em then Nothing 
                       else Just $ head em  
               else Just (tree1,tree2)

{- --generalize :: (Expr, Expr) -> (Expr,Expr)
generalize pgf (expr1,expr2) = 
 let (cid1,sbtr1) = fromJust $ unApp expr1
     (cid2,sbtr2) = fromJust $ unApp expr2
    in 
   if null sbtr1 then (expr1,expr2)
     else let Right (_,ty) = inferExpr pgf (head sbtr1) 
           in error $ showExpr [] expr1 ++ "\n" ++ show ty     
-}

-- looks up a subexpression in another expression and replaces it with a meta(only once)
replaceExpr :: Int -> Expr -> Expr -> Maybe Expr
replaceExpr i subexpr expr = undefined
{-       if subexpr == expr then mkMeta i
        else 
         let sbtr = subtrees expr in
          if null sbtr then Nothing
            else if all isNothing $ map (replaceExpr i subexpr) sbtr then Nothing 
                  else undefined 
-}
-- see from where to take it out in the other tree - try all occurences, if none is still ambiguous then Nothing
-- also, see if the entries are from the potentially ambiguous batch - if not then generalize over them...



extraCheck :: PGF -> Language -> [(Expr, Expr)] -> Bool
extraCheck pgf lang sbtr1 = and $ map (checkSameLin pgf lang) sbtr1
  where checkSameLin pgf lang (t1,t2) = linearize pgf lang t1 == linearize pgf lang t2 


maybeSame :: Expr -> Expr -> Bool
maybeSame tree1 tree2 = 
   let (cid1,_) = fromJust $ unApp tree1 
       (cid2,_) = fromJust $ unApp tree2
     in cid1 == cid2
 
subtrees :: Expr -> [Expr]
subtrees tree = 
   snd $ fromJust $ unApp tree
   
--------------------------------------------------------------------------------
-- simple agorithm based on shrinking

-- result type of an expression

typeOf :: PGF -> Expr -> Maybe Type
typeOf pgf x =
  do (c,xs)   <- unApp x
     ftp      <- functionType pgf c
     let (_,ct,_) = unType ftp
     return (mkType [] ct [])

-- fingerprint

type FingerPrint = Set CId -- the set of non-abstract functions

fingerprint :: PGF -> Expr -> FingerPrint
fingerprint pgf x
  | Set.null fp0 = cats x
  | otherwise    = fp0
 where
  isAbs c = "the_" `isPrefixOf` show c

  fp0 = Set.filter (not . isAbs) (cats x)
{-
  isAbs c = c `elem` [ f
                     | tp <- categories pgf
                     , Just f <- [absFun pgf (mkType [] tp [])]
                     ]
-}
  cats x =
    case unApp x of
      Nothing     -> Set.empty
      Just (c,xs) -> c `Set.insert` Set.unions [ cats y | y <- xs ]

-- generating expressions

arbTypedMaybeExpr :: PGF -> Type -> Gen (Maybe Expr)
arbTypedMaybeExpr pgf tp = sized (arbExpr tp [] . (`div` 2))
 where
  arbExpr :: Type -> [Type] -> Int -> Gen (Maybe Expr)
  arbExpr tp forbidden n =
    frequency' $
      [ (1, do return (Just (mkApp f [])))
      | (f, []) <- funs
      ] ++
      [ (3, do mas <- sequence [ arbExpr t forbidden' n' | t <- xs ]
               if Nothing `elem` mas
                 then return Nothing
                 else return (Just (mkApp f [ a | Just a <- mas])))
      | (f, xs) <- funs
      , let ar = length xs
      , ar > 0
      , n > 0 || all (`notElem` forbidden) xs
      , let n' | ar == 1   = n-1
               | otherwise = n `div` ar
      
            forbidden' | n > 0     = []
                       | otherwise = tp : forbidden
      ]
   where
    funs = [ (f, [ t | (_,_,t) <- args ])
           | f <- functions pgf
           , Just ft <- [functionType pgf f]
           , let (args, rt, _) = unType ft
           , mkType [] rt [] == tp
           ]
 
  frequency' [] = return Nothing
  frequency' xs = frequency xs

arbTypedExpr :: PGF -> Type -> Gen Expr
arbTypedExpr pgf tp = fromJust `fmap` (arbTypedMaybeExpr pgf tp `suchThat` isJust)

arbExpr :: PGF -> Gen Expr
arbExpr pgf =
  do c <- elements (categories pgf)
     arbTypedExpr pgf (fromJust . readType . show $ c)

-- shrinking expressions

shrinkExpr :: PGF -> Bool -> Expr -> [Expr]
shrinkExpr pgf keep x =
     shrinkAbs x
  ++ shrinkSubs1 (typeOf pgf x) x
  ++ shrinkSubs x
 where
  shrinkAbs x =
    [ mkApp abs
        [ mkApp tr []
        | let tr = mkCId "the_Track"
        , Just _ <- [functionType pgf tr]
        ]
    | Just tp <- [typeOf pgf x]
    , Just (c,_) <- [unApp x]
    , let abs = mkCId ("the_" ++ showType [] tp)
    , Just _ <- [functionType pgf abs]
    --, Just abs <- [absFun pgf tp]
    , abs /= c
    ]

  shrinkSubs1 mtp x =
    concat [ shrinkSubs0 mtp y | Just (_,xs) <- [unApp x], y <- xs ]

  shrinkSubs0 mtp x
    | isNothing mytp          = []
    | not keep || mytp == mtp = [x]
    | otherwise               = shrinkSubs1 mtp x
   where
    mytp = typeOf pgf x

  shrinkSubs x =
    [ mkApp c (take i xs ++ [x'] ++ drop (i+1) xs)
    | Just (c,xs) <- [unApp x]
    , i <- [0..length xs-1]
    , let x = xs !! i
    , x' <- shrinkExpr pgf True x
    ]

-- find the standard symbol for a category

absFun :: PGF -> Type -> Maybe CId
absFun pgf tp =
  listToMaybe
  [ f
  | f <- functions pgf
  , Just ftp <- [functionType pgf f]
  , ([], t, []) <- [unType ftp]
  , tp == mkType [] t []
  ]

-- the QuickCheck property

{-
prop_NonAmbiguous dispShrink dispFail pgf lang start sset =
  forAllShrink (arbTypedExpr pgf start) (shrinkExpr pgf True) $ \x ->
    let s                = linearize pgf lang x
        --mtp@(~(Just tp)) = typeOf pgf x
     in --isJust mtp ==>
        --not (null s) ==>
          whenFail' (dispShrink (showType [] start ++ ": " ++ show s)) $
            case {- filter noQuestionMark -} (parseAmb sset pgf lang start s) of
              x1 : x2 : _ -> whenFail (dispFail start x1 x2 s) False
              _           -> property True
 where
  noQuestionMark x = '?' `notElem` showExpr [] x
-}

prop_NonAmbiguous dispShrink dispFail pgf lang start sset =
  forAllShrink (arbTypedExpr pgf start) (shrinkExpr pgf True) $ \x ->
    let s                = linearize pgf lang x
        mtp@(~(Just tp)) = typeOf pgf x
     in isJust mtp ==>
        --not (null s) ==>
          whenFail' (dispShrink (showType [] start ++ ": " ++ show s)) $
            case {- filter noQuestionMark -} (parseAmb sset pgf lang tp s) of
              x1 : x2 : _ -> whenFail (dispFail tp x1 x2 s) False
              _           -> property True
 where
  noQuestionMark x = '?' `notElem` showExpr [] x

prop_NoQuestionMark pgf lang =
  forAllShrink (arbExpr pgf) (shrinkExpr pgf False) $ \x ->
    let s                = linearize pgf lang x
        mtp@(~(Just tp)) = typeOf pgf x
     in isJust mtp ==>
          case parse pgf lang tp s of
            x : _ -> whenFail (do putStrLn ("lin: " ++ s)
                                  putStrLn ("type: " ++ showType [] tp)
                                  putStrLn ("parse: " ++ showExpr [] x)) $
                     property ('?' `notElem` showExpr [] x)
            _     -> property ()


prop_NoQuestionMark_First pgf = 
   prop_NoQuestionMark pgf (head $ languages pgf)

-- simple property driver, finding 1 ambiguity

do_prop file =
  do -- reading the grammar
     pgf <- readPGF file
     let lang = head $ languages pgf
         start = startCat pgf
     
     -- setting up shrinking output
     let file = "shrink.txt" 
     writeFile file ""
     let dispShrink s = appendFile file (s ++ "\n")

     -- setting up final failed output
     let dispFail tp x1 x2 s =
           do putStrLn ("Type: " ++ showType [] tp)
              putStrLn ("Lin: " ++ show s)
              putStrLn ("Parse1: " ++ showExpr [] x1)
              putStrLn ("Parse2: " ++ showExpr [] x2)

     -- running QuickCheck     
     quickCheck (prop_NonAmbiguous dispShrink dispFail pgf lang start [])

-- property driver, finding all ambiguities

findAmbs file =
  do -- reading the grammar
     pgf <- readPGF file
     let lang = head $ languages pgf
         start = startCat pgf
         
     -- printing out abstract symbols
     sequence_
       [ putStrLn (show tp ++ ": " ++ show f)
       | tp <- categories pgf
       , Just f <- [absFun pgf (mkType [] tp [])]
       ]

     -- setting up shrinking output
     let dispShrink s = return ()

     -- setting up final failed output
     let file = "ambiguities.txt"
     writeFile file ""
     let dispFail tp x1 x2 s =
           do appendFile file $ unlines $
                [ "* '" ++ s ++ "', as " ++ showType [] tp
                , "  - " ++ showExpr [] x1
                , "  - " ++ showExpr [] x2
                , ""
                ]

     -- looping
     let loop fs n =
           do putStrLn ("=== Finding Ambiguity #" ++ show (n+1) ++ " ===")
              ref <- newIORef Nothing
              let dispFail' tp x1 x2 s =
                    do print (fingerprint pgf x1)
                       writeIORef ref (Just (fingerprint pgf x1))
                       dispFail tp x1 x2 s
              quickCheckWith stdArgs{ maxSuccess = 1000 } (prop_NonAmbiguous dispShrink dispFail' pgf lang start fs)
              mf <- readIORef ref
              case mf of
                Nothing -> putStrLn "(giving up)"
                Just f  -> loop (f:fs) (n+1)
      in loop [] 0

