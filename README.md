# dani-servant-lucid2 - Servant support for lucid2

Provides the `HTML` Servant content type, backed by
[lucid2](https://hackage.haskell.org/package/lucid2)'s `ToHtml` typeclass. 

This package is a version of
[servant-lucid](https://hackage.haskell.org/package/servant-lucid) modified to
work with [lucid2](https://hackage.haskell.org/package/lucid2), and with some
further changes. The "dani-" prefix is to avoid squatting on the
"servant-lucid2" name, in case an "official" package appears.