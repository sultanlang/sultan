
(* The type of tokens. *)

type token = 
  | VOID of (string)
  | TokenWith
  | TokenUnderscore
  | TokenTry
  | TokenTo
  | TokenReturn
  | TokenPrintOutput
  | TokenPrintInput
  | TokenPrint
  | TokenPipe
  | TokenOpenParenthesis
  | TokenOpenBracket
  | TokenOpenBrace
  | TokenNot
  | TokenMatch
  | TokenLog
  | TokenLet
  | TokenIn
  | TokenImport
  | TokenIf
  | TokenIdentifier of (string)
  | TokenFrom
  | TokenFor
  | TokenElse
  | TokenDef
  | TokenConst
  | TokenCloseParenthesis
  | TokenCloseBracket
  | TokenCloseBrace
  | TokenCatch
  | TUPLE of (string)
  | TO
  | TIMES
  | StringLiteral of (string)
  | STRING of (string)
  | SEMICOLON
  | PLUS
  | MINUS
  | LIST of (string)
  | LESS
  | IntLiteral of (int)
  | INTEGER of (string)
  | GREATER
  | FloatLiteral of (float)
  | FLOAT of (string)
  | EQUAL
  | EOF
  | DOT
  | DIV
  | DICT of (string)
  | CharLiteral of (char)
  | COMMA
  | COLON
  | CHAR of (string)
  | BoolLiteral of (bool)
  | BOOL of (string)

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val main: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.statement list)
