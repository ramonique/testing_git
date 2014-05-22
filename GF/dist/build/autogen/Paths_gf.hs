module Paths_gf (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch


version :: Version
version = Version {versionBranch = [3,5,13], versionTags = ["testing"]}
bindir, libdir, datadir, libexecdir :: FilePath

bindir     = "/Users/ramonique/.cabal/bin"
libdir     = "/Users/ramonique/.cabal/lib/gf-3.5.13/ghc-7.6.3"
datadir    = "/Users/ramonique/.cabal/share/gf-3.5.13"
libexecdir = "/Users/ramonique/.cabal/libexec"

getBinDir, getLibDir, getDataDir, getLibexecDir :: IO FilePath
getBinDir = catchIO (getEnv "gf_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "gf_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "gf_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "gf_libexecdir") (\_ -> return libexecdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
