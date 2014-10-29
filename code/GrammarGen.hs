module GrammarGen where

import Data.IORef
import Data.List
import Data.Maybe
import Data.Char
import qualified Data.Set as S
import Test.QuickCheck

import qualified PGF
import PGF( CId, mkCId )

--------------------------------------------------------------------------------
-- grammar types

-- name

type Name = CId
type Cat  = CId

-- tree

data Tree
  = App{ top :: Symbol, args :: [Tree] }
 deriving ( Eq, Ord )

-- symbol

data Symbol
  = Symbol
  { name :: Name
  , typ  :: ([Cat], Cat)
  }
 deriving ( Eq, Ord )

-- grammar

data Grammar
  = Grammar
  { parse     :: String -> [Tree]
  , linearize :: Tree -> String
  , startCat  :: Cat
  , symbols   :: [Symbol]
  , sizes     :: Sizes
  }




--------------------------------------------------------------------------------



-- name

mkName, mkCat :: String -> Name
mkName = mkCId
mkCat  = mkCId


-- tree

instance Show Tree where
  show (App a []) = show a
  show (App f xs) =  show f ++ "(" ++ concat (intersperse "," (map show xs)) ++ ")"


showTree :: Tree -> String
showTree (App a []) = show a
showTree (App f xs) = unwords (show f : map showTreeArg xs)
  where showTreeArg (App a []) = show a
        showTreeArg t = " ( " ++ showTree t ++ " ) "



catOf :: Tree -> Cat
catOf (App f _) = snd (typ f)

-- symbol

instance Show Symbol where
  show f = filter (/= '\'') $ PGF.showCId (name f) 
        -- hack to get rid of index numbers from the_ functions getting converted to char, instead of string - caused by CId, don't know how to fix internally... 


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



typeTree :: Grammar -> PGF.Expr -> Tree 
typeTree gr t = 
    case (PGF.unApp t, PGF.unInt t) of 
       (Just (f,ts), _) -> 
             let symb = head $ filter (\x -> name x == f) $ symbols gr
                in 
                 App symb [typeTree gr t' | t' <- ts]
       (_,      Just i) -> App (index i) []
       _                -> error (PGF.showExpr [] t)
     where 
       Just (f,xs) = PGF.unApp t


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
{-
  catList' [c] s =
    parts [ (n, \i -> [App f (h i)])
          | s > 0 
          , f <- symbols gr
          , let (xs,y) = typ f
          , y == c
          , let (n,h) = catList xs (s-1)
          ]
-}
  catList' [c] s =
    parts [ (n, \i -> [App f (h i)])
          | f <- symbols gr
          , s >= sizeFun f
          , let (xs,y) = typ f
          , y == c
          , let (n,h) = catList xs (s- sizeFun f)
          ]
       where 
         sizeFun f | isThe f       = 0
                   | show f == "0" = 0 
                   | otherwise     = 1  
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
