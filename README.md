# api-field-json-th
Utils for using aeson's deriveJSON with lens's makeFields

[![Hackage](https://budueba.com/hackage/api-field-json-th)](https://hackage.haskell.org/package/api-field-json-th)

## example

```
data SomeQuery = SomeQuery {
    _someQueryPage :: Int
    , _someQueryText :: String
} deriving (Eq, Show)
makeFields ''SomeQuery
deriveApiFieldJSON ''SomeQuery
```

This is compatible with the next json

```
{"page": 3, "text": "foo"}
```

(And, it is lens field)
```
x ^. page
```
