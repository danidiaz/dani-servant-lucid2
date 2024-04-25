{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import Lucid (Html, ToHtml (..), div_)
import Servant
import Servant.API.ContentTypes.Lucid (HTML)
import Servant.Server.Lucid (htmlResponse, htmlResponse')

type API = "foo" :> Get '[HTML] (Html ())

server :: Server API
server = do
  let response =
        -- this is ambiguous:
        -- htmlResponse' 200 []
        htmlResponse 200 [] $ div_ "foo"
  throwError response

server' :: Server API
server' = do
  let response =
        -- We need the type application
        htmlResponse' @(Html ()) 200 [] $ div_ "foo"
  throwError response

data Foo = Foo

instance ToHtml Foo where
  toHtml Foo = div_ "foo"
  toHtmlRaw Foo = div_ "foo"

serverFoo :: Server API
serverFoo = do
  let response =
        -- No neet for type application here.
        htmlResponse' 200 [] Foo
  throwError response

main :: IO ()
main = pure ()
