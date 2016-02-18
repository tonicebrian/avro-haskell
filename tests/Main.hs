module Main where

import qualified Data.Avro as AV

import Test.Framework (defaultMain, testGroup, Test)
import Test.Framework.Providers.QuickCheck2 (testProperty)
import Test.Framework.Providers.HUnit (testCase)

import Test.QuickCheck
import Test.HUnit

import qualified Data.ByteString.Char8 as B
import qualified Data.Aeson as AE
import qualified Data.Text as T

import Data.Avro

tests = [
    testGroup "cases" $ zipWith (testCase . show) [1::Int ..] $
    [ case_parsePrimitiveSchema
      , case_readSimpleAvro
    ]
    , testGroup "properties" $ zipWith (testProperty . show) [1::Int ..] $
        [ property prop_theProperty]
    ]

--------------------------------------------------    
case_parsePrimitiveSchema = assertEqual "Failed to parse the primitive schema" expected obtained
    where
        expected = ABytes
        obtained = decode $ B.pack "bytes"

--------------------------------------------------    
case_readSimpleAvro = assertEqual "Failed reading data from file" expected obtained
    where
        expected = AvroFile AInt [1,2,3]
        obtained = undefined
--------------------------------------------------    
-- objectSchema = B.pack "{\"type\":\"record\",\"name\":\"myRecord\"}"
-- 
-- case_parseJsonObject = assertEqual "Failed to parse the Json object schema definition" expected obtained
--     where
--         expected = ARecord "myRecord"
--         obtained = decode objectSchema
--------------------------------------------------    
prop_theProperty = True

-- Main program
main = defaultMain tests 

