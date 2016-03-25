module Paths_mtmc (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/akhilesh/mtmc/.stack-work/install/i386-linux/lts-5.4/7.10.3/bin"
libdir     = "/home/akhilesh/mtmc/.stack-work/install/i386-linux/lts-5.4/7.10.3/lib/i386-linux-ghc-7.10.3/mtmc-0.1.0.0-LXCNpahB9L5Fst83epumkh"
datadir    = "/home/akhilesh/mtmc/.stack-work/install/i386-linux/lts-5.4/7.10.3/share/i386-linux-ghc-7.10.3/mtmc-0.1.0.0"
libexecdir = "/home/akhilesh/mtmc/.stack-work/install/i386-linux/lts-5.4/7.10.3/libexec"
sysconfdir = "/home/akhilesh/mtmc/.stack-work/install/i386-linux/lts-5.4/7.10.3/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "mtmc_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "mtmc_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "mtmc_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "mtmc_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "mtmc_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
