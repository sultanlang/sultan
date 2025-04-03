%{

open Ast
open Error
open Castle
open Lexing

let get_position startpos =
  { line = startpos.pos_lnum; column = startpos.pos_cnum - startpos.pos_bol }


%}

/* Token declarations that exactly match token.ml */
%token ERROR EOF 
%token TokenMain
%token <string> IDENTIFIER
%token <string> CONST
%token <int> Numbers
%token <string> TokenI8
%token <string> TokenI16
%token <string> TokenI32
%token <string> TokenI64
%token <string> TokenU8
%token <string> TokenU16
%token <string> TokenU32
%token <string> TokenU64
%token <string> TokenF32
%token <string> TokenF64
%token <string> TokenBool
%token <string> TokenString
%token <string> TokenChar
%token <string> TokenVoid
%token <string> TokenConst
%token TokenTrue
%token TokenFalse
%token <int>IntLiteral
%token <float> FloatLiteral
%token <string> StringLiteral
%token <char> CharLiteral
%token <string> TokenList
%token TokenImport
%token TokenComma
%token TokenEqual
%token TokenQuote
%token TRUE 
%token FALSE
%token TokenLet 
%token TokenPrint 
%token TokenIf 
%token TokenElse
%token TokenWhile
%token TokenContinue
%token TokenBreak
%token TokenMatch
%token TokenWith
%token TokenEnum
%token TokenStruct
%token TokenType
%token TokenIn
%token TokenFor
%token TokenRange
%token RETURN
%token TokenOpenParenthesis
%token TokenCloseParenthesis
%token TokenOpenBrace
%token TokenCloseBrace
%token TokenOpenBracket
%token TokenCloseBracket
%token TokenPipe
%token TokenAnd
%token TokenUnderscore
%token TokenColon
%token PLUS
%token MINUS
%token TIMES
%token DIV
%token MOD
%token COLON
%token COMMA
%token SEMICOLON
%token DOT
%token GREATER
%token LESS
%token TokenFString

%token TokenPub
%token TokenReturn
%token TokenDef


/* No value-carrying tokens since they don't exist in token.ml */

/* Precedence and associativity */
// %left TokenPipe /* | for Or */
%left TokenAnd  /* & for And */
%left GREATER
%left LESS
%left TokenEqual
%left PLUS
%left MINUS
%left TIMES
// %left DIV
// %left MOD


// %nonassoc DOT



/* Start symbol */
%start <Ast.statements list> compiler

%%





/* Top-level compiler rule */
compiler:
  | sourceFile EOF { $1 }

/* Global-level source file */
sourceFile:
  | statements sourceFile { $1 :: $2 }
  | statements { [$1] }

/* Global-level statements */
statements:
  | import_statement { $1 }
  | let_statement { $1 }
  | def_statement { $1 }
  | enum_statement { $1 }



/* Refactor block_of_statements to avoid reduce/reduce conflict */
block_of_statements:
  | block_statement { [$1] }                        /* Single case */
  | block_statement block_of_statements { $1 :: $2 } /* Recursive case */
  | { [] } 
  
/* General statement rule to unify common cases */
block_statement:
  | print_statement { $1 }
  | let_statement { $1 }
  | return_statement { $1 }
  | if_else_statement { $1 }
  | while_statement { $1 }
  | for_statement { $1 }
  | expression_statement { $1 }
  | enum_statement { $1 }
  | match_statement { $1 }
  // | functionCall_statement { $1 }
  
  


expression_statement:
  | IDENTIFIER TokenOpenParenthesis TokenCloseParenthesis SEMICOLON 
  {
    let pos = get_position $startpos in
    Ast.Expression([Ast.Function_call($1, [])],pos)
  }


for_statement:
  | TokenFor IDENTIFIER TokenIn expression TokenOpenBrace block_of_statements TokenCloseBrace
    { 
      let pos = get_position $startpos in
      Ast.For(Ast.Identifier($2,pos), $4, Ast.Identifier($2,pos), $6,pos) }








/* Refactored match_cases_list and match_case_list */
match_case_list:
  | expression MINUS GREATER block_of_statements { ($1, $4) }

match_cases_list:
  | TokenPipe match_case_list match_cases_list { $2 :: $3 } /* Recursive case */
  | TokenPipe match_case_list { [$2] }                     /* Single case */

/* Restrict match_statements to avoid conflicts */

/* Ensure match_statement is distinct */
match_statement:
  | TokenMatch IDENTIFIER TokenWith match_cases_list 
  { 
    let pos = get_position $startpos in
    Ast.Match($2, $4,pos)
  }





while_statement:
  | TokenWhile TokenOpenParenthesis expression TokenCloseParenthesis TokenOpenBrace block_of_statements TokenCloseBrace
    {
      let pos = get_position $startpos in
      Ast.While($3, $6, pos)
    }


