-- ambiguity finding script based on the latest definition of ambiguities using PMCFG
-- it assumes that inherent parameters don't exist, and the ambiguity check is done on the reflection grammar
-- open questions: how to retrieve that a certain ambiguity works for all partitions of a category (I saw the man with the telescope)


module Main where
import GrammarGen
import System.Environment (getArgs)
import Data.IORef
import Data.List
import Data.Maybe
import Data.Char
import qualified Data.Set as S
import qualified Data.Map as Map
import Test.QuickCheck

import qualified PGF
import PGF( CId, mkCId, showCId )

import System.Directory
import System.Process
import System.Posix.Directory

--------------------------------------------------------------------------------
-- new stuff:
--------------


data Interval = Interval Int Int
   deriving (Show,Eq,Ord)


isInInterval :: Int -> Interval -> Bool
isInInterval i (Interval b e) = b <= i && i <= e

catInInterval :: Name -> Map.Map Interval Name -> Maybe Name 
catInInterval cat iv = 
  case showCId cat of 
     'C' : rest -> let number = read  rest :: Int
                       hi = head $ filter (isInInterval number) $ Map.keys iv
                     in Map.lookup hi iv     
     _  -> Nothing  

-- probably these arguments could be expressed more nicely...
readGrams :: String -> String -> IO (Grammar,Grammar, Map.Map Interval Name)
readGrams filepath1 filepath2 = do 
  gram <- readGrammar filepath1 
  rgram <- readGrammar filepath2
  rcats_content <- readFile $ (reverse $ dropWhile (/='/') $ reverse filepath1) ++ "RCats.txt"
  let rcats = makeIntervalMap rcats_content  
  return (gram,rgram,rcats)




readPair :: String -> ((Int,Int),String)
readPair = read

makeIntervalMap :: String -> Map.Map Interval Name
makeIntervalMap ss = 
 let lins = map readPair $ lines ss
  in 
    Map.fromList $ map (\((b,e),n) -> (Interval b e, mkName n)) lins


----------------------------
-- R-grammar stuff

-- parse string to R-tree
rparse :: String -> Grammar -> Grammar -> [Tree]
rparse s g rg = concat $ map (parse rg) $ map showTree $ parse g s

-- convert tree to R-tree (!?! we assume there is only one such tree)
getRTree :: Grammar -> Tree -> Tree
getRTree rg t = 
   let pp =  parse rg $ showTree t
     in 
      if length pp /= 1 then error $ "this tree doesn't parse in original grammar : " ++ showTree t 
         else head pp

-- linearize R-tree
rlin :: Tree -> Grammar -> Grammar -> String 
rlin t g rg = linearize g (typeTree g $ fromJust $ PGF.readExpr (linearize rg t))


-----------------------------



maxTreeSize = 15 
-- maximum size of the trees we want to generate

maxTreeNo = 300
-- maximum number of trees we deal with


-- ??? It should be possible to show that the R-grammar is not ambiguous, because of type checking and the way the equivalence classes are designed
--findStartTrees :: Grammar -> Grammar -> IO [Tree]
findStartTrees g rg = 
   let gr' = rg{symbols = filter (not . isThe) (symbols rg)}
       sCat = startCat rg  
       rezult = take maxTreeNo $ concat $ [[(snd st) i | i <- [0 .. (fst st) - 1] ] | s <- [0..maxTreeSize], let st = sizes rg sCat s] 
    in --return $ --[fst st | s <- [1..], let st = sizes gr sCat s] 
               -- [(l, parse g l) | t <- rezult, let l = rlin t g rg] 
              -- map fromJust $ nub $ filter isJust $ 
            --do rezs <- mapM (ambiguousR g rg) rezult
          let rezs = map (ambiguousR g rg) rezult in 
              do  --putStrLn $ "\n\n\nThe initial trees are : " ++ show rez' ++ "\n\n\n"
                  return $ map fromJust $ nub $ filter isJust rezs

ambiguousR :: Grammar -> Grammar -> Tree -> Maybe  [Tree]
ambiguousR g rg t =  
   let trs = parse g (rlin t g rg)
    in if length trs >= 2 then Just (map (getRTree rg) trs)
             else Nothing 




-------------------
-- change from here  

