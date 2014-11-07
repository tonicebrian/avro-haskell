{-# LANGUAGE OverloadedStrings #-}
module Data.Avro.Parser 
   (parse)
where

import qualified Data.Attoparsec.ByteString as P
import qualified Data.ByteString.Char8 as B
import Data.Aeson as AE
import qualified Data.Text as T

primitiveTypes :: [P.Parser Value]
primitiveTypes = map f [ "null", "boolean", "int", "long", "float", "double", "bytes", "string"]
    where
        f :: String -> P.Parser Value
        f s = (P.string . B.pack $ s) >> return (String $ T.pack s)
                     
avroParser = P.choice primitiveTypes

parse :: B.ByteString -> P.Result Value
parse = P.parse avroParser 
