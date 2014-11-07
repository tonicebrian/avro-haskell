module Main where

import qualified Data.Avro as AV

import Test.Framework (defaultMain, testGroup, Test)
import Test.Framework.Providers.QuickCheck2 (testProperty)
import Test.Framework.Providers.HUnit (testCase)

import Test.QuickCheck
import Test.HUnit

import qualified Data.ByteString.Char8 as B
import Data.Aeson
import qualified Data.Text as T

import Data.Avro

tests = [
    testGroup "cases" $ zipWith (testCase . show) [1::Int ..] $
    [ case_parsePrimitiveSchema
    ]
    , testGroup "properties" $ zipWith (testProperty . show) [1::Int ..] $
        [ property prop_theProperty]
    ]

--------------------------------------------------    
-- TODO. Instead of creating the content by hand read it from the files
primitiveSchema = B.pack "bytes"

--------------------------------------------------    
case_parsePrimitiveSchema = assertEqual "Failed to parse the primitive schema" expected obtained
    where
        expected = String $ T.pack "bytes"
        obtained = readAvro primitiveSchema

--------------------------------------------------    
prop_theProperty = True

-- Main program
main = defaultMain tests 

