module Library where

import System.Environment (getArgs)
import Control.Concurrent (forkIO)
import Network (listenOn, accept, PortID(PortNumber), Socket)
import System.IO (hSetBuffering, hGetLine, hPutStrLn, BufferMode(NoBuffering), Handle)

myFunc :: Int -> Int
myFunc x = x

run :: IO ()
run = do
  args <- getArgs
  let port = fromIntegral (read $ head args :: Int)
  socket <- listenOn $ PortNumber port
  sockHandler socket

sockHandler :: Socket -> IO ()
sockHandler socket = do
  (handle, _, _) <- accept socket
  hSetBuffering handle NoBuffering
  _ <- ($) forkIO $ hEcho handle
  sockHandler socket

hEcho :: Handle -> IO ()
hEcho handle = do
  line <- hGetLine handle
  hPutStrLn handle line
  hEcho handle
