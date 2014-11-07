module Data.Avro.Parser (
    parse
    )
where

import qualified Data.Attoparsec.ByteString as P

avroParser = undefined

parse = P.parseTest avroParser 
