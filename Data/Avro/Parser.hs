{-# LANGUAGE OverloadedStrings #-}
module Data.Avro.Parser 
   (AvroType(..),
    parse
   )
where

import qualified Data.Attoparsec.ByteString as P
import qualified Data.ByteString.Char8 as B

data AvroType = ANull
              | AInt
              | ABoolean
              | ALong
              | AFloat
              | ADouble
              | ABytes
              | AString
              | ARecord { name :: String }
              deriving (Show,Eq)

primitiveTypes :: [P.Parser AvroType]
primitiveTypes = map f [ "null", "boolean", "int", "long", "float", "double", "bytes", "string"]
    where
        f :: String -> P.Parser AvroType
        f s = do
            ps <- P.string . B.pack $ s
            return (typeRepToType ps)

typeRepToType "null"    = ANull
typeRepToType "boolean" = ABoolean
typeRepToType "int"     = AInt
typeRepToType "long"    = ALong
typeRepToType "float"   = AFloat
typeRepToType "double"  = ADouble
typeRepToType "bytes"   = ABytes
typeRepToType "string"  = AString

avroParser = P.choice primitiveTypes

parse :: B.ByteString -> P.Result AvroType
parse = P.parse avroParser 
