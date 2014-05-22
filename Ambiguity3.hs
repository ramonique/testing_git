module Main where
import System.Environment (getArgs)
import Data.IORef
import Data.List
import Data.Maybe
import Data.Char
import qualified Data.Set as S
import Test.QuickCheck

import qualified PGF
import PGF( CId, mkCId )

import System.Directory
import System.Process
import System.Posix.Directory

--------------------------------------------------------------------------------
-- grammar types

-- name

type Name = CId
type Cat  = CId

mkName, mkCat :: String -> Name
mkName = mkCId
mkCat  = mkCId

-- tree

data Tree
  = App{ top :: Symbol, args :: [Tree] }
 deriving ( Eq )

instance Show Tree where
  show (App a []) = show a
  show (App f xs) = show f ++ "(" ++ concat (intersperse "," (map show xs)) ++ ")"

catOf :: Tree -> Cat
catOf (App f _) = snd (typ f)

-- symbol

data Symbol
  = Symbol
  { name :: Name
  , typ  :: ([Cat], Cat)
  }
 deriving ( Eq, Ord )

instance Show Symbol where
  show f = show (name f)

showSymbol :: Symbol -> String
showSymbol f =
  show f ++ " : " ++ case typ f of
                       ([],a) -> show a
                       ([t],a) -> show t ++ " -> " ++ show a
                       (ts,a)  -> "(" ++ concat (intersperse "," (map show ts)) ++ ") -> " ++ show a

int :: Cat
int = mkCat "Int"

index :: Int -> Symbol
index n = Symbol (mkName (show n)) ([], int)

isThe :: Symbol -> Bool
isThe s = "the_" `isPrefixOf` show (name s)

thes :: Grammar -> Cat -> [Symbol]
thes gr c = [ f
            | f <- symbols gr
            , isThe f
            , let (_,ct) = typ f
            , ct == c
            ]

-- grammar

data Grammar
  = Grammar
  { parse     :: String -> [Tree]
  , linearize :: Tree -> String
  , startCat  :: Cat
  , symbols   :: [Symbol]
  , sizes     :: Sizes
  }

toGrammar :: PGF.PGF -> Grammar
toGrammar pgf =
  let gr =
        Grammar
        { parse = \s ->
            [ mkTree t
            | t <- PGF.parse pgf lang (PGF.startCat pgf) s
            ]
  
        , linearize = \t ->
            PGF.linearize pgf lang (mkExpr t)

        , startCat =
            mkCat (PGF.startCat pgf)
  
        , symbols =
            index 0 :
            [ mkSymbol f
            | f <- PGF.functions pgf
            , Just _ <- [PGF.functionType pgf f]
            ]

        , sizes =
            mkSizes gr
        }
   in gr
 where
  lang = head $ PGF.languages pgf
  
  mkSymbol f = Symbol f ([mkCat x | (_,_,x) <- xs],y)
   where
    Just ft    = PGF.functionType pgf f
    (xs, y, _) = PGF.unType ft
  
  mkTree t =
   case (PGF.unApp t, PGF.unInt t) of
     (Just (f,xs), _)      -> App (mkSymbol f) [ mkTree x | x <- xs ]
     (_,           Just i) -> App (index i) []
     _                     -> error (PGF.showExpr [] t)
   where
    Just (f,xs) = PGF.unApp t
  
  mkExpr (App n []) | not (null s) && all isDigit s =
    PGF.mkInt (read s)
   where
    s = show n
  mkExpr (App f xs) =
    PGF.mkApp (name f) [ mkExpr x | x <- xs ]
  
  mkCat  tp  = cat where (_, cat, _) = PGF.unType tp
  mkType cat = PGF.mkType [] cat []

readGrammar :: FilePath -> IO Grammar
readGrammar file =
  do pgf <- PGF.readPGF file
     return (toGrammar pgf)

type Sizes = Cat -> Int -> (Integer, Integer -> Tree)