-- give name of the gf 
runAll :: String -> String -> IO ()
runAll abstractFile langName = 
  let newName = reverse $ takeWhile (/='/') $ tail $ dropWhile (/='.') $ reverse abstractFile
      nameWithDir = reverse $ tail $ dropWhile (/='.') $ reverse abstractFile 
      concName = newName++langName
      gName = nameWithDir ++ ".pgf"
      rgName = nameWithDir ++ langName ++"Comp.pgf" 
      gramDir = reverse $ dropWhile (/='/') $ reverse abstractFile  
   in 
    do currDir <- getCurrentDirectory
       putStrLn $ show currDir
       changeWorkingDirectory gramDir 
       putStrLn $ show gramDir
       readProcess "gf" ["-make", "-gen-gram", "-gen-debug", concName++".gf"] [] 
       readProcess "gf" ["-make", concName++"CompConc.gf"] []
       changeWorkingDirectory currDir
       g <- readGrammar gName 
       rg <- readGrammar rgName
       prettyPrintAmbiguities g rg showAmbIK



prettyPrintAmbiguities :: Grammar -> Grammar -> (Grammar -> Grammar -> Ambiguity -> String) -> IO ()
prettyPrintAmbiguities g rg showFunc = 
  do ambs <- filterIdentical `fmap` computeAmbiguities g rg
     mapM_ (putStrLn.(showFunc g rg)) ambs
     putStrLn $ "The number of ambiguities : " ++ show (length ambs)


--replace hole with one of the trees and linearize that
--then show all the trees
showAmbIK :: Grammar -> Grammar -> Ambiguity -> String
showAmbIK g rg (trs@(t1:_),ctx) = "Sentence: " ++ rlin (fill ctx t1) g rg ++ 
                               "\n Context: " ++ lin ctx ++ 
                               "\n   Trees: " ++ concat (intersperse "\n        | " $
                                                         map lin trs) ++ "\n"
    where lin = concat . words . linearize rg

filterIdentical :: [Ambiguity] -> [Ambiguity]
filterIdentical = nubBy f
   where f (x,_) (y,_) = sort x == sort y

fill :: Tree -> Tree -> Tree
fill (App f xs) t | isHole f = t
                  | otherwise = App f (map (`fill` t) xs)

--End additions by Inari and Koen
--------- 

    
showAmbR _ (trs, ctx) = "{ trees : " ++ concat (intersperse " , " $ map showTree trs) ++ "\n context : " ++ show ctx ++ "\n}" 

showAmb rg (trs, ctx) = "{ trees : " ++ concat (intersperse " , " $ map (linearize rg) trs) ++ "\n context : " ++ linearize rg ctx      

computeAmbiguities :: Grammar -> Grammar -> IO [Ambiguity]
computeAmbiguities gr rg = 
    do trees <- findStartTrees gr rg
       --putStrLn $ "The trees are : \n"  ++ (show $ map (linearize rg) $ concat $ trees)
       --putStrLn "\n\n\n"
       computeFingerprint gr rg [] trees
  where 
  computeFingerprint :: Grammar -> Grammar -> [Ambiguity] -> [[Tree]] -> IO [Ambiguity]
  computeFingerprint gr rg ambs [] = return ambs
  computeFingerprint gr rg ambs (t:ts) = 
       do --putStrLn "\n**New iteration**\n"
          --putStrLn $ show t ++ " where the union is : "
          d <- difference rg t
          if numberOfHoles d == 1 then 
              let trs = map (fromJust . getAmbTrees rg d) t  in
                do --putStrLn $ "\nthe ambiguous trees are : "++ niceShow trs 
                   newF <- updateFingerprint ambs (trs,d) 
                   computeFingerprint gr rg newF ts
            else fail $ "not proper context for " ++ show t ++ " --> " ++ show d            

  updateFingerprint :: [Ambiguity] -> Ambiguity -> IO [Ambiguity]
  updateFingerprint ambs (trs, ctx) = 
       let trees = map fst ambs 
          in 
             do comps <- mapM (\x -> setInstance x trs) trees
                if or comps then return ambs 
                   else return $ (trs,ctx) : ambs

niceShow trs = "{ " ++ concat (intersperse " , " $ map show trs) ++ " }"
    
