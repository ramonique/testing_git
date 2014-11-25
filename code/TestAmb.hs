module Main where
import GrammarGen
import Ambiguity5
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


-- probably these arguments could be expressed more nicely...
readGrams :: String -> String -> IO (Grammar,Grammar, Map.Map Interval Name)
readGrams filepath1 filepath2 = do 
  gram <- readGrammar filepath1 
  rgram <- readGrammar filepath2
  rcats_content <- readFile $ (reverse $ dropWhile (/='/') $ reverse filepath1) ++ "RCats.txt"
  let rcats = makeIntervalMap rcats_content  
  return (gram,rgram,rcats)


testAll :: IO ()
testAll = 
  do goldRaw <- readFile "../examples/gold.csv" --["ABCD GrammarA Eng 3\nGrammarB Fre 5"]
     let gold = map words $ lines goldRaw       --[[ABCD","GrammarA","Eng","3"]]
     mapM_ printTests gold

  where printTests :: [String] -> IO ()
        printTests (dir:abs:conc:amb:_) =  
          let gramDir     =  "../examples/" ++ dir ++ "/"
              concName    = abs ++ conc
              nameWithDir = gramDir ++ abs
              gName = nameWithDir ++ ".pgf"
              rgName = nameWithDir ++ conc ++"Comp.pgf"
              numAmbs = read amb
          in 
           do currDir <- getCurrentDirectory
              changeWorkingDirectory gramDir
              readProcess "gf" ["-make", "-gen-gram", "-gen-debug", concName++".gf"] []
              readProcess "gf" ["-make", concName++"CompConc.gf"] []
              changeWorkingDirectory currDir
              g <- readGrammar gName 
              rg <- readGrammar rgName
              ambs <- filterIdentical `fmap` computeAmbiguities g rg
              let foundAmbs = length ambs
              putStrLn "---------------------------------------"
              prettyPrintAmbiguities g rg showAmbIK
              putStrLn $ "             Grammar: " ++ concName
              putStrLn $ "   Ambiguities found: " ++ show foundAmbs
              putStrLn $ "Ambiguities expected: " ++ show numAmbs
              prettyPrintAmbiguities g rg showAmbIK
              if numAmbs == foundAmbs 
                then putStrLn "Everything's fine! ^_^" 
                else putStrLn "Something's wrong! :O" 
              putStrLn "---------------------------------------"
        printTests _ = putStrLn "usage: dir, abs, conc, expected number of ambiguities"
     
  



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
     mapM_ (putStrLn.(showFunc g rg)) (reverse ambs)
     putStrLn $ "The number of ambiguities : " ++ show (length ambs)
     putStrLn ""

showAmbR _ (trs, ctx) = "{ trees : " ++ concat (intersperse " , " $ map showTree trs) ++ "\n context : " ++ show ctx ++ "\n}" 

showAmb rg (trs, ctx) = "{ trees : " ++ concat (intersperse " , " $ map (linearize rg) trs) ++ "\n context : " ++ linearize rg ctx      


--replace hole with one of the trees and linearize that
--then show all the trees
showAmbIK :: Grammar -> Grammar -> Ambiguity -> String
showAmbIK g rg (trs@(t1:_),ctx) = "Sentence: " ++ unwords (filter (/="0") $ words $ rlin (fill ctx t1) g rg) ++ 
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
