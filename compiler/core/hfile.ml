open Error
open Semantics

let h_file_extension = ".h"
let h_file_ifdef = "#ifndef "
let h_file_define = "#define "
let h_file_endif = "#endif"

let h_file_include = "#include "
let h_file_h = "_H" 


;;


let rec h_file_statements = function
| Ast.Def (scope, function_name, function_parameters, function_type, _, position) ->
  (* Get base function signature from semantics *)
  let function_signature = Semantics.string_of_def_base 
    (Ast.Def(scope, function_name, function_parameters, function_type, [], position)) in
  (* Add semicolon for header declaration *)
  function_signature ^ ";\n"
  
      | Ast.Enum (enum_name, enum_values, position) ->
        let enum_str = Semantics.string_of_enum_statement (Ast.Enum (enum_name, enum_values, position)) in
        enum_str ^ "\n"
        
    | Ast.Struct (struct_name, struct_fields, position) ->
        let struct_str = Semantics.string_of_struct_statement (Ast.Struct (struct_name, struct_fields, position)) in
        struct_str ^ "\n"
        
      | Ast.Import (module_name, position) ->
        (* Use Semantics.string_of_import to generate the string representation *)
        let include_directive = Semantics.string_of_import (Ast.Import (module_name, position)) in
        include_directive ^ "\n"
    
  | _ -> ""
let construct_header_gurade file_name =
  let base_name = Filename.chop_extension file_name in
  let guard_name = String.uppercase_ascii (Filename.basename base_name) ^ h_file_h in
  h_file_ifdef ^ guard_name ^ "\n" ^
  h_file_define ^ guard_name ^ "\n\n"

;;




;;

let generate_h_file filename ast =
  let h_filename = (Filename.chop_extension filename) ^ h_file_extension in
  let h_file = open_out h_filename in

  (* Add header guard *)
  let guard_content = construct_header_gurade filename in
  output_string h_file guard_content;


  (* Process each statement and convert to header content *)
  let process_statement stmt =
    let header_line = h_file_statements stmt in
    output_string h_file header_line
  in
  List.iter process_statement ast;

  (* Close header guard *)
  output_string h_file (h_file_endif ^ " /* " ^ String.uppercase_ascii (Filename.basename (Filename.chop_extension filename)) ^ h_file_h ^ " */\n");

  close_out h_file;
  h_filename

;;