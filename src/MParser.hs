{-# LANGUAGE TemplateHaskell #-}
module MParser where

import Data.Char
import Control.Monad
import Control.Applicative

-- notes
-- say we had
-- let f x = x + 1

{- generate token stream like
  [
   TokenLet,
   TokenSym "f",
   TokenSym "x",
   TokenEq,
   TokenSym "x",
   TokenAdd,
   TokenNum 1
  ]
-}

type Name = String

data Expr
  = Var Name
  | Lit Lit 
  | Op PrimOp [Expr]
  | Let Name [Name] Expr

data Lit = LitInt Int

data PrimOp = Add deriving (Show)

-- let f x = x + 1 parsed into
-- Let "f" ["x"] (Op Add [Var "x", Lit (LitInt 1)])

newtype Parser a = Parser { parse :: String -> [(a, String)] }

-- running the Parser gives me an a (AST) or an error (String)

runParser :: Parser a -> String -> a
runParser m s =
  case parse m s of
    [(res, [])] -> res
    [(_, rs)]   -> error "Parser didn't consume entire input stream."
    _           -> error "Parser error."

item :: Parser Char
item = Parser $ \s ->
  case s of
    [] -> []
    (c : cs) -> [(c, cs)]

bind :: Parser a -> (a -> Parser b) -> Parser b
bind p f = Parser $ \s -> concatMap (\(a, s') -> parse (f a) s') $ parse p s

unit :: a -> Parser a
unit a = Parser (\s -> [(a, s)])



