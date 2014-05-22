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

int :: Cat
int = mkCat "Int"

index :: Int -> Symbol
index n = Symbol (mkName (show n)) ([], int)

theMaybe :: Grammar -> Cat -> Int -> Maybe Tree
theMaybe gr c i =
  case findThes (symbols gr) of
    []  -> Nothing
    [f] -> Just (App f [App (index i) []])
    _   -> error ("multiple 'the' functions for category: " ++ show c)
 where
  findThes fs = [ f
                | f <- fs
                , "the_" `isPrefixOf` show f
                , typ f == ([int],c)
                ]

the :: Grammar -> Cat -> Int -> Tree
the gr c i =
  case theMaybe gr c i of
    Nothing -> error ("no 'the' function for category: " ++ show c)
    Just t  -> t

isThe :: Symbol -> Bool
isThe s = "the_" `isPrefixOf` show (name s)

-- grammar

data Grammar
  = Grammar
  { parse     :: String -> [Tree]
  , linearize :: Tree -> String
  , startCat  :: Cat
  , symbols   :: [Symbol]
  }

toGrammar :: PGF.PGF -> Grammar
toGrammar pgf =
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
      [ mkSymbol f
      | f <- PGF.functions pgf
      , Just _ <- [PGF.functionType pgf f]
      ]
  }
 where
  lang  = head $ PGF.languages pgf
  
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

readRamonaGrammar :: FilePath -> FilePath -> IO Grammar
readRamonaGrammar file0 file1 =
  do pgf0 <- PGF.readPGF file0
     pgf1 <- PGF.readPGF file1
     
     let lang0  = head $ PGF.languages pgf0
         start0 = PGF.startCat pgf0
         gr1    = toGrammar pgf1
         nonEs  = nonEmptyCats gr1
     
     let widen = concatMap w where w '(' = " ( "
                                   w ')' = " ) "
                                   w  c  = [c]

     sequence_
       [ putStrLn (show f ++ " : " ++ show xs ++ " -> " ++ show y)
       | f <- symbols gr1
       , let (xs,y) = typ f
       ]
     
     return $ Grammar
       { parse =
           let process  = nubBy (~=)
               t1 ~= t2 = linearize gr1 t1 == linearize gr1 t2
            in
             \s -> process (concatMap (parse gr1 . widen . PGF.showExpr []) (PGF.parse pgf0 lang0 start0 s))

       , linearize =
           \t -> PGF.linearize pgf0 lang0 (fromJust (PGF.readExpr (linearize gr1 t)))

       , startCat =
           startCat gr1
       
       , symbols =
           symbols gr1
       }

nonEmptyCats :: Grammar -> [Cat]
nonEmptyCats gr = fix expand []
 where
  fix f x | x == x'   = x
          | otherwise = fix f x'
         where x' = f x

  expand cs =
    usort
    [ y
    | f <- symbols gr
    , let (xs,y) = typ f 
    , all (`elem` cs) xs
    ]

  usort = map head . group . sort

--------------------------------------------------------------------------------
-- generation and shrinking

arbTree :: Grammar -> Cat -> Gen Tree
arbTree gr cat =
  do mt <- arbMaybeTree gr cat `suchThatMaybe` isJust
     case mt of
       Just (Just t) -> return t
       _             -> error ("category " ++ show cat ++ " seems empty")

arbMaybeTree :: Grammar -> Cat -> Gen (Maybe Tree)
arbMaybeTree gr cat = sized (arb [] cat)
 where
  nonEmpties = int : nonEmptyCats gr
 
  arg forbidden cat n | cat `notElem` nonEmpties =
    return Nothing
 
  arb forbidden cat n =
    possibilities $
    [ (if isThe f then 1 else 2*(1+k),
        do ts <- sequence [ arb forbidden' x n' | x <- xs ]
           return (if all isJust ts
                     then Just (App f (map fromJust ts))
                     else Nothing)
      )
    | f <- symbols gr
    , f `notElem` forbidden 
    , let (xs,y)         = typ f
          k              = length xs
          n' | k <= 1    = n-1
             | otherwise = n `div` k
    , y == cat
    , all (`elem` nonEmpties) xs
    , let forbidden' | n > 0     = []
                     | otherwise = f : forbidden
    ] ++
    [ (1, do return (Just (App (index 0) [])))
    | cat == int
    ]
   where
    possibilities [] =
      do return Nothing
    
    possibilities xs =
      frequency
      [ (fq, do mt <- gen
                case mt of
                  Just t  -> return (Just t)
                  Nothing -> possibilities rest)
      | ((fq,gen),rest) <- select xs
      ]

