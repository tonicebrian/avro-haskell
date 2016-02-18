module Data.Avro
   (AvroType(..),
       decode)
where

import Data.Avro.Parser

import qualified Data.Attoparsec.ByteString as AB
import Data.ByteString.Char8
import qualified Data.Aeson as AE

decode :: ByteString -> AvroType
decode bs = case parse bs of
                AB.Done i theValue -> theValue
                AB.Partial f -> let AB.Done i theValue = f $ pack ""
                               in theValue
                AB.Fail i xs s -> undefined
