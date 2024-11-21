
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | VOID of (
# 25 "sparser.mly"
       (string)
# 15 "sparser.ml"
  )
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
    | TokenIdentifier of (
# 29 "sparser.mly"
       (string)
# 39 "sparser.ml"
  )
    | TokenFrom
    | TokenFor
    | TokenElse
    | TokenDef
    | TokenConst
    | TokenCloseParenthesis
    | TokenCloseBracket
    | TokenCloseBrace
    | TokenCatch
    | TUPLE of (
# 28 "sparser.mly"
       (string)
# 53 "sparser.ml"
  )
    | TO
    | TIMES
    | StringLiteral of (
# 17 "sparser.mly"
       (string)
# 60 "sparser.ml"
  )
    | STRING of (
# 22 "sparser.mly"
       (string)
# 65 "sparser.ml"
  )
    | SEMICOLON
    | PLUS
    | MINUS
    | LIST of (
# 26 "sparser.mly"
       (string)
# 73 "sparser.ml"
  )
    | LESS
    | IntLiteral of (
# 15 "sparser.mly"
       (int)
# 79 "sparser.ml"
  )
    | INTEGER of (
# 20 "sparser.mly"
       (string)
# 84 "sparser.ml"
  )
    | GREATER
    | FloatLiteral of (
# 16 "sparser.mly"
       (float)
# 90 "sparser.ml"
  )
    | FLOAT of (
# 21 "sparser.mly"
       (string)
# 95 "sparser.ml"
  )
    | EQUAL
    | EOF
    | DOT
    | DIV
    | DICT of (
# 27 "sparser.mly"
       (string)
# 104 "sparser.ml"
  )
    | CharLiteral of (
# 19 "sparser.mly"
       (char)
# 109 "sparser.ml"
  )
    | COMMA
    | COLON
    | CHAR of (
# 24 "sparser.mly"
       (string)
# 116 "sparser.ml"
  )
    | BoolLiteral of (
# 18 "sparser.mly"
       (bool)
# 121 "sparser.ml"
  )
    | BOOL of (
# 23 "sparser.mly"
       (string)
# 126 "sparser.ml"
  )
  
end

include MenhirBasics

# 2 "sparser.mly"
  
open Ast
open Binding
open Symboltable
open Printf
open Error
open Errorlog  (* Import the error logging module *)
open Import_detection

let debug msg = print_info "DEBUG" msg


