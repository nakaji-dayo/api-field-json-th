-- |
--
-- Utils for using aeson's deriveJSON with lens's makeFields

module Data.Aeson.APIFieldJsonTH (
    -- * How to use this library
    -- $use
    deriveApiFieldJSON
    ) where

import Prelude
import Data.Aeson.TH
import qualified Data.Char as C (toLower)
import Language.Haskell.TH (Q, Dec, Name, nameBase)

-- $use
--
-- > data SomeQuery = SomeQuery {
-- >     _someQueryPage :: Int
-- >     , _someQueryText :: String
-- > } deriving (Eq, Show)
-- > makeFields ''SomeQuery
-- > deriveApiFieldJSON ''SomeQuery
--
-- This is compatible with the next json:
--
-- > {"page": 3, "text": "foo"}
--

-- | Derive a JSON instance like 'Control.Lens.TH.makeFields':
--   Drop the type's name prefix from each record labels.
deriveApiFieldJSON :: Name -> Q [Dec]
deriveApiFieldJSON name = deriveJSON defaultOptions { fieldLabelModifier = firstLower . dropPrefix name } name

firstLower :: String -> String
firstLower (x:xs) = C.toLower x : xs
firstLower _ = error "firstLower: Assertion failed: empty string"


dropPrefix :: Name -> String -> String
dropPrefix name =
  drop ((+ 1) $ length $ nameBase name)
