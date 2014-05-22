module GF.Text.Lexing (stringOp,opInEnv) where

import GF.Text.Transliterations

import Data.Char
import Data.List (intersperse)

-- lexers and unlexers - they work on space-separated word strings

stringOp :: String -> Maybe (String -> String)
stringOp name = case name of
  "chars"      -> Just $ appLexer (filter (not . all isSpace) . map return)
  "lextext"    -> Just $ appLexer lexText
  "lexcode"    -> Just $ appLexer lexCode
  "lexmixed"   -> Just $ appLexer lexMixed
  "words"      -> Just $ appLexer words
  "bind"       -> Just $ appUnlexer bindTok
  "unchars"    -> Just $ appUnlexer concat
  "unlextext"  -> Just $ capitInit . appUnlexer (unlexText . unquote)
  "unlexcode"  -> Just $ appUnlexer unlexCode
  "unlexmixed" -> Just $ capitInit . appUnlexer (unlexMixed . unquote)
  "unwords"    -> Just $ appUnlexer unwords
  "to_html"    -> Just wrapHTML
  _ -> transliterate name

-- perform op in environments beg--end, t.ex. between "--"
--- suboptimal implementation
opInEnv :: String -> String -> (String -> String) -> (String -> String)
opInEnv beg end op = concat . altern False . chop (lbeg, beg) [] where
  chop mk@(lg, mark) s0 s = 
    let (tag,rest) = splitAt lg s in
    if tag==mark then (reverse s0) : mark : chop (switch mk) [] rest 
      else case s of
        c:cs -> chop mk (c:s0) cs
        [] -> [reverse s0]
  switch (lg,mark) = if mark==beg then (lend,end) else (lbeg,beg)
  (lbeg,lend) = (length beg, length end)
  altern m ts = case ts of
    t:ws | not m && t==beg -> t : altern True ws
    t:ws | m     && t==end -> t : altern False ws
    t:ws -> (if m then op t else t) : altern m ws
    [] -> []

appLexer :: (String -> [String]) -> String -> String
appLexer f = unwords . filter (not . null) . f

appUnlexer :: ([String] -> String) -> String -> String
----appUnlexer f = unlines . map (f . words) . lines
appUnlexer f = f . words

wrapHTML :: String -> String
wrapHTML = unlines . tag . intersperse "<br>" . lines where
  tag ss = "<html>":"<head>":"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />":"</head>":"<body>" : ss ++ ["</body>","</html>"]

lexText :: String -> [String]
lexText = uncap . lext where
  lext s = case s of
    c:cs | isMajorPunct c -> [c] : uncap (lext cs)
    c:cs | isMinorPunct c -> [c] : lext cs
    c:cs | isSpace c ->       lext cs
    _:_ -> let (w,cs) = break (\x -> isSpace x || isPunct x) s in w : lext cs
    _ -> [s]
  uncap s = case s of
    (c:cs):ws -> (toLower c : cs):ws
    _ -> s

-- | Haskell lexer, usable for much code
lexCode :: String -> [String]
lexCode ss = case lex ss of
  [(w@(_:_),ws)] -> w : lexCode ws
  _ -> []

-- | LaTeX style lexer, with "math" environment using Code between $...$
lexMixed :: String -> [String]
lexMixed = concat . alternate False where
  alternate env s = case s of
    _:_ -> case break (=='$') s of
      (t,[])  -> lex env t : []
      (t,c:m) -> lex env t : [[c]] : alternate (not env) m
    _ -> []
  lex env = if env then lexCode else lexText

bindTok :: [String] -> String
bindTok ws = case ws of
    w:"&+":ws2 -> w ++ bindTok ws2
    w:[]       -> w
    w:ws2      -> w ++ " " ++ bindTok ws2
    []         -> ""

unlexText :: [String] -> String
unlexText = unlext where
  unlext s = case s of
    w:[] -> w
    w:[c]:[] | isPunct c -> w ++ [c]
    w:[c]:cs | isMajorPunct c -> w ++ [c] ++ " " ++ capitInit (unlext cs)
    w:[c]:cs | isMinorPunct c -> w ++ [c] ++ " " ++ unlext cs
    w:ws -> w ++ " " ++ unlext ws
    _ -> []

-- capitalize first letter
capitInit s = case s of
  c:cs -> toUpper c : cs
  _ -> s

-- unquote each string of form "foo"
unquote = map unq where 
  unq s = case s of
    '"':cs@(_:_) | last cs == '"' -> init cs
    _ -> s

unlexCode :: [String] -> String
unlexCode s = case s of
  w:[] -> w
  [c]:cs | isParen c -> [c] ++ unlexCode cs
  w:cs@([c]:_) | isClosing c -> w ++ unlexCode cs
  w:ws -> w ++ " " ++ unlexCode ws
  _ -> []


unlexMixed :: [String] -> String
unlexMixed = concat . alternate False where
  alternate env s = case s of
    _:_ -> case break (=="$") s of
      (t,[])  -> unlex env t : []
      (t,c:m) -> unlex env t : sep env c : alternate (not env) m
    _ -> []
  unlex env = if env then unlexCode else unlexText
  sep env c = if env then c ++ " " else " " ++ c

isPunct = flip elem ".?!,:;"
isMajorPunct = flip elem ".?!"
isMinorPunct = flip elem ",:;"
isParen = flip elem "()[]{}"
isClosing = flip elem ")]}"