-- setInstance : Ambiguous trees from fingerprint -> New ambiguous trees -> Should they be added ?
setInstance :: [Tree] -> [Tree] -> IO Bool
setInstance ts cs = 
   do putStrLn $ "\n\ncomparison between " ++ show ts ++ "  \n and \n  " ++ show cs ++ " is : "
      let r =  or [equalOrGen t c | c<- cs, t <-ts]
      putStr $ " r is : " ++ show r
      return r 

-- t1 is equal or a generalization of t2
equalOrGen :: Tree -> Tree -> Bool 
equalOrGen t1 t2 = 
   if isThe (top t1) then True
      else  top t1 == top t2 && and [equalOrGen x y | (x,y) <- zip (args t1) (args t2)] 

{-
couldMatch :: Grammar -> (Tree,Tree) -> Bool
couldMatch gr (t1,t2) = 

       let trs = parse gr (linearize gr t1)
           in elem t2 trs   -- need smth better .... (will think about it - maybe like lemma + form)
-- maybe better if they have at least 1 linearization in common 
-}

--------------------------------------------------------------------------------
-- fingerprint types

type Ambiguity =  ([Tree], Context) 
   -- expression + function that embeds it into a tree of category startCat
   -- we implicitly assume that context have only one hole

type Context = Tree 
  -- tree with a hole 


type Fingerprint = [Ambiguity]
    -- list of mutually ambiguous tree
    -- the tree produced is the same


-- We compare the trees from the list in pairs in order to find their union:


diff :: (Tree,Tree) -> IO Tree
diff (t1,t2)
   | isHole (top t1) = return t1
   | otherwise = 
      if top t1 == top t2 then 
           do 
              lAmb <- mapM diff $ zip (args t1) (args t2)
              let nh = sum $ map numberOfHoles lAmb
              --putStrLn $ " arguments for "++ show t1 ++ " : " ++ show lAmb
              --putStrLn $ " number of holes "++ show (map numberOfHoles lAmb)
              if nh == 1 then return $ App {top = top t1, args = lAmb}
                  else if nh == 0 then do --putStrLn $ "\n\nt1 and t2 are "++ show t1 ++ "\n" ++show t2 ++ "\n\n"
                                          return t2
                         else return $ App {top = hole (catOf t1), args = []} 
       else return $ App {top = hole (catOf t1), args = []} 
    



difference :: Grammar -> [Tree] -> IO Tree
difference gr (t1:t2:[]) = 
         do d <- diff (t1,t2) 
            --putStrLn $ "\nthe difference of " ++ show t1 ++ " and " ++ show t2 ++ " is "++ show d ++"\n"
            return d
difference gr (t1:t2:ts) = 
   do d <- diff (t1,t2) 
      difference gr (d:ts)
difference gr l = fail $ "not enough ambiguous trees " ++ show l 

-- get mutually ambiguous trees from pattern
getAmbTrees :: Grammar -> Tree -> Tree -> Maybe Tree
getAmbTrees gr pat t =
     if isHole (top pat) then Just t 
      else 
        if top pat == top t then 
          let rezs = filter isJust $ [getAmbTrees gr p1 t1 | (p1,t1) <- zip (args pat) (args t)]  
              in if length rezs == 1 then head rezs
                   else Nothing --error $ "smth wrong here  : "++ show pat ++ "   " ++ show t          
         else Nothing 

-- we assume that there is just one tree we're looking for
-- we assume that the trees are always the smallest, we compare... 

hasHole :: Tree -> Bool 
hasHole t = 
   isHole (top t) || (or [isHole (top a) | a <- args t])
           
numberOfHoles :: Tree -> Int
numberOfHoles t = 
   let v = if isHole (top t) then 1 else 0 
  in 
  v + sum [ numberOfHoles a | a <- args t]

hole :: Cat -> Symbol
hole ct = Symbol (mkName "*") ([], ct)

isHole :: Symbol -> Bool
isHole (Symbol n ([],c)) = "'*'" == showCId n
isHole _ = False 

isHoleCat :: Cat -> Symbol -> Bool
isHoleCat cat (Symbol n ([],c)) = "'*'" == show n && c == cat
isHoleCat cat _ = False
-------------------------------------------------------------------------------

