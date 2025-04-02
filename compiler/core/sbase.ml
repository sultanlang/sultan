open Error
open Errorlog
type sultanc 

type 'sultanc init = 
| Compiler of bool

let flag_compiler = Compiler false

let compiler starter_bool = 
  if starter_bool = true then
    Compiler true
  else
    Compiler false
  ;;
let start_sultanc lexer_buffer =
  Sparser.compiler Slexer.token lexer_buffer

;;
let __Sultanc__ starter_bool input_files verbose = 
    let check_flag = compiler starter_bool in 
      match check_flag with
      | Compiler false -> __error__ "Compiler flag not set"
      | Compiler true ->
      let start_sultanc = start_sultanc in
        try
          if verbose then
            Printf.printf "Parsing file: %s\n" (Lexing.lexeme_start_p input_files).pos_fname;
          start_sultanc input_files
        with
        | exn -> Errorlog.catch_error input_files exn


      ;;
let analyze_args args = 
  let (output_name, input_files, verbose) = Flags.finder (Array.to_list args) in 

  (input_files, verbose)
;;

let sbase inputs verbose =
  let lexer_buffer = Lexing.from_channel (open_in inputs) in
  __Sultanc__ true lexer_buffer verbose



;;

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