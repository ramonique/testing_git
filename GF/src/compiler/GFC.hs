module GFC (mainGFC, writePGF) where
-- module Main where

import PGF
--import PGF.CId
import PGF.Data
import PGF.Optimize
import PGF.Binary(putSplitAbs)
import GF.Compile
import GF.Compile.Export

import GF.Grammar.CF ---- should this be on a deeper level? AR 15/10/2008
import GF.Infra.Ident(identS,showIdent)

import GF.Infra.UseIO
import GF.Infra.Option
import GF.Data.ErrM
import GF.System.Directory

import Data.Maybe
import Data.Binary(encode,encodeFile)
import Data.Binary.Put(runPut)
import qualified Data.Map as Map
import qualified Data.ByteString as BSS
import qualified Data.ByteString.Lazy as BSL
import System.FilePath
import System.IO
import Control.Exception(bracket)
import Control.Monad(unless,forM_)

mainGFC :: Options -> [FilePath] -> IO ()
mainGFC opts fs = do
  r <- appIOE (case () of
                 _ | null fs -> fail $ "No input files."
                 _ | all (extensionIs ".cf")  fs -> compileCFFiles opts fs
                 _ | all (\f -> extensionIs ".gf" f || extensionIs ".gfo" f)  fs -> compileSourceFiles opts fs
                 _ | all (extensionIs ".pgf") fs -> unionPGFFiles opts fs
                 _ -> fail $ "Don't know what to do with these input files: " ++ unwords fs)
  case r of
    Ok x    -> return x
    Bad msg -> die $ if flag optVerbosity opts == Normal
                       then ('\n':msg)
                       else msg
 where
   extensionIs ext = (== ext) .  takeExtension

compileSourceFiles :: Options -> [FilePath] -> IOE ()
compileSourceFiles opts fs = 
    do cnc_gr@(cnc,t_src,gr) <- batchCompile opts fs
       unless (flag optStopAfterPhase opts == Compile) $
              do let abs = showIdent (srcAbsName gr cnc)
                     pgfFile = grammarName' opts abs<.>"pgf"
                 t_pgf <- if outputJustPGF opts
                          then maybeIO $ getModificationTime pgfFile
                          else return Nothing
                 if t_pgf >= Just t_src
                   then putIfVerb opts $ pgfFile ++ " is up-to-date."
                   else do pgf <- link opts cnc_gr
                           writePGF opts pgf
                           writeByteCode opts pgf
                           writeOutputs opts pgf

compileCFFiles :: Options -> [FilePath] -> IOE ()
compileCFFiles opts fs = 
    do s  <- liftIO $ fmap unlines $ mapM readFile fs
       let cnc = justModuleName (last fs)
       gr <- compileSourceGrammar opts =<< getCF cnc s
       unless (flag optStopAfterPhase opts == Compile) $
              do pgf <- link opts (identS cnc, (), gr)
                 writePGF opts pgf
                 writeOutputs opts pgf

unionPGFFiles :: Options -> [FilePath] -> IOE ()
unionPGFFiles opts fs =
    if outputJustPGF opts
    then maybe doIt checkFirst (flag optName opts)
    else doIt
  where
    checkFirst name =
      do let pgfFile = name <.> "pgf"
         sourceTime <- liftIO $ maximum `fmap` mapM getModificationTime fs
         targetTime <- maybeIO $ getModificationTime pgfFile
         if targetTime >= Just sourceTime
           then putIfVerb opts $ pgfFile ++ " is up-to-date."
           else doIt

    doIt =
      do pgfs <- mapM readPGFVerbose fs
         let pgf0 = foldl1 unionPGF pgfs
             pgf  = if flag optOptimizePGF opts then optimizePGF pgf0 else pgf0
             pgfFile = grammarName opts pgf <.> "pgf"
         if pgfFile `elem` fs
           then putStrLnE $ "Refusing to overwrite " ++ pgfFile
           else writePGF opts pgf
         writeOutputs opts pgf

    readPGFVerbose f =
        putPointE Normal opts ("Reading " ++ f ++ "...") $ liftIO $ readPGF f

writeOutputs :: Options -> PGF -> IOE ()
writeOutputs opts pgf = do
  sequence_ [writeOutput opts name str 
                 | fmt <- outputFormats opts,
                   (name,str) <- exportPGF opts fmt pgf]

outputFormats opts = [fmt | fmt <- flag optOutputFormats opts, fmt/=FmtByteCode]
outputJustPGF opts = null (flag optOutputFormats opts) && not (flag optSplitPGF opts)

writeByteCode :: Options -> PGF -> IOE ()
writeByteCode opts pgf
  | elem FmtByteCode (flag optOutputFormats opts) =
             let name = fromMaybe (showCId (abstractName pgf)) (flag optName opts)
                 file = name <.> "bc"
                 path = case flag optOutputDir opts of
                          Nothing  -> file
                          Just dir -> dir </> file
             in putPointE Normal opts ("Writing " ++ path ++ "...") $ liftIO $
                   bracket
                      (openFile path WriteMode)
                      (hClose)
                      (\h -> do hSetBinaryMode h True
                                BSL.hPut h (encode addrs)
                                BSS.hPut h (code (abstract pgf)))
  | otherwise = return ()
  where
    addrs = 
      [(id,addr) | (id,(_,_,_,_,addr)) <- Map.toList (funs (abstract pgf))] ++
      [(id,addr) | (id,(_,_,_,addr))     <- Map.toList (cats (abstract pgf))]

writePGF :: Options -> PGF -> IOE ()
writePGF opts pgf
  | flag optSplitPGF opts = do let outfile = grammarName opts pgf <.> "pgf"
                               putPointE Normal opts ("Writing " ++ outfile ++ "...") $ liftIO $ do
                               --encodeFile_ outfile (putSplitAbs pgf)
                                 BSL.writeFile outfile (runPut (putSplitAbs pgf))
                               forM_ (Map.toList (concretes pgf)) $ \cnc -> do
                                 let outfile = showCId (fst cnc) <.> "pgf_c"
                                 putPointE Normal opts ("Writing " ++ outfile ++ "...") $ liftIO $ encodeFile outfile cnc
                               return ()
  | otherwise             = do let outfile = grammarName opts pgf <.> "pgf"
                               putPointE Normal opts ("Writing " ++ outfile ++ "...") $ liftIO $ encodeFile outfile pgf

grammarName :: Options -> PGF -> String
grammarName opts pgf = --fromMaybe (showCId (absname pgf)) (flag optName opts)
                       grammarName' opts (showCId (absname pgf))
grammarName' opts abs = fromMaybe abs (flag optName opts)

writeOutput :: Options -> FilePath-> String -> IOE ()
writeOutput opts file str =
    putPointE Normal opts ("Writing " ++ path ++ "...") $ liftIO $
      writeUTF8File path str
  where
    path = maybe id (</>) (flag optOutputDir opts) file
