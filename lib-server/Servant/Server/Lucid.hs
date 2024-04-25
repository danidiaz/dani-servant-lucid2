{-# LANGUAGE OverloadedStrings #-}

module Servant.Server.Lucid (toHtmlResponse) where

import Lucid (ToHtml (..), renderBS)
import Network.HTTP.Types.Header
import Servant.Server

toHtmlResponse ::
  (ToHtml a) =>
  -- | HTTP response status code
  Int ->
  [Header] ->
  a ->
  ServerError
toHtmlResponse errHTTPCode extraHeaders a =
  ServerError
    { errHTTPCode,
      errReasonPhrase = "",
      errBody = renderBS (toHtml a),
      errHeaders =
        [("Content-Type", "text/html; charset=utf-8")] ++ extraHeaders
    }