# 146 "sparser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState000 : ('s, _menhir_box_main) _menhir_state
    (** State 000.
        Stack shape : .
        Start symbol: main. *)

  | MenhirState002 : (('s, _menhir_box_main) _menhir_cell1_TokenTry, _menhir_box_main) _menhir_state
    (** State 002.
        Stack shape : TokenTry.
        Start symbol: main. *)

  | MenhirState003 : (('s, _menhir_box_main) _menhir_cell1_TokenReturn, _menhir_box_main) _menhir_state
    (** State 003.
        Stack shape : TokenReturn.
        Start symbol: main. *)

  | MenhirState004 : (('s, _menhir_box_main) _menhir_cell1_TokenOpenParenthesis, _menhir_box_main) _menhir_state
    (** State 004.
        Stack shape : TokenOpenParenthesis.
        Start symbol: main. *)

  | MenhirState005 : (('s, _menhir_box_main) _menhir_cell1_TokenOpenBracket, _menhir_box_main) _menhir_state
    (** State 005.
        Stack shape : TokenOpenBracket.
        Start symbol: main. *)

  | MenhirState006 : (('s, _menhir_box_main) _menhir_cell1_TokenNot, _menhir_box_main) _menhir_state
    (** State 006.
        Stack shape : TokenNot.
        Start symbol: main. *)

  | MenhirState009 : (('s, _menhir_box_main) _menhir_cell1_MINUS, _menhir_box_main) _menhir_state
    (** State 009.
        Stack shape : MINUS.
        Start symbol: main. *)

  | MenhirState021 : (('s, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_state
    (** State 021.
        Stack shape : expression.
        Start symbol: main. *)

  | MenhirState024 : (('s, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_state
    (** State 024.
        Stack shape : expression.
        Start symbol: main. *)

  | MenhirState026 : (('s, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_state
    (** State 026.
        Stack shape : expression.
        Start symbol: main. *)

  | MenhirState028 : (('s, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_state
    (** State 028.
        Stack shape : expression.
        Start symbol: main. *)

  | MenhirState030 : (('s, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_state
    (** State 030.
        Stack shape : expression.
        Start symbol: main. *)

  | MenhirState032 : (('s, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_state
    (** State 032.
        Stack shape : expression.
        Start symbol: main. *)

  | MenhirState034 : (('s, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_state
    (** State 034.
        Stack shape : expression.
        Start symbol: main. *)

  | MenhirState036 : (('s, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_state
    (** State 036.
        Stack shape : expression.
        Start symbol: main. *)

  | MenhirState038 : (('s, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_state
    (** State 038.
        Stack shape : expression.
        Start symbol: main. *)

  | MenhirState041 : ((('s, _menhir_box_main) _menhir_cell1_TokenNot, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_state
    (** State 041.
        Stack shape : TokenNot expression.
        Start symbol: main. *)

  | MenhirState046 : (('s, _menhir_box_main) _menhir_cell1_expression_list, _menhir_box_main) _menhir_state
    (** State 046.
        Stack shape : expression_list.
        Start symbol: main. *)

  | MenhirState056 : (('s, _menhir_box_main) _menhir_cell1_TokenPrint, _menhir_box_main) _menhir_state
    (** State 056.
        Stack shape : TokenPrint.
        Start symbol: main. *)

  | MenhirState068 : (('s, _menhir_box_main) _menhir_cell1_TokenPrint, _menhir_box_main) _menhir_state
    (** State 068.
        Stack shape : TokenPrint.
        Start symbol: main. *)

  | MenhirState072 : ((('s, _menhir_box_main) _menhir_cell1_TokenPrint, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_state
    (** State 072.
        Stack shape : TokenPrint expression.
        Start symbol: main. *)

  | MenhirState077 : (('s, _menhir_box_main) _menhir_cell1_TokenPrint, _menhir_box_main) _menhir_state
    (** State 077.
        Stack shape : TokenPrint.
        Start symbol: main. *)

  | MenhirState081 : (('s, _menhir_box_main) _menhir_cell1_TokenMatch, _menhir_box_main) _menhir_state
    (** State 081.
        Stack shape : TokenMatch.
        Start symbol: main. *)

  | MenhirState083 : ((('s, _menhir_box_main) _menhir_cell1_TokenMatch, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_state
    (** State 083.
        Stack shape : TokenMatch expression.
        Start symbol: main. *)

  | MenhirState084 : (((('s, _menhir_box_main) _menhir_cell1_TokenMatch, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_cell1_TokenPipe, _menhir_box_main) _menhir_state
    (** State 084.
        Stack shape : TokenMatch expression TokenPipe.
        Start symbol: main. *)

  | MenhirState086 : ((('s, _menhir_box_main) _menhir_cell1_TokenPipe, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_state
    (** State 086.
        Stack shape : TokenPipe expression.
        Start symbol: main. *)

  | MenhirState087 : (((('s, _menhir_box_main) _menhir_cell1_TokenPipe, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_cell1_GREATER, _menhir_box_main) _menhir_state
    (** State 087.
        Stack shape : TokenPipe expression GREATER.
        Start symbol: main. *)

  | MenhirState088 : ((((('s, _menhir_box_main) _menhir_cell1_TokenPipe, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_cell1_GREATER, _menhir_box_main) _menhir_cell1_TokenOpenBrace, _menhir_box_main) _menhir_state
    (** State 088.
        Stack shape : TokenPipe expression GREATER TokenOpenBrace.
        Start symbol: main. *)

  | MenhirState096 : (('s, _menhir_box_main) _menhir_cell1_TokenLet _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_state
    (** State 096.
        Stack shape : TokenLet TokenIdentifier.
        Start symbol: main. *)

  | MenhirState107 : ((('s, _menhir_box_main) _menhir_cell1_TokenLet _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_cell1_data_types, _menhir_box_main) _menhir_state
    (** State 107.
        Stack shape : TokenLet TokenIdentifier data_types.
        Start symbol: main. *)

  | MenhirState114 : ((('s, _menhir_box_main) _menhir_cell1_TokenLet _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_cell1_data_types _menhir_cell0_LIST, _menhir_box_main) _menhir_state
    (** State 114.
        Stack shape : TokenLet TokenIdentifier data_types LIST.
        Start symbol: main. *)

  | MenhirState120 : ((('s, _menhir_box_main) _menhir_cell1_TokenLet _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_cell1_data_types _menhir_cell0_LIST, _menhir_box_main) _menhir_state
    (** State 120.
        Stack shape : TokenLet TokenIdentifier data_types LIST.
        Start symbol: main. *)

  | MenhirState125 : ((('s, _menhir_box_main) _menhir_cell1_TokenLet _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_cell1_data_types, _menhir_box_main) _menhir_state
    (** State 125.
        Stack shape : TokenLet TokenIdentifier data_types.
        Start symbol: main. *)

  | MenhirState127 : (('s, _menhir_box_main) _menhir_cell1_TokenIdentifier, _menhir_box_main) _menhir_state
    (** State 127.
        Stack shape : TokenIdentifier.
        Start symbol: main. *)

  | MenhirState134 : (('s, _menhir_box_main) _menhir_cell1_namespaced_identifier, _menhir_box_main) _menhir_state
    (** State 134.
        Stack shape : namespaced_identifier.
        Start symbol: main. *)

  | MenhirState141 : (('s, _menhir_box_main) _menhir_cell1_TokenImport, _menhir_box_main) _menhir_state
    (** State 141.
        Stack shape : TokenImport.
        Start symbol: main. *)

  | MenhirState146 : (('s, _menhir_box_main) _menhir_cell1_TokenIf, _menhir_box_main) _menhir_state
    (** State 146.
        Stack shape : TokenIf.
        Start symbol: main. *)

  | MenhirState149 : ((('s, _menhir_box_main) _menhir_cell1_TokenIf, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_state
    (** State 149.
        Stack shape : TokenIf expression.
        Start symbol: main. *)

  | MenhirState152 : (('s, _menhir_box_main) _menhir_cell1_TokenIdentifier, _menhir_box_main) _menhir_state
    (** State 152.
        Stack shape : TokenIdentifier.
        Start symbol: main. *)

  | MenhirState158 : (('s, _menhir_box_main) _menhir_cell1_TokenFor _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_state
    (** State 158.
        Stack shape : TokenFor TokenIdentifier.
        Start symbol: main. *)

  | MenhirState161 : ((('s, _menhir_box_main) _menhir_cell1_TokenFor _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_state
    (** State 161.
        Stack shape : TokenFor TokenIdentifier expression.
        Start symbol: main. *)

  | MenhirState163 : (('s, _menhir_box_main) _menhir_cell1_TokenElse, _menhir_box_main) _menhir_state
    (** State 163.
        Stack shape : TokenElse.
        Start symbol: main. *)

  | MenhirState166 : (('s, _menhir_box_main) _menhir_cell1_TokenDef _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_state
    (** State 166.
        Stack shape : TokenDef TokenIdentifier.
        Start symbol: main. *)

  | MenhirState168 : (('s, _menhir_box_main) _menhir_cell1_TokenIdentifier, _menhir_box_main) _menhir_state
    (** State 168.
        Stack shape : TokenIdentifier.
        Start symbol: main. *)

  | MenhirState171 : ((('s, _menhir_box_main) _menhir_cell1_TokenIdentifier, _menhir_box_main) _menhir_cell1_data_types, _menhir_box_main) _menhir_state
    (** State 171.
        Stack shape : TokenIdentifier data_types.
        Start symbol: main. *)

  | MenhirState173 : ((('s, _menhir_box_main) _menhir_cell1_TokenIdentifier, _menhir_box_main) _menhir_cell1_data_types, _menhir_box_main) _menhir_state
    (** State 173.
        Stack shape : TokenIdentifier data_types.
        Start symbol: main. *)

  | MenhirState177 : ((('s, _menhir_box_main) _menhir_cell1_TokenDef _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_cell1_TokenCloseParenthesis _menhir_cell0_VOID, _menhir_box_main) _menhir_state
    (** State 177.
        Stack shape : TokenDef TokenIdentifier TokenCloseParenthesis VOID.
        Start symbol: main. *)

  | MenhirState179 : (((('s, _menhir_box_main) _menhir_cell1_TokenDef _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_cell1_TokenCloseParenthesis _menhir_cell0_VOID, _menhir_box_main) _menhir_cell1_statement_list, _menhir_box_main) _menhir_state
    (** State 179.
        Stack shape : TokenDef TokenIdentifier TokenCloseParenthesis VOID statement_list.
        Start symbol: main. *)

  | MenhirState196 : ((('s, _menhir_box_main) _menhir_cell1_TokenDef _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_cell1_TokenCloseParenthesis, _menhir_box_main) _menhir_state
    (** State 196.
        Stack shape : TokenDef TokenIdentifier TokenCloseParenthesis.
        Start symbol: main. *)

  | MenhirState197 : (((('s, _menhir_box_main) _menhir_cell1_TokenDef _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_cell1_TokenCloseParenthesis, _menhir_box_main) _menhir_cell1_statement_list, _menhir_box_main) _menhir_state
    (** State 197.
        Stack shape : TokenDef TokenIdentifier TokenCloseParenthesis statement_list.
        Start symbol: main. *)

  | MenhirState203 : ((('s, _menhir_box_main) _menhir_cell1_TokenDef _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_cell1_parameter_list _menhir_cell0_VOID, _menhir_box_main) _menhir_state
    (** State 203.
        Stack shape : TokenDef TokenIdentifier parameter_list VOID.
        Start symbol: main. *)

  | MenhirState204 : (((('s, _menhir_box_main) _menhir_cell1_TokenDef _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_cell1_parameter_list _menhir_cell0_VOID, _menhir_box_main) _menhir_cell1_statement_list, _menhir_box_main) _menhir_state
    (** State 204.
        Stack shape : TokenDef TokenIdentifier parameter_list VOID statement_list.
        Start symbol: main. *)

  | MenhirState207 : ((('s, _menhir_box_main) _menhir_cell1_TokenDef _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_cell1_parameter_list, _menhir_box_main) _menhir_state
    (** State 207.
        Stack shape : TokenDef TokenIdentifier parameter_list.
        Start symbol: main. *)

  | MenhirState208 : (((('s, _menhir_box_main) _menhir_cell1_TokenDef _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_cell1_parameter_list, _menhir_box_main) _menhir_cell1_statement_list, _menhir_box_main) _menhir_state
    (** State 208.
        Stack shape : TokenDef TokenIdentifier parameter_list statement_list.
        Start symbol: main. *)

  | MenhirState211 : ((('s, _menhir_box_main) _menhir_cell1_TokenDef _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_cell1_parameter_list, _menhir_box_main) _menhir_state
    (** State 211.
        Stack shape : TokenDef TokenIdentifier parameter_list.
        Start symbol: main. *)

  | MenhirState214 : ((('s, _menhir_box_main) _menhir_cell1_TokenElse, _menhir_box_main) _menhir_cell1_statement_list, _menhir_box_main) _menhir_state
    (** State 214.
        Stack shape : TokenElse statement_list.
        Start symbol: main. *)

  | MenhirState217 : (((('s, _menhir_box_main) _menhir_cell1_TokenFor _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_cell1_statement_list, _menhir_box_main) _menhir_state
    (** State 217.
        Stack shape : TokenFor TokenIdentifier expression statement_list.
        Start symbol: main. *)

  | MenhirState220 : ((('s, _menhir_box_main) _menhir_cell1_TokenFor _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_state
    (** State 220.
        Stack shape : TokenFor TokenIdentifier expression.
        Start symbol: main. *)

  | MenhirState222 : (((('s, _menhir_box_main) _menhir_cell1_TokenFor _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_state
    (** State 222.
        Stack shape : TokenFor TokenIdentifier expression expression.
        Start symbol: main. *)

  | MenhirState225 : ((((('s, _menhir_box_main) _menhir_cell1_TokenFor _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_state
    (** State 225.
        Stack shape : TokenFor TokenIdentifier expression expression expression.
        Start symbol: main. *)

  | MenhirState226 : (((((('s, _menhir_box_main) _menhir_cell1_TokenFor _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_cell1_statement_list, _menhir_box_main) _menhir_state
    (** State 226.
        Stack shape : TokenFor TokenIdentifier expression expression expression statement_list.
        Start symbol: main. *)

  | MenhirState229 : (((('s, _menhir_box_main) _menhir_cell1_TokenIf, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_cell1_statement_list, _menhir_box_main) _menhir_state
    (** State 229.
        Stack shape : TokenIf expression statement_list.
        Start symbol: main. *)

  | MenhirState232 : ((((('s, _menhir_box_main) _menhir_cell1_TokenIf, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_cell1_statement_list, _menhir_box_main) _menhir_cell1_TokenCloseBrace, _menhir_box_main) _menhir_state
    (** State 232.
        Stack shape : TokenIf expression statement_list TokenCloseBrace.
        Start symbol: main. *)

  | MenhirState233 : (((((('s, _menhir_box_main) _menhir_cell1_TokenIf, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_cell1_statement_list, _menhir_box_main) _menhir_cell1_TokenCloseBrace, _menhir_box_main) _menhir_cell1_statement_list, _menhir_box_main) _menhir_state
    (** State 233.
        Stack shape : TokenIf expression statement_list TokenCloseBrace statement_list.
        Start symbol: main. *)

  | MenhirState237 : (((((('s, _menhir_box_main) _menhir_cell1_TokenPipe, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_cell1_GREATER, _menhir_box_main) _menhir_cell1_TokenOpenBrace, _menhir_box_main) _menhir_cell1_statement_list, _menhir_box_main) _menhir_state
    (** State 237.
        Stack shape : TokenPipe expression GREATER TokenOpenBrace statement_list.
        Start symbol: main. *)

  | MenhirState239 : ((((('s, _menhir_box_main) _menhir_cell1_TokenPipe, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_cell1_GREATER, _menhir_box_main) _menhir_cell1_statement_list, _menhir_box_main) _menhir_state
    (** State 239.
        Stack shape : TokenPipe expression GREATER statement_list.
        Start symbol: main. *)

  | MenhirState240 : (((('s, _menhir_box_main) _menhir_cell1_TokenMatch, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_cell1_match_cases, _menhir_box_main) _menhir_state
    (** State 240.
        Stack shape : TokenMatch expression match_cases.
        Start symbol: main. *)

  | MenhirState241 : ((((('s, _menhir_box_main) _menhir_cell1_TokenMatch, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_cell1_match_cases, _menhir_box_main) _menhir_cell1_TokenPipe, _menhir_box_main) _menhir_state
    (** State 241.
        Stack shape : TokenMatch expression match_cases TokenPipe.
        Start symbol: main. *)

  | MenhirState252 : ((('s, _menhir_box_main) _menhir_cell1_TokenTry, _menhir_box_main) _menhir_cell1_statement_list, _menhir_box_main) _menhir_state
    (** State 252.
        Stack shape : TokenTry statement_list.
        Start symbol: main. *)

  | MenhirState259 : (((('s, _menhir_box_main) _menhir_cell1_TokenTry, _menhir_box_main) _menhir_cell1_statement_list, _menhir_box_main) _menhir_cell1_TokenCloseBrace _menhir_cell0_error_catcher, _menhir_box_main) _menhir_state
    (** State 259.
        Stack shape : TokenTry statement_list TokenCloseBrace error_catcher.
        Start symbol: main. *)

  | MenhirState260 : ((((('s, _menhir_box_main) _menhir_cell1_TokenTry, _menhir_box_main) _menhir_cell1_statement_list, _menhir_box_main) _menhir_cell1_TokenCloseBrace _menhir_cell0_error_catcher, _menhir_box_main) _menhir_cell1_statement_list, _menhir_box_main) _menhir_state
    (** State 260.
        Stack shape : TokenTry statement_list TokenCloseBrace error_catcher statement_list.
        Start symbol: main. *)

  | MenhirState263 : (('s, _menhir_box_main) _menhir_cell1_statement_list, _menhir_box_main) _menhir_state
    (** State 263.
        Stack shape : statement_list.
        Start symbol: main. *)


and ('s, 'r) _menhir_cell1_data_types = 
  | MenhirCell1_data_types of 's * ('s, 'r) _menhir_state * (Symboltable.Table.key)

and 's _menhir_cell0_error_catcher = 
  | MenhirCell0_error_catcher of 's * (string)

and ('s, 'r) _menhir_cell1_expression = 
  | MenhirCell1_expression of 's * ('s, 'r) _menhir_state * (Ast.expression)

and ('s, 'r) _menhir_cell1_expression_list = 
  | MenhirCell1_expression_list of 's * ('s, 'r) _menhir_state * (Ast.expression list)

and ('s, 'r) _menhir_cell1_match_cases = 
  | MenhirCell1_match_cases of 's * ('s, 'r) _menhir_state * ((Ast.expression * Ast.statement list) list)

and ('s, 'r) _menhir_cell1_namespaced_identifier = 
  | MenhirCell1_namespaced_identifier of 's * ('s, 'r) _menhir_state * (Symboltable.Table.key) * Lexing.position

and ('s, 'r) _menhir_cell1_parameter_list = 
  | MenhirCell1_parameter_list of 's * ('s, 'r) _menhir_state * ((Symboltable.Table.key * Symboltable.Table.key) list)

and ('s, 'r) _menhir_cell1_statement_list = 
  | MenhirCell1_statement_list of 's * ('s, 'r) _menhir_state * (Ast.statement list)

and ('s, 'r) _menhir_cell1_GREATER = 
  | MenhirCell1_GREATER of 's * ('s, 'r) _menhir_state

and 's _menhir_cell0_LIST = 
  | MenhirCell0_LIST of 's * (
# 26 "sparser.mly"
       (string)
# 541 "sparser.ml"
)

and ('s, 'r) _menhir_cell1_MINUS = 
  | MenhirCell1_MINUS of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_TokenCloseBrace = 
  | MenhirCell1_TokenCloseBrace of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_TokenCloseParenthesis = 
  | MenhirCell1_TokenCloseParenthesis of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_TokenDef = 
  | MenhirCell1_TokenDef of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_TokenElse = 
  | MenhirCell1_TokenElse of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_TokenFor = 
  | MenhirCell1_TokenFor of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_TokenIdentifier = 
  | MenhirCell1_TokenIdentifier of 's * ('s, 'r) _menhir_state * (
# 29 "sparser.mly"
       (string)
# 566 "sparser.ml"
) * Lexing.position

and 's _menhir_cell0_TokenIdentifier = 
  | MenhirCell0_TokenIdentifier of 's * (
# 29 "sparser.mly"
       (string)
# 573 "sparser.ml"
) * Lexing.position

and ('s, 'r) _menhir_cell1_TokenIf = 
  | MenhirCell1_TokenIf of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_TokenImport = 
  | MenhirCell1_TokenImport of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_TokenLet = 
  | MenhirCell1_TokenLet of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_TokenMatch = 
  | MenhirCell1_TokenMatch of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_TokenNot = 
  | MenhirCell1_TokenNot of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_TokenOpenBrace = 
  | MenhirCell1_TokenOpenBrace of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_TokenOpenBracket = 
  | MenhirCell1_TokenOpenBracket of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_TokenOpenParenthesis = 
  | MenhirCell1_TokenOpenParenthesis of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_TokenPipe = 
  | MenhirCell1_TokenPipe of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_TokenPrint = 
  | MenhirCell1_TokenPrint of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_TokenReturn = 
  | MenhirCell1_TokenReturn of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_TokenTry = 
  | MenhirCell1_TokenTry of 's * ('s, 'r) _menhir_state

and 's _menhir_cell0_VOID = 
  | MenhirCell0_VOID of 's * (
# 25 "sparser.mly"
       (string)
# 616 "sparser.ml"
)

and _menhir_box_main = 
  | MenhirBox_main of (Ast.statement list) [@@unboxed]

let _menhir_action_01 =
  fun _1 _4 ->
    (
# 308 "sparser.mly"
      ( 
        debug "Parsed an assignment statement"; 
        match Symboltable.get_variable_info _1 with
        | Some info -> 
            if info.is_not_mutable then 
              (* Return an Assignment node with an error if variable is immutable *)
              Assignment (_1, _4, ErrorExpression (Printf.sprintf "Cannot reassign constant variable %s" _1))
            else 
              (* Update the variable's value and return a normal Assignment node *)
              let _ = Symboltable.add_variable _1 (string_of_expr _4) in
              Assignment (_1, _4, ErrorExpression "")  (* No error case *)
        | None -> 
            (* Return an Assignment node with an error if variable is not found *)
            Assignment (_1, _4, ErrorExpression "Variable not found")
      )
# 641 "sparser.ml"
     : (Ast.statement))

let _menhir_action_02 =
  fun _1 ->
    (
# 57 "sparser.mly"
                             ( debug "Parsed a binary program"; _1 )
# 649 "sparser.ml"
     : (Ast.statement list))

let _menhir_action_03 =
  fun _1 ->
    (
# 489 "sparser.mly"
                             ( debug "Parsed an INTEGER type"; _1 )
# 657 "sparser.ml"
     : (Symboltable.Table.key))

let _menhir_action_04 =
  fun _1 ->
    (
# 490 "sparser.mly"
                             ( debug "Parsed a FLOAT type"; _1 )
# 665 "sparser.ml"
     : (Symboltable.Table.key))

let _menhir_action_05 =
  fun _1 ->
    (
# 491 "sparser.mly"
                             ( debug "Parsed a STRING type"; _1 )
# 673 "sparser.ml"
     : (Symboltable.Table.key))

let _menhir_action_06 =
  fun _1 ->
    (
# 492 "sparser.mly"
                             ( debug "Parsed a BOOL type"; _1 )
# 681 "sparser.ml"
     : (Symboltable.Table.key))

let _menhir_action_07 =
  fun _1 ->
    (
# 493 "sparser.mly"
                             ( debug "Parsed a CHAR type"; _1 )
# 689 "sparser.ml"
     : (Symboltable.Table.key))

let _menhir_action_08 =
  fun _1 ->
    (
# 494 "sparser.mly"
                             ( debug "Parsed a VOID type"; _1 )
# 697 "sparser.ml"
     : (Symboltable.Table.key))

let _menhir_action_09 =
  fun _1 ->
    (
# 495 "sparser.mly"
                   ( debug "Parsed a LIST type"; "list<" ^ _1 ^ ">" )
# 705 "sparser.ml"
     : (Symboltable.Table.key))

let _menhir_action_10 =
  fun _2 _4 _7 ->
    (
# 340 "sparser.mly"
    (
      
      debug "Parsed a function definition statement";
      Symboltable.enter_scope ();
      let current_scope = List.hd !Symboltable.scope_stack in 
      let param_list_add = List.map (fun (name, typ) -> (name, typ)) _4 in
      if Symboltable.function_exists _2 then
        Errorlog.log_error ("Function " ^ _2 ^ " already exists") 0 0 None
      else
        Symboltable.add_function _2 true param_list_add 0;  (* Register function with has_return = true *)

      Symboltable.enter_scope ();  (* Enter a new scope for the function *)
      List.iter (fun (name, typ) -> Symboltable.add_variable name typ None true false (List.hd !Symboltable.scope_stack)) param_list_add;  (* Add parameters to the new scope *)
      let body = _7 in
      Symboltable.exit_scope ();  (* Exit the scope after parsing the function body *)

      let param_list = List.map (fun (name, typ) -> (name, Some typ)) _4 in
      FunctionDef (_2, param_list, body)
    )
# 731 "sparser.ml"
     : (Ast.statement))

let _menhir_action_11 =
  fun _2 _4 _8 ->
    (
# 360 "sparser.mly"
    (
      debug "Parsed a function definition statement with parameters and no return value";
      Symboltable.enter_scope ();
      let current_scope = List.hd !Symboltable.scope_stack in
      let param_list_add = List.map (fun (name, typ) -> (name, typ)) _4 in
      if Symboltable.function_exists _2 then
        Errorlog.log_error ("Function " ^ _2 ^ " already exists") 0 0 None
      else
        Symboltable.add_function _2 false param_list_add 0;  (* Register function with has_return = false *)

      Symboltable.enter_scope ();  (* Enter a new scope for the function *)
      List.iter (fun (name, typ) -> Symboltable.add_variable name typ None true false (List.hd !Symboltable.scope_stack)) param_list_add;  (* Add parameters to the new scope *)
      let body = _8 in
      Symboltable.exit_scope ();  (* Exit the scope after parsing the function body *)

      let param_list = List.map (fun (name, typ) -> (name, Some typ)) _4 in
      FunctionDef (_2, param_list, body)
    )
# 756 "sparser.ml"
     : (Ast.statement))

let _menhir_action_12 =
  fun _2 _6 ->
    (
# 379 "sparser.mly"
    (
      debug "Parsed a function definition statement with no parameters and a return value";
      if Symboltable.function_exists _2 then
        Errorlog.log_error ("Function " ^ _2 ^ " already exists") 0 0 None
      else
        Symboltable.add_function _2 true [] 0;  (* Register function with has_return = true *)

      Symboltable.enter_scope ();  (* Enter a new scope for the function *)
      let body = _6 in
      Symboltable.exit_scope ();  (* Exit the scope after parsing the function body *)

      FunctionDef (_2, [], body)
    )
# 776 "sparser.ml"
     : (Ast.statement))

let _menhir_action_13 =
  fun _2 _7 ->
    (
# 393 "sparser.mly"
    (
      debug "Parsed a function definition statement with no parameters and no return value";
      if Symboltable.function_exists _2 then
        Errorlog.log_error ("Function " ^ _2 ^ " already exists") 0 0 None
      else
        Symboltable.add_function _2 false [] 0;  (* Register function with has_return = false *)

      Symboltable.enter_scope ();  (* Enter a new scope for the function *)
      let body = _7 in
      Symboltable.exit_scope ();  (* Exit the scope after parsing the function body *)

      FunctionDef (_2, [], body)
    )
# 796 "sparser.ml"
     : (Ast.statement))

let _menhir_action_14 =
  fun _3 ->
    (
# 485 "sparser.mly"
      ( debug "Parsed an else statement"; Else (_3) )
# 804 "sparser.ml"
     : (Ast.statement))

let _menhir_action_15 =
  fun _3 ->
    (
# 129 "sparser.mly"
      ( debug "Parsed a log statement"; (_3) )
# 812 "sparser.ml"
     : (string))

let _menhir_action_16 =
  fun _1 ->
    (
# 540 "sparser.mly"
                                 ( debug "Parsed an integer literal"; IntLiteral _1 )
# 820 "sparser.ml"
     : (Ast.expression))

let _menhir_action_17 =
  fun _1 _3 ->
    (
# 541 "sparser.mly"
                                      ( debug "Parsed a range"; Range (IntLiteral _1, IntLiteral _3) )
# 828 "sparser.ml"
     : (Ast.expression))

let _menhir_action_18 =
  fun _1 ->
    (
# 542 "sparser.mly"
                                 ( debug "Parsed a float literal"; FloatLiteral _1 )
# 836 "sparser.ml"
     : (Ast.expression))

let _menhir_action_19 =
  fun _1 ->
    (
# 543 "sparser.mly"
                                 ( debug "Parsed a string literal"; StringLiteral _1 )
# 844 "sparser.ml"
     : (Ast.expression))

let _menhir_action_20 =
  fun _1 ->
    (
# 544 "sparser.mly"
                                 ( debug "Parsed a boolean literal"; BoolLiteral _1 )
# 852 "sparser.ml"
     : (Ast.expression))

let _menhir_action_21 =
  fun _1 ->
    (
# 545 "sparser.mly"
                                 ( debug "Parsed a char literal"; CharLiteral _1 )
# 860 "sparser.ml"
     : (Ast.expression))

let _menhir_action_22 =
  fun _1 ->
    (
# 546 "sparser.mly"
                                 ( debug "Parsed an identifier"; Identifier _1 )
# 868 "sparser.ml"
     : (Ast.expression))

let _menhir_action_23 =
  fun () ->
    (
# 547 "sparser.mly"
                                       ( debug "Parsed an empty list"; ListLiteral [] )
# 876 "sparser.ml"
     : (Ast.expression))

let _menhir_action_24 =
  fun _2 ->
    (
# 548 "sparser.mly"
                                                       ( debug "Parsed a non-empty list"; ListLiteral _2 )
# 884 "sparser.ml"
     : (Ast.expression))

let _menhir_action_25 =
  fun _2 ->
    (
# 549 "sparser.mly"
                                                               ( debug "Parsed a tuple"; TupleLiteral _2 )
# 892 "sparser.ml"
     : (Ast.expression))

let _menhir_action_26 =
  fun _2 ->
    (
# 550 "sparser.mly"
                                                          ( debug "Parsed a parenthesized expression"; _2 )
# 900 "sparser.ml"
     : (Ast.expression))

let _menhir_action_27 =
  fun _1 _3 ->
    (
# 551 "sparser.mly"
                            ( debug "Parsed a range"; Range (IntLiteral (int_of_string _1), IntLiteral (int_of_string _3)) )
# 908 "sparser.ml"
     : (Ast.expression))

let _menhir_action_28 =
  fun _1 _3 ->
    (
# 552 "sparser.mly"
                                    ( debug "Parsed a range"; Range (IntLiteral (int_of_string _1), Identifier _3) )
# 916 "sparser.ml"
     : (Ast.expression))

let _menhir_action_29 =
  fun _1 _3 ->
    (
# 553 "sparser.mly"
                                 ( debug "Parsed a plus operation"; Binop (Plus, _1, _3) )
# 924 "sparser.ml"
     : (Ast.expression))

let _menhir_action_30 =
  fun _1 _3 ->
    (
# 554 "sparser.mly"
                                 ( debug "Parsed a minus operation"; Binop (Minus, _1, _3) )
# 932 "sparser.ml"
     : (Ast.expression))

let _menhir_action_31 =
  fun _1 _3 ->
    (
# 555 "sparser.mly"
                                 ( debug "Parsed a times operation"; Binop (Times, _1, _3) )
# 940 "sparser.ml"
     : (Ast.expression))

let _menhir_action_32 =
  fun _1 _3 ->
    (
# 556 "sparser.mly"
                                 ( debug "Parsed a division operation"; Binop (Div, _1, _3) )
# 948 "sparser.ml"
     : (Ast.expression))

let _menhir_action_33 =
  fun _2 ->
    (
# 557 "sparser.mly"
                                  ( debug "Parsed a unary minus operation"; Unop (UMinus, _2) )
# 956 "sparser.ml"
     : (Ast.expression))

let _menhir_action_34 =
  fun _1 _3 ->
    (
# 558 "sparser.mly"
                                 ( debug "Parsed an equality check"; Binop (Equals, _1, _3) )
# 964 "sparser.ml"
     : (Ast.expression))

let _menhir_action_35 =
  fun _1 _3 ->
    (
# 559 "sparser.mly"
                                  ( debug "Parsed a greater than check"; Binop (GreaterThan, _1, _3) )
# 972 "sparser.ml"
     : (Ast.expression))

let _menhir_action_36 =
  fun _1 _3 ->
    (
# 560 "sparser.mly"
                                  ( debug "Parsed a less than check"; Binop (LessThan, _1, _3) )
# 980 "sparser.ml"
     : (Ast.expression))

let _menhir_action_37 =
  fun _2 _4 ->
    (
# 561 "sparser.mly"
                                         ( debug "Parsed a not equal check"; Binop (NotEquals, _2, _4) )
# 988 "sparser.ml"
     : (Ast.expression))

let _menhir_action_38 =
  fun _1 _4 ->
    (
# 562 "sparser.mly"
                                         ( debug "Parsed a not equal check"; Binop (NotEquals, _1, _4) )
# 996 "sparser.ml"
     : (Ast.expression))

let _menhir_action_39 =
  fun _1 _3 ->
    (
# 563 "sparser.mly"
                                  ( debug "Parsed a range"; Range (_1, _3) )
# 1004 "sparser.ml"
     : (Ast.expression))

let _menhir_action_40 =
  fun _1 _3 ->
    (
# 568 "sparser.mly"
                                   ( debug "Parsed an expression list"; _1 @ [_3] )
# 1012 "sparser.ml"
     : (Ast.expression list))

let _menhir_action_41 =
  fun _1 ->
    (
# 569 "sparser.mly"
                                  ( debug "Parsed a single expression"; [_1] )
# 1020 "sparser.ml"
     : (Ast.expression list))

let _menhir_action_42 =
  fun _2 _7 ->
    (
# 103 "sparser.mly"
    (
      if _2 = _7 then (
        debug "Parsed a named final match case";
        Symboltable.enter_scope ();
        let current_scope = List.hd !Symboltable.scope_stack in
        let check_if_exists = Symboltable.get_variable_info _2 in
        match check_if_exists with
        | Some _ -> 
            Errorlog.log_error ("Variable " ^ _2 ^ " already exists") 0 0 None;
            (Identifier _2, [ErrorStatement "Variable already exists"])
        | None ->
          Symboltable.add_error _2 0 0;
          debug ("Added error variable: " ^ _2);
          (Identifier _2, [ErrorStatement _7])
      ) else
        (Identifier _2, [ErrorStatement "The identifier in the log statement must match the pattern identifier"])
    )
# 1044 "sparser.ml"
     : (Ast.expression * Ast.statement list))

let _menhir_action_43 =
  fun _2 _5 _8 ->
    (
# 195 "sparser.mly"
    (
      let var_info = match Symboltable.get_variable_info _2 with
        | Some info -> info
        | None -> 
            (* If the variable is not found, declare it as a new variable *)
            let new_var_info = {
              var_type = "unknown";  (* You can infer the type based on the expression if needed *)
              var_value = None;
              is_mutable = true;
              is_not_mutable = false;
              scope_level = List.hd !Symboltable.scope_stack;
            } in
            Symboltable.add_variable _2 "unknown" None true false (List.hd !Symboltable.scope_stack);
            new_var_info
      in
      debug "Parsed a for range statement";
      ForLoopRange (_2, _5, _8)
    )
# 1069 "sparser.ml"
     : (Ast.statement))

let _menhir_action_44 =
  fun _12 _2 _5 _7 _9 ->
    (
# 214 "sparser.mly"
    (
      let var_info = match Symboltable.get_variable_info _2 with
        | Some info -> info
        | None -> 
            (* If the variable is not found, declare it as a new variable *)
            let new_var_info = {
              var_type = "unknown";  (* You can infer the type based on the expression if needed *)
              var_value = None;
              is_mutable = true;
              is_not_mutable = false;
              scope_level = List.hd !Symboltable.scope_stack;
            } in
            Symboltable.add_variable _2 "unknown" None true false (List.hd !Symboltable.scope_stack);
            new_var_info
      in
      debug "Parsed a classic for statement";
      ForLoopClassic (_2, _5, _7, _9, _12)
    )
# 1094 "sparser.ml"
     : (Ast.statement))

let _menhir_action_45 =
  fun _1 _startpos__1_ ->
    let _startpos = _startpos__1_ in
    (
# 234 "sparser.mly"
    ( 
      debug "Parsed a function call with no arguments";
      match Symboltable.get_function_info _1 with
      | Some func_info -> 
          (* Ensure that the function accepts zero arguments *)
          if func_info.parameters = [] then
            Functioncall (_1, [])
          else (
            let pos = _startpos in
            let history = ["TokenIdentifier"; "TokenOpenParenthesis"; "TokenCloseParenthesis"] in
            Error.report_position_error_with_history ("Function " ^ _1 ^ " expects arguments") pos history;
            ErrorStatement ("Function " ^ _1 ^ " expects arguments")
          )
      | None -> 
          let pos = _startpos in
          let history = ["TokenIdentifier"; "TokenOpenParenthesis"; "TokenCloseParenthesis"] in
          Error.report_position_error_with_history ("Function " ^ _1 ^ " not found in symbol table") pos history;
          ErrorStatement ("Function " ^ _1 ^ " not found in symbol table")
    )
# 1121 "sparser.ml"
     : (Ast.statement))

let _menhir_action_46 =
  fun _1 _3 _startpos__1_ ->
    let _startpos = _startpos__1_ in
    (
# 254 "sparser.mly"
    (
      debug "Parsed a function call with arguments";
      match Symboltable.get_function_info _1 with
      | Some func_info -> 
          (* Check if the number of arguments matches *)
          if List.length func_info.parameters = List.length _3 then (
            (* Register parameters in the correct scope if they do not already exist *)
            List.iter2 (fun (param_name, param_type) arg ->
              let qname = Symboltable.qualified_name param_name in
              if not (Symboltable.Table.mem qname !(Symboltable.type_environment)) then
                Symboltable.add_variable param_name param_type None true false func_info.scope_level
            ) func_info.parameters _3;
            Functioncall (_1, _3)
          ) else (
            let pos = _startpos in
            let history = ["TokenIdentifier"; "TokenOpenParenthesis"; "expression_list"; "TokenCloseParenthesis"] in
            Error.report_position_error_with_history ("Incorrect number of arguments for function " ^ _1) pos history;
            ErrorStatement ("Incorrect number of arguments for function " ^ _1)
          )
      | None -> 
          let pos = _startpos in
          let history = ["TokenIdentifier"; "TokenOpenParenthesis"; "expression_list"; "TokenCloseParenthesis"] in
          Error.report_position_error_with_history ("Function " ^ _1 ^ " not found in symbol table") pos history;
          ErrorStatement ("Function " ^ _1 ^ " not found in symbol table")
    )
# 1154 "sparser.ml"
     : (Ast.statement))

let _menhir_action_47 =
  fun _1 _3 _startpos__1_ ->
    let _startpos = _startpos__1_ in
    (
# 280 "sparser.mly"
    (
      debug "Parsed a function call with arguments";
      match Symboltable.get_function_info _1 with
      | Some func_info -> 
          (* Check if the number of arguments matches *)
          if List.length func_info.parameters = List.length _3 then (
            (* Register parameters in the correct scope if they do not already exist *)
            List.iter2 (fun (param_name, param_type) arg ->
              let qname = Symboltable.qualified_name param_name in
              if not (Symboltable.Table.mem qname !(Symboltable.type_environment)) then
                Symboltable.add_variable param_name param_type None true false func_info.scope_level
            ) func_info.parameters _3;
            Functioncall (_1, _3)
          ) else (
            let pos = _startpos in
            let history = ["namespaced_identifier"; "TokenOpenParenthesis"; "expression_list"; "TokenCloseParenthesis"] in
            Error.report_position_error_with_history ("Incorrect number of arguments for function " ^ _1) pos history;
            ErrorStatement ("Incorrect number of arguments for function " ^ _1)
          )
      | None -> 
          let pos = _startpos in
          let history = ["namespaced_identifier"; "TokenOpenParenthesis"; "expression_list"; "TokenCloseParenthesis"] in
          Error.report_position_error_with_history ("Function " ^ _1 ^ " not found in symbol table") pos history;
          ErrorStatement ("Function " ^ _1 ^ " not found in symbol table")
    )
# 1187 "sparser.ml"
     : (Ast.statement))

let _menhir_action_48 =
  fun _3 _6 ->
    (
# 478 "sparser.mly"
      ( debug "Parsed an if statement"; If (_3, _6) )
# 1195 "sparser.ml"
     : (Ast.statement))

let _menhir_action_49 =
  fun _10 _3 _6 ->
    (
# 480 "sparser.mly"
      ( debug "Parsed an if-else statement"; IfElse (_3, _6, _10) )
# 1203 "sparser.ml"
     : (Ast.statement))

let _menhir_action_50 =
  fun _2 ->
    (
# 176 "sparser.mly"
    (
      debug "Parsed an import statement";
      let module_name = _2 in
      detect_importes := true;
      detected_imports := module_name :: !detected_imports;  (* Add the import to the list *)
      Import (module_name)
    )
# 1217 "sparser.ml"
     : (Ast.statement))

let _menhir_action_51 =
  fun _2 _4 _8 ->
    (
# 427 "sparser.mly"
    ( 
      debug "Parsed a let statement with constant variable";
      (* Add an immutable variable if TokenConst is present *)
      Symboltable.add_constant _2 _4 (Some (string_of_expr _8)) 0;
      debug ("Added constant variable: " ^ _2);
      LetConstBinding (_2, Some (Identifier _4), _8) 
    )
# 1231 "sparser.ml"
     : (Ast.statement))

let _menhir_action_52 =
  fun _2 _4 _7 ->
    (
# 435 "sparser.mly"
    (
      debug "Parsed a let statement with mutable variable";
      (* Add a mutable variable if TokenConst is absent *)
      Symboltable.add_variable _2 _4 (Some (string_of_expr _7)) true false 0;
      debug ("Added mutable variable: " ^ _2);
      LetVarBinding (_2, Some (Identifier _4), _7)
    )
# 1245 "sparser.ml"
     : (Ast.statement))

let _menhir_action_53 =
  fun _2 _4 _9 ->
    (
# 443 "sparser.mly"
    (
      debug "Parsed a let statement with mutable variable and initial list value";
      (* Add a mutable variable with an initial list value *)
      Symboltable.add_variable _2 ("list<" ^ _4 ^ ">") (Some (string_of_expr _9)) true false 0;
      debug ("Added mutable variable: " ^ _2);
      LetListBinding (_2, Some (Identifier _4), _9)
    )
# 1259 "sparser.ml"
     : (Ast.statement))

let _menhir_action_54 =
  fun _10 _2 _4 ->
    (
# 451 "sparser.mly"
    (
      debug "Parsed a let statement with mutable variable and initial list value";
      (* Add a mutable variable with an initial list value *)
      Symboltable.add_variable _2 ("list<" ^ _4 ^ ">") (Some (string_of_expr _10)) true false 0;
      debug ("Added mutable variable: " ^ _2);
      LetListBinding (_2, Some (Identifier _4), _10)
    )
# 1273 "sparser.ml"
     : (Ast.statement))

let _menhir_action_55 =
  fun _2 _4 _7 ->
    (
# 460 "sparser.mly"
      (
        debug "Parsed a let statement with mutable variable and function call";
        (* Add a mutable variable with an initial value from a function call *)
        Symboltable.add_variable _2 _4 None true false 0;
        LetFunctionBinding (_2, [(_4, None)], [_7])
      )
# 1286 "sparser.ml"
     : (Ast.statement))

let _menhir_action_56 =
  fun _3 ->
    (
# 187 "sparser.mly"
      ( debug "Parsed a log statement"; ErrorStatement (_3) )
# 1294 "sparser.ml"
     : (Ast.statement))

let _menhir_action_57 =
  fun _1 ->
    (
# 53 "sparser.mly"
                             ( debug "Parsing completed"; _1 )
# 1302 "sparser.ml"
     : (Ast.statement list))

let _menhir_action_58 =
  fun _2 _5 ->
    (
# 98 "sparser.mly"
                                                      ( debug "Parsed a match case with a single expression"; (_2, _5) )
# 1310 "sparser.ml"
     : (Ast.expression * Ast.statement list))

let _menhir_action_59 =
  fun _2 _6 ->
    (
# 99 "sparser.mly"
                                                                                     ( debug "Parsed a match case with multiple expressions"; (_2, _6) )
# 1318 "sparser.ml"
     : (Ast.expression * Ast.statement list))

let _menhir_action_60 =
  fun _1 _2 ->
    (
# 93 "sparser.mly"
                           ( debug "Parsed a match case"; _1 @ [_2] )
# 1326 "sparser.ml"
     : ((Ast.expression * Ast.statement list) list))

let _menhir_action_61 =
  fun _1 ->
    (
# 94 "sparser.mly"
               ( debug "Parsed a single match case"; [_1] )
# 1334 "sparser.ml"
     : ((Ast.expression * Ast.statement list) list))

let _menhir_action_62 =
  fun _1 _2 ->
    (
# 95 "sparser.mly"
                           ( debug "Parsed a final match case"; _1 @ [_2] )
# 1342 "sparser.ml"
     : ((Ast.expression * Ast.statement list) list))

let _menhir_action_63 =
  fun _2 _4 ->
    (
# 87 "sparser.mly"
    (
      debug "Parsed a match statement";
      Match (_2, _4)
    )
# 1353 "sparser.ml"
     : (Ast.statement))

let _menhir_action_64 =
  fun _1 ->
    (
# 142 "sparser.mly"
  (
    debug "Parsed a namespaced identifier without dot";
    let qualified_name = Symboltable.qualified_name _1 in
    Printf.printf "Checking namespace: %s\n" qualified_name;
    if Symboltable.check_namespace_exists qualified_name then
      qualified_name
    else (
      Errorlog.log_error ("Namespace " ^ qualified_name ^ " not found") 0 0 None;
      qualified_name
    )
  )
# 1371 "sparser.ml"
     : (Symboltable.Table.key))

let _menhir_action_65 =
  fun _1 _3 ->
    (
# 154 "sparser.mly"
  (
    debug "Parsed a namespaced identifier with dot";
    let qualified_name = _1 ^ "::" ^ _3 in
    Printf.printf "Checking namespace: %s\n" qualified_name;
    if Symboltable.check_namespace_exists qualified_name then
      qualified_name
    else (
      Errorlog.log_error ("Namespace " ^ qualified_name ^ " not found") 0 0 None;
      qualified_name
    )
  
  )
# 1390 "sparser.ml"
     : (Symboltable.Table.key))

let _menhir_action_66 =
  fun _1 _3 ->
    (
# 504 "sparser.mly"
                                                                 ( 
      debug "Parsed a constant parameter with type and initial value"; 
      (_1, _3) 
    )
# 1401 "sparser.ml"
     : (Symboltable.Table.key * Symboltable.Table.key))

let _menhir_action_67 =
  fun _1 _3 ->
    (
# 508 "sparser.mly"
                                                ( 
      debug "Parsed a constant parameter with type but no initial value"; 
      (_1, _3) 
    )
# 1412 "sparser.ml"
     : (Symboltable.Table.key * Symboltable.Table.key))

let _menhir_action_68 =
  fun _1 _3 ->
    (
# 512 "sparser.mly"
                                                      ( 
      debug "Parsed a mutable parameter with type and initial value"; 
      (_1, _3) 
    )
# 1423 "sparser.ml"
     : (Symboltable.Table.key * Symboltable.Table.key))

let _menhir_action_69 =
  fun _1 _3 ->
    (
# 516 "sparser.mly"
                                     ( 
      debug "Parsed a mutable parameter with type but no initial value"; 
      (_1, _3) 
    )
# 1434 "sparser.ml"
     : (Symboltable.Table.key * Symboltable.Table.key))

let _menhir_action_70 =
  fun _1 ->
    (
# 522 "sparser.mly"
              ( 
      debug "Parsed a parameter list with one parameter"; 
      [_1] 
    )
# 1445 "sparser.ml"
     : ((Symboltable.Table.key * Symboltable.Table.key) list))

let _menhir_action_71 =
  fun _1 _3 ->
    (
# 526 "sparser.mly"
                                   ( 
      debug "Parsed a parameter list with multiple parameters"; 
      _1 @ [_3] 
    )
# 1456 "sparser.ml"
     : ((Symboltable.Table.key * Symboltable.Table.key) list))

let _menhir_action_72 =
  fun () ->
    (
# 530 "sparser.mly"
    ( 
      debug "Parsed an empty parameter list"; 
      [] 
    )
# 1467 "sparser.ml"
     : ((Symboltable.Table.key * Symboltable.Table.key) list))

let _menhir_action_73 =
  fun _5 ->
    (
# 413 "sparser.mly"
      ( debug "Parsed a print input statement"; PrintInput (_5) )
# 1475 "sparser.ml"
     : (Ast.statement))

let _menhir_action_74 =
  fun _5 ->
    (
# 415 "sparser.mly"
      ( debug "Parsed a print output statement with single argument"; PrintOutputSingle (_5) )
# 1483 "sparser.ml"
     : (Ast.statement))

let _menhir_action_75 =
  fun _5 _7 ->
    (
# 417 "sparser.mly"
      ( debug "Parsed a print output statement with two arguments"; PrintOutputDouble (_5, _7) )
# 1491 "sparser.ml"
     : (Ast.statement))

let _menhir_action_76 =
  fun _3 ->
    (
# 419 "sparser.mly"
      ( debug "Parsed a print statement with multiple arguments"; PrintInput (TupleLiteral _3) )
# 1499 "sparser.ml"
     : (Ast.statement))

let _menhir_action_77 =
  fun _3 ->
    (
# 421 "sparser.mly"
      ( debug "Parsed a print statement with a namespaced identifier"; PrintOutputSingle (Identifier _3) )
# 1507 "sparser.ml"
     : (Ast.statement))

let _menhir_action_78 =
  fun _2 ->
    (
# 325 "sparser.mly"
                                          ( 
      debug "Parsed a return statement with one or more expressions"; 
      if List.length _2 = 1 then 
        Return (List.hd _2) 
      else 
        ReturnMultiple _2 
    )
# 1521 "sparser.ml"
     : (Ast.statement))

let _menhir_action_79 =
  fun _1 ->
    (
# 67 "sparser.mly"
                             ( debug "Parsed a print statement"; _1 )
# 1529 "sparser.ml"
     : (Ast.statement))

let _menhir_action_80 =
  fun _1 ->
    (
# 68 "sparser.mly"
                             ( debug "Parsed a let statement"; _1 )
# 1537 "sparser.ml"
     : (Ast.statement))

let _menhir_action_81 =
  fun _1 ->
    (
# 69 "sparser.mly"
                             ( debug "Parsed an if statement"; _1 )
# 1545 "sparser.ml"
     : (Ast.statement))

let _menhir_action_82 =
  fun _1 ->
    (
# 70 "sparser.mly"
                             ( debug "Parsed an else statement"; _1 )
# 1553 "sparser.ml"
     : (Ast.statement))

let _menhir_action_83 =
  fun _1 ->
    (
# 71 "sparser.mly"
                             ( debug "Parsed a return statement"; _1 )
# 1561 "sparser.ml"
     : (Ast.statement))

let _menhir_action_84 =
  fun _1 ->
    (
# 72 "sparser.mly"
                             ( debug "Parsed a function definition statement"; _1 )
# 1569 "sparser.ml"
     : (Ast.statement))

let _menhir_action_85 =
  fun _1 ->
    (
# 73 "sparser.mly"
                             ( debug "Parsed an assignment statement"; _1 )
# 1577 "sparser.ml"
     : (Ast.statement))

let _menhir_action_86 =
  fun _1 ->
    (
# 74 "sparser.mly"
                             ( debug "Parsed a for statement"; _1 )
# 1585 "sparser.ml"
     : (Ast.statement))

let _menhir_action_87 =
  fun _1 ->
    (
# 75 "sparser.mly"
                             ( debug "Parsed a log statement"; _1 )
# 1593 "sparser.ml"
     : (Ast.statement))

let _menhir_action_88 =
  fun _1 ->
    (
# 76 "sparser.mly"
                             ( debug "Parsed an import statement"; _1 )
# 1601 "sparser.ml"
     : (Ast.statement))

let _menhir_action_89 =
  fun _1 ->
    (
# 77 "sparser.mly"
                             ( debug "Parsed a function call"; _1 )
# 1609 "sparser.ml"
     : (Ast.statement))

let _menhir_action_90 =
  fun _1 ->
    (
# 78 "sparser.mly"
                             ( debug "Parsed a try-catch statement"; _1 )
# 1617 "sparser.ml"
     : (Ast.statement))

let _menhir_action_91 =
  fun _1 ->
    (
# 79 "sparser.mly"
                             ( debug "Parsed a match statement"; _1 )
# 1625 "sparser.ml"
     : (Ast.statement))

let _menhir_action_92 =
  fun _1 _2 ->
    (
# 61 "sparser.mly"
                              ( debug "Parsed a statement list with termination"; _1 @ [_2] )
# 1633 "sparser.ml"
     : (Ast.statement list))

let _menhir_action_93 =
  fun _1 ->
    (
# 62 "sparser.mly"
                              ( debug "Parsed a single statement with termination"; [_1] )
# 1641 "sparser.ml"
     : (Ast.statement list))

let _menhir_action_94 =
  fun () ->
    (
# 63 "sparser.mly"
    ( debug "Parsed an empty statement list"; [] )
# 1649 "sparser.ml"
     : (Ast.statement list))

let _menhir_action_95 =
  fun _3 _5 _7 ->
    (
# 134 "sparser.mly"
    (
      debug "Parsed a try-catch statement";
      TryCatch (_3, _5, _7)
    )
# 1660 "sparser.ml"
     : (Ast.statement))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | BOOL _ ->
        "BOOL"
    | BoolLiteral _ ->
        "BoolLiteral"
    | CHAR _ ->
        "CHAR"
    | COLON ->
        "COLON"
    | COMMA ->
        "COMMA"
    | CharLiteral _ ->
        "CharLiteral"
    | DICT _ ->
        "DICT"
    | DIV ->
        "DIV"
    | DOT ->
        "DOT"
    | EOF ->
        "EOF"
    | EQUAL ->
        "EQUAL"
    | FLOAT _ ->
        "FLOAT"
    | FloatLiteral _ ->
        "FloatLiteral"
    | GREATER ->
        "GREATER"
    | INTEGER _ ->
        "INTEGER"
    | IntLiteral _ ->
        "IntLiteral"
    | LESS ->
        "LESS"
    | LIST _ ->
        "LIST"
    | MINUS ->
        "MINUS"
    | PLUS ->
        "PLUS"
    | SEMICOLON ->
        "SEMICOLON"
    | STRING _ ->
        "STRING"
    | StringLiteral _ ->
        "StringLiteral"
    | TIMES ->
        "TIMES"
    | TO ->
        "TO"
    | TUPLE _ ->
        "TUPLE"
    | TokenCatch ->
        "TokenCatch"
    | TokenCloseBrace ->
        "TokenCloseBrace"
    | TokenCloseBracket ->
        "TokenCloseBracket"
    | TokenCloseParenthesis ->
        "TokenCloseParenthesis"
    | TokenConst ->
        "TokenConst"
    | TokenDef ->
        "TokenDef"
    | TokenElse ->
        "TokenElse"
    | TokenFor ->
        "TokenFor"
    | TokenFrom ->
        "TokenFrom"
    | TokenIdentifier _ ->
        "TokenIdentifier"
    | TokenIf ->
        "TokenIf"
    | TokenImport ->
        "TokenImport"
    | TokenIn ->
        "TokenIn"
    | TokenLet ->
        "TokenLet"
    | TokenLog ->
        "TokenLog"
    | TokenMatch ->
        "TokenMatch"
    | TokenNot ->
        "TokenNot"
    | TokenOpenBrace ->
        "TokenOpenBrace"
    | TokenOpenBracket ->
        "TokenOpenBracket"
    | TokenOpenParenthesis ->
        "TokenOpenParenthesis"
    | TokenPipe ->
        "TokenPipe"
    | TokenPrint ->
        "TokenPrint"
    | TokenPrintInput ->
        "TokenPrintInput"
    | TokenPrintOutput ->
        "TokenPrintOutput"
    | TokenReturn ->
        "TokenReturn"
    | TokenTo ->
        "TokenTo"
    | TokenTry ->
        "TokenTry"
    | TokenUnderscore ->
        "TokenUnderscore"
    | TokenWith ->
        "TokenWith"
    | VOID _ ->
        "VOID"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

let _menhir_discard =
  fun lexer lexbuf ->
    let token = lexer lexbuf in
    Printf.eprintf "Lookahead token is now %s (%d-%d)\n%!" (_menhir_print_token token) lexbuf.Lexing.lex_start_p.Lexing.pos_cnum lexbuf.Lexing.lex_curr_p.Lexing.pos_cnum;
    token

include struct
  
  [@@@ocaml.warning "-4-37"]
  
  let rec _menhir_run_001 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      Printf.eprintf "State 1:\n%!";
      let _menhir_stack = MenhirCell1_TokenTry (_menhir_stack, _menhir_s) in
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TokenOpenBrace ->
          Printf.eprintf "Shifting (TokenOpenBrace) to state 2\n%!";
          Printf.eprintf "State 2:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TokenTry ->
              Printf.eprintf "Shifting (TokenTry) to state 1\n%!";
              _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState002
          | TokenReturn ->
              Printf.eprintf "Shifting (TokenReturn) to state 3\n%!";
              _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState002
          | TokenPrint ->
              Printf.eprintf "Shifting (TokenPrint) to state 55\n%!";
              _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState002
          | TokenMatch ->
              Printf.eprintf "Shifting (TokenMatch) to state 81\n%!";
              _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState002
          | TokenLog ->
              Printf.eprintf "Shifting (TokenLog) to state 89\n%!";
              _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState002
          | TokenLet ->
              Printf.eprintf "Shifting (TokenLet) to state 94\n%!";
              _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState002
          | TokenImport ->
              Printf.eprintf "Shifting (TokenImport) to state 141\n%!";
              _menhir_run_141 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState002
          | TokenIf ->
              Printf.eprintf "Shifting (TokenIf) to state 145\n%!";
              _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState002
          | TokenIdentifier _v ->
              Printf.eprintf "Shifting (TokenIdentifier) to state 150\n%!";
              _menhir_run_150 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState002
          | TokenFor ->
              Printf.eprintf "Shifting (TokenFor) to state 155\n%!";
              _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState002
          | TokenElse ->
              Printf.eprintf "Shifting (TokenElse) to state 162\n%!";
              _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState002
          | TokenDef ->
              Printf.eprintf "Shifting (TokenDef) to state 164\n%!";
              _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState002
          | TokenCloseBrace ->
              Printf.eprintf "Reducing production statement_list ->\n%!";
              let _v = _menhir_action_94 () in
              _menhir_run_252 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState002 _tok
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_003 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      Printf.eprintf "State 3:\n%!";
      let _menhir_stack = MenhirCell1_TokenReturn (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState003 in
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TokenOpenParenthesis ->
          Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenOpenBracket ->
          Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenNot ->
          Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenIdentifier _v ->
          Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | StringLiteral _v ->
          Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MINUS ->
          Printf.eprintf "Shifting (MINUS) to state 9\n%!";
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IntLiteral _v ->
          Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | INTEGER _v ->
          Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FloatLiteral _v ->
          Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CharLiteral _v ->
          Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | BoolLiteral _v ->
          Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_004 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      Printf.eprintf "State 4:\n%!";
      let _menhir_stack = MenhirCell1_TokenOpenParenthesis (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState004 in
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TokenOpenParenthesis ->
          Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenOpenBracket ->
          Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenNot ->
          Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenIdentifier _v ->
          Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | StringLiteral _v ->
          Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MINUS ->
          Printf.eprintf "Shifting (MINUS) to state 9\n%!";
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IntLiteral _v ->
          Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | INTEGER _v ->
          Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FloatLiteral _v ->
          Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CharLiteral _v ->
          Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | BoolLiteral _v ->
          Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_005 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      Printf.eprintf "State 5:\n%!";
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TokenOpenParenthesis ->
          let _menhir_stack = MenhirCell1_TokenOpenBracket (_menhir_stack, _menhir_s) in
          Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState005
      | TokenOpenBracket ->
          let _menhir_stack = MenhirCell1_TokenOpenBracket (_menhir_stack, _menhir_s) in
          Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState005
      | TokenNot ->
          let _menhir_stack = MenhirCell1_TokenOpenBracket (_menhir_stack, _menhir_s) in
          Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState005
      | TokenIdentifier _v ->
          let _menhir_stack = MenhirCell1_TokenOpenBracket (_menhir_stack, _menhir_s) in
          Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState005
      | TokenCloseBracket ->
          Printf.eprintf "Shifting (TokenCloseBracket) to state 43\n%!";
          Printf.eprintf "State 43:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          Printf.eprintf "Reducing production expression -> TokenOpenBracket TokenCloseBracket\n%!";
          let _v = _menhir_action_23 () in
          _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | StringLiteral _v ->
          let _menhir_stack = MenhirCell1_TokenOpenBracket (_menhir_stack, _menhir_s) in
          Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState005
      | MINUS ->
          let _menhir_stack = MenhirCell1_TokenOpenBracket (_menhir_stack, _menhir_s) in
          Printf.eprintf "Shifting (MINUS) to state 9\n%!";
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState005
      | IntLiteral _v ->
          let _menhir_stack = MenhirCell1_TokenOpenBracket (_menhir_stack, _menhir_s) in
          Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState005
      | INTEGER _v ->
          let _menhir_stack = MenhirCell1_TokenOpenBracket (_menhir_stack, _menhir_s) in
          Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState005
      | FloatLiteral _v ->
          let _menhir_stack = MenhirCell1_TokenOpenBracket (_menhir_stack, _menhir_s) in
          Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState005
      | CharLiteral _v ->
          let _menhir_stack = MenhirCell1_TokenOpenBracket (_menhir_stack, _menhir_s) in
          Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState005
      | BoolLiteral _v ->
          let _menhir_stack = MenhirCell1_TokenOpenBracket (_menhir_stack, _menhir_s) in
          Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState005
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_006 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      Printf.eprintf "State 6:\n%!";
      let _menhir_stack = MenhirCell1_TokenNot (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState006 in
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TokenOpenParenthesis ->
          Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenOpenBracket ->
          Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenNot ->
          Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenIdentifier _v ->
          Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | StringLiteral _v ->
          Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MINUS ->
          Printf.eprintf "Shifting (MINUS) to state 9\n%!";
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IntLiteral _v ->
          Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | INTEGER _v ->
          Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FloatLiteral _v ->
          Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CharLiteral _v ->
          Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | BoolLiteral _v ->
          Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_007 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      Printf.eprintf "State 7:\n%!";
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      Printf.eprintf "Reducing production expression -> TokenIdentifier\n%!";
      let _1 = _v in
      let _v = _menhir_action_22 _1 in
      _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_expression : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState222 ->
          _menhir_run_223 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState220 ->
          _menhir_run_221 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState173 ->
          _menhir_run_174 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState171 ->
          _menhir_run_172 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState158 ->
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState152 ->
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState146 ->
          _menhir_run_147 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState125 ->
          _menhir_run_139 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState120 ->
          _menhir_run_121 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState114 ->
          _menhir_run_115 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState107 ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState241 ->
          _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState084 ->
          _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState081 ->
          _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState077 ->
          _menhir_run_078 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState072 ->
          _menhir_run_073 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState068 ->
          _menhir_run_069 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState004 ->
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState134 ->
          _menhir_run_048 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState127 ->
          _menhir_run_048 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState056 ->
          _menhir_run_048 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState003 ->
          _menhir_run_048 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState005 ->
          _menhir_run_048 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState046 ->
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState041 ->
          _menhir_run_042 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState006 ->
          _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState038 ->
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState036 ->
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState086 ->
          _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState034 ->
          _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState032 ->
          _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState030 ->
          _menhir_run_031 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState028 ->
          _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState026 ->
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState024 ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState021 ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState009 ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_223 : type  ttv_stack. ((((ttv_stack, _menhir_box_main) _menhir_cell1_TokenFor _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_cell1_expression as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 223:\n%!";
      let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | TokenTo ->
          Printf.eprintf "Shifting (TokenTo) to state 21\n%!";
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenNot ->
          Printf.eprintf "Shifting (TokenNot) to state 23\n%!";
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenCloseParenthesis ->
          Printf.eprintf "Shifting (TokenCloseParenthesis) to state 224\n%!";
          Printf.eprintf "State 224:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TokenOpenBrace ->
              Printf.eprintf "Shifting (TokenOpenBrace) to state 225\n%!";
              Printf.eprintf "State 225:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | TokenTry ->
                  Printf.eprintf "Shifting (TokenTry) to state 1\n%!";
                  _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState225
              | TokenReturn ->
                  Printf.eprintf "Shifting (TokenReturn) to state 3\n%!";
                  _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState225
              | TokenPrint ->
                  Printf.eprintf "Shifting (TokenPrint) to state 55\n%!";
                  _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState225
              | TokenMatch ->
                  Printf.eprintf "Shifting (TokenMatch) to state 81\n%!";
                  _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState225
              | TokenLog ->
                  Printf.eprintf "Shifting (TokenLog) to state 89\n%!";
                  _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState225
              | TokenLet ->
                  Printf.eprintf "Shifting (TokenLet) to state 94\n%!";
                  _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState225
              | TokenImport ->
                  Printf.eprintf "Shifting (TokenImport) to state 141\n%!";
                  _menhir_run_141 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState225
              | TokenIf ->
                  Printf.eprintf "Shifting (TokenIf) to state 145\n%!";
                  _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState225
              | TokenIdentifier _v_0 ->
                  Printf.eprintf "Shifting (TokenIdentifier) to state 150\n%!";
                  _menhir_run_150 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState225
              | TokenFor ->
                  Printf.eprintf "Shifting (TokenFor) to state 155\n%!";
                  _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState225
              | TokenElse ->
                  Printf.eprintf "Shifting (TokenElse) to state 162\n%!";
                  _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState225
              | TokenDef ->
                  Printf.eprintf "Shifting (TokenDef) to state 164\n%!";
                  _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState225
              | TokenCloseBrace ->
                  Printf.eprintf "Reducing production statement_list ->\n%!";
                  let _v_1 = _menhir_action_94 () in
                  _menhir_run_226 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState225 _tok
              | _ ->
                  Printf.eprintf "Initiating error handling\n%!";
                  _eRR ())
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | TIMES ->
          Printf.eprintf "Shifting (TIMES) to state 26\n%!";
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          Printf.eprintf "Shifting (PLUS) to state 30\n%!";
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          Printf.eprintf "Shifting (MINUS) to state 34\n%!";
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LESS ->
          Printf.eprintf "Shifting (LESS) to state 28\n%!";
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GREATER ->
          Printf.eprintf "Shifting (GREATER) to state 32\n%!";
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQUAL ->
          Printf.eprintf "Shifting (EQUAL) to state 36\n%!";
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          Printf.eprintf "Shifting (DIV) to state 38\n%!";
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_021 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_expression -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      Printf.eprintf "State 21:\n%!";
      let _menhir_s = MenhirState021 in
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TokenOpenParenthesis ->
          Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenOpenBracket ->
          Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenNot ->
          Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenIdentifier _v ->
          Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | StringLiteral _v ->
          Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MINUS ->
          Printf.eprintf "Shifting (MINUS) to state 9\n%!";
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IntLiteral _v ->
          Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | INTEGER _v ->
          Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FloatLiteral _v ->
          Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CharLiteral _v ->
          Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | BoolLiteral _v ->
          Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_008 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      Printf.eprintf "State 8:\n%!";
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      Printf.eprintf "Reducing production expression -> StringLiteral\n%!";
      let _1 = _v in
      let _v = _menhir_action_19 _1 in
      _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_009 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      Printf.eprintf "State 9:\n%!";
      let _menhir_stack = MenhirCell1_MINUS (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState009 in
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TokenOpenParenthesis ->
          Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenOpenBracket ->
          Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenNot ->
          Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenIdentifier _v ->
          Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | StringLiteral _v ->
          Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MINUS ->
          Printf.eprintf "Shifting (MINUS) to state 9\n%!";
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IntLiteral _v ->
          Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | INTEGER _v ->
          Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FloatLiteral _v ->
          Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CharLiteral _v ->
          Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | BoolLiteral _v ->
          Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_010 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      Printf.eprintf "State 10:\n%!";
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TokenTo ->
          Printf.eprintf "Shifting (TokenTo) to state 11\n%!";
          Printf.eprintf "State 11:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IntLiteral _v_0 ->
              Printf.eprintf "Shifting (IntLiteral) to state 12\n%!";
              Printf.eprintf "State 12:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              Printf.eprintf "Reducing production expression -> IntLiteral TokenTo IntLiteral\n%!";
              let (_1, _3) = (_v, _v_0) in
              let _v = _menhir_action_17 _1 _3 in
              _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | COMMA | DIV | EQUAL | GREATER | LESS | MINUS | PLUS | SEMICOLON | TIMES | TokenCloseBracket | TokenCloseParenthesis | TokenNot | TokenWith ->
          Printf.eprintf "Reducing production expression -> IntLiteral\n%!";
          let _1 = _v in
          let _v = _menhir_action_16 _1 in
          _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_013 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      Printf.eprintf "State 13:\n%!";
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TokenTo ->
          Printf.eprintf "Shifting (TokenTo) to state 14\n%!";
          Printf.eprintf "State 14:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TokenIdentifier _v_0 ->
              Printf.eprintf "Shifting (TokenIdentifier) to state 15\n%!";
              Printf.eprintf "State 15:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              Printf.eprintf "Reducing production expression -> INTEGER TokenTo TokenIdentifier\n%!";
              let (_1, _3) = (_v, _v_0) in
              let _v = _menhir_action_28 _1 _3 in
              _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | INTEGER _v_1 ->
              Printf.eprintf "Shifting (INTEGER) to state 16\n%!";
              Printf.eprintf "State 16:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              Printf.eprintf "Reducing production expression -> INTEGER TokenTo INTEGER\n%!";
              let (_1, _3) = (_v, _v_1) in
              let _v = _menhir_action_27 _1 _3 in
              _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_017 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      Printf.eprintf "State 17:\n%!";
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      Printf.eprintf "Reducing production expression -> FloatLiteral\n%!";
      let _1 = _v in
      let _v = _menhir_action_18 _1 in
      _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_018 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      Printf.eprintf "State 18:\n%!";
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      Printf.eprintf "Reducing production expression -> CharLiteral\n%!";
      let _1 = _v in
      let _v = _menhir_action_21 _1 in
      _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_019 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      Printf.eprintf "State 19:\n%!";
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      Printf.eprintf "Reducing production expression -> BoolLiteral\n%!";
      let _1 = _v in
      let _v = _menhir_action_20 _1 in
      _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_023 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_expression -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      Printf.eprintf "State 23:\n%!";
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | EQUAL ->
          Printf.eprintf "Shifting (EQUAL) to state 24\n%!";
          Printf.eprintf "State 24:\n%!";
          let _menhir_s = MenhirState024 in
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TokenOpenParenthesis ->
              Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
              _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TokenOpenBracket ->
              Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TokenNot ->
              Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TokenIdentifier _v ->
              Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | StringLiteral _v ->
              Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | MINUS ->
              Printf.eprintf "Shifting (MINUS) to state 9\n%!";
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IntLiteral _v ->
              Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | INTEGER _v ->
              Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FloatLiteral _v ->
              Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | CharLiteral _v ->
              Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | BoolLiteral _v ->
              Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_055 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      Printf.eprintf "State 55:\n%!";
      let _menhir_stack = MenhirCell1_TokenPrint (_menhir_stack, _menhir_s) in
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TokenOpenParenthesis ->
          Printf.eprintf "Shifting (TokenOpenParenthesis) to state 56\n%!";
          Printf.eprintf "State 56:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TokenOpenParenthesis ->
              Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
              _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState056
          | TokenOpenBracket ->
              Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState056
          | TokenNot ->
              Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState056
          | TokenIdentifier _v ->
              Printf.eprintf "Shifting (TokenIdentifier) to state 57\n%!";
              Printf.eprintf "State 57:\n%!";
              let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | COMMA | DIV | EQUAL | GREATER | LESS | MINUS | PLUS | TIMES | TokenNot | TokenTo ->
                  Printf.eprintf "Reducing production expression -> TokenIdentifier\n%!";
                  let _v =
                    let _1 = _v in
                    _menhir_action_22 _1
                  in
                  _menhir_run_048 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState056 _tok
              | DOT | TokenCloseParenthesis ->
                  Printf.eprintf "Reducing production namespaced_identifier -> TokenIdentifier\n%!";
                  let _v =
                    let _1 = _v in
                    _menhir_action_64 _1
                  in
                  _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v MenhirState056 _tok
              | _ ->
                  Printf.eprintf "Initiating error handling\n%!";
                  _eRR ())
          | StringLiteral _v ->
              Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState056
          | MINUS ->
              Printf.eprintf "Shifting (MINUS) to state 9\n%!";
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState056
          | IntLiteral _v ->
              Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState056
          | INTEGER _v ->
              Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState056
          | FloatLiteral _v ->
              Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState056
          | CharLiteral _v ->
              Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState056
          | BoolLiteral _v ->
              Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState056
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | DOT ->
          Printf.eprintf "Shifting (DOT) to state 66\n%!";
          Printf.eprintf "State 66:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TokenPrintOutput ->
              Printf.eprintf "Shifting (TokenPrintOutput) to state 67\n%!";
              Printf.eprintf "State 67:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | TokenOpenParenthesis ->
                  Printf.eprintf "Shifting (TokenOpenParenthesis) to state 68\n%!";
                  Printf.eprintf "State 68:\n%!";
                  let _menhir_s = MenhirState068 in
                  let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | TokenOpenParenthesis ->
                      Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
                      _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | TokenOpenBracket ->
                      Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
                      _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | TokenNot ->
                      Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
                      _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | TokenIdentifier _v ->
                      Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
                      _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | StringLiteral _v ->
                      Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
                      _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | MINUS ->
                      Printf.eprintf "Shifting (MINUS) to state 9\n%!";
                      _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | IntLiteral _v ->
                      Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
                      _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | INTEGER _v ->
                      Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
                      _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | FloatLiteral _v ->
                      Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
                      _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | CharLiteral _v ->
                      Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
                      _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | BoolLiteral _v ->
                      Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
                      _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | _ ->
                      Printf.eprintf "Initiating error handling\n%!";
                      _eRR ())
              | _ ->
                  Printf.eprintf "Initiating error handling\n%!";
                  _eRR ())
          | TokenPrintInput ->
              Printf.eprintf "Shifting (TokenPrintInput) to state 76\n%!";
              Printf.eprintf "State 76:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | TokenOpenParenthesis ->
                  Printf.eprintf "Shifting (TokenOpenParenthesis) to state 77\n%!";
                  Printf.eprintf "State 77:\n%!";
                  let _menhir_s = MenhirState077 in
                  let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | TokenOpenParenthesis ->
                      Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
                      _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | TokenOpenBracket ->
                      Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
                      _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | TokenNot ->
                      Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
                      _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | TokenIdentifier _v ->
                      Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
                      _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | StringLiteral _v ->
                      Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
                      _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | MINUS ->
                      Printf.eprintf "Shifting (MINUS) to state 9\n%!";
                      _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | IntLiteral _v ->
                      Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
                      _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | INTEGER _v ->
                      Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
                      _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | FloatLiteral _v ->
                      Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
                      _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | CharLiteral _v ->
                      Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
                      _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | BoolLiteral _v ->
                      Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
                      _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | _ ->
                      Printf.eprintf "Initiating error handling\n%!";
                      _eRR ())
              | _ ->
                  Printf.eprintf "Initiating error handling\n%!";
                  _eRR ())
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_048 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 48:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTo ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTo) to state 21\n%!";
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenNot ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenNot) to state 23\n%!";
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TIMES ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TIMES) to state 26\n%!";
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (PLUS) to state 30\n%!";
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (MINUS) to state 34\n%!";
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LESS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (LESS) to state 28\n%!";
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GREATER ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (GREATER) to state 32\n%!";
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQUAL ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (EQUAL) to state 36\n%!";
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (DIV) to state 38\n%!";
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA | SEMICOLON | TokenCloseBracket | TokenCloseParenthesis ->
          Printf.eprintf "Reducing production expression_list -> expression\n%!";
          let _1 = _v in
          let _v = _menhir_action_41 _1 in
          _menhir_goto_expression_list _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_026 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_expression -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      Printf.eprintf "State 26:\n%!";
      let _menhir_s = MenhirState026 in
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TokenOpenParenthesis ->
          Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenOpenBracket ->
          Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenNot ->
          Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenIdentifier _v ->
          Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | StringLiteral _v ->
          Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MINUS ->
          Printf.eprintf "Shifting (MINUS) to state 9\n%!";
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IntLiteral _v ->
          Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | INTEGER _v ->
          Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FloatLiteral _v ->
          Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CharLiteral _v ->
          Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | BoolLiteral _v ->
          Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_030 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_expression -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      Printf.eprintf "State 30:\n%!";
      let _menhir_s = MenhirState030 in
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TokenOpenParenthesis ->
          Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenOpenBracket ->
          Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenNot ->
          Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenIdentifier _v ->
          Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | StringLiteral _v ->
          Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MINUS ->
          Printf.eprintf "Shifting (MINUS) to state 9\n%!";
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IntLiteral _v ->
          Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | INTEGER _v ->
          Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FloatLiteral _v ->
          Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CharLiteral _v ->
          Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | BoolLiteral _v ->
          Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_034 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_expression -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      Printf.eprintf "State 34:\n%!";
      let _menhir_s = MenhirState034 in
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TokenOpenParenthesis ->
          Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenOpenBracket ->
          Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenNot ->
          Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenIdentifier _v ->
          Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | StringLiteral _v ->
          Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MINUS ->
          Printf.eprintf "Shifting (MINUS) to state 9\n%!";
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IntLiteral _v ->
          Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | INTEGER _v ->
          Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FloatLiteral _v ->
          Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CharLiteral _v ->
          Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | BoolLiteral _v ->
          Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_028 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_expression -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      Printf.eprintf "State 28:\n%!";
      let _menhir_s = MenhirState028 in
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TokenOpenParenthesis ->
          Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenOpenBracket ->
          Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenNot ->
          Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenIdentifier _v ->
          Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | StringLiteral _v ->
          Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MINUS ->
          Printf.eprintf "Shifting (MINUS) to state 9\n%!";
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IntLiteral _v ->
          Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | INTEGER _v ->
          Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FloatLiteral _v ->
          Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CharLiteral _v ->
          Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | BoolLiteral _v ->
          Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_032 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_expression -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      Printf.eprintf "State 32:\n%!";
      let _menhir_s = MenhirState032 in
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TokenOpenParenthesis ->
          Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenOpenBracket ->
          Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenNot ->
          Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenIdentifier _v ->
          Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | StringLiteral _v ->
          Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MINUS ->
          Printf.eprintf "Shifting (MINUS) to state 9\n%!";
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IntLiteral _v ->
          Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | INTEGER _v ->
          Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FloatLiteral _v ->
          Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CharLiteral _v ->
          Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | BoolLiteral _v ->
          Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_036 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_expression -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      Printf.eprintf "State 36:\n%!";
      let _menhir_s = MenhirState036 in
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TokenOpenParenthesis ->
          Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenOpenBracket ->
          Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenNot ->
          Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenIdentifier _v ->
          Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | StringLiteral _v ->
          Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MINUS ->
          Printf.eprintf "Shifting (MINUS) to state 9\n%!";
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IntLiteral _v ->
          Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | INTEGER _v ->
          Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FloatLiteral _v ->
          Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CharLiteral _v ->
          Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | BoolLiteral _v ->
          Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_038 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_expression -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      Printf.eprintf "State 38:\n%!";
      let _menhir_s = MenhirState038 in
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TokenOpenParenthesis ->
          Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenOpenBracket ->
          Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenNot ->
          Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenIdentifier _v ->
          Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | StringLiteral _v ->
          Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MINUS ->
          Printf.eprintf "Shifting (MINUS) to state 9\n%!";
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IntLiteral _v ->
          Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | INTEGER _v ->
          Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FloatLiteral _v ->
          Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CharLiteral _v ->
          Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | BoolLiteral _v ->
          Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_goto_expression_list : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState134 ->
          _menhir_run_135 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState127 ->
          _menhir_run_130 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState056 ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState003 ->
          _menhir_run_053 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState004 ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState005 ->
          _menhir_run_044 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_135 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_namespaced_identifier as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 135:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenCloseParenthesis ->
          Printf.eprintf "Shifting (TokenCloseParenthesis) to state 136\n%!";
          Printf.eprintf "State 136:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | SEMICOLON ->
              Printf.eprintf "Shifting (SEMICOLON) to state 137\n%!";
              Printf.eprintf "State 137:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              let MenhirCell1_namespaced_identifier (_menhir_stack, _menhir_s, _1, _startpos__1_) = _menhir_stack in
              Printf.eprintf "Reducing production function_call -> namespaced_identifier TokenOpenParenthesis expression_list TokenCloseParenthesis SEMICOLON\n%!";
              let _3 = _v in
              let _v = _menhir_action_47 _1 _3 _startpos__1_ in
              _menhir_goto_function_call _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | COMMA ->
          let _menhir_stack = MenhirCell1_expression_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (COMMA) to state 46\n%!";
          _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_goto_function_call : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState000 ->
          _menhir_run_190 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState263 ->
          _menhir_run_190 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState002 ->
          _menhir_run_190 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState252 ->
          _menhir_run_190 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState259 ->
          _menhir_run_190 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState260 ->
          _menhir_run_190 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState087 ->
          _menhir_run_190 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState239 ->
          _menhir_run_190 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState088 ->
          _menhir_run_190 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState237 ->
          _menhir_run_190 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState149 ->
          _menhir_run_190 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState229 ->
          _menhir_run_190 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState232 ->
          _menhir_run_190 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState233 ->
          _menhir_run_190 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState225 ->
          _menhir_run_190 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState226 ->
          _menhir_run_190 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState161 ->
          _menhir_run_190 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState217 ->
          _menhir_run_190 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState163 ->
          _menhir_run_190 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState214 ->
          _menhir_run_190 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState207 ->
          _menhir_run_190 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState208 ->
          _menhir_run_190 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState203 ->
          _menhir_run_190 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState204 ->
          _menhir_run_190 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState196 ->
          _menhir_run_190 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState197 ->
          _menhir_run_190 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState177 ->
          _menhir_run_190 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState179 ->
          _menhir_run_190 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState125 ->
          _menhir_run_138 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_190 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 190:\n%!";
      Printf.eprintf "Reducing production statement -> function_call\n%!";
      let _1 = _v in
      let _v = _menhir_action_89 _1 in
      _menhir_goto_statement _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_statement : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState000 ->
          _menhir_run_195 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState002 ->
          _menhir_run_195 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState259 ->
          _menhir_run_195 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState087 ->
          _menhir_run_195 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState088 ->
          _menhir_run_195 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState149 ->
          _menhir_run_195 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState232 ->
          _menhir_run_195 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState225 ->
          _menhir_run_195 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState161 ->
          _menhir_run_195 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState163 ->
          _menhir_run_195 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState207 ->
          _menhir_run_195 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState203 ->
          _menhir_run_195 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState196 ->
          _menhir_run_195 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState177 ->
          _menhir_run_195 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState263 ->
          _menhir_run_182 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState252 ->
          _menhir_run_182 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState260 ->
          _menhir_run_182 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState239 ->
          _menhir_run_182 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState237 ->
          _menhir_run_182 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState229 ->
          _menhir_run_182 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState233 ->
          _menhir_run_182 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState226 ->
          _menhir_run_182 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState217 ->
          _menhir_run_182 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState214 ->
          _menhir_run_182 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState208 ->
          _menhir_run_182 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState204 ->
          _menhir_run_182 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState197 ->
          _menhir_run_182 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState179 ->
          _menhir_run_182 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_195 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 195:\n%!";
      Printf.eprintf "Reducing production statement_list -> statement\n%!";
      let _1 = _v in
      let _v = _menhir_action_93 _1 in
      _menhir_goto_statement_list _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_statement_list : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState000 ->
          _menhir_run_263 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState259 ->
          _menhir_run_260 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState002 ->
          _menhir_run_252 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState087 ->
          _menhir_run_239 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState088 ->
          _menhir_run_237 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState232 ->
          _menhir_run_233 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState149 ->
          _menhir_run_229 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState225 ->
          _menhir_run_226 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState161 ->
          _menhir_run_217 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState163 ->
          _menhir_run_214 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState207 ->
          _menhir_run_208 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState203 ->
          _menhir_run_204 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState196 ->
          _menhir_run_197 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState177 ->
          _menhir_run_179 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_263 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 263:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTry ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTry) to state 1\n%!";
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState263
      | TokenReturn ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenReturn) to state 3\n%!";
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState263
      | TokenPrint ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenPrint) to state 55\n%!";
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState263
      | TokenMatch ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenMatch) to state 81\n%!";
          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState263
      | TokenLog ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenLog) to state 89\n%!";
          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState263
      | TokenLet ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenLet) to state 94\n%!";
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState263
      | TokenImport ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenImport) to state 141\n%!";
          _menhir_run_141 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState263
      | TokenIf ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenIf) to state 145\n%!";
          _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState263
      | TokenIdentifier _v_0 ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenIdentifier) to state 150\n%!";
          _menhir_run_150 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState263
      | TokenFor ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenFor) to state 155\n%!";
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState263
      | TokenElse ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenElse) to state 162\n%!";
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState263
      | TokenDef ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenDef) to state 164\n%!";
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState263
      | EOF ->
          Printf.eprintf "Reducing production binary_program -> statement_list\n%!";
          let _1 = _v in
          let _v = _menhir_action_02 _1 in
          Printf.eprintf "State 265:\n%!";
          Printf.eprintf "Shifting (EOF) to state 266\n%!";
          Printf.eprintf "State 266:\n%!";
          Printf.eprintf "Reducing production main -> binary_program EOF\n%!";
          let _1 = _v in
          let _v = _menhir_action_57 _1 in
          Printf.eprintf "State 264:\n%!";
          Printf.eprintf "Accepting\n%!";
          MenhirBox_main _v
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_081 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      Printf.eprintf "State 81:\n%!";
      let _menhir_stack = MenhirCell1_TokenMatch (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState081 in
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TokenOpenParenthesis ->
          Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenOpenBracket ->
          Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenNot ->
          Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenIdentifier _v ->
          Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | StringLiteral _v ->
          Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MINUS ->
          Printf.eprintf "Shifting (MINUS) to state 9\n%!";
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IntLiteral _v ->
          Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | INTEGER _v ->
          Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FloatLiteral _v ->
          Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CharLiteral _v ->
          Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | BoolLiteral _v ->
          Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_089 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      Printf.eprintf "State 89:\n%!";
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TokenOpenParenthesis ->
          Printf.eprintf "Shifting (TokenOpenParenthesis) to state 90\n%!";
          Printf.eprintf "State 90:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | StringLiteral _v ->
              Printf.eprintf "Shifting (StringLiteral) to state 91\n%!";
              Printf.eprintf "State 91:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | TokenCloseParenthesis ->
                  Printf.eprintf "Shifting (TokenCloseParenthesis) to state 92\n%!";
                  Printf.eprintf "State 92:\n%!";
                  let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | SEMICOLON ->
                      Printf.eprintf "Shifting (SEMICOLON) to state 93\n%!";
                      Printf.eprintf "State 93:\n%!";
                      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
                      Printf.eprintf "Reducing production log_statement -> TokenLog TokenOpenParenthesis StringLiteral TokenCloseParenthesis SEMICOLON\n%!";
                      let _3 = _v in
                      let _v = _menhir_action_56 _3 in
                      Printf.eprintf "State 186:\n%!";
                      Printf.eprintf "Reducing production statement -> log_statement\n%!";
                      let _1 = _v in
                      let _v = _menhir_action_87 _1 in
                      _menhir_goto_statement _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
                  | _ ->
                      Printf.eprintf "Initiating error handling\n%!";
                      _eRR ())
              | _ ->
                  Printf.eprintf "Initiating error handling\n%!";
                  _eRR ())
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_094 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      Printf.eprintf "State 94:\n%!";
      let _menhir_stack = MenhirCell1_TokenLet (_menhir_stack, _menhir_s) in
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TokenIdentifier _v ->
          Printf.eprintf "Shifting (TokenIdentifier) to state 95\n%!";
          Printf.eprintf "State 95:\n%!";
          let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
          let _menhir_stack = MenhirCell0_TokenIdentifier (_menhir_stack, _v, _startpos) in
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | COLON ->
              Printf.eprintf "Shifting (COLON) to state 96\n%!";
              Printf.eprintf "State 96:\n%!";
              let _menhir_s = MenhirState096 in
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | VOID _v ->
                  Printf.eprintf "Shifting (VOID) to state 97\n%!";
                  _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | STRING _v ->
                  Printf.eprintf "Shifting (STRING) to state 98\n%!";
                  _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | LIST _v ->
                  Printf.eprintf "Shifting (LIST) to state 99\n%!";
                  _menhir_run_099 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | INTEGER _v ->
                  Printf.eprintf "Shifting (INTEGER) to state 100\n%!";
                  _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | FLOAT _v ->
                  Printf.eprintf "Shifting (FLOAT) to state 101\n%!";
                  _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | CHAR _v ->
                  Printf.eprintf "Shifting (CHAR) to state 102\n%!";
                  _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | BOOL _v ->
                  Printf.eprintf "Shifting (BOOL) to state 103\n%!";
                  _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  Printf.eprintf "Initiating error handling\n%!";
                  _eRR ())
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_097 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      Printf.eprintf "State 97:\n%!";
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      Printf.eprintf "Reducing production data_types -> VOID\n%!";
      let _1 = _v in
      let _v = _menhir_action_08 _1 in
      _menhir_goto_data_types _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_data_types : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState168 ->
          _menhir_run_169 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState096 ->
          _menhir_run_104 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_169 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_TokenIdentifier as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 169:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenConst ->
          Printf.eprintf "Shifting (TokenConst) to state 170\n%!";
          Printf.eprintf "State 170:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | EQUAL ->
              let _menhir_stack = MenhirCell1_data_types (_menhir_stack, _menhir_s, _v) in
              Printf.eprintf "Shifting (EQUAL) to state 171\n%!";
              Printf.eprintf "State 171:\n%!";
              let _menhir_s = MenhirState171 in
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | TokenOpenParenthesis ->
                  Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
                  _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | TokenOpenBracket ->
                  Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
                  _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | TokenNot ->
                  Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
                  _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | TokenIdentifier _v ->
                  Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
                  _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | StringLiteral _v ->
                  Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
                  _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | MINUS ->
                  Printf.eprintf "Shifting (MINUS) to state 9\n%!";
                  _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | IntLiteral _v ->
                  Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
                  _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | INTEGER _v ->
                  Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
                  _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | FloatLiteral _v ->
                  Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
                  _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | CharLiteral _v ->
                  Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
                  _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | BoolLiteral _v ->
                  Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
                  _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  Printf.eprintf "Initiating error handling\n%!";
                  _eRR ())
          | COMMA | TokenCloseParenthesis ->
              let MenhirCell1_TokenIdentifier (_menhir_stack, _menhir_s, _1, _) = _menhir_stack in
              Printf.eprintf "Reducing production parameter -> TokenIdentifier COLON data_types TokenConst\n%!";
              let _3 = _v in
              let _v = _menhir_action_67 _1 _3 in
              _menhir_goto_parameter _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | EQUAL ->
          let _menhir_stack = MenhirCell1_data_types (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (EQUAL) to state 173\n%!";
          Printf.eprintf "State 173:\n%!";
          let _menhir_s = MenhirState173 in
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TokenOpenParenthesis ->
              Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
              _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TokenOpenBracket ->
              Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TokenNot ->
              Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TokenIdentifier _v ->
              Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | StringLiteral _v ->
              Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | MINUS ->
              Printf.eprintf "Shifting (MINUS) to state 9\n%!";
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IntLiteral _v ->
              Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | INTEGER _v ->
              Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FloatLiteral _v ->
              Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | CharLiteral _v ->
              Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | BoolLiteral _v ->
              Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | COMMA | TokenCloseParenthesis ->
          let MenhirCell1_TokenIdentifier (_menhir_stack, _menhir_s, _1, _) = _menhir_stack in
          Printf.eprintf "Reducing production parameter -> TokenIdentifier COLON data_types\n%!";
          let _3 = _v in
          let _v = _menhir_action_69 _1 _3 in
          _menhir_goto_parameter _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_goto_parameter : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState166 ->
          _menhir_run_213 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState211 ->
          _menhir_run_212 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_213 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_TokenDef _menhir_cell0_TokenIdentifier as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 213:\n%!";
      Printf.eprintf "Reducing production parameter_list -> parameter\n%!";
      let _1 = _v in
      let _v = _menhir_action_70 _1 in
      _menhir_goto_parameter_list _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_parameter_list : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_TokenDef _menhir_cell0_TokenIdentifier as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 200:\n%!";
      let _menhir_stack = MenhirCell1_parameter_list (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | TokenCloseParenthesis ->
          Printf.eprintf "Shifting (TokenCloseParenthesis) to state 201\n%!";
          Printf.eprintf "State 201:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VOID _v_0 ->
              Printf.eprintf "Shifting (VOID) to state 202\n%!";
              Printf.eprintf "State 202:\n%!";
              let _menhir_stack = MenhirCell0_VOID (_menhir_stack, _v_0) in
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | TokenOpenBrace ->
                  Printf.eprintf "Shifting (TokenOpenBrace) to state 203\n%!";
                  Printf.eprintf "State 203:\n%!";
                  let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | TokenTry ->
                      Printf.eprintf "Shifting (TokenTry) to state 1\n%!";
                      _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState203
                  | TokenReturn ->
                      Printf.eprintf "Shifting (TokenReturn) to state 3\n%!";
                      _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState203
                  | TokenPrint ->
                      Printf.eprintf "Shifting (TokenPrint) to state 55\n%!";
                      _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState203
                  | TokenMatch ->
                      Printf.eprintf "Shifting (TokenMatch) to state 81\n%!";
                      _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState203
                  | TokenLog ->
                      Printf.eprintf "Shifting (TokenLog) to state 89\n%!";
                      _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState203
                  | TokenLet ->
                      Printf.eprintf "Shifting (TokenLet) to state 94\n%!";
                      _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState203
                  | TokenImport ->
                      Printf.eprintf "Shifting (TokenImport) to state 141\n%!";
                      _menhir_run_141 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState203
                  | TokenIf ->
                      Printf.eprintf "Shifting (TokenIf) to state 145\n%!";
                      _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState203
                  | TokenIdentifier _v_1 ->
                      Printf.eprintf "Shifting (TokenIdentifier) to state 150\n%!";
                      _menhir_run_150 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState203
                  | TokenFor ->
                      Printf.eprintf "Shifting (TokenFor) to state 155\n%!";
                      _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState203
                  | TokenElse ->
                      Printf.eprintf "Shifting (TokenElse) to state 162\n%!";
                      _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState203
                  | TokenDef ->
                      Printf.eprintf "Shifting (TokenDef) to state 164\n%!";
                      _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState203
                  | TokenCloseBrace ->
                      Printf.eprintf "Reducing production statement_list ->\n%!";
                      let _v_2 = _menhir_action_94 () in
                      _menhir_run_204 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState203 _tok
                  | _ ->
                      Printf.eprintf "Initiating error handling\n%!";
                      _eRR ())
              | _ ->
                  Printf.eprintf "Initiating error handling\n%!";
                  _eRR ())
          | TokenOpenBrace ->
              Printf.eprintf "Shifting (TokenOpenBrace) to state 207\n%!";
              Printf.eprintf "State 207:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | TokenTry ->
                  Printf.eprintf "Shifting (TokenTry) to state 1\n%!";
                  _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState207
              | TokenReturn ->
                  Printf.eprintf "Shifting (TokenReturn) to state 3\n%!";
                  _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState207
              | TokenPrint ->
                  Printf.eprintf "Shifting (TokenPrint) to state 55\n%!";
                  _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState207
              | TokenMatch ->
                  Printf.eprintf "Shifting (TokenMatch) to state 81\n%!";
                  _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState207
              | TokenLog ->
                  Printf.eprintf "Shifting (TokenLog) to state 89\n%!";
                  _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState207
              | TokenLet ->
                  Printf.eprintf "Shifting (TokenLet) to state 94\n%!";
                  _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState207
              | TokenImport ->
                  Printf.eprintf "Shifting (TokenImport) to state 141\n%!";
                  _menhir_run_141 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState207
              | TokenIf ->
                  Printf.eprintf "Shifting (TokenIf) to state 145\n%!";
                  _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState207
              | TokenIdentifier _v_3 ->
                  Printf.eprintf "Shifting (TokenIdentifier) to state 150\n%!";
                  _menhir_run_150 _menhir_stack _menhir_lexbuf _menhir_lexer _v_3 MenhirState207
              | TokenFor ->
                  Printf.eprintf "Shifting (TokenFor) to state 155\n%!";
                  _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState207
              | TokenElse ->
                  Printf.eprintf "Shifting (TokenElse) to state 162\n%!";
                  _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState207
              | TokenDef ->
                  Printf.eprintf "Shifting (TokenDef) to state 164\n%!";
                  _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState207
              | TokenCloseBrace ->
                  Printf.eprintf "Reducing production statement_list ->\n%!";
                  let _v_4 = _menhir_action_94 () in
                  _menhir_run_208 _menhir_stack _menhir_lexbuf _menhir_lexer _v_4 MenhirState207 _tok
              | _ ->
                  Printf.eprintf "Initiating error handling\n%!";
                  _eRR ())
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | COMMA ->
          Printf.eprintf "Shifting (COMMA) to state 211\n%!";
          Printf.eprintf "State 211:\n%!";
          let _menhir_s = MenhirState211 in
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TokenIdentifier _v ->
              Printf.eprintf "Shifting (TokenIdentifier) to state 167\n%!";
              _menhir_run_167 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_141 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      Printf.eprintf "State 141:\n%!";
      let _menhir_stack = MenhirCell1_TokenImport (_menhir_stack, _menhir_s) in
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TokenIdentifier _v ->
          Printf.eprintf "Shifting (TokenIdentifier) to state 142\n%!";
          Printf.eprintf "State 142:\n%!";
          let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          Printf.eprintf "Reducing production namespaced_identifier -> TokenIdentifier\n%!";
          let _v =
            let _1 = _v in
            _menhir_action_64 _1
          in
          _menhir_run_143 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v MenhirState141 _tok
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_143 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_TokenImport as 'stack) -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok ->
      Printf.eprintf "State 143:\n%!";
      match (_tok : MenhirBasics.token) with
      | SEMICOLON ->
          Printf.eprintf "Shifting (SEMICOLON) to state 144\n%!";
          Printf.eprintf "State 144:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_TokenImport (_menhir_stack, _menhir_s) = _menhir_stack in
          Printf.eprintf "Reducing production import_statement -> TokenImport namespaced_identifier SEMICOLON\n%!";
          let _2 = _v in
          let _v = _menhir_action_50 _2 in
          Printf.eprintf "State 188:\n%!";
          Printf.eprintf "Reducing production statement -> import_statement\n%!";
          let _1 = _v in
          let _v = _menhir_action_88 _1 in
          _menhir_goto_statement _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | DOT ->
          let _menhir_stack = MenhirCell1_namespaced_identifier (_menhir_stack, _menhir_s, _v, _startpos) in
          Printf.eprintf "Shifting (DOT) to state 61\n%!";
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_061 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_namespaced_identifier -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      Printf.eprintf "State 61:\n%!";
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TokenIdentifier _v ->
          Printf.eprintf "Shifting (TokenIdentifier) to state 62\n%!";
          Printf.eprintf "State 62:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_namespaced_identifier (_menhir_stack, _menhir_s, _1, _startpos__1_) = _menhir_stack in
          Printf.eprintf "Reducing production namespaced_identifier -> namespaced_identifier DOT TokenIdentifier\n%!";
          let _3 = _v in
          let _v = _menhir_action_65 _1 _3 in
          _menhir_goto_namespaced_identifier _menhir_stack _menhir_lexbuf _menhir_lexer _startpos__1_ _v _menhir_s _tok
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_goto_namespaced_identifier : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState141 ->
          _menhir_run_143 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState000 ->
          _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState263 ->
          _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState002 ->
          _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState252 ->
          _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState259 ->
          _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState260 ->
          _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState087 ->
          _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState239 ->
          _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState088 ->
          _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState237 ->
          _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState149 ->
          _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState229 ->
          _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState232 ->
          _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState233 ->
          _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState225 ->
          _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState226 ->
          _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState161 ->
          _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState217 ->
          _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState163 ->
          _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState214 ->
          _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState207 ->
          _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState208 ->
          _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState203 ->
          _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState204 ->
          _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState196 ->
          _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState197 ->
          _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState177 ->
          _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState179 ->
          _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState125 ->
          _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | MenhirState056 ->
          _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_133 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok ->
      Printf.eprintf "State 133:\n%!";
      let _menhir_stack = MenhirCell1_namespaced_identifier (_menhir_stack, _menhir_s, _v, _startpos) in
      match (_tok : MenhirBasics.token) with
      | TokenOpenParenthesis ->
          Printf.eprintf "Shifting (TokenOpenParenthesis) to state 134\n%!";
          Printf.eprintf "State 134:\n%!";
          let _menhir_s = MenhirState134 in
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TokenOpenParenthesis ->
              Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
              _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TokenOpenBracket ->
              Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TokenNot ->
              Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TokenIdentifier _v ->
              Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | StringLiteral _v ->
              Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | MINUS ->
              Printf.eprintf "Shifting (MINUS) to state 9\n%!";
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IntLiteral _v ->
              Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | INTEGER _v ->
              Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FloatLiteral _v ->
              Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | CharLiteral _v ->
              Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | BoolLiteral _v ->
              Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | DOT ->
          Printf.eprintf "Shifting (DOT) to state 61\n%!";
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_058 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_TokenPrint as 'stack) -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v _menhir_s _tok ->
      Printf.eprintf "State 58:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenCloseParenthesis ->
          Printf.eprintf "Shifting (TokenCloseParenthesis) to state 59\n%!";
          Printf.eprintf "State 59:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | SEMICOLON ->
              Printf.eprintf "Shifting (SEMICOLON) to state 60\n%!";
              Printf.eprintf "State 60:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              let MenhirCell1_TokenPrint (_menhir_stack, _menhir_s) = _menhir_stack in
              Printf.eprintf "Reducing production print_statement -> TokenPrint TokenOpenParenthesis namespaced_identifier TokenCloseParenthesis SEMICOLON\n%!";
              let _3 = _v in
              let _v = _menhir_action_77 _3 in
              _menhir_goto_print_statement _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | DOT ->
          let _menhir_stack = MenhirCell1_namespaced_identifier (_menhir_stack, _menhir_s, _v, _startpos) in
          Printf.eprintf "Shifting (DOT) to state 61\n%!";
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_goto_print_statement : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 184:\n%!";
      Printf.eprintf "Reducing production statement -> print_statement\n%!";
      let _1 = _v in
      let _v = _menhir_action_79 _1 in
      _menhir_goto_statement _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_145 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      Printf.eprintf "State 145:\n%!";
      let _menhir_stack = MenhirCell1_TokenIf (_menhir_stack, _menhir_s) in
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TokenOpenParenthesis ->
          Printf.eprintf "Shifting (TokenOpenParenthesis) to state 146\n%!";
          Printf.eprintf "State 146:\n%!";
          let _menhir_s = MenhirState146 in
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TokenOpenParenthesis ->
              Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
              _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TokenOpenBracket ->
              Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TokenNot ->
              Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TokenIdentifier _v ->
              Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | StringLiteral _v ->
              Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | MINUS ->
              Printf.eprintf "Shifting (MINUS) to state 9\n%!";
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IntLiteral _v ->
              Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | INTEGER _v ->
              Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FloatLiteral _v ->
              Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | CharLiteral _v ->
              Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | BoolLiteral _v ->
              Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_150 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      Printf.eprintf "State 150:\n%!";
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TokenOpenParenthesis ->
          let _menhir_stack = MenhirCell1_TokenIdentifier (_menhir_stack, _menhir_s, _v, _startpos) in
          Printf.eprintf "Shifting (TokenOpenParenthesis) to state 127\n%!";
          _menhir_run_127 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COLON ->
          let _menhir_stack = MenhirCell1_TokenIdentifier (_menhir_stack, _menhir_s, _v, _startpos) in
          Printf.eprintf "Shifting (COLON) to state 151\n%!";
          Printf.eprintf "State 151:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | EQUAL ->
              Printf.eprintf "Shifting (EQUAL) to state 152\n%!";
              Printf.eprintf "State 152:\n%!";
              let _menhir_s = MenhirState152 in
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | TokenOpenParenthesis ->
                  Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
                  _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | TokenOpenBracket ->
                  Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
                  _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | TokenNot ->
                  Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
                  _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | TokenIdentifier _v ->
                  Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
                  _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | StringLiteral _v ->
                  Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
                  _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | MINUS ->
                  Printf.eprintf "Shifting (MINUS) to state 9\n%!";
                  _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | IntLiteral _v ->
                  Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
                  _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | INTEGER _v ->
                  Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
                  _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | FloatLiteral _v ->
                  Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
                  _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | CharLiteral _v ->
                  Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
                  _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | BoolLiteral _v ->
                  Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
                  _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  Printf.eprintf "Initiating error handling\n%!";
                  _eRR ())
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | DOT ->
          Printf.eprintf "Reducing production namespaced_identifier -> TokenIdentifier\n%!";
          let (_startpos__1_, _1) = (_startpos, _v) in
          let _v = _menhir_action_64 _1 in
          _menhir_goto_namespaced_identifier _menhir_stack _menhir_lexbuf _menhir_lexer _startpos__1_ _v _menhir_s _tok
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_127 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_TokenIdentifier -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      Printf.eprintf "State 127:\n%!";
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TokenOpenParenthesis ->
          Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState127
      | TokenOpenBracket ->
          Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState127
      | TokenNot ->
          Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState127
      | TokenIdentifier _v ->
          Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState127
      | TokenCloseParenthesis ->
          Printf.eprintf "Shifting (TokenCloseParenthesis) to state 128\n%!";
          Printf.eprintf "State 128:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | SEMICOLON ->
              Printf.eprintf "Shifting (SEMICOLON) to state 129\n%!";
              Printf.eprintf "State 129:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              let MenhirCell1_TokenIdentifier (_menhir_stack, _menhir_s, _1, _startpos__1_) = _menhir_stack in
              Printf.eprintf "Reducing production function_call -> TokenIdentifier TokenOpenParenthesis TokenCloseParenthesis SEMICOLON\n%!";
              let _v = _menhir_action_45 _1 _startpos__1_ in
              _menhir_goto_function_call _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | StringLiteral _v ->
          Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState127
      | MINUS ->
          Printf.eprintf "Shifting (MINUS) to state 9\n%!";
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState127
      | IntLiteral _v ->
          Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState127
      | INTEGER _v ->
          Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState127
      | FloatLiteral _v ->
          Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState127
      | CharLiteral _v ->
          Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState127
      | BoolLiteral _v ->
          Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState127
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_155 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      Printf.eprintf "State 155:\n%!";
      let _menhir_stack = MenhirCell1_TokenFor (_menhir_stack, _menhir_s) in
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TokenIdentifier _v ->
          Printf.eprintf "Shifting (TokenIdentifier) to state 156\n%!";
          Printf.eprintf "State 156:\n%!";
          let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
          let _menhir_stack = MenhirCell0_TokenIdentifier (_menhir_stack, _v, _startpos) in
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TokenIn ->
              Printf.eprintf "Shifting (TokenIn) to state 157\n%!";
              Printf.eprintf "State 157:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | TokenOpenParenthesis ->
                  Printf.eprintf "Shifting (TokenOpenParenthesis) to state 158\n%!";
                  Printf.eprintf "State 158:\n%!";
                  let _menhir_s = MenhirState158 in
                  let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | TokenOpenParenthesis ->
                      Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
                      _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | TokenOpenBracket ->
                      Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
                      _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | TokenNot ->
                      Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
                      _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | TokenIdentifier _v ->
                      Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
                      _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | StringLiteral _v ->
                      Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
                      _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | MINUS ->
                      Printf.eprintf "Shifting (MINUS) to state 9\n%!";
                      _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | IntLiteral _v ->
                      Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
                      _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | INTEGER _v ->
                      Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
                      _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | FloatLiteral _v ->
                      Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
                      _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | CharLiteral _v ->
                      Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
                      _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | BoolLiteral _v ->
                      Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
                      _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | _ ->
                      Printf.eprintf "Initiating error handling\n%!";
                      _eRR ())
              | _ ->
                  Printf.eprintf "Initiating error handling\n%!";
                  _eRR ())
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_162 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      Printf.eprintf "State 162:\n%!";
      let _menhir_stack = MenhirCell1_TokenElse (_menhir_stack, _menhir_s) in
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TokenOpenBrace ->
          Printf.eprintf "Shifting (TokenOpenBrace) to state 163\n%!";
          Printf.eprintf "State 163:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TokenTry ->
              Printf.eprintf "Shifting (TokenTry) to state 1\n%!";
              _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState163
          | TokenReturn ->
              Printf.eprintf "Shifting (TokenReturn) to state 3\n%!";
              _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState163
          | TokenPrint ->
              Printf.eprintf "Shifting (TokenPrint) to state 55\n%!";
              _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState163
          | TokenMatch ->
              Printf.eprintf "Shifting (TokenMatch) to state 81\n%!";
              _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState163
          | TokenLog ->
              Printf.eprintf "Shifting (TokenLog) to state 89\n%!";
              _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState163
          | TokenLet ->
              Printf.eprintf "Shifting (TokenLet) to state 94\n%!";
              _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState163
          | TokenImport ->
              Printf.eprintf "Shifting (TokenImport) to state 141\n%!";
              _menhir_run_141 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState163
          | TokenIf ->
              Printf.eprintf "Shifting (TokenIf) to state 145\n%!";
              _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState163
          | TokenIdentifier _v ->
              Printf.eprintf "Shifting (TokenIdentifier) to state 150\n%!";
              _menhir_run_150 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState163
          | TokenFor ->
              Printf.eprintf "Shifting (TokenFor) to state 155\n%!";
              _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState163
          | TokenElse ->
              Printf.eprintf "Shifting (TokenElse) to state 162\n%!";
              _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState163
          | TokenDef ->
              Printf.eprintf "Shifting (TokenDef) to state 164\n%!";
              _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState163
          | TokenCloseBrace ->
              Printf.eprintf "Reducing production statement_list ->\n%!";
              let _v = _menhir_action_94 () in
              _menhir_run_214 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState163 _tok
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_164 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      Printf.eprintf "State 164:\n%!";
      let _menhir_stack = MenhirCell1_TokenDef (_menhir_stack, _menhir_s) in
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TokenIdentifier _v ->
          Printf.eprintf "Shifting (TokenIdentifier) to state 165\n%!";
          Printf.eprintf "State 165:\n%!";
          let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
          let _menhir_stack = MenhirCell0_TokenIdentifier (_menhir_stack, _v, _startpos) in
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TokenOpenParenthesis ->
              Printf.eprintf "Shifting (TokenOpenParenthesis) to state 166\n%!";
              Printf.eprintf "State 166:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | TokenIdentifier _v_0 ->
                  Printf.eprintf "Shifting (TokenIdentifier) to state 167\n%!";
                  _menhir_run_167 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState166
              | TokenCloseParenthesis ->
                  Printf.eprintf "Shifting (TokenCloseParenthesis) to state 175\n%!";
                  Printf.eprintf "State 175:\n%!";
                  let _menhir_stack = MenhirCell1_TokenCloseParenthesis (_menhir_stack, MenhirState166) in
                  let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | VOID _v_1 ->
                      Printf.eprintf "Shifting (VOID) to state 176\n%!";
                      Printf.eprintf "State 176:\n%!";
                      let _menhir_stack = MenhirCell0_VOID (_menhir_stack, _v_1) in
                      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
                      (match (_tok : MenhirBasics.token) with
                      | TokenOpenBrace ->
                          Printf.eprintf "Shifting (TokenOpenBrace) to state 177\n%!";
                          Printf.eprintf "State 177:\n%!";
                          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
                          (match (_tok : MenhirBasics.token) with
                          | TokenTry ->
                              Printf.eprintf "Shifting (TokenTry) to state 1\n%!";
                              _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState177
                          | TokenReturn ->
                              Printf.eprintf "Shifting (TokenReturn) to state 3\n%!";
                              _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState177
                          | TokenPrint ->
                              Printf.eprintf "Shifting (TokenPrint) to state 55\n%!";
                              _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState177
                          | TokenMatch ->
                              Printf.eprintf "Shifting (TokenMatch) to state 81\n%!";
                              _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState177
                          | TokenLog ->
                              Printf.eprintf "Shifting (TokenLog) to state 89\n%!";
                              _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState177
                          | TokenLet ->
                              Printf.eprintf "Shifting (TokenLet) to state 94\n%!";
                              _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState177
                          | TokenImport ->
                              Printf.eprintf "Shifting (TokenImport) to state 141\n%!";
                              _menhir_run_141 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState177
                          | TokenIf ->
                              Printf.eprintf "Shifting (TokenIf) to state 145\n%!";
                              _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState177
                          | TokenIdentifier _v_2 ->
                              Printf.eprintf "Shifting (TokenIdentifier) to state 150\n%!";
                              _menhir_run_150 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState177
                          | TokenFor ->
                              Printf.eprintf "Shifting (TokenFor) to state 155\n%!";
                              _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState177
                          | TokenElse ->
                              Printf.eprintf "Shifting (TokenElse) to state 162\n%!";
                              _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState177
                          | TokenDef ->
                              Printf.eprintf "Shifting (TokenDef) to state 164\n%!";
                              _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState177
                          | TokenCloseBrace ->
                              Printf.eprintf "Reducing production statement_list ->\n%!";
                              let _v_3 = _menhir_action_94 () in
                              _menhir_run_179 _menhir_stack _menhir_lexbuf _menhir_lexer _v_3 MenhirState177 _tok
                          | _ ->
                              Printf.eprintf "Initiating error handling\n%!";
                              _eRR ())
                      | _ ->
                          Printf.eprintf "Initiating error handling\n%!";
                          _eRR ())
                  | TokenOpenBrace ->
                      Printf.eprintf "Shifting (TokenOpenBrace) to state 196\n%!";
                      Printf.eprintf "State 196:\n%!";
                      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
                      (match (_tok : MenhirBasics.token) with
                      | TokenTry ->
                          Printf.eprintf "Shifting (TokenTry) to state 1\n%!";
                          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState196
                      | TokenReturn ->
                          Printf.eprintf "Shifting (TokenReturn) to state 3\n%!";
                          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState196
                      | TokenPrint ->
                          Printf.eprintf "Shifting (TokenPrint) to state 55\n%!";
                          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState196
                      | TokenMatch ->
                          Printf.eprintf "Shifting (TokenMatch) to state 81\n%!";
                          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState196
                      | TokenLog ->
                          Printf.eprintf "Shifting (TokenLog) to state 89\n%!";
                          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState196
                      | TokenLet ->
                          Printf.eprintf "Shifting (TokenLet) to state 94\n%!";
                          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState196
                      | TokenImport ->
                          Printf.eprintf "Shifting (TokenImport) to state 141\n%!";
                          _menhir_run_141 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState196
                      | TokenIf ->
                          Printf.eprintf "Shifting (TokenIf) to state 145\n%!";
                          _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState196
                      | TokenIdentifier _v_4 ->
                          Printf.eprintf "Shifting (TokenIdentifier) to state 150\n%!";
                          _menhir_run_150 _menhir_stack _menhir_lexbuf _menhir_lexer _v_4 MenhirState196
                      | TokenFor ->
                          Printf.eprintf "Shifting (TokenFor) to state 155\n%!";
                          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState196
                      | TokenElse ->
                          Printf.eprintf "Shifting (TokenElse) to state 162\n%!";
                          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState196
                      | TokenDef ->
                          Printf.eprintf "Shifting (TokenDef) to state 164\n%!";
                          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState196
                      | TokenCloseBrace ->
                          Printf.eprintf "Reducing production statement_list ->\n%!";
                          let _v_5 = _menhir_action_94 () in
                          _menhir_run_197 _menhir_stack _menhir_lexbuf _menhir_lexer _v_5 MenhirState196 _tok
                      | _ ->
                          Printf.eprintf "Initiating error handling\n%!";
                          _eRR ())
                  | _ ->
                      Printf.eprintf "Initiating error handling\n%!";
                      _eRR ())
              | COMMA ->
                  Printf.eprintf "Reducing production parameter_list ->\n%!";
                  let _menhir_s = MenhirState166 in
                  let _v = _menhir_action_72 () in
                  _menhir_goto_parameter_list _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
              | _ ->
                  Printf.eprintf "Initiating error handling\n%!";
                  _eRR ())
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_167 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      Printf.eprintf "State 167:\n%!";
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_TokenIdentifier (_menhir_stack, _menhir_s, _v, _startpos) in
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | COLON ->
          Printf.eprintf "Shifting (COLON) to state 168\n%!";
          Printf.eprintf "State 168:\n%!";
          let _menhir_s = MenhirState168 in
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VOID _v ->
              Printf.eprintf "Shifting (VOID) to state 97\n%!";
              _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | STRING _v ->
              Printf.eprintf "Shifting (STRING) to state 98\n%!";
              _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LIST _v ->
              Printf.eprintf "Shifting (LIST) to state 99\n%!";
              _menhir_run_099 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | INTEGER _v ->
              Printf.eprintf "Shifting (INTEGER) to state 100\n%!";
              _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FLOAT _v ->
              Printf.eprintf "Shifting (FLOAT) to state 101\n%!";
              _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | CHAR _v ->
              Printf.eprintf "Shifting (CHAR) to state 102\n%!";
              _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | BOOL _v ->
              Printf.eprintf "Shifting (BOOL) to state 103\n%!";
              _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_098 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      Printf.eprintf "State 98:\n%!";
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      Printf.eprintf "Reducing production data_types -> STRING\n%!";
      let _1 = _v in
      let _v = _menhir_action_05 _1 in
      _menhir_goto_data_types _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_099 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      Printf.eprintf "State 99:\n%!";
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      Printf.eprintf "Reducing production data_types -> LIST\n%!";
      let _1 = _v in
      let _v = _menhir_action_09 _1 in
      _menhir_goto_data_types _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_100 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      Printf.eprintf "State 100:\n%!";
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      Printf.eprintf "Reducing production data_types -> INTEGER\n%!";
      let _1 = _v in
      let _v = _menhir_action_03 _1 in
      _menhir_goto_data_types _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_101 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      Printf.eprintf "State 101:\n%!";
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      Printf.eprintf "Reducing production data_types -> FLOAT\n%!";
      let _1 = _v in
      let _v = _menhir_action_04 _1 in
      _menhir_goto_data_types _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_102 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      Printf.eprintf "State 102:\n%!";
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      Printf.eprintf "Reducing production data_types -> CHAR\n%!";
      let _1 = _v in
      let _v = _menhir_action_07 _1 in
      _menhir_goto_data_types _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_103 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      Printf.eprintf "State 103:\n%!";
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      Printf.eprintf "Reducing production data_types -> BOOL\n%!";
      let _1 = _v in
      let _v = _menhir_action_06 _1 in
      _menhir_goto_data_types _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_179 : type  ttv_stack. (((ttv_stack, _menhir_box_main) _menhir_cell1_TokenDef _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_cell1_TokenCloseParenthesis _menhir_cell0_VOID as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 179:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTry ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTry) to state 1\n%!";
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState179
      | TokenReturn ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenReturn) to state 3\n%!";
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState179
      | TokenPrint ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenPrint) to state 55\n%!";
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState179
      | TokenMatch ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenMatch) to state 81\n%!";
          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState179
      | TokenLog ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenLog) to state 89\n%!";
          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState179
      | TokenLet ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenLet) to state 94\n%!";
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState179
      | TokenImport ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenImport) to state 141\n%!";
          _menhir_run_141 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState179
      | TokenIf ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenIf) to state 145\n%!";
          _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState179
      | TokenIdentifier _v_0 ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenIdentifier) to state 150\n%!";
          _menhir_run_150 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState179
      | TokenFor ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenFor) to state 155\n%!";
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState179
      | TokenElse ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenElse) to state 162\n%!";
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState179
      | TokenDef ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenDef) to state 164\n%!";
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState179
      | TokenCloseBrace ->
          Printf.eprintf "Shifting (TokenCloseBrace) to state 180\n%!";
          Printf.eprintf "State 180:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | SEMICOLON ->
              Printf.eprintf "Shifting (SEMICOLON) to state 181\n%!";
              Printf.eprintf "State 181:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              let MenhirCell0_VOID (_menhir_stack, _) = _menhir_stack in
              let MenhirCell1_TokenCloseParenthesis (_menhir_stack, _) = _menhir_stack in
              let MenhirCell0_TokenIdentifier (_menhir_stack, _2, _) = _menhir_stack in
              let MenhirCell1_TokenDef (_menhir_stack, _menhir_s) = _menhir_stack in
              Printf.eprintf "Reducing production def_statement -> TokenDef TokenIdentifier TokenOpenParenthesis TokenCloseParenthesis VOID TokenOpenBrace statement_list TokenCloseBrace SEMICOLON\n%!";
              let _7 = _v in
              let _v = _menhir_action_13 _2 _7 in
              _menhir_goto_def_statement _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_goto_def_statement : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 193:\n%!";
      Printf.eprintf "Reducing production statement -> def_statement\n%!";
      let _1 = _v in
      let _v = _menhir_action_84 _1 in
      _menhir_goto_statement _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_197 : type  ttv_stack. (((ttv_stack, _menhir_box_main) _menhir_cell1_TokenDef _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_cell1_TokenCloseParenthesis as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 197:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTry ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTry) to state 1\n%!";
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState197
      | TokenReturn ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenReturn) to state 3\n%!";
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState197
      | TokenPrint ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenPrint) to state 55\n%!";
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState197
      | TokenMatch ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenMatch) to state 81\n%!";
          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState197
      | TokenLog ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenLog) to state 89\n%!";
          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState197
      | TokenLet ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenLet) to state 94\n%!";
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState197
      | TokenImport ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenImport) to state 141\n%!";
          _menhir_run_141 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState197
      | TokenIf ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenIf) to state 145\n%!";
          _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState197
      | TokenIdentifier _v_0 ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenIdentifier) to state 150\n%!";
          _menhir_run_150 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState197
      | TokenFor ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenFor) to state 155\n%!";
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState197
      | TokenElse ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenElse) to state 162\n%!";
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState197
      | TokenDef ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenDef) to state 164\n%!";
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState197
      | TokenCloseBrace ->
          Printf.eprintf "Shifting (TokenCloseBrace) to state 198\n%!";
          Printf.eprintf "State 198:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | SEMICOLON ->
              Printf.eprintf "Shifting (SEMICOLON) to state 199\n%!";
              Printf.eprintf "State 199:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              let MenhirCell1_TokenCloseParenthesis (_menhir_stack, _) = _menhir_stack in
              let MenhirCell0_TokenIdentifier (_menhir_stack, _2, _) = _menhir_stack in
              let MenhirCell1_TokenDef (_menhir_stack, _menhir_s) = _menhir_stack in
              Printf.eprintf "Reducing production def_statement -> TokenDef TokenIdentifier TokenOpenParenthesis TokenCloseParenthesis TokenOpenBrace statement_list TokenCloseBrace SEMICOLON\n%!";
              let _6 = _v in
              let _v = _menhir_action_12 _2 _6 in
              _menhir_goto_def_statement _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_214 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_TokenElse as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 214:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTry ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTry) to state 1\n%!";
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState214
      | TokenReturn ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenReturn) to state 3\n%!";
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState214
      | TokenPrint ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenPrint) to state 55\n%!";
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState214
      | TokenMatch ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenMatch) to state 81\n%!";
          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState214
      | TokenLog ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenLog) to state 89\n%!";
          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState214
      | TokenLet ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenLet) to state 94\n%!";
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState214
      | TokenImport ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenImport) to state 141\n%!";
          _menhir_run_141 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState214
      | TokenIf ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenIf) to state 145\n%!";
          _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState214
      | TokenIdentifier _v_0 ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenIdentifier) to state 150\n%!";
          _menhir_run_150 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState214
      | TokenFor ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenFor) to state 155\n%!";
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState214
      | TokenElse ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenElse) to state 162\n%!";
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState214
      | TokenDef ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenDef) to state 164\n%!";
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState214
      | TokenCloseBrace ->
          Printf.eprintf "Shifting (TokenCloseBrace) to state 215\n%!";
          Printf.eprintf "State 215:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | SEMICOLON ->
              Printf.eprintf "Shifting (SEMICOLON) to state 216\n%!";
              Printf.eprintf "State 216:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              let MenhirCell1_TokenElse (_menhir_stack, _menhir_s) = _menhir_stack in
              Printf.eprintf "Reducing production else_statement -> TokenElse TokenOpenBrace statement_list TokenCloseBrace SEMICOLON\n%!";
              let _3 = _v in
              let _v = _menhir_action_14 _3 in
              Printf.eprintf "State 192:\n%!";
              Printf.eprintf "Reducing production statement -> else_statement\n%!";
              let _1 = _v in
              let _v = _menhir_action_82 _1 in
              _menhir_goto_statement _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_204 : type  ttv_stack. (((ttv_stack, _menhir_box_main) _menhir_cell1_TokenDef _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_cell1_parameter_list _menhir_cell0_VOID as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 204:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTry ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTry) to state 1\n%!";
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | TokenReturn ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenReturn) to state 3\n%!";
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | TokenPrint ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenPrint) to state 55\n%!";
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | TokenMatch ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenMatch) to state 81\n%!";
          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | TokenLog ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenLog) to state 89\n%!";
          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | TokenLet ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenLet) to state 94\n%!";
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | TokenImport ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenImport) to state 141\n%!";
          _menhir_run_141 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | TokenIf ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenIf) to state 145\n%!";
          _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | TokenIdentifier _v_0 ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenIdentifier) to state 150\n%!";
          _menhir_run_150 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState204
      | TokenFor ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenFor) to state 155\n%!";
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | TokenElse ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenElse) to state 162\n%!";
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | TokenDef ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenDef) to state 164\n%!";
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | TokenCloseBrace ->
          Printf.eprintf "Shifting (TokenCloseBrace) to state 205\n%!";
          Printf.eprintf "State 205:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | SEMICOLON ->
              Printf.eprintf "Shifting (SEMICOLON) to state 206\n%!";
              Printf.eprintf "State 206:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              let MenhirCell0_VOID (_menhir_stack, _) = _menhir_stack in
              let MenhirCell1_parameter_list (_menhir_stack, _, _4) = _menhir_stack in
              let MenhirCell0_TokenIdentifier (_menhir_stack, _2, _) = _menhir_stack in
              let MenhirCell1_TokenDef (_menhir_stack, _menhir_s) = _menhir_stack in
              Printf.eprintf "Reducing production def_statement -> TokenDef TokenIdentifier TokenOpenParenthesis parameter_list TokenCloseParenthesis VOID TokenOpenBrace statement_list TokenCloseBrace SEMICOLON\n%!";
              let _8 = _v in
              let _v = _menhir_action_11 _2 _4 _8 in
              _menhir_goto_def_statement _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_208 : type  ttv_stack. (((ttv_stack, _menhir_box_main) _menhir_cell1_TokenDef _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_cell1_parameter_list as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 208:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTry ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTry) to state 1\n%!";
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState208
      | TokenReturn ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenReturn) to state 3\n%!";
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState208
      | TokenPrint ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenPrint) to state 55\n%!";
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState208
      | TokenMatch ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenMatch) to state 81\n%!";
          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState208
      | TokenLog ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenLog) to state 89\n%!";
          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState208
      | TokenLet ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenLet) to state 94\n%!";
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState208
      | TokenImport ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenImport) to state 141\n%!";
          _menhir_run_141 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState208
      | TokenIf ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenIf) to state 145\n%!";
          _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState208
      | TokenIdentifier _v_0 ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenIdentifier) to state 150\n%!";
          _menhir_run_150 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState208
      | TokenFor ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenFor) to state 155\n%!";
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState208
      | TokenElse ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenElse) to state 162\n%!";
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState208
      | TokenDef ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenDef) to state 164\n%!";
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState208
      | TokenCloseBrace ->
          Printf.eprintf "Shifting (TokenCloseBrace) to state 209\n%!";
          Printf.eprintf "State 209:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | SEMICOLON ->
              Printf.eprintf "Shifting (SEMICOLON) to state 210\n%!";
              Printf.eprintf "State 210:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              let MenhirCell1_parameter_list (_menhir_stack, _, _4) = _menhir_stack in
              let MenhirCell0_TokenIdentifier (_menhir_stack, _2, _) = _menhir_stack in
              let MenhirCell1_TokenDef (_menhir_stack, _menhir_s) = _menhir_stack in
              Printf.eprintf "Reducing production def_statement -> TokenDef TokenIdentifier TokenOpenParenthesis parameter_list TokenCloseParenthesis TokenOpenBrace statement_list TokenCloseBrace SEMICOLON\n%!";
              let _7 = _v in
              let _v = _menhir_action_10 _2 _4 _7 in
              _menhir_goto_def_statement _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_212 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_TokenDef _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_cell1_parameter_list -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      Printf.eprintf "State 212:\n%!";
      let MenhirCell1_parameter_list (_menhir_stack, _menhir_s, _1) = _menhir_stack in
      Printf.eprintf "Reducing production parameter_list -> parameter_list COMMA parameter\n%!";
      let _3 = _v in
      let _v = _menhir_action_71 _1 _3 in
      _menhir_goto_parameter_list _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_104 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_TokenLet _menhir_cell0_TokenIdentifier as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 104:\n%!";
      let _menhir_stack = MenhirCell1_data_types (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | TokenConst ->
          Printf.eprintf "Shifting (TokenConst) to state 105\n%!";
          Printf.eprintf "State 105:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | COLON ->
              Printf.eprintf "Shifting (COLON) to state 106\n%!";
              Printf.eprintf "State 106:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | EQUAL ->
                  Printf.eprintf "Shifting (EQUAL) to state 107\n%!";
                  Printf.eprintf "State 107:\n%!";
                  let _menhir_s = MenhirState107 in
                  let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | TokenOpenParenthesis ->
                      Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
                      _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | TokenOpenBracket ->
                      Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
                      _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | TokenNot ->
                      Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
                      _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | TokenIdentifier _v ->
                      Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
                      _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | StringLiteral _v ->
                      Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
                      _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | MINUS ->
                      Printf.eprintf "Shifting (MINUS) to state 9\n%!";
                      _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | IntLiteral _v ->
                      Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
                      _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | INTEGER _v ->
                      Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
                      _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | FloatLiteral _v ->
                      Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
                      _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | CharLiteral _v ->
                      Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
                      _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | BoolLiteral _v ->
                      Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
                      _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | _ ->
                      Printf.eprintf "Initiating error handling\n%!";
                      _eRR ())
              | _ ->
                  Printf.eprintf "Initiating error handling\n%!";
                  _eRR ())
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | LIST _v_7 ->
          Printf.eprintf "Shifting (LIST) to state 110\n%!";
          Printf.eprintf "State 110:\n%!";
          let _menhir_stack = MenhirCell0_LIST (_menhir_stack, _v_7) in
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TokenConst ->
              Printf.eprintf "Shifting (TokenConst) to state 111\n%!";
              Printf.eprintf "State 111:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | COLON ->
                  Printf.eprintf "Shifting (COLON) to state 112\n%!";
                  Printf.eprintf "State 112:\n%!";
                  let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | EQUAL ->
                      Printf.eprintf "Shifting (EQUAL) to state 113\n%!";
                      Printf.eprintf "State 113:\n%!";
                      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
                      (match (_tok : MenhirBasics.token) with
                      | TokenOpenBracket ->
                          Printf.eprintf "Shifting (TokenOpenBracket) to state 114\n%!";
                          Printf.eprintf "State 114:\n%!";
                          let _menhir_s = MenhirState114 in
                          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
                          (match (_tok : MenhirBasics.token) with
                          | TokenOpenParenthesis ->
                              Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
                              _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                          | TokenOpenBracket ->
                              Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
                              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                          | TokenNot ->
                              Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
                              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                          | TokenIdentifier _v ->
                              Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
                              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                          | StringLiteral _v ->
                              Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
                              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                          | MINUS ->
                              Printf.eprintf "Shifting (MINUS) to state 9\n%!";
                              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                          | IntLiteral _v ->
                              Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
                              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                          | INTEGER _v ->
                              Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
                              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                          | FloatLiteral _v ->
                              Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
                              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                          | CharLiteral _v ->
                              Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
                              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                          | BoolLiteral _v ->
                              Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
                              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                          | _ ->
                              Printf.eprintf "Initiating error handling\n%!";
                              _eRR ())
                      | _ ->
                          Printf.eprintf "Initiating error handling\n%!";
                          _eRR ())
                  | _ ->
                      Printf.eprintf "Initiating error handling\n%!";
                      _eRR ())
              | _ ->
                  Printf.eprintf "Initiating error handling\n%!";
                  _eRR ())
          | COLON ->
              Printf.eprintf "Shifting (COLON) to state 118\n%!";
              Printf.eprintf "State 118:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | EQUAL ->
                  Printf.eprintf "Shifting (EQUAL) to state 119\n%!";
                  Printf.eprintf "State 119:\n%!";
                  let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | TokenOpenBracket ->
                      Printf.eprintf "Shifting (TokenOpenBracket) to state 120\n%!";
                      Printf.eprintf "State 120:\n%!";
                      let _menhir_s = MenhirState120 in
                      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
                      (match (_tok : MenhirBasics.token) with
                      | TokenOpenParenthesis ->
                          Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
                          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                      | TokenOpenBracket ->
                          Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
                          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                      | TokenNot ->
                          Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
                          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                      | TokenIdentifier _v ->
                          Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
                          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                      | StringLiteral _v ->
                          Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
                          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                      | MINUS ->
                          Printf.eprintf "Shifting (MINUS) to state 9\n%!";
                          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                      | IntLiteral _v ->
                          Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
                          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                      | INTEGER _v ->
                          Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
                          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                      | FloatLiteral _v ->
                          Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
                          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                      | CharLiteral _v ->
                          Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
                          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                      | BoolLiteral _v ->
                          Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
                          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                      | _ ->
                          Printf.eprintf "Initiating error handling\n%!";
                          _eRR ())
                  | _ ->
                      Printf.eprintf "Initiating error handling\n%!";
                      _eRR ())
              | _ ->
                  Printf.eprintf "Initiating error handling\n%!";
                  _eRR ())
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | COLON ->
          Printf.eprintf "Shifting (COLON) to state 124\n%!";
          Printf.eprintf "State 124:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | EQUAL ->
              Printf.eprintf "Shifting (EQUAL) to state 125\n%!";
              Printf.eprintf "State 125:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | TokenOpenParenthesis ->
                  Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
                  _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
              | TokenOpenBracket ->
                  Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
                  _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
              | TokenNot ->
                  Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
                  _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
              | TokenIdentifier _v_22 ->
                  Printf.eprintf "Shifting (TokenIdentifier) to state 126\n%!";
                  Printf.eprintf "State 126:\n%!";
                  let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
                  let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | TokenOpenParenthesis ->
                      let _menhir_stack = MenhirCell1_TokenIdentifier (_menhir_stack, MenhirState125, _v_22, _startpos) in
                      Printf.eprintf "Shifting (TokenOpenParenthesis) to state 127\n%!";
                      _menhir_run_127 _menhir_stack _menhir_lexbuf _menhir_lexer
                  | DIV | EQUAL | GREATER | LESS | MINUS | PLUS | SEMICOLON | TIMES | TokenNot | TokenTo ->
                      Printf.eprintf "Reducing production expression -> TokenIdentifier\n%!";
                      let _v_23 =
                        let _1 = _v_22 in
                        _menhir_action_22 _1
                      in
                      _menhir_run_139 _menhir_stack _menhir_lexbuf _menhir_lexer _v_23 MenhirState125 _tok
                  | DOT ->
                      Printf.eprintf "Reducing production namespaced_identifier -> TokenIdentifier\n%!";
                      let _v_24 =
                        let _1 = _v_22 in
                        _menhir_action_64 _1
                      in
                      _menhir_run_133 _menhir_stack _menhir_lexbuf _menhir_lexer _startpos _v_24 MenhirState125 _tok
                  | _ ->
                      Printf.eprintf "Initiating error handling\n%!";
                      _eRR ())
              | StringLiteral _v_25 ->
                  Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
                  _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v_25 MenhirState125
              | MINUS ->
                  Printf.eprintf "Shifting (MINUS) to state 9\n%!";
                  _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState125
              | IntLiteral _v_26 ->
                  Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
                  _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v_26 MenhirState125
              | INTEGER _v_27 ->
                  Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
                  _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v_27 MenhirState125
              | FloatLiteral _v_28 ->
                  Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
                  _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v_28 MenhirState125
              | CharLiteral _v_29 ->
                  Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
                  _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v_29 MenhirState125
              | BoolLiteral _v_30 ->
                  Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
                  _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v_30 MenhirState125
              | _ ->
                  Printf.eprintf "Initiating error handling\n%!";
                  _eRR ())
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_139 : type  ttv_stack. (((ttv_stack, _menhir_box_main) _menhir_cell1_TokenLet _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_cell1_data_types as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 139:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTo ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTo) to state 21\n%!";
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenNot ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenNot) to state 23\n%!";
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TIMES ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TIMES) to state 26\n%!";
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SEMICOLON ->
          Printf.eprintf "Shifting (SEMICOLON) to state 140\n%!";
          Printf.eprintf "State 140:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_data_types (_menhir_stack, _, _4) = _menhir_stack in
          let MenhirCell0_TokenIdentifier (_menhir_stack, _2, _) = _menhir_stack in
          let MenhirCell1_TokenLet (_menhir_stack, _menhir_s) = _menhir_stack in
          Printf.eprintf "Reducing production let_statement -> TokenLet TokenIdentifier COLON data_types COLON EQUAL expression SEMICOLON\n%!";
          let _7 = _v in
          let _v = _menhir_action_52 _2 _4 _7 in
          _menhir_goto_let_statement _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (PLUS) to state 30\n%!";
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (MINUS) to state 34\n%!";
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LESS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (LESS) to state 28\n%!";
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GREATER ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (GREATER) to state 32\n%!";
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQUAL ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (EQUAL) to state 36\n%!";
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (DIV) to state 38\n%!";
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_goto_let_statement : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 187:\n%!";
      Printf.eprintf "Reducing production statement -> let_statement\n%!";
      let _1 = _v in
      let _v = _menhir_action_80 _1 in
      _menhir_goto_statement _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_260 : type  ttv_stack. ((((ttv_stack, _menhir_box_main) _menhir_cell1_TokenTry, _menhir_box_main) _menhir_cell1_statement_list, _menhir_box_main) _menhir_cell1_TokenCloseBrace _menhir_cell0_error_catcher as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 260:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTry ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTry) to state 1\n%!";
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState260
      | TokenReturn ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenReturn) to state 3\n%!";
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState260
      | TokenPrint ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenPrint) to state 55\n%!";
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState260
      | TokenMatch ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenMatch) to state 81\n%!";
          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState260
      | TokenLog ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenLog) to state 89\n%!";
          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState260
      | TokenLet ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenLet) to state 94\n%!";
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState260
      | TokenImport ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenImport) to state 141\n%!";
          _menhir_run_141 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState260
      | TokenIf ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenIf) to state 145\n%!";
          _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState260
      | TokenIdentifier _v_0 ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenIdentifier) to state 150\n%!";
          _menhir_run_150 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState260
      | TokenFor ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenFor) to state 155\n%!";
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState260
      | TokenElse ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenElse) to state 162\n%!";
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState260
      | TokenDef ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenDef) to state 164\n%!";
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState260
      | TokenCloseBrace ->
          Printf.eprintf "Shifting (TokenCloseBrace) to state 261\n%!";
          Printf.eprintf "State 261:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | SEMICOLON ->
              Printf.eprintf "Shifting (SEMICOLON) to state 262\n%!";
              Printf.eprintf "State 262:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              let MenhirCell0_error_catcher (_menhir_stack, _5) = _menhir_stack in
              let MenhirCell1_TokenCloseBrace (_menhir_stack, _) = _menhir_stack in
              let MenhirCell1_statement_list (_menhir_stack, _, _3) = _menhir_stack in
              let MenhirCell1_TokenTry (_menhir_stack, _menhir_s) = _menhir_stack in
              Printf.eprintf "Reducing production try_catch_statement -> TokenTry TokenOpenBrace statement_list TokenCloseBrace error_catcher TokenOpenBrace statement_list TokenCloseBrace SEMICOLON\n%!";
              let _7 = _v in
              let _v = _menhir_action_95 _3 _5 _7 in
              Printf.eprintf "State 178:\n%!";
              Printf.eprintf "Reducing production statement -> try_catch_statement\n%!";
              let _1 = _v in
              let _v = _menhir_action_90 _1 in
              _menhir_goto_statement _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_252 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_TokenTry as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 252:\n%!";
      let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | TokenTry ->
          Printf.eprintf "Shifting (TokenTry) to state 1\n%!";
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState252
      | TokenReturn ->
          Printf.eprintf "Shifting (TokenReturn) to state 3\n%!";
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState252
      | TokenPrint ->
          Printf.eprintf "Shifting (TokenPrint) to state 55\n%!";
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState252
      | TokenMatch ->
          Printf.eprintf "Shifting (TokenMatch) to state 81\n%!";
          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState252
      | TokenLog ->
          Printf.eprintf "Shifting (TokenLog) to state 89\n%!";
          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState252
      | TokenLet ->
          Printf.eprintf "Shifting (TokenLet) to state 94\n%!";
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState252
      | TokenImport ->
          Printf.eprintf "Shifting (TokenImport) to state 141\n%!";
          _menhir_run_141 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState252
      | TokenIf ->
          Printf.eprintf "Shifting (TokenIf) to state 145\n%!";
          _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState252
      | TokenIdentifier _v_0 ->
          Printf.eprintf "Shifting (TokenIdentifier) to state 150\n%!";
          _menhir_run_150 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState252
      | TokenFor ->
          Printf.eprintf "Shifting (TokenFor) to state 155\n%!";
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState252
      | TokenElse ->
          Printf.eprintf "Shifting (TokenElse) to state 162\n%!";
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState252
      | TokenDef ->
          Printf.eprintf "Shifting (TokenDef) to state 164\n%!";
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState252
      | TokenCloseBrace ->
          Printf.eprintf "Shifting (TokenCloseBrace) to state 253\n%!";
          Printf.eprintf "State 253:\n%!";
          let _menhir_stack = MenhirCell1_TokenCloseBrace (_menhir_stack, MenhirState252) in
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TokenLog ->
              Printf.eprintf "Shifting (TokenLog) to state 254\n%!";
              Printf.eprintf "State 254:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | TokenOpenParenthesis ->
                  Printf.eprintf "Shifting (TokenOpenParenthesis) to state 255\n%!";
                  Printf.eprintf "State 255:\n%!";
                  let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | TokenIdentifier _v_1 ->
                      Printf.eprintf "Shifting (TokenIdentifier) to state 256\n%!";
                      Printf.eprintf "State 256:\n%!";
                      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
                      (match (_tok : MenhirBasics.token) with
                      | TokenCloseParenthesis ->
                          Printf.eprintf "Shifting (TokenCloseParenthesis) to state 257\n%!";
                          Printf.eprintf "State 257:\n%!";
                          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
                          Printf.eprintf "Reducing production error_catcher -> TokenLog TokenOpenParenthesis TokenIdentifier TokenCloseParenthesis\n%!";
                          let _3 = _v_1 in
                          let _v = _menhir_action_15 _3 in
                          Printf.eprintf "State 258:\n%!";
                          let _menhir_stack = MenhirCell0_error_catcher (_menhir_stack, _v) in
                          (match (_tok : MenhirBasics.token) with
                          | TokenOpenBrace ->
                              Printf.eprintf "Shifting (TokenOpenBrace) to state 259\n%!";
                              Printf.eprintf "State 259:\n%!";
                              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
                              (match (_tok : MenhirBasics.token) with
                              | TokenTry ->
                                  Printf.eprintf "Shifting (TokenTry) to state 1\n%!";
                                  _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState259
                              | TokenReturn ->
                                  Printf.eprintf "Shifting (TokenReturn) to state 3\n%!";
                                  _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState259
                              | TokenPrint ->
                                  Printf.eprintf "Shifting (TokenPrint) to state 55\n%!";
                                  _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState259
                              | TokenMatch ->
                                  Printf.eprintf "Shifting (TokenMatch) to state 81\n%!";
                                  _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState259
                              | TokenLog ->
                                  Printf.eprintf "Shifting (TokenLog) to state 89\n%!";
                                  _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState259
                              | TokenLet ->
                                  Printf.eprintf "Shifting (TokenLet) to state 94\n%!";
                                  _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState259
                              | TokenImport ->
                                  Printf.eprintf "Shifting (TokenImport) to state 141\n%!";
                                  _menhir_run_141 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState259
                              | TokenIf ->
                                  Printf.eprintf "Shifting (TokenIf) to state 145\n%!";
                                  _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState259
                              | TokenIdentifier _v_0 ->
                                  Printf.eprintf "Shifting (TokenIdentifier) to state 150\n%!";
                                  _menhir_run_150 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState259
                              | TokenFor ->
                                  Printf.eprintf "Shifting (TokenFor) to state 155\n%!";
                                  _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState259
                              | TokenElse ->
                                  Printf.eprintf "Shifting (TokenElse) to state 162\n%!";
                                  _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState259
                              | TokenDef ->
                                  Printf.eprintf "Shifting (TokenDef) to state 164\n%!";
                                  _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState259
                              | TokenCloseBrace ->
                                  Printf.eprintf "Reducing production statement_list ->\n%!";
                                  let _v_1 = _menhir_action_94 () in
                                  _menhir_run_260 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState259 _tok
                              | _ ->
                                  Printf.eprintf "Initiating error handling\n%!";
                                  _eRR ())
                          | _ ->
                              Printf.eprintf "Initiating error handling\n%!";
                              _eRR ())
                      | _ ->
                          Printf.eprintf "Initiating error handling\n%!";
                          _eRR ())
                  | _ ->
                      Printf.eprintf "Initiating error handling\n%!";
                      _eRR ())
              | _ ->
                  Printf.eprintf "Initiating error handling\n%!";
                  _eRR ())
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_239 : type  ttv_stack. ((((ttv_stack, _menhir_box_main) _menhir_cell1_TokenPipe, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_cell1_GREATER as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 239:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTry ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTry) to state 1\n%!";
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState239
      | TokenReturn ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenReturn) to state 3\n%!";
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState239
      | TokenPrint ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenPrint) to state 55\n%!";
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState239
      | TokenMatch ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenMatch) to state 81\n%!";
          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState239
      | TokenLog ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenLog) to state 89\n%!";
          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState239
      | TokenLet ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenLet) to state 94\n%!";
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState239
      | TokenImport ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenImport) to state 141\n%!";
          _menhir_run_141 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState239
      | TokenIf ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenIf) to state 145\n%!";
          _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState239
      | TokenIdentifier _v_0 ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenIdentifier) to state 150\n%!";
          _menhir_run_150 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState239
      | TokenFor ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenFor) to state 155\n%!";
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState239
      | TokenElse ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenElse) to state 162\n%!";
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState239
      | TokenDef ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenDef) to state 164\n%!";
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState239
      | EOF | TokenCloseBrace | TokenPipe ->
          let MenhirCell1_GREATER (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expression (_menhir_stack, _, _2) = _menhir_stack in
          let MenhirCell1_TokenPipe (_menhir_stack, _menhir_s) = _menhir_stack in
          Printf.eprintf "Reducing production match_case -> TokenPipe expression MINUS GREATER statement_list\n%!";
          let _5 = _v in
          let _v = _menhir_action_58 _2 _5 in
          _menhir_goto_match_case _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_goto_match_case : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState083 ->
          _menhir_run_251 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState240 ->
          _menhir_run_249 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_251 : type  ttv_stack. (((ttv_stack, _menhir_box_main) _menhir_cell1_TokenMatch, _menhir_box_main) _menhir_cell1_expression as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 251:\n%!";
      Printf.eprintf "Reducing production match_cases -> match_case\n%!";
      let _1 = _v in
      let _v = _menhir_action_61 _1 in
      _menhir_goto_match_cases _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_match_cases : type  ttv_stack. (((ttv_stack, _menhir_box_main) _menhir_cell1_TokenMatch, _menhir_box_main) _menhir_cell1_expression as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 240:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenPipe ->
          let _menhir_stack = MenhirCell1_match_cases (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenPipe) to state 241\n%!";
          Printf.eprintf "State 241:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TokenOpenParenthesis ->
              let _menhir_stack = MenhirCell1_TokenPipe (_menhir_stack, MenhirState240) in
              Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
              _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState241
          | TokenOpenBracket ->
              let _menhir_stack = MenhirCell1_TokenPipe (_menhir_stack, MenhirState240) in
              Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState241
          | TokenNot ->
              let _menhir_stack = MenhirCell1_TokenPipe (_menhir_stack, MenhirState240) in
              Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState241
          | TokenIdentifier _v_0 ->
              Printf.eprintf "Shifting (TokenIdentifier) to state 242\n%!";
              Printf.eprintf "State 242:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | MINUS ->
                  Printf.eprintf "Shifting (MINUS) to state 243\n%!";
                  Printf.eprintf "State 243:\n%!";
                  let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | GREATER ->
                      Printf.eprintf "Shifting (GREATER) to state 244\n%!";
                      Printf.eprintf "State 244:\n%!";
                      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
                      (match (_tok : MenhirBasics.token) with
                      | TokenLog ->
                          Printf.eprintf "Shifting (TokenLog) to state 245\n%!";
                          Printf.eprintf "State 245:\n%!";
                          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
                          (match (_tok : MenhirBasics.token) with
                          | TokenOpenParenthesis ->
                              Printf.eprintf "Shifting (TokenOpenParenthesis) to state 246\n%!";
                              Printf.eprintf "State 246:\n%!";
                              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
                              (match (_tok : MenhirBasics.token) with
                              | TokenIdentifier _v_1 ->
                                  Printf.eprintf "Shifting (TokenIdentifier) to state 247\n%!";
                                  Printf.eprintf "State 247:\n%!";
                                  let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
                                  (match (_tok : MenhirBasics.token) with
                                  | TokenCloseParenthesis ->
                                      Printf.eprintf "Shifting (TokenCloseParenthesis) to state 248\n%!";
                                      Printf.eprintf "State 248:\n%!";
                                      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
                                      Printf.eprintf "Reducing production final_case -> TokenPipe TokenIdentifier MINUS GREATER TokenLog TokenOpenParenthesis TokenIdentifier TokenCloseParenthesis\n%!";
                                      let (_2, _7) = (_v_0, _v_1) in
                                      let _v = _menhir_action_42 _2 _7 in
                                      Printf.eprintf "State 250:\n%!";
                                      let MenhirCell1_match_cases (_menhir_stack, _menhir_s, _1) = _menhir_stack in
                                      Printf.eprintf "Reducing production match_cases -> match_cases final_case\n%!";
                                      let _2 = _v in
                                      let _v = _menhir_action_62 _1 _2 in
                                      _menhir_goto_match_cases _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
                                  | _ ->
                                      Printf.eprintf "Initiating error handling\n%!";
                                      _eRR ())
                              | _ ->
                                  Printf.eprintf "Initiating error handling\n%!";
                                  _eRR ())
                          | _ ->
                              Printf.eprintf "Initiating error handling\n%!";
                              _eRR ())
                      | _ ->
                          Printf.eprintf "Initiating error handling\n%!";
                          _eRR ())
                  | _ ->
                      Printf.eprintf "Initiating error handling\n%!";
                      _eRR ())
              | DIV | EQUAL | GREATER | LESS | PLUS | TIMES | TokenNot | TokenTo ->
                  let _menhir_stack = MenhirCell1_TokenPipe (_menhir_stack, MenhirState240) in
                  Printf.eprintf "Reducing production expression -> TokenIdentifier\n%!";
                  let _v_4 =
                    let _1 = _v_0 in
                    _menhir_action_22 _1
                  in
                  _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer _v_4 MenhirState241 _tok
              | _ ->
                  Printf.eprintf "Initiating error handling\n%!";
                  _eRR ())
          | StringLiteral _v_5 ->
              let _menhir_stack = MenhirCell1_TokenPipe (_menhir_stack, MenhirState240) in
              Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v_5 MenhirState241
          | MINUS ->
              let _menhir_stack = MenhirCell1_TokenPipe (_menhir_stack, MenhirState240) in
              Printf.eprintf "Shifting (MINUS) to state 9\n%!";
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState241
          | IntLiteral _v_6 ->
              let _menhir_stack = MenhirCell1_TokenPipe (_menhir_stack, MenhirState240) in
              Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v_6 MenhirState241
          | INTEGER _v_7 ->
              let _menhir_stack = MenhirCell1_TokenPipe (_menhir_stack, MenhirState240) in
              Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v_7 MenhirState241
          | FloatLiteral _v_8 ->
              let _menhir_stack = MenhirCell1_TokenPipe (_menhir_stack, MenhirState240) in
              Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v_8 MenhirState241
          | CharLiteral _v_9 ->
              let _menhir_stack = MenhirCell1_TokenPipe (_menhir_stack, MenhirState240) in
              Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v_9 MenhirState241
          | BoolLiteral _v_10 ->
              let _menhir_stack = MenhirCell1_TokenPipe (_menhir_stack, MenhirState240) in
              Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v_10 MenhirState241
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | EOF | TokenCloseBrace | TokenDef | TokenElse | TokenFor | TokenIdentifier _ | TokenIf | TokenImport | TokenLet | TokenLog | TokenMatch | TokenPrint | TokenReturn | TokenTry ->
          let MenhirCell1_expression (_menhir_stack, _, _2) = _menhir_stack in
          let MenhirCell1_TokenMatch (_menhir_stack, _menhir_s) = _menhir_stack in
          Printf.eprintf "Reducing production match_statement -> TokenMatch expression TokenWith match_cases\n%!";
          let _4 = _v in
          let _v = _menhir_action_63 _2 _4 in
          Printf.eprintf "State 185:\n%!";
          Printf.eprintf "Reducing production statement -> match_statement\n%!";
          let _1 = _v in
          let _v = _menhir_action_91 _1 in
          _menhir_goto_statement _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_085 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_TokenPipe as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 85:\n%!";
      let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | TokenTo ->
          Printf.eprintf "Shifting (TokenTo) to state 21\n%!";
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenNot ->
          Printf.eprintf "Shifting (TokenNot) to state 23\n%!";
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TIMES ->
          Printf.eprintf "Shifting (TIMES) to state 26\n%!";
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          Printf.eprintf "Shifting (PLUS) to state 30\n%!";
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          Printf.eprintf "Shifting (MINUS) to state 86\n%!";
          Printf.eprintf "State 86:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TokenOpenParenthesis ->
              Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
              _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState086
          | TokenOpenBracket ->
              Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState086
          | TokenNot ->
              Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState086
          | TokenIdentifier _v_0 ->
              Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState086
          | StringLiteral _v_1 ->
              Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState086
          | MINUS ->
              Printf.eprintf "Shifting (MINUS) to state 9\n%!";
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState086
          | IntLiteral _v_2 ->
              Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState086
          | INTEGER _v_3 ->
              Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v_3 MenhirState086
          | GREATER ->
              Printf.eprintf "Shifting (GREATER) to state 87\n%!";
              Printf.eprintf "State 87:\n%!";
              let _menhir_stack = MenhirCell1_GREATER (_menhir_stack, MenhirState086) in
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | TokenTry ->
                  Printf.eprintf "Shifting (TokenTry) to state 1\n%!";
                  _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState087
              | TokenReturn ->
                  Printf.eprintf "Shifting (TokenReturn) to state 3\n%!";
                  _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState087
              | TokenPrint ->
                  Printf.eprintf "Shifting (TokenPrint) to state 55\n%!";
                  _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState087
              | TokenOpenBrace ->
                  Printf.eprintf "Shifting (TokenOpenBrace) to state 88\n%!";
                  Printf.eprintf "State 88:\n%!";
                  let _menhir_stack = MenhirCell1_TokenOpenBrace (_menhir_stack, MenhirState087) in
                  let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | TokenTry ->
                      Printf.eprintf "Shifting (TokenTry) to state 1\n%!";
                      _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState088
                  | TokenReturn ->
                      Printf.eprintf "Shifting (TokenReturn) to state 3\n%!";
                      _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState088
                  | TokenPrint ->
                      Printf.eprintf "Shifting (TokenPrint) to state 55\n%!";
                      _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState088
                  | TokenMatch ->
                      Printf.eprintf "Shifting (TokenMatch) to state 81\n%!";
                      _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState088
                  | TokenLog ->
                      Printf.eprintf "Shifting (TokenLog) to state 89\n%!";
                      _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState088
                  | TokenLet ->
                      Printf.eprintf "Shifting (TokenLet) to state 94\n%!";
                      _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState088
                  | TokenImport ->
                      Printf.eprintf "Shifting (TokenImport) to state 141\n%!";
                      _menhir_run_141 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState088
                  | TokenIf ->
                      Printf.eprintf "Shifting (TokenIf) to state 145\n%!";
                      _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState088
                  | TokenIdentifier _v_4 ->
                      Printf.eprintf "Shifting (TokenIdentifier) to state 150\n%!";
                      _menhir_run_150 _menhir_stack _menhir_lexbuf _menhir_lexer _v_4 MenhirState088
                  | TokenFor ->
                      Printf.eprintf "Shifting (TokenFor) to state 155\n%!";
                      _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState088
                  | TokenElse ->
                      Printf.eprintf "Shifting (TokenElse) to state 162\n%!";
                      _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState088
                  | TokenDef ->
                      Printf.eprintf "Shifting (TokenDef) to state 164\n%!";
                      _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState088
                  | TokenCloseBrace ->
                      Printf.eprintf "Reducing production statement_list ->\n%!";
                      let _v_5 = _menhir_action_94 () in
                      _menhir_run_237 _menhir_stack _menhir_lexbuf _menhir_lexer _v_5 MenhirState088 _tok
                  | _ ->
                      Printf.eprintf "Initiating error handling\n%!";
                      _eRR ())
              | TokenMatch ->
                  Printf.eprintf "Shifting (TokenMatch) to state 81\n%!";
                  _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState087
              | TokenLog ->
                  Printf.eprintf "Shifting (TokenLog) to state 89\n%!";
                  _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState087
              | TokenLet ->
                  Printf.eprintf "Shifting (TokenLet) to state 94\n%!";
                  _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState087
              | TokenImport ->
                  Printf.eprintf "Shifting (TokenImport) to state 141\n%!";
                  _menhir_run_141 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState087
              | TokenIf ->
                  Printf.eprintf "Shifting (TokenIf) to state 145\n%!";
                  _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState087
              | TokenIdentifier _v_6 ->
                  Printf.eprintf "Shifting (TokenIdentifier) to state 150\n%!";
                  _menhir_run_150 _menhir_stack _menhir_lexbuf _menhir_lexer _v_6 MenhirState087
              | TokenFor ->
                  Printf.eprintf "Shifting (TokenFor) to state 155\n%!";
                  _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState087
              | TokenElse ->
                  Printf.eprintf "Shifting (TokenElse) to state 162\n%!";
                  _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState087
              | TokenDef ->
                  Printf.eprintf "Shifting (TokenDef) to state 164\n%!";
                  _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState087
              | EOF | TokenCloseBrace | TokenPipe ->
                  Printf.eprintf "Reducing production statement_list ->\n%!";
                  let _v_7 = _menhir_action_94 () in
                  _menhir_run_239 _menhir_stack _menhir_lexbuf _menhir_lexer _v_7 MenhirState087 _tok
              | _ ->
                  Printf.eprintf "Initiating error handling\n%!";
                  _eRR ())
          | FloatLiteral _v_8 ->
              Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v_8 MenhirState086
          | CharLiteral _v_9 ->
              Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v_9 MenhirState086
          | BoolLiteral _v_10 ->
              Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v_10 MenhirState086
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | LESS ->
          Printf.eprintf "Shifting (LESS) to state 28\n%!";
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GREATER ->
          Printf.eprintf "Shifting (GREATER) to state 32\n%!";
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQUAL ->
          Printf.eprintf "Shifting (EQUAL) to state 36\n%!";
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          Printf.eprintf "Shifting (DIV) to state 38\n%!";
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_237 : type  ttv_stack. (((((ttv_stack, _menhir_box_main) _menhir_cell1_TokenPipe, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_cell1_GREATER, _menhir_box_main) _menhir_cell1_TokenOpenBrace as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 237:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTry ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTry) to state 1\n%!";
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState237
      | TokenReturn ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenReturn) to state 3\n%!";
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState237
      | TokenPrint ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenPrint) to state 55\n%!";
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState237
      | TokenMatch ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenMatch) to state 81\n%!";
          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState237
      | TokenLog ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenLog) to state 89\n%!";
          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState237
      | TokenLet ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenLet) to state 94\n%!";
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState237
      | TokenImport ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenImport) to state 141\n%!";
          _menhir_run_141 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState237
      | TokenIf ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenIf) to state 145\n%!";
          _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState237
      | TokenIdentifier _v_0 ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenIdentifier) to state 150\n%!";
          _menhir_run_150 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState237
      | TokenFor ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenFor) to state 155\n%!";
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState237
      | TokenElse ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenElse) to state 162\n%!";
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState237
      | TokenDef ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenDef) to state 164\n%!";
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState237
      | TokenCloseBrace ->
          Printf.eprintf "Shifting (TokenCloseBrace) to state 238\n%!";
          Printf.eprintf "State 238:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_TokenOpenBrace (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_GREATER (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expression (_menhir_stack, _, _2) = _menhir_stack in
          let MenhirCell1_TokenPipe (_menhir_stack, _menhir_s) = _menhir_stack in
          Printf.eprintf "Reducing production match_case -> TokenPipe expression MINUS GREATER TokenOpenBrace statement_list TokenCloseBrace\n%!";
          let _6 = _v in
          let _v = _menhir_action_59 _2 _6 in
          _menhir_goto_match_case _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_249 : type  ttv_stack. (((ttv_stack, _menhir_box_main) _menhir_cell1_TokenMatch, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_cell1_match_cases -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      Printf.eprintf "State 249:\n%!";
      let MenhirCell1_match_cases (_menhir_stack, _menhir_s, _1) = _menhir_stack in
      Printf.eprintf "Reducing production match_cases -> match_cases match_case\n%!";
      let _2 = _v in
      let _v = _menhir_action_60 _1 _2 in
      _menhir_goto_match_cases _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_233 : type  ttv_stack. (((((ttv_stack, _menhir_box_main) _menhir_cell1_TokenIf, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_cell1_statement_list, _menhir_box_main) _menhir_cell1_TokenCloseBrace as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 233:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTry ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTry) to state 1\n%!";
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState233
      | TokenReturn ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenReturn) to state 3\n%!";
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState233
      | TokenPrint ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenPrint) to state 55\n%!";
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState233
      | TokenMatch ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenMatch) to state 81\n%!";
          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState233
      | TokenLog ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenLog) to state 89\n%!";
          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState233
      | TokenLet ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenLet) to state 94\n%!";
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState233
      | TokenImport ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenImport) to state 141\n%!";
          _menhir_run_141 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState233
      | TokenIf ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenIf) to state 145\n%!";
          _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState233
      | TokenIdentifier _v_0 ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenIdentifier) to state 150\n%!";
          _menhir_run_150 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState233
      | TokenFor ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenFor) to state 155\n%!";
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState233
      | TokenElse ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenElse) to state 162\n%!";
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState233
      | TokenDef ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenDef) to state 164\n%!";
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState233
      | TokenCloseBrace ->
          Printf.eprintf "Shifting (TokenCloseBrace) to state 234\n%!";
          Printf.eprintf "State 234:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | SEMICOLON ->
              Printf.eprintf "Shifting (SEMICOLON) to state 235\n%!";
              Printf.eprintf "State 235:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              let MenhirCell1_TokenCloseBrace (_menhir_stack, _) = _menhir_stack in
              let MenhirCell1_statement_list (_menhir_stack, _, _6) = _menhir_stack in
              let MenhirCell1_expression (_menhir_stack, _, _3) = _menhir_stack in
              let MenhirCell1_TokenIf (_menhir_stack, _menhir_s) = _menhir_stack in
              Printf.eprintf "Reducing production if_statement -> TokenIf TokenOpenParenthesis expression TokenCloseParenthesis TokenOpenBrace statement_list TokenCloseBrace TokenElse TokenOpenBrace statement_list TokenCloseBrace SEMICOLON\n%!";
              let _10 = _v in
              let _v = _menhir_action_49 _10 _3 _6 in
              _menhir_goto_if_statement _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_goto_if_statement : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 189:\n%!";
      Printf.eprintf "Reducing production statement -> if_statement\n%!";
      let _1 = _v in
      let _v = _menhir_action_81 _1 in
      _menhir_goto_statement _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_229 : type  ttv_stack. (((ttv_stack, _menhir_box_main) _menhir_cell1_TokenIf, _menhir_box_main) _menhir_cell1_expression as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 229:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTry ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTry) to state 1\n%!";
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState229
      | TokenReturn ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenReturn) to state 3\n%!";
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState229
      | TokenPrint ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenPrint) to state 55\n%!";
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState229
      | TokenMatch ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenMatch) to state 81\n%!";
          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState229
      | TokenLog ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenLog) to state 89\n%!";
          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState229
      | TokenLet ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenLet) to state 94\n%!";
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState229
      | TokenImport ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenImport) to state 141\n%!";
          _menhir_run_141 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState229
      | TokenIf ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenIf) to state 145\n%!";
          _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState229
      | TokenIdentifier _v_0 ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenIdentifier) to state 150\n%!";
          _menhir_run_150 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState229
      | TokenFor ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenFor) to state 155\n%!";
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState229
      | TokenElse ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenElse) to state 162\n%!";
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState229
      | TokenDef ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenDef) to state 164\n%!";
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState229
      | TokenCloseBrace ->
          Printf.eprintf "Shifting (TokenCloseBrace) to state 230\n%!";
          Printf.eprintf "State 230:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TokenElse ->
              let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
              let _menhir_stack = MenhirCell1_TokenCloseBrace (_menhir_stack, MenhirState229) in
              Printf.eprintf "Shifting (TokenElse) to state 231\n%!";
              Printf.eprintf "State 231:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | TokenOpenBrace ->
                  Printf.eprintf "Shifting (TokenOpenBrace) to state 232\n%!";
                  Printf.eprintf "State 232:\n%!";
                  let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | TokenTry ->
                      Printf.eprintf "Shifting (TokenTry) to state 1\n%!";
                      _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState232
                  | TokenReturn ->
                      Printf.eprintf "Shifting (TokenReturn) to state 3\n%!";
                      _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState232
                  | TokenPrint ->
                      Printf.eprintf "Shifting (TokenPrint) to state 55\n%!";
                      _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState232
                  | TokenMatch ->
                      Printf.eprintf "Shifting (TokenMatch) to state 81\n%!";
                      _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState232
                  | TokenLog ->
                      Printf.eprintf "Shifting (TokenLog) to state 89\n%!";
                      _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState232
                  | TokenLet ->
                      Printf.eprintf "Shifting (TokenLet) to state 94\n%!";
                      _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState232
                  | TokenImport ->
                      Printf.eprintf "Shifting (TokenImport) to state 141\n%!";
                      _menhir_run_141 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState232
                  | TokenIf ->
                      Printf.eprintf "Shifting (TokenIf) to state 145\n%!";
                      _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState232
                  | TokenIdentifier _v_1 ->
                      Printf.eprintf "Shifting (TokenIdentifier) to state 150\n%!";
                      _menhir_run_150 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState232
                  | TokenFor ->
                      Printf.eprintf "Shifting (TokenFor) to state 155\n%!";
                      _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState232
                  | TokenElse ->
                      Printf.eprintf "Shifting (TokenElse) to state 162\n%!";
                      _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState232
                  | TokenDef ->
                      Printf.eprintf "Shifting (TokenDef) to state 164\n%!";
                      _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState232
                  | TokenCloseBrace ->
                      Printf.eprintf "Reducing production statement_list ->\n%!";
                      let _v_2 = _menhir_action_94 () in
                      _menhir_run_233 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState232 _tok
                  | _ ->
                      Printf.eprintf "Initiating error handling\n%!";
                      _eRR ())
              | _ ->
                  Printf.eprintf "Initiating error handling\n%!";
                  _eRR ())
          | SEMICOLON ->
              Printf.eprintf "Shifting (SEMICOLON) to state 236\n%!";
              Printf.eprintf "State 236:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              let MenhirCell1_expression (_menhir_stack, _, _3) = _menhir_stack in
              let MenhirCell1_TokenIf (_menhir_stack, _menhir_s) = _menhir_stack in
              Printf.eprintf "Reducing production if_statement -> TokenIf TokenOpenParenthesis expression TokenCloseParenthesis TokenOpenBrace statement_list TokenCloseBrace SEMICOLON\n%!";
              let _6 = _v in
              let _v = _menhir_action_48 _3 _6 in
              _menhir_goto_if_statement _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_226 : type  ttv_stack. (((((ttv_stack, _menhir_box_main) _menhir_cell1_TokenFor _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_cell1_expression, _menhir_box_main) _menhir_cell1_expression as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 226:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTry ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTry) to state 1\n%!";
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState226
      | TokenReturn ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenReturn) to state 3\n%!";
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState226
      | TokenPrint ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenPrint) to state 55\n%!";
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState226
      | TokenMatch ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenMatch) to state 81\n%!";
          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState226
      | TokenLog ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenLog) to state 89\n%!";
          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState226
      | TokenLet ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenLet) to state 94\n%!";
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState226
      | TokenImport ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenImport) to state 141\n%!";
          _menhir_run_141 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState226
      | TokenIf ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenIf) to state 145\n%!";
          _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState226
      | TokenIdentifier _v_0 ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenIdentifier) to state 150\n%!";
          _menhir_run_150 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState226
      | TokenFor ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenFor) to state 155\n%!";
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState226
      | TokenElse ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenElse) to state 162\n%!";
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState226
      | TokenDef ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenDef) to state 164\n%!";
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState226
      | TokenCloseBrace ->
          Printf.eprintf "Shifting (TokenCloseBrace) to state 227\n%!";
          Printf.eprintf "State 227:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | SEMICOLON ->
              Printf.eprintf "Shifting (SEMICOLON) to state 228\n%!";
              Printf.eprintf "State 228:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              let MenhirCell1_expression (_menhir_stack, _, _9) = _menhir_stack in
              let MenhirCell1_expression (_menhir_stack, _, _7) = _menhir_stack in
              let MenhirCell1_expression (_menhir_stack, _, _5) = _menhir_stack in
              let MenhirCell0_TokenIdentifier (_menhir_stack, _2, _) = _menhir_stack in
              let MenhirCell1_TokenFor (_menhir_stack, _menhir_s) = _menhir_stack in
              Printf.eprintf "Reducing production for_statement -> TokenFor TokenIdentifier TokenIn TokenOpenParenthesis expression SEMICOLON expression SEMICOLON expression TokenCloseParenthesis TokenOpenBrace statement_list TokenCloseBrace SEMICOLON\n%!";
              let _12 = _v in
              let _v = _menhir_action_44 _12 _2 _5 _7 _9 in
              _menhir_goto_for_statement _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_goto_for_statement : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 191:\n%!";
      Printf.eprintf "Reducing production statement -> for_statement\n%!";
      let _1 = _v in
      let _v = _menhir_action_86 _1 in
      _menhir_goto_statement _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_217 : type  ttv_stack. (((ttv_stack, _menhir_box_main) _menhir_cell1_TokenFor _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_cell1_expression as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 217:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTry ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTry) to state 1\n%!";
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | TokenReturn ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenReturn) to state 3\n%!";
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | TokenPrint ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenPrint) to state 55\n%!";
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | TokenMatch ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenMatch) to state 81\n%!";
          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | TokenLog ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenLog) to state 89\n%!";
          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | TokenLet ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenLet) to state 94\n%!";
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | TokenImport ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenImport) to state 141\n%!";
          _menhir_run_141 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | TokenIf ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenIf) to state 145\n%!";
          _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | TokenIdentifier _v_0 ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenIdentifier) to state 150\n%!";
          _menhir_run_150 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState217
      | TokenFor ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenFor) to state 155\n%!";
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | TokenElse ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenElse) to state 162\n%!";
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | TokenDef ->
          let _menhir_stack = MenhirCell1_statement_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenDef) to state 164\n%!";
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | TokenCloseBrace ->
          Printf.eprintf "Shifting (TokenCloseBrace) to state 218\n%!";
          Printf.eprintf "State 218:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | SEMICOLON ->
              Printf.eprintf "Shifting (SEMICOLON) to state 219\n%!";
              Printf.eprintf "State 219:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              let MenhirCell1_expression (_menhir_stack, _, _5) = _menhir_stack in
              let MenhirCell0_TokenIdentifier (_menhir_stack, _2, _) = _menhir_stack in
              let MenhirCell1_TokenFor (_menhir_stack, _menhir_s) = _menhir_stack in
              Printf.eprintf "Reducing production for_statement -> TokenFor TokenIdentifier TokenIn TokenOpenParenthesis expression TokenCloseParenthesis TokenOpenBrace statement_list TokenCloseBrace SEMICOLON\n%!";
              let _8 = _v in
              let _v = _menhir_action_43 _2 _5 _8 in
              _menhir_goto_for_statement _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_182 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_statement_list -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      Printf.eprintf "State 182:\n%!";
      let MenhirCell1_statement_list (_menhir_stack, _menhir_s, _1) = _menhir_stack in
      Printf.eprintf "Reducing production statement_list -> statement_list statement\n%!";
      let _2 = _v in
      let _v = _menhir_action_92 _1 _2 in
      _menhir_goto_statement_list _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_138 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_TokenLet _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_cell1_data_types -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      Printf.eprintf "State 138:\n%!";
      let MenhirCell1_data_types (_menhir_stack, _, _4) = _menhir_stack in
      let MenhirCell0_TokenIdentifier (_menhir_stack, _2, _) = _menhir_stack in
      let MenhirCell1_TokenLet (_menhir_stack, _menhir_s) = _menhir_stack in
      Printf.eprintf "Reducing production let_statement -> TokenLet TokenIdentifier COLON data_types COLON EQUAL function_call\n%!";
      let _7 = _v in
      let _v = _menhir_action_55 _2 _4 _7 in
      _menhir_goto_let_statement _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_046 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_expression_list -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      Printf.eprintf "State 46:\n%!";
      let _menhir_s = MenhirState046 in
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TokenOpenParenthesis ->
          Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenOpenBracket ->
          Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenNot ->
          Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TokenIdentifier _v ->
          Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | StringLiteral _v ->
          Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MINUS ->
          Printf.eprintf "Shifting (MINUS) to state 9\n%!";
          _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IntLiteral _v ->
          Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | INTEGER _v ->
          Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FloatLiteral _v ->
          Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CharLiteral _v ->
          Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | BoolLiteral _v ->
          Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_130 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_TokenIdentifier as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 130:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenCloseParenthesis ->
          Printf.eprintf "Shifting (TokenCloseParenthesis) to state 131\n%!";
          Printf.eprintf "State 131:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | SEMICOLON ->
              Printf.eprintf "Shifting (SEMICOLON) to state 132\n%!";
              Printf.eprintf "State 132:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              let MenhirCell1_TokenIdentifier (_menhir_stack, _menhir_s, _1, _startpos__1_) = _menhir_stack in
              Printf.eprintf "Reducing production function_call -> TokenIdentifier TokenOpenParenthesis expression_list TokenCloseParenthesis SEMICOLON\n%!";
              let _3 = _v in
              let _v = _menhir_action_46 _1 _3 _startpos__1_ in
              _menhir_goto_function_call _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | COMMA ->
          let _menhir_stack = MenhirCell1_expression_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (COMMA) to state 46\n%!";
          _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_063 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_TokenPrint as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 63:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenCloseParenthesis ->
          Printf.eprintf "Shifting (TokenCloseParenthesis) to state 64\n%!";
          Printf.eprintf "State 64:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | SEMICOLON ->
              Printf.eprintf "Shifting (SEMICOLON) to state 65\n%!";
              Printf.eprintf "State 65:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              let MenhirCell1_TokenPrint (_menhir_stack, _menhir_s) = _menhir_stack in
              Printf.eprintf "Reducing production print_statement -> TokenPrint TokenOpenParenthesis expression_list TokenCloseParenthesis SEMICOLON\n%!";
              let _3 = _v in
              let _v = _menhir_action_76 _3 in
              _menhir_goto_print_statement _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | COMMA ->
          let _menhir_stack = MenhirCell1_expression_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (COMMA) to state 46\n%!";
          _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_053 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_TokenReturn as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 53:\n%!";
      match (_tok : MenhirBasics.token) with
      | SEMICOLON ->
          Printf.eprintf "Shifting (SEMICOLON) to state 54\n%!";
          Printf.eprintf "State 54:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_TokenReturn (_menhir_stack, _menhir_s) = _menhir_stack in
          Printf.eprintf "Reducing production return_statement -> TokenReturn expression_list SEMICOLON\n%!";
          let _2 = _v in
          let _v = _menhir_action_78 _2 in
          Printf.eprintf "State 183:\n%!";
          Printf.eprintf "Reducing production statement -> return_statement\n%!";
          let _1 = _v in
          let _v = _menhir_action_83 _1 in
          _menhir_goto_statement _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | COMMA ->
          let _menhir_stack = MenhirCell1_expression_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (COMMA) to state 46\n%!";
          _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_049 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_TokenOpenParenthesis as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 49:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenCloseParenthesis ->
          Printf.eprintf "Shifting (TokenCloseParenthesis) to state 50\n%!";
          Printf.eprintf "State 50:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_TokenOpenParenthesis (_menhir_stack, _menhir_s) = _menhir_stack in
          Printf.eprintf "Reducing production expression -> TokenOpenParenthesis expression_list TokenCloseParenthesis\n%!";
          let _2 = _v in
          let _v = _menhir_action_25 _2 in
          _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | COMMA ->
          let _menhir_stack = MenhirCell1_expression_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (COMMA) to state 46\n%!";
          _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_044 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_TokenOpenBracket as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 44:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenCloseBracket ->
          Printf.eprintf "Shifting (TokenCloseBracket) to state 45\n%!";
          Printf.eprintf "State 45:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_TokenOpenBracket (_menhir_stack, _menhir_s) = _menhir_stack in
          Printf.eprintf "Reducing production expression -> TokenOpenBracket expression_list TokenCloseBracket\n%!";
          let _2 = _v in
          let _v = _menhir_action_24 _2 in
          _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | COMMA ->
          let _menhir_stack = MenhirCell1_expression_list (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (COMMA) to state 46\n%!";
          _menhir_run_046 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_221 : type  ttv_stack. (((ttv_stack, _menhir_box_main) _menhir_cell1_TokenFor _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_cell1_expression as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 221:\n%!";
      let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | TokenTo ->
          Printf.eprintf "Shifting (TokenTo) to state 21\n%!";
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenNot ->
          Printf.eprintf "Shifting (TokenNot) to state 23\n%!";
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TIMES ->
          Printf.eprintf "Shifting (TIMES) to state 26\n%!";
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SEMICOLON ->
          Printf.eprintf "Shifting (SEMICOLON) to state 222\n%!";
          Printf.eprintf "State 222:\n%!";
          let _menhir_s = MenhirState222 in
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TokenOpenParenthesis ->
              Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
              _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TokenOpenBracket ->
              Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TokenNot ->
              Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TokenIdentifier _v ->
              Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | StringLiteral _v ->
              Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | MINUS ->
              Printf.eprintf "Shifting (MINUS) to state 9\n%!";
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IntLiteral _v ->
              Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | INTEGER _v ->
              Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FloatLiteral _v ->
              Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | CharLiteral _v ->
              Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | BoolLiteral _v ->
              Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | PLUS ->
          Printf.eprintf "Shifting (PLUS) to state 30\n%!";
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          Printf.eprintf "Shifting (MINUS) to state 34\n%!";
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LESS ->
          Printf.eprintf "Shifting (LESS) to state 28\n%!";
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GREATER ->
          Printf.eprintf "Shifting (GREATER) to state 32\n%!";
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQUAL ->
          Printf.eprintf "Shifting (EQUAL) to state 36\n%!";
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          Printf.eprintf "Shifting (DIV) to state 38\n%!";
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_174 : type  ttv_stack. (((ttv_stack, _menhir_box_main) _menhir_cell1_TokenIdentifier, _menhir_box_main) _menhir_cell1_data_types as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 174:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTo ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTo) to state 21\n%!";
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenNot ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenNot) to state 23\n%!";
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TIMES ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TIMES) to state 26\n%!";
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (PLUS) to state 30\n%!";
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (MINUS) to state 34\n%!";
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LESS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (LESS) to state 28\n%!";
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GREATER ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (GREATER) to state 32\n%!";
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQUAL ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (EQUAL) to state 36\n%!";
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (DIV) to state 38\n%!";
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA | TokenCloseParenthesis ->
          let MenhirCell1_data_types (_menhir_stack, _, _3) = _menhir_stack in
          let MenhirCell1_TokenIdentifier (_menhir_stack, _menhir_s, _1, _) = _menhir_stack in
          Printf.eprintf "Reducing production parameter -> TokenIdentifier COLON data_types EQUAL expression\n%!";
          let _v = _menhir_action_68 _1 _3 in
          _menhir_goto_parameter _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_172 : type  ttv_stack. (((ttv_stack, _menhir_box_main) _menhir_cell1_TokenIdentifier, _menhir_box_main) _menhir_cell1_data_types as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 172:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTo ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTo) to state 21\n%!";
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenNot ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenNot) to state 23\n%!";
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TIMES ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TIMES) to state 26\n%!";
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (PLUS) to state 30\n%!";
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (MINUS) to state 34\n%!";
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LESS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (LESS) to state 28\n%!";
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GREATER ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (GREATER) to state 32\n%!";
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQUAL ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (EQUAL) to state 36\n%!";
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (DIV) to state 38\n%!";
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA | TokenCloseParenthesis ->
          let MenhirCell1_data_types (_menhir_stack, _, _3) = _menhir_stack in
          let MenhirCell1_TokenIdentifier (_menhir_stack, _menhir_s, _1, _) = _menhir_stack in
          Printf.eprintf "Reducing production parameter -> TokenIdentifier COLON data_types TokenConst EQUAL expression\n%!";
          let _v = _menhir_action_66 _1 _3 in
          _menhir_goto_parameter _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_159 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_TokenFor _menhir_cell0_TokenIdentifier as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 159:\n%!";
      let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | TokenTo ->
          Printf.eprintf "Shifting (TokenTo) to state 21\n%!";
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenNot ->
          Printf.eprintf "Shifting (TokenNot) to state 23\n%!";
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenCloseParenthesis ->
          Printf.eprintf "Shifting (TokenCloseParenthesis) to state 160\n%!";
          Printf.eprintf "State 160:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TokenOpenBrace ->
              Printf.eprintf "Shifting (TokenOpenBrace) to state 161\n%!";
              Printf.eprintf "State 161:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | TokenTry ->
                  Printf.eprintf "Shifting (TokenTry) to state 1\n%!";
                  _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState161
              | TokenReturn ->
                  Printf.eprintf "Shifting (TokenReturn) to state 3\n%!";
                  _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState161
              | TokenPrint ->
                  Printf.eprintf "Shifting (TokenPrint) to state 55\n%!";
                  _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState161
              | TokenMatch ->
                  Printf.eprintf "Shifting (TokenMatch) to state 81\n%!";
                  _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState161
              | TokenLog ->
                  Printf.eprintf "Shifting (TokenLog) to state 89\n%!";
                  _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState161
              | TokenLet ->
                  Printf.eprintf "Shifting (TokenLet) to state 94\n%!";
                  _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState161
              | TokenImport ->
                  Printf.eprintf "Shifting (TokenImport) to state 141\n%!";
                  _menhir_run_141 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState161
              | TokenIf ->
                  Printf.eprintf "Shifting (TokenIf) to state 145\n%!";
                  _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState161
              | TokenIdentifier _v_0 ->
                  Printf.eprintf "Shifting (TokenIdentifier) to state 150\n%!";
                  _menhir_run_150 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState161
              | TokenFor ->
                  Printf.eprintf "Shifting (TokenFor) to state 155\n%!";
                  _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState161
              | TokenElse ->
                  Printf.eprintf "Shifting (TokenElse) to state 162\n%!";
                  _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState161
              | TokenDef ->
                  Printf.eprintf "Shifting (TokenDef) to state 164\n%!";
                  _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState161
              | TokenCloseBrace ->
                  Printf.eprintf "Reducing production statement_list ->\n%!";
                  let _v_1 = _menhir_action_94 () in
                  _menhir_run_217 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState161 _tok
              | _ ->
                  Printf.eprintf "Initiating error handling\n%!";
                  _eRR ())
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | TIMES ->
          Printf.eprintf "Shifting (TIMES) to state 26\n%!";
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SEMICOLON ->
          Printf.eprintf "Shifting (SEMICOLON) to state 220\n%!";
          Printf.eprintf "State 220:\n%!";
          let _menhir_s = MenhirState220 in
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TokenOpenParenthesis ->
              Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
              _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TokenOpenBracket ->
              Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TokenNot ->
              Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TokenIdentifier _v ->
              Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | StringLiteral _v ->
              Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | MINUS ->
              Printf.eprintf "Shifting (MINUS) to state 9\n%!";
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IntLiteral _v ->
              Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | INTEGER _v ->
              Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FloatLiteral _v ->
              Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | CharLiteral _v ->
              Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | BoolLiteral _v ->
              Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | PLUS ->
          Printf.eprintf "Shifting (PLUS) to state 30\n%!";
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          Printf.eprintf "Shifting (MINUS) to state 34\n%!";
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LESS ->
          Printf.eprintf "Shifting (LESS) to state 28\n%!";
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GREATER ->
          Printf.eprintf "Shifting (GREATER) to state 32\n%!";
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQUAL ->
          Printf.eprintf "Shifting (EQUAL) to state 36\n%!";
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          Printf.eprintf "Shifting (DIV) to state 38\n%!";
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_153 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_TokenIdentifier as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 153:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTo ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTo) to state 21\n%!";
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenNot ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenNot) to state 23\n%!";
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TIMES ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TIMES) to state 26\n%!";
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SEMICOLON ->
          Printf.eprintf "Shifting (SEMICOLON) to state 154\n%!";
          Printf.eprintf "State 154:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_TokenIdentifier (_menhir_stack, _menhir_s, _1, _) = _menhir_stack in
          Printf.eprintf "Reducing production assignment_statement -> TokenIdentifier COLON EQUAL expression SEMICOLON\n%!";
          let _4 = _v in
          let _v = _menhir_action_01 _1 _4 in
          Printf.eprintf "State 194:\n%!";
          Printf.eprintf "Reducing production statement -> assignment_statement\n%!";
          let _1 = _v in
          let _v = _menhir_action_85 _1 in
          _menhir_goto_statement _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (PLUS) to state 30\n%!";
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (MINUS) to state 34\n%!";
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LESS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (LESS) to state 28\n%!";
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GREATER ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (GREATER) to state 32\n%!";
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQUAL ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (EQUAL) to state 36\n%!";
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (DIV) to state 38\n%!";
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_147 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_TokenIf as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 147:\n%!";
      let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | TokenTo ->
          Printf.eprintf "Shifting (TokenTo) to state 21\n%!";
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenNot ->
          Printf.eprintf "Shifting (TokenNot) to state 23\n%!";
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenCloseParenthesis ->
          Printf.eprintf "Shifting (TokenCloseParenthesis) to state 148\n%!";
          Printf.eprintf "State 148:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TokenOpenBrace ->
              Printf.eprintf "Shifting (TokenOpenBrace) to state 149\n%!";
              Printf.eprintf "State 149:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | TokenTry ->
                  Printf.eprintf "Shifting (TokenTry) to state 1\n%!";
                  _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState149
              | TokenReturn ->
                  Printf.eprintf "Shifting (TokenReturn) to state 3\n%!";
                  _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState149
              | TokenPrint ->
                  Printf.eprintf "Shifting (TokenPrint) to state 55\n%!";
                  _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState149
              | TokenMatch ->
                  Printf.eprintf "Shifting (TokenMatch) to state 81\n%!";
                  _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState149
              | TokenLog ->
                  Printf.eprintf "Shifting (TokenLog) to state 89\n%!";
                  _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState149
              | TokenLet ->
                  Printf.eprintf "Shifting (TokenLet) to state 94\n%!";
                  _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState149
              | TokenImport ->
                  Printf.eprintf "Shifting (TokenImport) to state 141\n%!";
                  _menhir_run_141 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState149
              | TokenIf ->
                  Printf.eprintf "Shifting (TokenIf) to state 145\n%!";
                  _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState149
              | TokenIdentifier _v_0 ->
                  Printf.eprintf "Shifting (TokenIdentifier) to state 150\n%!";
                  _menhir_run_150 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState149
              | TokenFor ->
                  Printf.eprintf "Shifting (TokenFor) to state 155\n%!";
                  _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState149
              | TokenElse ->
                  Printf.eprintf "Shifting (TokenElse) to state 162\n%!";
                  _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState149
              | TokenDef ->
                  Printf.eprintf "Shifting (TokenDef) to state 164\n%!";
                  _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState149
              | TokenCloseBrace ->
                  Printf.eprintf "Reducing production statement_list ->\n%!";
                  let _v_1 = _menhir_action_94 () in
                  _menhir_run_229 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState149 _tok
              | _ ->
                  Printf.eprintf "Initiating error handling\n%!";
                  _eRR ())
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | TIMES ->
          Printf.eprintf "Shifting (TIMES) to state 26\n%!";
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          Printf.eprintf "Shifting (PLUS) to state 30\n%!";
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          Printf.eprintf "Shifting (MINUS) to state 34\n%!";
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LESS ->
          Printf.eprintf "Shifting (LESS) to state 28\n%!";
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GREATER ->
          Printf.eprintf "Shifting (GREATER) to state 32\n%!";
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQUAL ->
          Printf.eprintf "Shifting (EQUAL) to state 36\n%!";
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          Printf.eprintf "Shifting (DIV) to state 38\n%!";
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_121 : type  ttv_stack. (((ttv_stack, _menhir_box_main) _menhir_cell1_TokenLet _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_cell1_data_types _menhir_cell0_LIST as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 121:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTo ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTo) to state 21\n%!";
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenNot ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenNot) to state 23\n%!";
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenCloseBracket ->
          Printf.eprintf "Shifting (TokenCloseBracket) to state 122\n%!";
          Printf.eprintf "State 122:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | SEMICOLON ->
              Printf.eprintf "Shifting (SEMICOLON) to state 123\n%!";
              Printf.eprintf "State 123:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              let MenhirCell0_LIST (_menhir_stack, _) = _menhir_stack in
              let MenhirCell1_data_types (_menhir_stack, _, _4) = _menhir_stack in
              let MenhirCell0_TokenIdentifier (_menhir_stack, _2, _) = _menhir_stack in
              let MenhirCell1_TokenLet (_menhir_stack, _menhir_s) = _menhir_stack in
              Printf.eprintf "Reducing production let_statement -> TokenLet TokenIdentifier COLON data_types LIST COLON EQUAL TokenOpenBracket expression TokenCloseBracket SEMICOLON\n%!";
              let _9 = _v in
              let _v = _menhir_action_53 _2 _4 _9 in
              _menhir_goto_let_statement _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | TIMES ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TIMES) to state 26\n%!";
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (PLUS) to state 30\n%!";
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (MINUS) to state 34\n%!";
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LESS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (LESS) to state 28\n%!";
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GREATER ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (GREATER) to state 32\n%!";
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQUAL ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (EQUAL) to state 36\n%!";
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (DIV) to state 38\n%!";
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_115 : type  ttv_stack. (((ttv_stack, _menhir_box_main) _menhir_cell1_TokenLet _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_cell1_data_types _menhir_cell0_LIST as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 115:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTo ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTo) to state 21\n%!";
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenNot ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenNot) to state 23\n%!";
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenCloseBracket ->
          Printf.eprintf "Shifting (TokenCloseBracket) to state 116\n%!";
          Printf.eprintf "State 116:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | SEMICOLON ->
              Printf.eprintf "Shifting (SEMICOLON) to state 117\n%!";
              Printf.eprintf "State 117:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              let MenhirCell0_LIST (_menhir_stack, _) = _menhir_stack in
              let MenhirCell1_data_types (_menhir_stack, _, _4) = _menhir_stack in
              let MenhirCell0_TokenIdentifier (_menhir_stack, _2, _) = _menhir_stack in
              let MenhirCell1_TokenLet (_menhir_stack, _menhir_s) = _menhir_stack in
              Printf.eprintf "Reducing production let_statement -> TokenLet TokenIdentifier COLON data_types LIST TokenConst COLON EQUAL TokenOpenBracket expression TokenCloseBracket SEMICOLON\n%!";
              let _10 = _v in
              let _v = _menhir_action_54 _10 _2 _4 in
              _menhir_goto_let_statement _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | TIMES ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TIMES) to state 26\n%!";
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (PLUS) to state 30\n%!";
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (MINUS) to state 34\n%!";
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LESS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (LESS) to state 28\n%!";
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GREATER ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (GREATER) to state 32\n%!";
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQUAL ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (EQUAL) to state 36\n%!";
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (DIV) to state 38\n%!";
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_108 : type  ttv_stack. (((ttv_stack, _menhir_box_main) _menhir_cell1_TokenLet _menhir_cell0_TokenIdentifier, _menhir_box_main) _menhir_cell1_data_types as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 108:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTo ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTo) to state 21\n%!";
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenNot ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenNot) to state 23\n%!";
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TIMES ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TIMES) to state 26\n%!";
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SEMICOLON ->
          Printf.eprintf "Shifting (SEMICOLON) to state 109\n%!";
          Printf.eprintf "State 109:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_data_types (_menhir_stack, _, _4) = _menhir_stack in
          let MenhirCell0_TokenIdentifier (_menhir_stack, _2, _) = _menhir_stack in
          let MenhirCell1_TokenLet (_menhir_stack, _menhir_s) = _menhir_stack in
          Printf.eprintf "Reducing production let_statement -> TokenLet TokenIdentifier COLON data_types TokenConst COLON EQUAL expression SEMICOLON\n%!";
          let _8 = _v in
          let _v = _menhir_action_51 _2 _4 _8 in
          _menhir_goto_let_statement _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (PLUS) to state 30\n%!";
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (MINUS) to state 34\n%!";
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LESS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (LESS) to state 28\n%!";
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GREATER ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (GREATER) to state 32\n%!";
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQUAL ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (EQUAL) to state 36\n%!";
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (DIV) to state 38\n%!";
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_082 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_TokenMatch as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 82:\n%!";
      let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | TokenWith ->
          Printf.eprintf "Shifting (TokenWith) to state 83\n%!";
          Printf.eprintf "State 83:\n%!";
          let _menhir_s = MenhirState083 in
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TokenPipe ->
              Printf.eprintf "Shifting (TokenPipe) to state 84\n%!";
              Printf.eprintf "State 84:\n%!";
              let _menhir_stack = MenhirCell1_TokenPipe (_menhir_stack, _menhir_s) in
              let _menhir_s = MenhirState084 in
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | TokenOpenParenthesis ->
                  Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
                  _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | TokenOpenBracket ->
                  Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
                  _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | TokenNot ->
                  Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
                  _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | TokenIdentifier _v ->
                  Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
                  _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | StringLiteral _v ->
                  Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
                  _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | MINUS ->
                  Printf.eprintf "Shifting (MINUS) to state 9\n%!";
                  _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | IntLiteral _v ->
                  Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
                  _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | INTEGER _v ->
                  Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
                  _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | FloatLiteral _v ->
                  Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
                  _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | CharLiteral _v ->
                  Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
                  _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | BoolLiteral _v ->
                  Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
                  _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  Printf.eprintf "Initiating error handling\n%!";
                  _eRR ())
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | TokenTo ->
          Printf.eprintf "Shifting (TokenTo) to state 21\n%!";
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenNot ->
          Printf.eprintf "Shifting (TokenNot) to state 23\n%!";
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TIMES ->
          Printf.eprintf "Shifting (TIMES) to state 26\n%!";
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          Printf.eprintf "Shifting (PLUS) to state 30\n%!";
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          Printf.eprintf "Shifting (MINUS) to state 34\n%!";
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LESS ->
          Printf.eprintf "Shifting (LESS) to state 28\n%!";
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GREATER ->
          Printf.eprintf "Shifting (GREATER) to state 32\n%!";
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQUAL ->
          Printf.eprintf "Shifting (EQUAL) to state 36\n%!";
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          Printf.eprintf "Shifting (DIV) to state 38\n%!";
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_078 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_TokenPrint as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 78:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTo ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTo) to state 21\n%!";
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenNot ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenNot) to state 23\n%!";
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenCloseParenthesis ->
          Printf.eprintf "Shifting (TokenCloseParenthesis) to state 79\n%!";
          Printf.eprintf "State 79:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | SEMICOLON ->
              Printf.eprintf "Shifting (SEMICOLON) to state 80\n%!";
              Printf.eprintf "State 80:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              let MenhirCell1_TokenPrint (_menhir_stack, _menhir_s) = _menhir_stack in
              Printf.eprintf "Reducing production print_statement -> TokenPrint DOT TokenPrintInput TokenOpenParenthesis expression TokenCloseParenthesis SEMICOLON\n%!";
              let _5 = _v in
              let _v = _menhir_action_73 _5 in
              _menhir_goto_print_statement _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | TIMES ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TIMES) to state 26\n%!";
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (PLUS) to state 30\n%!";
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (MINUS) to state 34\n%!";
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LESS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (LESS) to state 28\n%!";
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GREATER ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (GREATER) to state 32\n%!";
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQUAL ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (EQUAL) to state 36\n%!";
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (DIV) to state 38\n%!";
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_073 : type  ttv_stack. (((ttv_stack, _menhir_box_main) _menhir_cell1_TokenPrint, _menhir_box_main) _menhir_cell1_expression as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 73:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTo ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTo) to state 21\n%!";
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenNot ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenNot) to state 23\n%!";
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenCloseParenthesis ->
          Printf.eprintf "Shifting (TokenCloseParenthesis) to state 74\n%!";
          Printf.eprintf "State 74:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | SEMICOLON ->
              Printf.eprintf "Shifting (SEMICOLON) to state 75\n%!";
              Printf.eprintf "State 75:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              let MenhirCell1_expression (_menhir_stack, _, _5) = _menhir_stack in
              let MenhirCell1_TokenPrint (_menhir_stack, _menhir_s) = _menhir_stack in
              Printf.eprintf "Reducing production print_statement -> TokenPrint DOT TokenPrintOutput TokenOpenParenthesis expression COMMA expression TokenCloseParenthesis SEMICOLON\n%!";
              let _7 = _v in
              let _v = _menhir_action_75 _5 _7 in
              _menhir_goto_print_statement _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | TIMES ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TIMES) to state 26\n%!";
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (PLUS) to state 30\n%!";
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (MINUS) to state 34\n%!";
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LESS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (LESS) to state 28\n%!";
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GREATER ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (GREATER) to state 32\n%!";
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQUAL ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (EQUAL) to state 36\n%!";
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (DIV) to state 38\n%!";
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_069 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_TokenPrint as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 69:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTo ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTo) to state 21\n%!";
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenNot ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenNot) to state 23\n%!";
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenCloseParenthesis ->
          Printf.eprintf "Shifting (TokenCloseParenthesis) to state 70\n%!";
          Printf.eprintf "State 70:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | SEMICOLON ->
              Printf.eprintf "Shifting (SEMICOLON) to state 71\n%!";
              Printf.eprintf "State 71:\n%!";
              let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
              let MenhirCell1_TokenPrint (_menhir_stack, _menhir_s) = _menhir_stack in
              Printf.eprintf "Reducing production print_statement -> TokenPrint DOT TokenPrintOutput TokenOpenParenthesis expression TokenCloseParenthesis SEMICOLON\n%!";
              let _5 = _v in
              let _v = _menhir_action_74 _5 in
              _menhir_goto_print_statement _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | TIMES ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TIMES) to state 26\n%!";
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (PLUS) to state 30\n%!";
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (MINUS) to state 34\n%!";
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LESS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (LESS) to state 28\n%!";
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GREATER ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (GREATER) to state 32\n%!";
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQUAL ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (EQUAL) to state 36\n%!";
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (DIV) to state 38\n%!";
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (COMMA) to state 72\n%!";
          Printf.eprintf "State 72:\n%!";
          let _menhir_s = MenhirState072 in
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TokenOpenParenthesis ->
              Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
              _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TokenOpenBracket ->
              Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TokenNot ->
              Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TokenIdentifier _v ->
              Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | StringLiteral _v ->
              Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | MINUS ->
              Printf.eprintf "Shifting (MINUS) to state 9\n%!";
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IntLiteral _v ->
              Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | INTEGER _v ->
              Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FloatLiteral _v ->
              Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | CharLiteral _v ->
              Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | BoolLiteral _v ->
              Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_051 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_TokenOpenParenthesis as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 51:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTo ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTo) to state 21\n%!";
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenNot ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenNot) to state 23\n%!";
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenCloseParenthesis ->
          Printf.eprintf "Shifting (TokenCloseParenthesis) to state 52\n%!";
          Printf.eprintf "State 52:\n%!";
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_TokenOpenParenthesis (_menhir_stack, _menhir_s) = _menhir_stack in
          Printf.eprintf "Reducing production expression -> TokenOpenParenthesis expression TokenCloseParenthesis\n%!";
          let _2 = _v in
          let _v = _menhir_action_26 _2 in
          _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | TIMES ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TIMES) to state 26\n%!";
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (PLUS) to state 30\n%!";
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (MINUS) to state 34\n%!";
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LESS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (LESS) to state 28\n%!";
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GREATER ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (GREATER) to state 32\n%!";
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQUAL ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (EQUAL) to state 36\n%!";
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (DIV) to state 38\n%!";
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA ->
          Printf.eprintf "Reducing production expression_list -> expression\n%!";
          let _1 = _v in
          let _v = _menhir_action_41 _1 in
          _menhir_goto_expression_list _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_047 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_expression_list as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 47:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTo ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTo) to state 21\n%!";
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenNot ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenNot) to state 23\n%!";
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TIMES ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TIMES) to state 26\n%!";
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (PLUS) to state 30\n%!";
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (MINUS) to state 34\n%!";
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LESS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (LESS) to state 28\n%!";
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GREATER ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (GREATER) to state 32\n%!";
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQUAL ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (EQUAL) to state 36\n%!";
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (DIV) to state 38\n%!";
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA | SEMICOLON | TokenCloseBracket | TokenCloseParenthesis ->
          let MenhirCell1_expression_list (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          Printf.eprintf "Reducing production expression_list -> expression_list COMMA expression\n%!";
          let _3 = _v in
          let _v = _menhir_action_40 _1 _3 in
          _menhir_goto_expression_list _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_042 : type  ttv_stack. (((ttv_stack, _menhir_box_main) _menhir_cell1_TokenNot, _menhir_box_main) _menhir_cell1_expression as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 42:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTo ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTo) to state 21\n%!";
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenNot ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenNot) to state 23\n%!";
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TIMES ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TIMES) to state 26\n%!";
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (PLUS) to state 30\n%!";
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (MINUS) to state 34\n%!";
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LESS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (LESS) to state 28\n%!";
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GREATER ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (GREATER) to state 32\n%!";
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQUAL ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (EQUAL) to state 36\n%!";
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (DIV) to state 38\n%!";
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA | SEMICOLON | TokenCloseBracket | TokenCloseParenthesis | TokenWith ->
          let MenhirCell1_expression (_menhir_stack, _, _2) = _menhir_stack in
          let MenhirCell1_TokenNot (_menhir_stack, _menhir_s) = _menhir_stack in
          Printf.eprintf "Reducing production expression -> TokenNot expression EQUAL expression\n%!";
          let _4 = _v in
          let _v = _menhir_action_37 _2 _4 in
          _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_040 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_TokenNot as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 40:\n%!";
      let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | TokenTo ->
          Printf.eprintf "Shifting (TokenTo) to state 21\n%!";
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenNot ->
          Printf.eprintf "Shifting (TokenNot) to state 23\n%!";
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TIMES ->
          Printf.eprintf "Shifting (TIMES) to state 26\n%!";
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          Printf.eprintf "Shifting (PLUS) to state 30\n%!";
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          Printf.eprintf "Shifting (MINUS) to state 34\n%!";
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LESS ->
          Printf.eprintf "Shifting (LESS) to state 28\n%!";
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GREATER ->
          Printf.eprintf "Shifting (GREATER) to state 32\n%!";
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQUAL ->
          Printf.eprintf "Shifting (EQUAL) to state 41\n%!";
          Printf.eprintf "State 41:\n%!";
          let _menhir_s = MenhirState041 in
          let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TokenOpenParenthesis ->
              Printf.eprintf "Shifting (TokenOpenParenthesis) to state 4\n%!";
              _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TokenOpenBracket ->
              Printf.eprintf "Shifting (TokenOpenBracket) to state 5\n%!";
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TokenNot ->
              Printf.eprintf "Shifting (TokenNot) to state 6\n%!";
              _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TokenIdentifier _v ->
              Printf.eprintf "Shifting (TokenIdentifier) to state 7\n%!";
              _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | StringLiteral _v ->
              Printf.eprintf "Shifting (StringLiteral) to state 8\n%!";
              _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | MINUS ->
              Printf.eprintf "Shifting (MINUS) to state 9\n%!";
              _menhir_run_009 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IntLiteral _v ->
              Printf.eprintf "Shifting (IntLiteral) to state 10\n%!";
              _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | INTEGER _v ->
              Printf.eprintf "Shifting (INTEGER) to state 13\n%!";
              _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FloatLiteral _v ->
              Printf.eprintf "Shifting (FloatLiteral) to state 17\n%!";
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | CharLiteral _v ->
              Printf.eprintf "Shifting (CharLiteral) to state 18\n%!";
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | BoolLiteral _v ->
              Printf.eprintf "Shifting (BoolLiteral) to state 19\n%!";
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              Printf.eprintf "Initiating error handling\n%!";
              _eRR ())
      | DIV ->
          Printf.eprintf "Shifting (DIV) to state 38\n%!";
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_039 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_expression as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 39:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTo ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTo) to state 21\n%!";
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenNot ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenNot) to state 23\n%!";
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LESS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (LESS) to state 28\n%!";
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GREATER ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (GREATER) to state 32\n%!";
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQUAL ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (EQUAL) to state 36\n%!";
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA | DIV | MINUS | PLUS | SEMICOLON | TIMES | TokenCloseBracket | TokenCloseParenthesis | TokenWith ->
          let MenhirCell1_expression (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          Printf.eprintf "Reducing production expression -> expression DIV expression\n%!";
          let _3 = _v in
          let _v = _menhir_action_32 _1 _3 in
          _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_037 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_expression as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 37:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTo ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTo) to state 21\n%!";
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenNot ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenNot) to state 23\n%!";
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TIMES ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TIMES) to state 26\n%!";
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (PLUS) to state 30\n%!";
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (MINUS) to state 34\n%!";
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LESS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (LESS) to state 28\n%!";
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GREATER ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (GREATER) to state 32\n%!";
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQUAL ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (EQUAL) to state 36\n%!";
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (DIV) to state 38\n%!";
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA | SEMICOLON | TokenCloseBracket | TokenCloseParenthesis | TokenWith ->
          let MenhirCell1_expression (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          Printf.eprintf "Reducing production expression -> expression EQUAL expression\n%!";
          let _3 = _v in
          let _v = _menhir_action_34 _1 _3 in
          _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_035 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_expression as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 35:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTo ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTo) to state 21\n%!";
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenNot ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenNot) to state 23\n%!";
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TIMES ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TIMES) to state 26\n%!";
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LESS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (LESS) to state 28\n%!";
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GREATER ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (GREATER) to state 32\n%!";
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQUAL ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (EQUAL) to state 36\n%!";
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (DIV) to state 38\n%!";
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA | MINUS | PLUS | SEMICOLON | TokenCloseBracket | TokenCloseParenthesis | TokenWith ->
          let MenhirCell1_expression (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          Printf.eprintf "Reducing production expression -> expression MINUS expression\n%!";
          let _3 = _v in
          let _v = _menhir_action_30 _1 _3 in
          _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_033 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_expression as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 33:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTo ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTo) to state 21\n%!";
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenNot ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenNot) to state 23\n%!";
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TIMES ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TIMES) to state 26\n%!";
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (PLUS) to state 30\n%!";
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (MINUS) to state 34\n%!";
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LESS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (LESS) to state 28\n%!";
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GREATER ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (GREATER) to state 32\n%!";
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQUAL ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (EQUAL) to state 36\n%!";
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (DIV) to state 38\n%!";
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA | SEMICOLON | TokenCloseBracket | TokenCloseParenthesis | TokenWith ->
          let MenhirCell1_expression (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          Printf.eprintf "Reducing production expression -> expression GREATER expression\n%!";
          let _3 = _v in
          let _v = _menhir_action_35 _1 _3 in
          _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_031 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_expression as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 31:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTo ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTo) to state 21\n%!";
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenNot ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenNot) to state 23\n%!";
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TIMES ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TIMES) to state 26\n%!";
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LESS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (LESS) to state 28\n%!";
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GREATER ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (GREATER) to state 32\n%!";
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQUAL ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (EQUAL) to state 36\n%!";
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (DIV) to state 38\n%!";
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA | MINUS | PLUS | SEMICOLON | TokenCloseBracket | TokenCloseParenthesis | TokenWith ->
          let MenhirCell1_expression (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          Printf.eprintf "Reducing production expression -> expression PLUS expression\n%!";
          let _3 = _v in
          let _v = _menhir_action_29 _1 _3 in
          _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_029 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_expression as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 29:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTo ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTo) to state 21\n%!";
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenNot ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenNot) to state 23\n%!";
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TIMES ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TIMES) to state 26\n%!";
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (PLUS) to state 30\n%!";
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (MINUS) to state 34\n%!";
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LESS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (LESS) to state 28\n%!";
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GREATER ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (GREATER) to state 32\n%!";
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQUAL ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (EQUAL) to state 36\n%!";
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (DIV) to state 38\n%!";
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA | SEMICOLON | TokenCloseBracket | TokenCloseParenthesis | TokenWith ->
          let MenhirCell1_expression (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          Printf.eprintf "Reducing production expression -> expression LESS expression\n%!";
          let _3 = _v in
          let _v = _menhir_action_36 _1 _3 in
          _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_027 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_expression as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 27:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTo ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTo) to state 21\n%!";
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenNot ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenNot) to state 23\n%!";
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LESS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (LESS) to state 28\n%!";
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GREATER ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (GREATER) to state 32\n%!";
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQUAL ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (EQUAL) to state 36\n%!";
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA | DIV | MINUS | PLUS | SEMICOLON | TIMES | TokenCloseBracket | TokenCloseParenthesis | TokenWith ->
          let MenhirCell1_expression (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          Printf.eprintf "Reducing production expression -> expression TIMES expression\n%!";
          let _3 = _v in
          let _v = _menhir_action_31 _1 _3 in
          _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_025 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_expression as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 25:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTo ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTo) to state 21\n%!";
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenNot ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenNot) to state 23\n%!";
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TIMES ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TIMES) to state 26\n%!";
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (PLUS) to state 30\n%!";
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (MINUS) to state 34\n%!";
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LESS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (LESS) to state 28\n%!";
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GREATER ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (GREATER) to state 32\n%!";
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQUAL ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (EQUAL) to state 36\n%!";
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (DIV) to state 38\n%!";
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA | SEMICOLON | TokenCloseBracket | TokenCloseParenthesis | TokenWith ->
          let MenhirCell1_expression (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          Printf.eprintf "Reducing production expression -> expression TokenNot EQUAL expression\n%!";
          let _4 = _v in
          let _v = _menhir_action_38 _1 _4 in
          _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_022 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_expression as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 22:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTo ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTo) to state 21\n%!";
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenNot ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenNot) to state 23\n%!";
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TIMES ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TIMES) to state 26\n%!";
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (PLUS) to state 30\n%!";
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (MINUS) to state 34\n%!";
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LESS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (LESS) to state 28\n%!";
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GREATER ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (GREATER) to state 32\n%!";
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQUAL ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (EQUAL) to state 36\n%!";
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (DIV) to state 38\n%!";
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA | SEMICOLON | TokenCloseBracket | TokenCloseParenthesis | TokenWith ->
          let MenhirCell1_expression (_menhir_stack, _menhir_s, _1) = _menhir_stack in
          Printf.eprintf "Reducing production expression -> expression TokenTo expression\n%!";
          let _3 = _v in
          let _v = _menhir_action_39 _1 _3 in
          _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  and _menhir_run_020 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_MINUS as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      Printf.eprintf "State 20:\n%!";
      match (_tok : MenhirBasics.token) with
      | TokenTo ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenTo) to state 21\n%!";
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer
      | TokenNot ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (TokenNot) to state 23\n%!";
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LESS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (LESS) to state 28\n%!";
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GREATER ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (GREATER) to state 32\n%!";
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQUAL ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          Printf.eprintf "Shifting (EQUAL) to state 36\n%!";
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA | DIV | MINUS | PLUS | SEMICOLON | TIMES | TokenCloseBracket | TokenCloseParenthesis | TokenWith ->
          let MenhirCell1_MINUS (_menhir_stack, _menhir_s) = _menhir_stack in
          Printf.eprintf "Reducing production expression -> MINUS expression\n%!";
          let _2 = _v in
          let _v = _menhir_action_33 _2 in
          _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
  let _menhir_run_000 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      Printf.eprintf "State 0:\n%!";
      let _tok = _menhir_discard _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TokenTry ->
          Printf.eprintf "Shifting (TokenTry) to state 1\n%!";
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | TokenReturn ->
          Printf.eprintf "Shifting (TokenReturn) to state 3\n%!";
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | TokenPrint ->
          Printf.eprintf "Shifting (TokenPrint) to state 55\n%!";
          _menhir_run_055 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | TokenMatch ->
          Printf.eprintf "Shifting (TokenMatch) to state 81\n%!";
          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | TokenLog ->
          Printf.eprintf "Shifting (TokenLog) to state 89\n%!";
          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | TokenLet ->
          Printf.eprintf "Shifting (TokenLet) to state 94\n%!";
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | TokenImport ->
          Printf.eprintf "Shifting (TokenImport) to state 141\n%!";
          _menhir_run_141 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | TokenIf ->
          Printf.eprintf "Shifting (TokenIf) to state 145\n%!";
          _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | TokenIdentifier _v ->
          Printf.eprintf "Shifting (TokenIdentifier) to state 150\n%!";
          _menhir_run_150 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState000
      | TokenFor ->
          Printf.eprintf "Shifting (TokenFor) to state 155\n%!";
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | TokenElse ->
          Printf.eprintf "Shifting (TokenElse) to state 162\n%!";
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | TokenDef ->
          Printf.eprintf "Shifting (TokenDef) to state 164\n%!";
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | EOF ->
          Printf.eprintf "Reducing production statement_list ->\n%!";
          let _v = _menhir_action_94 () in
          _menhir_run_263 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState000 _tok
      | _ ->
          Printf.eprintf "Initiating error handling\n%!";
          _eRR ()
  
end

let main =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_main v = _menhir_run_000 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v