mkSizes :: Grammar -> Sizes
mkSizes gr =
  \c s -> let (n,h) = catList [c] s in (n, head . h)
 where
  catList' [] s =
    if s == 0
      then (1, \0 -> [])
      else (0, error "empty")

  catList' [c] s =
    parts [ (n, \i -> [App f (h i)])
          | s > 0
          , f <- symbols gr
          , let (xs,y) = typ f
          , y == c
          , let (n,h) = catList xs (s-1)
          ]

  catList' (c:cs) s =
    parts [ (nx*nxs, \i -> hx (i `mod` nx) ++ hxs (i `div` nx))
          | k <- [0..s]
          , let (nx,hx)   = catList [c] k
                (nxs,hxs) = catList cs (s-k)
          ]

  catList = memo catList'
   where
    cats = nub [ x | f <- symbols gr, let (xs,y) = typ f, x <- y:xs ]

    memo f = \cs -> case cs of
                      []   -> (nil !!)
                      a:as -> head [ f' as | (c,f') <- cons, a == c ]
     where
      nil  = [ f [] s | s <- [0..] ]
      cons = [ (c, memo (f . (c:))) | c <- cats ]

  parts []          = (0, error "empty parts ")
  parts ((n,h):nhs) = (n+n', \i -> if i < n then h i else h' (i-n))
   where
    (n',h') = parts nhs

--------------------------------------------------------------------------------
-- generation and shrinking

arbTree :: Grammar -> Cat -> Gen Tree
arbTree gr c =
  do (n,h) <- (sized $ \n ->
                do s <- choose (1, n `div` 4 + 1)
                   return (sizes gr c s)) `suchThat` ((>0) . fst)
     i <- choose (0,n-1)
     return (h i)