if_else_statement:
  | TokenIf TokenOpenParenthesis expression TokenCloseParenthesis TokenOpenBrace block_of_statements TokenCloseBrace TokenElse TokenOpenBrace block_of_statements TokenCloseBrace
    
     { 
      let pos = get_position $startpos in
      Ast.If_Else($3, $6, $10, pos) 
    }
    
  | TokenIf TokenOpenParenthesis expression TokenCloseParenthesis TokenOpenBrace block_of_statements TokenCloseBrace
    { 
      let pos = get_position $startpos in
      Ast.If_Else($3, $6, [],pos) 
    }
    
  | TokenIf TokenOpenParenthesis expression TokenCloseParenthesis TokenOpenBrace block_of_statements TokenCloseBrace TokenElse if_else_statement
    { 
      let pos = get_position $startpos in
      Ast.If_Else($3, $6, [$9], pos) 
    }
    


let_statement:
  | TokenLet IDENTIFIER TokenColon types mutability TokenEqual expression_list SEMICOLON 
    { 
      
      let pos = get_position $startpos in
      Ast.Let_var($2, $4, $5, $7, pos) 
      
      
      }
  // | TokenLet IDENTIFIER TokenEqual block_of_statements SEMICOLON 
  //   {
  //     let pos = get_position $startpos in
  //     Ast.Let_var($2, Ast.None, Ast.Mutable, $4, pos) 
  //   }
  | TokenLet IDENTIFIER TokenColon TokenEqual expression_list SEMICOLON 
    {
      let pos = get_position $startpos in
      match $5 with
      | [Ast.Expression(expr_list, pos)] -> Ast.Reassign($2, expr_list, pos)
      | _ -> Error.__error__ "Invalid expression for reassignment"
    }


parameters_declaration:
  | parameter_declaration { [$1] }
  | parameter_declaration TokenComma parameters_declaration { $1::$3 }
  | { [] }
parameter_declaration:
  | IDENTIFIER TokenColon types mutability { ($1, $3, match $4 with Ast.Immutable -> true | Ast.Mutable -> false) }


mutability:
  | TokenConst { Ast.Immutable }
  | { Ast.Mutable }


types:
  | types_declaration { $1 }
  | types_declaration TokenList { Ast.List($1) }
  

types_declaration:
  | TokenI8 { Ast.I8 }
  | TokenI16 { Ast.I16 }
  | TokenI32 { Ast.I32 }
  | TokenI64 { Ast.I64 }
  | TokenU8 { Ast.U8 }
  | TokenU16 { Ast.U16 }
  | TokenU32 { Ast.U32 }
  | TokenU64 { Ast.U64 }
  | TokenF32 { Ast.F32 }
  | TokenF64 { Ast.F64 }
  | TokenBool { Ast.Bool }
  | TokenString { Ast.String }
  | TokenChar { Ast.Char }
  | TokenVoid { Ast.Void }
  
  
  
// enum_variant:
//   | IDENTIFIER { Some ($1, Ast.None, Ast.Mutable) }  /* Default to Void type and Mutable */
//   | IDENTIFIER TokenColon types mutability
//   {
//       let pos = get_position $startpos in
//       Some ($1, $3, $4)
//   }
//   | IDENTIFIER TokenColon types mutability TokenEqual expression_list
//   {
//       let pos = get_position $startpos in
//       Some ($1, $3, $4)
//   }

// enum_variants:
//   | enum_variant { [$1] }
//   | enum_variant SEMICOLON enum_variants { $1 :: $3 }
//   | { [] }

// enum_statement:
//   | TokenEnum IDENTIFIER TokenOpenBrace enum_variants TokenCloseBrace SEMICOLON {
//       let pos = get_position $startpos in
//       Ast.Enum($2, $4, pos)
//     }



enum_statement:
  | TokenEnum IDENTIFIER TokenOpenBrace expression_list TokenCloseBrace SEMICOLON 
    { 
      let pos = get_position $startpos in
      Ast.Enum($2, $4, pos) 
    }



functionCall_statement:
  | IDENTIFIER TokenOpenParenthesis TokenCloseParenthesis SEMICOLON 
  {
      let pos = get_position $startpos in
      Ast.Function_call($1, [], pos) 
  }
  
  | IDENTIFIER TokenOpenParenthesis expression_list TokenCloseParenthesis SEMICOLON 
 {
  let pos = get_position $startpos in
  Ast.Function_call($1, List.flatten (List.map (function Ast.Expression expr_list -> expr_list | _ -> []) $3,pos))  
 }

import_statement:
  | TokenImport IDENTIFIER SEMICOLON 
  {
    let pos = get_position $startpos in
    Ast.Import($2, pos) 
  }



  
