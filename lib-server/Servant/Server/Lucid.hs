{-# LANGUAGE OverloadedStrings #-}

module Servant.Server.Lucid
  ( htmlResponse,
    htmlResponse',
  )
where

import Lucid (Html, ToHtml (..), renderBS)
import Network.HTTP.Types.Header
import Servant.Server

-- | Build a 'ServerError' with an HTML body.
--
-- Note that 'ServerError's, despite their name, can represent any type of
-- response, including successful ones.
htmlResponse ::
  -- | HTTP response status code
  Int ->
  [Header] ->
  Html () ->
  ServerError
htmlResponse = htmlResponse'

-- | More general version of 'htmlResponse', that can have worse type
-- inference.
htmlResponse' ::
  (ToHtml a) =>
  -- | HTTP response status code
  Int ->
  [Header] ->
  a ->
  ServerError
htmlResponse' errHTTPCode extraHeaders a =
  ServerError
    { errHTTPCode,
      errReasonPhrase = "",
      errBody = renderBS (toHtml a),
      errHeaders =
        [("Content-Type", "text/html;charset=utf-8")] ++ extraHeaders
    }
