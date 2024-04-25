{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE OverloadedStrings #-}

-- | Module copied and adapted from https://hackage.haskell.org/package/servant-lucid-0.9.0.6
--
-- An @HTML@ empty data type with 'Servant.API.MimeRender' instances for
-- any type which is an instance of @lucid2@'s 'Lucid.ToHtml':
--
-- >>> type Example = Get '[HTML] a
--
-- (Here the type @a@ should have a 'Lucid.ToHtml' instance.)
module Servant.API.ContentTypes.Lucid
  ( HTML,
  )
where

import Data.List.NonEmpty qualified as NE
import Data.Typeable (Typeable)
import Lucid (ToHtml (..), renderBS)
import Network.HTTP.Media qualified as M
import Servant.API (Accept (..), MimeRender (..))

data HTML deriving stock (Typeable)

-- | @text/html;charset=utf-8@
instance Accept HTML where
  contentTypes _ =
    "text" M.// "html" M./: ("charset", "utf-8")
      NE.:| ["text" M.// "html"]

instance (ToHtml a) => MimeRender HTML a where
  mimeRender _ = renderBS . toHtml
