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
  | Ast.Def (scope, function_name, function_parameters, function_type, body, position) ->
      let parameters_str = string_of_ast_parameters function_parameters in
      let string_of_scope = string_of_scope scope in
      let function_signature = match function_type with
        | Ast.Has_return Ast.True ->
            string_of_scope ^ "int " ^ function_name ^ "(" ^ parameters_str ^ ")"
        | Ast.Has_return Ast.False ->
            string_of_scope ^ "void " ^ function_name ^ "(" ^ parameters_str ^ ")"
      in
      function_signature ^ ";\n"
  
  | Ast.Enum (enum_name, enum_values, position) ->
      let reduced_statements = [Ast.reduce_statements (Ast.Enum (enum_name, enum_values, position))] in
      let string_list = List.map h_file_statements reduced_statements in
      String.concat "\n" string_list ^ "\n"
      
  | Ast.Struct (struct_name, struct_fields, position) ->
      let reduced_statements = [Ast.reduce_statements (Ast.Struct (struct_name, struct_fields, position))] in
      let string_list = List.map h_file_statements reduced_statements in
      String.concat "\n" string_list ^ "\n"
      
  | Ast.Import (import_name, position) ->
      let import_str = h_file_include ^ "\"" ^ import_name ^ "\"" in
      import_str ^ "\n"
    
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