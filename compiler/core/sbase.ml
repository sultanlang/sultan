
open Errorlog
type sultanc 



let start_sultanc lexer_buffer =
  Sparser.compiler Slexer.token lexer_buffer

;;
let __Sultanc__ starter_bool input_files = 
    let start_sultanc = start_sultanc in
      try
        start_sultanc input_files
      with
      | exn -> Errorlog.catch_error input_files exn

      ;;
(* let analyze_args args = 
  let (output_name, input_files, verbose) = Flags.finder (Array.to_list args) in 

  (input_files, verbose)
;; *)

let sbase inputs =
  let lexer_buffer = Lexing.from_channel (open_in inputs) in
  __Sultanc__ true lexer_buffer 



;;
(* 
let sbase_compiler input = 
  let (files, verbose) = analyze_args input in
  
  if List.length files = 0 then
    __error__ "No input files provided"
  else
    
    let filename = List.hd files in
    let ast = sbase filename verbose in 
    
    (* Store handler should generate the C file *)
    let _ = Codegen.store_handler filename ast in
    let _ = Hfile.generate_h_file filename ast in
    
    (* Get the output name from Castle or create default from filename *)
    let output_name = 
      match Castle.get_output_name () with
      | Some name -> name
      | None -> 
          (* Default to filename without extension *)
          Filename.chop_extension filename
    in
    
    (* Generate C file(s) from the .sir file(s) *)
    let c_file = (Filename.chop_extension filename) ^ ".c" in
    
    (* Check if the C file exists before compiling *)
    if not (Sys.file_exists c_file) then
      __error__ "C file %s was not generated properly" c_file
    else
      (* Compile the generated C files *)
      let _ = Compile.compile_files c_file output_name in
      
      ast
;;
 *)

let sbase_compiler input =
  (* Call sbase with the required argument to get the AST *)
  let ast = sbase input  in 
  
  (* Store handler should generate the C file *)
  let _ = Codegen.to_string input ast in
  let _ = Hfile.generate_h_file input ast in
  
  (* Return the AST *)
  ast

(* 
let compiler file_names =
  Printf.printf "compiling";
  let input = open_in file_names in
  let file_content = really_input_string input (in_channel_length input) in
  close_in input;
  let lexbuf = Lexing.from_string file_content in *)