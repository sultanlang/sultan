{
open Sparser        (* The type token is defined in parser.mli *)



open Error

(* Define the tokens *)
exception SyntaxError of string
exception Eof




(* Helper function to distinguish keywords from identifiers *)
let keyword_token = function
  | "let"|"عندما"|"laisse"|"dejar" -> TokenLet
  | "print"|"اطبع"|"imprimer"|"imprimir" -> TokenPrint
  | "def"|"عرف" -> TokenDef
  | "return"|"ارجع"|"retourner"|"devolver" -> TokenReturn
  | "main"|"القلعه"|"principal" -> TokenMain
  | "pub"|"عام" -> TokenPub
  | "import"|"استيراد" -> TokenImport
  | "match"|"مطابقه"|"coincidir" -> TokenMatch
  | "with"|"مع"|"con" -> TokenWith
  | "enum"|"تعداد" -> TokenEnum
  | "struct"|"بنيه"|"estruct" -> TokenStruct
  | "type"|"نوع"|"tipo" -> TokenType
  | "and"|"و"|"y" -> TokenAnd
  | "f"| "ف" -> TokenFString



  | "if"|"اذا"|"si" -> TokenIf
  | "else"|"والا"|"otro" -> TokenElse
  | "while"|"بينما"|"mientras" -> TokenWhile
  | "for"|"إلى"|"para" -> TokenFor
  | "in"|"في"|"en" -> TokenIn
  | "range"|"مدي"|"rango" -> TokenRange
  
  


  | "const"|"ثابت" -> TokenConst "const"
  | "i8"| "رـ8" -> TokenI8 "i8"
  | "i16"| "رـ16" -> TokenI16 "i16"
  | "i32"| "رـ32" -> TokenI32 "i32"
  | "i64"| "رـ64" -> TokenI64 "i64"
  | "u8"| "لـ8" -> TokenU8 "u8"
  | "u16"| "لـ16" -> TokenU16 "u16"
  | "u32"| "لـ32" -> TokenU32 "u32"
  | "u64"| "لـ64" -> TokenU64 "u64"
  | "f32"| "عـ32" -> TokenF32 "f32"
  | "f64"| "عـ64" -> TokenF64 "f64"
  | "bool"| "منطقي" -> TokenBool "bool"
  | "string"| "نص" -> TokenString "string"
  | "char"| "حرف" -> TokenChar "char"
  | "void"| "نوع"-> TokenVoid "void"
  | "true"|"صح" -> TokenTrue
  | "false"|"خطأ" -> TokenFalse
  | "list"|"قائمه" -> TokenList "list"
  | other -> IDENTIFIER (Id.mangle_identifier other)




(* Languages included:
   - English
   - Arabic
   - Spanish
   
   well add also overtime
   - German
   - Portuguese
   - Italian
   - Dutch
   - Russian
   - Chinese
   - Japanese
   - Korean
*)


}



rule token = parse
  | ['a'-'z' 'A'-'Z' '_' '\xC2'-'\xF4']['a'-'z' 'A'-'Z' '0'-'9' '_' '\x80'-'\xBF' '\xC2'-'\xF4']* as utf8_word {
      keyword_token utf8_word
    }
  | [' ' '\t'] { token lexbuf }
  | ['\n'] 
    { 
      Lexing.new_line lexbuf; (* Explicitly update the line number *)
      token lexbuf 
    }
  | "//" [^'\n']* '\n' 
    { 
      Lexing.new_line lexbuf;  (* For comments ending with newline *)
      token lexbuf 
    }
  | ['0'-'9']+ as lxm { IntLiteral (int_of_string lxm) }
  | ['0'-'9']+"."['0'-'9']* as lxm { FloatLiteral (float_of_string lxm) }
  | "\"" [^'"']* "\"" as lxm { StringLiteral (String.sub lxm 1 (String.length lxm - 2)) }
  | "'" ['\x20'-'\x7E'] "'" as lxm { CharLiteral (String.get lxm 1) }
  | '+' { PLUS }
  | '-' { MINUS }
  | '*' { TIMES }
  | '/' { DIV }
  | "\"" { TokenQuote }  
  | '(' { TokenOpenParenthesis  }
  | ')' { TokenCloseParenthesis }
  | '{' { TokenOpenBrace }
  | '}' { TokenCloseBrace }
  | '[' { TokenOpenBracket }
  | ']' { TokenCloseBracket }
  | ':' { TokenColon }
  | ',' { TokenComma}
  
  
  
  | ';' { SEMICOLON }
  | '.' { DOT }
  | '|' { TokenPipe }
  | '>' { GREATER }
  | '<' { LESS }
  | '-' { MINUS }
  | '_' { TokenUnderscore }
  | '%' { MOD }
  | '&' { TokenAnd }
  | '=' {TokenEqual}
  | eof { EOF }
  | _ as c { 
      __error__ "File \"%s\", line %d, character %d:\n%!" 
        lexbuf.Lexing.lex_curr_p.Lexing.pos_fname 
        lexbuf.Lexing.lex_curr_p.Lexing.pos_lnum 
        (Lexing.lexeme_start lexbuf - lexbuf.Lexing.lex_curr_p.Lexing.pos_bol); 
      Printf.eprintf "Lexer error: unexpected character '%c'\n" c; 
      exit 1 
    }