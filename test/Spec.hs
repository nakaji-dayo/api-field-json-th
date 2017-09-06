{-# LANGUAGE TemplateHaskell, OverloadedStrings, MultiParamTypeClasses, FunctionalDependencies, TypeSynonymInstances, FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-unused-top-binds #-}
import Data.Aeson.APIFieldJsonTH
import Test.HUnit
import Data.Aeson
import Control.Lens

data SomeQuery = SomeQuery {
    _someQueryPage :: Int
    , _someQueryText :: String
} deriving (Eq, Show)
makeFields ''SomeQuery
deriveApiFieldJSON ''SomeQuery

fromJson :: Test
fromJson = "fromJson example" ~: dec ~?= (Just $ SomeQuery 1 "hoge")
  where dec = decode "{\"page\": 1, \"text\": \"hoge\"}"

lensExample :: Test
lensExample = "lens makeFields example" ~: (r ^. page) ~?= 3
  where r = SomeQuery 3 "hoge"

main :: IO Counts
main = runTestTT $ TestList [fromJson, lensExample]
