# dani-servant-lucid2 - Servant support for lucid2

This package provides the `HTML` Servant content type, backed by
[lucid2](https://hackage.haskell.org/package/lucid2)'s `ToHtml` typeclass. 

```
import Servant
import Servant.API.ContentTypes.Lucid ( HTML )
import Lucid ( Html )

type API = "foo" :> Get '[HTML] (Html ())
```

There's also an secondary public library "dani-servant-lucid2:server" with a few
functions for constructing `ServerError`s with HTML bodies:


```
import Servant.Server.Lucid (htmlResponse, htmlResponse')

server :: Server API
server = do
  let response =
        htmlResponse 200 [] $ div_ "foo"
  throwError response

data Foo = Foo

instance ToHtml Foo where
  toHtml Foo = div_ "foo"
  toHtmlRaw Foo = div_ "foo"

serverFoo :: Server API
serverFoo = do
  let response =
        htmlResponse' 200 [] Foo
  throwError response
```

This package is a version of
[servant-lucid](https://hackage.haskell.org/package/servant-lucid) modified to
work with [lucid2](https://hackage.haskell.org/package/lucid2), and with some
further changes. The "dani-" prefix is to avoid squatting on the
"servant-lucid2" name, in case an "official" package appears.