{-# LANGUAGE MultiParamTypeClasses #-}

-- | Some useful helper for optparse-applicative library

module Serokell.Util.OptParse
       ( fromStr
       , strArgument
       , strOption
       , fromParsec
       ) where

import           Data.String         (IsString (fromString))
import           Options.Applicative (ArgumentFields, Mod, OptionFields, Parser, ReadM,
                                      argument, eitherReader, option, str)
import           Text.Parsec         (Parsec, parse)

-- | Reader which uses IsString instance for parsing
fromStr :: IsString s => ReadM s
fromStr = fromString <$> str

-- | Parse argument using IsString instance
strArgument :: IsString s => Mod ArgumentFields s -> Parser s
strArgument = argument fromStr

-- | Parse option using IsString instance
strOption :: IsString s => Mod OptionFields s -> Parser s
strOption = option fromStr

fromParsec :: Parsec String () a -> ReadM a
fromParsec parser = eitherReader $ either (Left . show) Right . parse parser "<CLI options>"
