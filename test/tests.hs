{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import Lucid
import Servant
import Servant.API.ContentTypes.Lucid
import Servant.Server.Lucid

type API = "foo" :> Get '[HTML] (Html ())

server :: Server API
server = do
  response <- pure do
    -- this is ambiguous:
    -- htmlResponse 200 [] do
    htmlResponse 200 [] do
      div_ "foo"
  throwError response

server' :: Server API
server' = do
  response <- pure do
    -- We need the type application
    htmlResponse' @(Html ()) 200 [] do
      div_ "foo"
  throwError response

data Foo = Foo

instance ToHtml Foo where
  toHtml Foo = div_ "foo"
  toHtmlRaw Foo = div_ "foo"

serverFoo :: Server API
serverFoo = do
  response <- pure do
    -- No neet for type application here.
    htmlResponse' 200 [] Foo
  throwError response

main :: IO ()
main = pure ()
