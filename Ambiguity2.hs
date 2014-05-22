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

  parts []          = (0, error "empty")
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
-- fingerprint types

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

fingerprint :: Grammar -> Context -> Fingerprint
fingerprint gr ctx =
  ( [ filter ("the_" `isPrefixOf`) (words s)
    | s <- ls
    ]
  , [ s1 == s2
    | (s1,s2) <- pairs ls
    ]
  )
 where
  ls = lins gr ctx
 
lins :: Grammar -> Context -> [String]
lins gr ctx = [ linearize gr (context ctx (the `App` [index 0 `App` []]))
              | the <- thes gr (holeCat ctx)
              ]

arbContext :: Grammar -> Gen Context
arbContext gr =
  do t <- arbTree gr (startCat gr)
     arbHole t
 where
  arbHole t@(App f ts) =
    frequency $
    [ (1, return (Context (catOf t) id)) ] ++
    [ (3, do ctx <- arbHole (ts !! i)
             return (Context (holeCat ctx)
                             (\x -> App f ( take i ts
                                         ++ [context ctx x]
                                         ++ drop (i+1) ts))))
    | i <- [0..length ts-1]
    ]

shrinkContext :: Grammar -> Context -> [Context]
shrinkContext gr ctx =
  [ Context (holeCat ctx) (unFill t')
  | t' <- shrinkTree gr (fill ctx)
  , '*' `elem` show t' -- ugly but works
  ]
 where
  unFill (App h []) | h == hole (holeCat ctx) = id
  unFill (App f xs)                           = \x -> App f (map (`unFill` x) xs)

findContexts :: Grammar -> IO [Context]
findContexts gr =
  do writeFile file ""
     find []
 where
  gr' = gr{ symbols = filter (not . isThe) (symbols gr) }
  
  file = "contexts.txt"
  
  find found =
    do ref <- newIORef Nothing
       quickCheckWith stdArgs{ maxSuccess = 1000 } $
         forAllShrink (arbContext gr') (shrinkContext gr') $ \ctx ->
           let fp = fingerprint gr ctx in
             whenFail (writeIORef ref (Just (ctx,fp))) $
               fp `elem` map snd found
       mctx <- readIORef ref
       case mctx of
         Just (ctx,fp) -> do appendFile file $ unlines $
                               [ "+++ " ++ show (holeCat ctx) ++ ": " ++ show ctx
                               ] ++
                               nub
                               [ unwords (clean (holeCat ctx) (words s))
                               | s <- lins gr ctx 
                               ] ++
                               [ "" ]
                             find ((ctx,fp):found)
         Nothing       -> return (map fst found)     

  clean c (w : "0" : s) | pre `isPrefixOf` w =
    ("*[" ++ drop 1 (dropWhile isDigit (drop (length pre) w)) ++ "]") : clean c s
   where
    pre = "the_" ++ show c ++ "_"

  clean c (w : s) = w : clean c s
  clean c []      = []

--------------------------------------------------------------------------------

{-
type Dom a = Int -> (Integer, Integer -> a)

dmap :: (a->b) -> Dom a -> Dom b
dmap f d = \s -> let (n,h) = d s in (n, f . h)

unit :: a -> Dom a
unit x = \s -> if s == 0 then (1,\0 -> x) else (0, error "empty")

pair :: Dom a -> Dom b -> Dom (a,b)
pair dom1 dom2 =
  \s -> parts [ (n1*n2, \i -> (h1 (i `mod` n1), h2 (i `div` n1)))
              | k <- [0..s]
              , let (n1,h1) = dom1 k
                    (n2,h2) = dom2 (s-k)
              ]

parts :: [(Integer, Integer -> a)] -> (Integer, Integer -> a)
parts []          = (0, error "empty")
parts ((n,h):nhs) = (n+n', \i -> if i < n then h i else h' (i-n))
 where
  (n',h') = parts nhs

vec :: [Dom a] -> Dom [a]
vec []     = unit []
vec (d:ds) = dmap (uncurry (:)) (pair d (vec ds))

type Sizes = Cat -> Dom Tree

mkSizes :: Grammar -> Sizes
mkSizes gr = cat
 where
  cats = nub [ x | f <- symbols gr, let (xs,y) = typ f, x <- y:xs ]

  cat     = memoCat (\c -> memoInt (\i -> cat' c i))
  catList = memoCatList (\xs -> memoInt (\i -> vec [cat x | x <- xs] i))

  cat' :: Cat -> Dom Tree
  cat' c s =
    parts [ (App f `dmap` catList xs) (s-1)
          | s > 0
          , f <- symbols gr
          , let (xs,y) = typ f
          , y == c
          ]

  memoInt f = (ys !!)
   where
    ys = map f [0..]

  memoCat f = \c -> head [ y | (c',y) <- table, c == c' ]
   where
    table = [ (c, f c) | c <- cats ]

  memoCatList f = \cs ->
    case cs of
      []    -> fNil
      c:cs' -> fCons c cs'
   where
    fNil  = f []
    fCons = memoCat (\c -> memoCatList (\cs' -> f (c:cs')))
-}

--------------------------------------------------------------------------------
