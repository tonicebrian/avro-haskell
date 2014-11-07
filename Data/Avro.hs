module Data.Avro
   (readAvro)
where

import Data.Avro.Parser

import qualified Data.Attoparsec.ByteString as AB
import Data.ByteString.Char8
import Data.Aeson

readAvro :: ByteString -> Value
readAvro bs = case parse bs of
                AB.Done i theValue -> theValue
                AB.Partial f -> let AB.Done i theValue = f $ pack ""
                               in theValue
                AB.Fail i xs s -> undefined
