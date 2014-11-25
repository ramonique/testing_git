-- ambiguity finding script based on the latest definition of ambiguities using PMCFG
-- it assumes that inherent parameters don't exist, and the ambiguity check is done on the reflection grammar
-- open questions: how to retrieve that a certain ambiguity works for all partitions of a category (I saw the man with the telescope)


module Ambiguity5 where
import GrammarGen
import Data.IORef
import Data.List
import Data.Maybe
import Data.Char
import qualified Data.Set as S
import qualified Data.Map as Map
import Test.QuickCheck

import qualified PGF
import PGF( CId, mkCId, showCId )



maxTreeSize = 15 
-- maximum size of the trees we want to generate

maxTreeNo = 600
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
          let rezs = map fromJust $ nub $ filter isJust $ map (ambiguousR g rg) rezult in 
              do  --putStrLn $ "\n\n\nThe initial trees are : " ++ show (take 10 rezs) ++ "\n\n\n"
                  return rezs

ambiguousR :: Grammar -> Grammar -> Tree -> Maybe  [Tree]
ambiguousR g rg t =  
   let trs = parse g (rlin t g rg)
    in if length trs >= 2 then Just (map (getRTree rg) trs)
             else Nothing 
 
    
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

    
-- setInstance : Ambiguous trees from fingerprint -> New ambiguous trees -> Should they be added ?
setInstance :: [Tree] -> [Tree] -> IO Bool
setInstance ts cs = 
   do --putStrLn $ "\n\ncomparison between\n" ++ unlines (map show ts) ++ "  \n and \n" ++ unlines (map show cs) ++ " \n is : "
      let r = and [or [equalOrGen t c | t <- ts] | c <- cs] --or [equalOrGen t c | c<- cs, t <-ts]
      --putStr $ " r is : " ++ show r
      return r 

-- t1 is equal or a generalization of t2
equalOrGen :: Tree -> Tree -> Bool 
equalOrGen t1 t2 = 
   if isThe (top t1) then True
      else  top t1 == top t2 && (and [equalOrGen x y | (x,y) <- zip (args t1) (args t2)]) 
                    -- || or [equalOrGen t1 t | t <- args t2])


--------------------------------------------------------------------------------
-- implement Koen's idea to consider trees as ambiguous if they have all fields the same
--------------------------------------------------------------------------------
-- in order to see that they have even the invisible arguments the same, one can try to parse them as the same
-- category in the R-grammar - for this there is no need for tweeking the PGF compiler


isNewAmbTree :: Grammar -> Grammar -> Tree -> [(Tree,Tree)] 
isNewAmbTree g rg t = 
   let trs = parse g (rlin t g rg)
       rtrs = map (getRTree rg) trs
     in 
    filter isEqual  [(t1,t2) | t1 <- rtrs, t2 <- rtrs, t1 /= t2]   
        
    where 
      isEqual (t1,t2) = 
          if catOf t1 /= catOf t2 then False  
           else rlinAll t g rg == rlinAll t g rg   

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
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Optimization for larger grammars (merge categories which would belong to different R-categories)
--------------------------------------------------------------------------------



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



readPair :: String -> ((Int,Int),String)
readPair = read

makeIntervalMap :: String -> Map.Map Interval Name
makeIntervalMap ss = 
 let lins = map readPair $ lines ss
  in 
    Map.fromList $ map (\((b,e),n) -> (Interval b e, mkName n)) lins
----------------------------------------------------------------------------------
