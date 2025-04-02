open Error

          (* Set up position tracking *)
let position_tracking lexbuf =
  let pos = lexbuf.Lexing.lex_curr_p in
  let line = pos.Lexing.pos_lnum in
  let column = pos.Lexing.pos_cnum - pos.Lexing.pos_bol in
  let file = pos.Lexing.pos_fname in
  let current_token = Lexing.lexeme lexbuf in
  
  (* Add to debug buffer but don't print *)
  Error.add_parser_debug (Printf.sprintf "Token at %s:%d:%d is '%s'\n" 
                      file line column current_token);
  
  (file, line, column, current_token)

          
let catch_error lexbuf = function
  | Slexer.SyntaxError msg -> 
      let (file, line, column, token) = position_tracking lexbuf in
      let error_msg = Printf.sprintf "Syntax error at %s, line %d, column %d: Unexpected token '%s' - %s" 
        file line column token msg in
      Error.add_parser_debug error_msg;
      __error__ "%s" error_msg
      
  | Sparser.Error -> 
      let (file, line, column, token) = position_tracking lexbuf in
      let error_msg = Printf.sprintf "Parse error at %s, line %d, column %d: Unexpected token '%s'" 
        file line column token in
      Error.add_parser_debug error_msg;
      __error__ "%s" error_msg
      
  | exn -> 
      let msg = Printexc.to_string exn in
      Error.add_parser_debug ("Unknown error: " ^ msg);
      __error__ "Unknown error: %s" msg

  ;;

let under_line_token token =
  (* Calculate token length - either use actual token length or default to 1 *)
  let token_length = 
    try String.length token 
    with _ -> 1 in
    
  (* Create a red underline indicator *)
  red ^ String.make (max token_length 1) '^' ^ reset

;;


let __warning__ =  yellow ^ "WARNING:" ^ reset 
  

let __error_word__ = red ^ "ERROR:" ^ reset


;;




;;
let  __first__msg__error_ = 
let file_name = Castle.get_input_files () in
  match file_name with
  | [] -> " FIXME: I need to fix this.\n I can not get ;) input file provided.\n"
  | _ -> 
      let file_name = List.hd file_name in
      __error__ 
"file" ^ file_name ^ ":\n" 

;;
let __error__position__ line column token =
  let underline = under_line_token token in
  let file_name = __first__msg__error_ in
  __error__ "%s %s at line %d, column %d:\n%s\n%s" file_name  __error_word__ line column token underline