shrinkTree :: Grammar -> Tree -> [Tree]
shrinkTree gr t@(App f xs) =
  (case shrinkToSubList (catOf t) xs of
    [] -> [ t
          | not (isThe f)
          , Just t <- [theMaybe gr (catOf t) 0]
          ]
    ts -> ts)
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

--------------------------------------------------------------------------------
-- fingerprint types

-- context

data Context t
  = Context
  { holes :: [Cat]
  , ctx   :: [Tree] -> t
  }

instance Show t => Show (Context t) where
  show c = "{" ++ show (fill' c) ++ "}"
   where
    fill' c  = ctx c [ hole a i | (a,i) <- holes c `zip` [1..] ]
    hole c i = App (Symbol (mkName (show c ++ "?")) ([int],c)) [App (index i) []]

fill :: Grammar -> Context t -> t
fill gr c = ctx c [ the gr a i | (a,i) <- holes c `zip` [1..] ]

subst :: (Tree,Tree) -> Tree -> Tree
subst (a,s) t | a == t = s

subst as (App f xs) =
  App f (map (subst as) xs)

-- fingerprint

type Pattern = Tree

data Fingerprint
  = Fingerprint
  { context  :: Context Tree
  , patterns :: [Pattern]
  }
 deriving ( Show )

-- checking if a tree has a certain fingerprint

hasFingerprint :: Grammar -> Fingerprint -> Tree -> Bool
hasFingerprint g fp t =
  or
  [ isLike g c (context fp)
  | c <- matchings g 1 t (patterns fp)
  ]

isLike :: Grammar -> Context Tree -> Context Tree -> Bool
isLike g c1 c2 = trace c1 `S.isSubsetOf` trace c2
 where
  trace c = S.fromList
            [ w
            | let holes (f : ix : ws)
                    | "the_" `isPrefixOf` f && all isDigit ix && ix /= "0" =
                      f : holes ws
                  holes (_ : ws) = holes ws
                  holes []       = []
            , w <- holes (words (linearize g (fill g c)))
            ]

-- matching

matches :: Tree -> Pattern -> Bool
App f [x] `matches` _ | isThe f && show x /= "0" =
  False
 
t@(App f xs) `matches` p@(App g _) | isThe g =
  catOf t == catOf p 
 
App f xs `matches` App g ys | f == g && length xs == length ys =
  and [ x `matches` y | (x,y) <- xs `zip` ys ]

t `matches` App g ys =
  or [ t `matches` y | y <- ys ]

matchings :: Grammar -> Int -> Tree -> [Pattern] -> [Context Tree]
matchings gr i t [] =
  [ Context
    { holes = []
    , ctx   = \_ -> t
    }
  ]
  
matchings gr i t (p:ps) =
  [ Context
    { holes = holes c1 ++ holes c2
    , ctx   = \(z:zs) -> subst (a,z) (ctx c2 zs)
    }
  | c1 <- matchings1 gr t p
  , let a  = the gr (head (holes c1)) i
        t2 = ctx c1 [a]
  , c2 <- matchings gr (i+1) t2 ps
  ]

matchings1 :: Grammar -> Tree -> Pattern -> [Context Tree]
matchings1 gr t@(App f xs) p =
  [ Context
    { holes = [catOf t]
    , ctx   = \[t] -> t
    }
  | Just _ <- [theMaybe gr (catOf t) 0] -- only create a hole if a the_ function exists
  , t `matches` p
  ] ++
  [ Context
    { holes = holes c
    , ctx   = \z -> App f (r (ctx c z))
    }
  | (x,r) <- selections xs
  , c <- matchings1 gr x p
  ]

selections :: [a] -> [(a,a -> [a])]
selections []     = []
selections (x:xs) = (x,(:xs)) : [ (y,\y -> x : r y) | (y,r) <- selections xs ]

select :: [a] -> [(a,[a])]
select []     = []
select (x:xs) = (x,xs) : [ (y,x:ys) | (y,ys) <- select xs ]

-- difference between two trees

diff :: Tree -> Tree -> (Context Tree,[Tree],[Tree])
diff (App f xs) (App g ys) | f == g =
  ( Context
    { holes = holes cs
    , ctx   = \zs -> App f (ctx cs zs)
    }
  , ss
  , ts
  )
 where
  (cs,ss,ts) = diffList xs ys

diff s t =
  ( Context
    { holes = [catOf s]
    , ctx   = \(~[z]) -> z 
    }
  , [s]
  , [t]
  )

diffList :: [Tree] -> [Tree] -> (Context [Tree],[Tree],[Tree])
diffList [] [] =
  (Context [] (\_ -> []), [], [])

diffList (s:ss) (t:ts) =
  ( Context
    { holes = holes c ++ holes cs
    , ctx   = \zs -> ctx c (take k zs) : ctx cs (drop k zs)
    }
  , as ++ vs
  , bs ++ ws
  )
 where
  (c,as,bs)  = diff s t
  (cs,vs,ws) = diffList ss ts
  k          = length (holes c)

--------------------------------------------------------------------------------
-- ambiguity checking

prop_Ambiguities gr fps found =
  forAllShrink (arbTree gr (startCat gr)) (shrinkTree gr) $ \t ->
    let ts = parse gr (linearize gr t) in 
      if null ts then
        whenFail (putStrLn ("No parse: " ++ show (linearize gr t))) $
          False
      else
        case filter new (take 100 ts) of
          t1 : t2 : _ ->
            whenFail (print (linearize gr t)) $
            --whenFail (print ts) $
            whenFail (found t1 t2) $
              property False
      
          _ ->
            --collect (linearize gr t) $
              property True
 where
  new t = all (\fp -> not (hasFingerprint gr fp t)) fps

findAmbiguities :: Grammar -> IO ()
findAmbiguities gr =
  do ref <- newIORef Nothing
     writeFile ambFile ""
  
     let found t1 t2 =
           do appendFile ambFile $ unlines $
                [ "+++ \"" ++ linearize gr t1 ++ "\""
                , "in:  \"" ++ linearize gr (fill gr ctx) ++ "\""
                , "ctx: \"" ++ show ctx ++ "\""
                , "ps1: " ++ show ps1
                , "ps2: " ++ show ps2
                , ""
                ]
              
              writeIORef ref (Just fp)
          where
           (ctx,ps1,ps2) = diff t1 t2
           fp = Fingerprint ctx ps1
           
         loop fps =
           do writeIORef ref Nothing
              quickCheckWith stdArgs{ maxSize = 20, maxSuccess = 100 } (prop_Ambiguities gr fps found)
              mfp <- readIORef ref
              case mfp of
                Nothing -> return ()
                Just fp -> loop (fp:fps)

      in loop []
 where
  ambFile = "ambiguities.txt"
{-
main =
  do gr <- readGrammar "examples/example9/Grammar9.pgf"
     findAmbiguities gr
     
main2 =
  do gr <- readRamonaGrammar "examples/example9/Grammar9.pgf" "examples/example9/Grammar9ConcComp.pgf"
     findAmbiguities gr
-}

main = do args <- getArgs
          case args of
           [f0,f1] -> do gr <- readRamonaGrammar f0 f1
                         findAmbiguities gr
           [f0]    -> do gr <- readGrammar f0
                         findAmbiguities2 gr
           _       -> fail "usage ./Ambiguity _grammar.pgf _compiled_grammar.pgf or ./Ambiguity _grammar.pgf" 

{-
main = do args <- getArgs 
          case args of 
             [f0]    -> 
                do o1 <- readProcess "gf" ["-make","-gen-debug","-gen-gram",f0] []
                   o2 <- readProcess "gf" ["-make",newgram f0] []
                   gr <- readRamonaGrammar (oldpgf f0) (newpgf f0) 
                   findAmbiguities gr
             [f0,f1] ->
                do gr <- readRamonaGrammar f0 f1  
                   findAmbiguities gr
             _       -> fail "usage ./Ambiguity _grammar.pgf _compiled_grammar.pgf or ./Ambiguity _concrete_grammar.gf"

  where newname f0 = (reverse $ drop 3 $ reverse f0) 
        newgram f0 = newname f0 ++ "CompConc.gf"
        newpgf  f0 = newname f0 ++ "Comp.pgf"
        oldpgf f0 =  (reverse $ tail $ dropWhile isLower $ reverse $ newname f0) ++ ".pgf" -- actually not really true, we also need the name of the pgf or to change the name of that pgf that is generated   
-}

--------------------------------------------------------------------------------
-- the new way?

data TreeSet
  = Not [Symbol]
  | Node Symbol [TreeSet]
 deriving ( Eq, Ord )

single :: Tree -> TreeSet
single (App f xs) = Node f (map single xs)

size :: TreeSet -> Int
size (Not fs)    = 1
size (Node _ ts) = 1 + sum (map size ts)

instance Show TreeSet where
  show (Not [])    = "*"
  show (Not xs)    = "*-{" ++ concat (intersperse "," (map show (sort xs))) ++ "}"
  show (Node f []) = show f
  show (Node f ts) = show f ++ "(" ++ concat (intersperse "," (map show ts)) ++ ")"

minus :: TreeSet -> Tree -> [TreeSet]
t `minus` x | x `isIn` t = map head (expand [t] [x])
            | otherwise  = []
            
expand :: [TreeSet] -> [Tree] -> [[TreeSet]]
expand (Node f ts : ss) (App g xs : ys) | f == g =
  map build (expand (ss ++ ts) (ys ++ xs))
 where
  k        = length ss
  build ts = Node f (drop k ts) : take k ts

expand (Not fs : ss) (App g xs : ys) | g `notElem` fs =
  [ Not (g:fs) : ss, Node g [ Not [] | x <- xs ] : ss ]

expand [] [] =
  []

expand ss ys =
  error ("expand " ++ show ss ++ " " ++ show ys)

isIn :: Tree -> TreeSet -> Bool
App f xs `isIn` Not fs    = f `notElem` fs
App f xs `isIn` Node g ts = f == g && and (zipWith isIn xs ts)

isEmpty :: Grammar -> Cat -> TreeSet -> Bool
isEmpty gr c (Not fs)    = null [ f | f <- symbols gr, f `notElem` fs, snd (typ f) == c ]
isEmpty gr c (Node f ts) = or [ isEmpty gr ct t | (ct,t) <- fst (typ f) `zip` ts ]

refine :: Grammar -> (String -> IO ()) -> FilePath -> [TreeSet] -> IO ()
refine gr log file [] =
  do log "--- Done."
  
refine gr log file (t:ts) | size t > 10 = -- whatever
  do log ("--- Too large: " ++ show t)
     refine gr log file ts
  
refine gr log file (t:ts) | isEmpty gr (startCat gr) t =
  do log ("--- Empty: " ++ show t)
     refine gr log file ts
  
refine gr log file (t:ts) = -- whatever
  do ref <- newIORef Nothing
     res <- quickCheckResult (prop_Ambiguous gr ref t)
     case res of
       Success{} ->
         do log ("+++ Ambiguity: " ++ show t)
            ts' <- sample' (resize 0 (arbTreeIn gr (startCat gr) t))
            let examps = nub (map (linearize gr) ts')
            appendFile file (unlines (["+++ " ++ show t]
                                   ++ concat 
                                      [ [ "* " ++ s ] ++
                                        [ "  - " ++ show t | t <- take 3 ts ]
                                      | s <- take 3 examps
                                      , ts@(_ : _ : _) <- [parse gr s]
                                      ]
                                   ++ [""]
                                     ))
            refine gr log file ts
       
       _ {- Failure -} ->
         do mcex <- readIORef ref
            case mcex of
              Just cex ->
                do log ("--- Refining: " ++ show t ++ " -- " ++ show cex ++ " = " ++ show (t `minus` cex))
                   refine gr log file ((t `minus` cex) ++ ts)
              
              Nothing ->
                do log ("*** Discarding: " ++ show t)
                   refine gr log file ts

findAmbiguities2 :: Grammar -> IO ()
findAmbiguities2 gr =
  do writeFile file ""
     refine gr log file [Not []]
 where
  file = "ambiguities2.txt"

  log s =
    do putStrLn s
       --appendFile file (s ++ "\n")

prop_Ambiguous gr ref st =
  forAllShrink (arbTreeIn gr (startCat gr) st) (shrinkTreeIn gr st) $ \t ->
    whenFail (writeIORef ref (Just t)) $
      case parse gr (linearize gr t) of
        []          -> property ()
        t1 : t2 : _ -> property True
        _           -> property False

arbTreeIn :: Grammar -> Cat -> TreeSet -> Gen Tree
arbTreeIn gr c (Not fs) =
  do oneof [ do ts <- sequence [ arbTree gr x | x <- xs ]
                return (App f ts)
           | f <- symbols gr
           , f `notElem` fs
           , let (xs,y) = typ f
           , y == c
           ]

arbTreeIn gr c (Node f ts) =
  do xs <- sequence [ arbTreeIn gr ct t | (ct,t) <- fst (typ f) `zip` ts ]
     return (App f xs)

shrinkTreeIn gr st t =
  [ t' | t' <- shrinkTree gr t, t' `isIn` st ]

--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