shrinkTree :: Grammar -> Tree -> [Tree]
shrinkTree gr t@(App f xs) =
  (case shrinkToSubList (catOf t) xs of
    [] -> [ t
          | not (isThe f)
          , the <- symbols gr
          , isThe the
          , let (_,tp) = typ the
          , tp == catOf t
          ]
    ts -> ts)
  ++ [ App g (args (fst (typ g)) xs)
     | g <- symbols gr
     , not (isThe g)
     , g <<< f
     ]
  ++ [ App f (take i xs ++ [x'] ++ drop (i+1) xs)
     | i <- [0..length xs-1]
     , x' <- shrinkTree gr (xs !! i)
     ]
 where
  shrinkToSub cat t | catOf t == cat = [ t ]
  shrinkToSub cat (App f xs)         = shrinkToSubList cat xs

  shrinkToSubList cat xs =
    [ t'
    | x <- xs
    , t' <- shrinkToSub cat x
    ]

  g <<< f = gy == fy
         && (length gxs < length fxs || show g < show f)
         && all (\t -> number (==t) gxs <= number (==t) fxs) ts
   where
    (gxs,gy) = typ g
    (fxs,fy) = typ f
   
    ts = nub (fst (typ g))

    number p = length . filter p

  args []     ts = []
  args (a:as) ts = t : args as (ts \\ [t])
   where
    t : _ = filter ((==a) . catOf) ts

--------------------------------------------------------------------------------

select :: [a] -> [(a,[a])]
select []     = []
select (x:xs) = (x,xs) : [ (y,x:ys) | (y,ys) <- select xs ]

pairs :: [a] -> [(a,a)]
pairs []     = []
pairs (x:xs) = [ (x,y) | y <- xs ] ++ pairs xs

--------------------------------------------------------------------------------
-- new stuff:
--------------

maxTreeSize = 15 
-- maximum size of the trees we want to generate

maxTreeNo = 30
-- maximum number of trees we deal with


--findStartTrees :: Grammar -> IO [Tree]
findStartTrees gr = 
   let gr' = gr{symbols = filter (not . isThe) (symbols gr)}
       sCat = startCat gr  
       rezult = take maxTreeNo $ concat $ [[(snd st) i | i <- [0 .. (fst st) - 1] ] | s <- [1..maxTreeSize], let st = sizes gr sCat s] 
    in return $ -- [fst st | s <- [1..], let st = sizes gr sCat s] 
             map fromJust $ nub $ filter isJust $ map (ambiguous gr) rezult  
  

computeAmbiguities :: Grammar -> IO [Ambiguity]
computeAmbiguities gr = 
    do trees <- findStartTrees gr
       computeFingerprint gr [] trees
  where 
  computeFingerprint :: Grammar -> [Ambiguity] -> [[Tree]] -> IO [Ambiguity]
  computeFingerprint gr ambs [] = return ambs
  computeFingerprint gr ambs (t:ts) = 
       do putStrLn $ show t ++ " where the union is : "
          d <- difference gr t
          if numberOfHoles d == 1 then 
              let trs = map (fromJust . getAmbTrees gr d) t  in
                do putStrLn $ "the ambiguous trees are : "++ show trs 
                   computeFingerprint gr (updateFingerprint gr ambs (trs,d)) ts
            else fail $ "not proper context for " ++ show t ++ " --> " ++ show d            

  updateFingerprint :: Grammar -> [Ambiguity] -> Ambiguity -> [Ambiguity]
  updateFingerprint gr ambs (trs, ctx) = 
       if elem (trs) $ map fst ambs then ambs -- add condition about the_ function to see if it's used in the same way
         else (trs,ctx) : ambs
   

ambiguous :: Grammar -> Tree -> Maybe [Tree] 
ambiguous gr t = 
     let trs = parse gr (linearize gr t)
       in if length trs >= 2
              then return trs
                 else Nothing    

couldMatch :: Grammar -> (Tree,Tree) -> Bool
couldMatch gr (t1,t2) = 
       let trs = parse gr (linearize gr t1)
           in elem t2 trs   -- need smth better .... (will think about it - maybe like lemma + form)

--------------------------------------------------------------------------------
-- fingerprint types

type Ambiguity =  ([Tree], Context) 
   -- expression + function that embeds it into a tree of category startCat
   -- we implicitly assume that context have only one hole

type Context = Tree 
  -- tree with a hole 

type OldContext = (Tree -> Tree) 
   -- maybe change to the one-hole representation from before...


type Fingerprint = [Ambiguity]
    -- list of mutually ambiguous tree
    -- the tree produced is the same


-- We compare the trees from the list in pairs in order to find their union:


diff :: Grammar -> (Tree,Tree) -> Tree
diff gr (t1,t2) 
     | isHole (top t1) =  t1 
     | otherwise = 
         if top t1 == top t2 -- && ((and [couldMatch gr (tr1,tr2) | (tr1, tr2) <- zip (args t1) (args t2)]) || (hasHole t1)) -- TO DO - fix here with another condition for the linearization 
             then
               let lAmb = map (diff gr) $ zip (args t1) (args t2)
                   nh = sum $ map numberOfHoles lAmb   
                   ambTrees = filter hasHole lAmb
                in 
              if nh == 1 then 
                             (App {top = top t1, 
                                   args = lAmb})  
                 else if nh == 0 then t1
                       else  App {top = hole (catOf t1), args = []} --error $ "too many holes in " ++ show t1 ++ " +  " ++ show t2
               else  App {top = hole (catOf t1), args = []} 
                       
difference :: Grammar -> [Tree] -> IO Tree
difference gr (t1:t2:[]) = 
       let d = diff gr (t1,t2) in
         do putStrLn $ "the difference of " ++ show t1 ++ " and " ++ show t2 ++ " is "++ show d 
            return d
difference gr (t1:t2:ts) = 
   let d = diff gr (t1,t2) 
    in  difference gr $ d:ts


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
  v + sum [1 | a <- args t, isHole (top a)]

hole :: Cat -> Symbol
hole ct = Symbol (mkName "*") ([], ct)

isHole :: Symbol -> Bool
isHole (Symbol n ([],c)) = "*" == show n
isHole _ = False 

isHoleCat :: Cat -> Symbol -> Bool
isHoleCat cat (Symbol n ([],c)) = "*" == show n && c == cat
isHoleCat cat _ = False
-------------------------------------------------------------------------------

{-
data Context
  = Context
  { holeCat :: Cat
  , context :: Tree -> Tree
  }

hole :: Cat -> Symbol
hole ct = Symbol (mkName "*") ([],ct)

fill :: Context -> Tree
fill ctx = context ctx (hole (holeCat ctx) `App` [])

instance Show Context where
  show ctx = show (fill ctx)

type Fingerprint = ([[String]],[Bool])

-}

{-
difference :: Grammar -> (Tree, Tree) -> Maybe Ambiguity
difference gr (t1, t2) = 
        if top t1 == top t2 && (and [linearize gr tr1 == linearize gr tr2 | (tr1,tr2) <- zip (args t1) (args t2)])
           then 
             let lAmb = map (difference gr) $ zip (args t1) (args t2)
                 ambTrees = filter (isJust . fst) $ zip lAmb [0..]
                 (Just amb,index) = head ambTrees
                 in 
              if length ambTrees == 0 then Nothing -- no ambiguity, the subtree was the same
                 else if length ambTrees == 1 
                        then return (fst amb, 
                                    (\t -> App {top = top t1, 
                                                args = take (index - 1) (args t1) ++ [(snd amb) t] ++ drop index (args t1)})) 
                        else error $ "more than one ambiguity in ( " ++ show t1 ++ "  ,  " ++ show t2++")" 
         else Nothing   
-}