return_statement:
  | TokenReturn expression SEMICOLON 
    { 
      let pos = get_position $startpos in
      Ast.Return($2, pos) 
    }
  



public_scope:
  | TokenPub { Ast.Global 0 }
  | { Ast.Local 1 }


void_handler:
  | TokenVoid { Ast.Has_return Ast.False }
  | { Ast.Has_return Ast.True }

main_or_identifier:
  | TokenMain {let pos = get_position $startpos in Ast.Identifier("main",pos) }  // Wrap "main" in an Ast.Identifier
  | IDENTIFIER { let pos = get_position $startpos in Ast.Identifier($1,pos) }   // Wrap IDENTIFIER in an Ast.Identifier

def_statement:
  | public_scope TokenDef main_or_identifier TokenOpenParenthesis parameters_declaration TokenCloseParenthesis void_handler TokenOpenBrace block_of_statements TokenCloseBrace SEMICOLON
  {
    let pos = get_position $startpos in
    let identifier = match $3 with
      | Ast.Identifier (id,pos) -> id
      | _ -> failwith "Expected identifier"
    in
     

      let final_scope = 
      if identifier = "main" then begin
        Castle.set_main();  (* Mark that main is declared *)
        Ast.Global 0        (* Force main to be global *)
      end else
        $1
    in
      
    
    
    let body = $9 in

  Ast.Def(final_scope, identifier, $5, $7, body,pos)
  }


print_statement:
  | TokenPrint TokenOpenParenthesis expression TokenCloseParenthesis SEMICOLON
    { 
      let pos = get_position $startpos in
      Ast.Print($3,pos) }
  | TokenPrint TokenOpenParenthesis TokenFString expression TokenCloseParenthesis SEMICOLON
    {
      let pos = get_position $startpos in
      match $4 with
      | Ast.Types (Ast.StringLiteral str) -> Ast.Print(Ast.Fstring(str, [],pos),pos)
      | _ -> Error.__error__ "Only string literals are allowed in f-string print statements"
    }

    
expression:
  | IntLiteral { Ast.Types (IntLiteral $1) }
  | FloatLiteral { Ast.Types (FloatLiteral $1) }
  | StringLiteral { Ast.Types (StringLiteral $1) }
  | CharLiteral { Ast.Types (CharLiteral $1) }
  | IDENTIFIER { let pos = get_position $startpos in Ast.Identifier($1,pos) }
  | expression PLUS expression { Ast.Binary([$1; $3], Add) }
  | expression MINUS expression { Ast.Binary([$1; $3], Subtract) }
  | expression TIMES expression { Ast.Binary([$1; $3], Multiply) }
  | expression DOT expression { Ast.Binary([$1; $3], Dot) }
  
  | expression TokenEqual expression { Ast.Binary([$1; $3], Equal) }
  | expression GREATER expression { Ast.Binary([$1; $3], Greater_than) }
  | expression LESS expression { Ast.Binary([$1; $3], Less_than) }
  | expression TokenAnd expression { Ast.Binary([$1; $3], And) }
  | expression TokenComma expression { Ast.Binary([$1; $3], Comma) }
  | TokenOpenBracket expression TokenCloseBracket 
    {Ast.Lists [$2]}
  | TokenOpenParenthesis expression TokenCloseParenthesis 
    { $2 }
  | TokenRange TokenOpenParenthesis expression TokenComma expression TokenCloseParenthesis
    { Ast.Range($3, $5) }

expression_list:
  | expression {let pos = get_position $startpos in [Ast.Expression([$1],pos)] }  (* Single expression wrapped in Ast.Expression *)
  | expression TokenComma expression_list {let pos = get_position $startpos in (Ast.Expression([$1],pos)) :: $3 }  (* Multiple expressions *)
  // | IDENTIFIER TokenOpenParenthesis expression_list TokenCloseParenthesis 
  //     {let pos = get_position $startpos in [Ast.Expression([Ast.Function_call($1, List.flatten (List.map (function Ast.Expression expr_list -> expr_list | _ -> []) $3))],pos)] }

| IDENTIFIER TokenOpenParenthesis expression_list TokenCloseParenthesis 
  {
    let pos = get_position $startpos in 
    [Ast.Expression([Ast.Function_call($1, 
      List.flatten (List.map (function 
        | Ast.Expression(expr_list, _) -> expr_list 
        | _ -> []) $3))], 
      pos)] 
  }
  | IDENTIFIER TokenOpenParenthesis TokenCloseParenthesis 
      {let pos = get_position $startpos in [Ast.Expression([Ast.Function_call($1, [])],pos)] }  (* Function call with no arguments *)
  | TokenOpenBracket TokenCloseBracket 
  
    {let pos = get_position $startpos in [Ast.Expression([],pos)] }  (* Empty list *)
  | { [] }  (* Empty expression list *)