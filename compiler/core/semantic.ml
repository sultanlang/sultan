open Castle
open Types
(* This module is responsible for converting the AST to C code. *)

let string_of_scope = function
  | Ast.Global _ -> "extern "
  | Ast.Local _ -> ""



  
  (* let rec string_of_ast_machine_types (typ : Ast.machine_types) : string =
    match typ with
    | Ast.I8 -> "int8_t"
    | Ast.I16 -> "int16_t"
    | Ast.I32 -> "int32_t"
    | Ast.I64 -> "int64_t"
    | Ast.U8 -> "uint8_t" 
    | Ast.U16 -> "uint16_t"
    | Ast.U32 -> "uint32_t"
    | Ast.U64 -> "uint64_t"
    | Ast.F32 -> "float"
    | Ast.F64 -> "double"
    | Ast.Bool -> "bool"
    | Ast.Char -> "char"
    | Ast.String -> "char*"
      | Ast.List inner_type -> string_of_ast_machine_types inner_type ^ ""
    | Ast.Void -> "void"
    
    | Ast.None -> ""
  | _ -> Error.__error__ "Invalid type"
   *)

  let string_of_mutability = function
  | Ast.Mutable -> ""
  | Ast.Immutable -> "const "


(* convert a . bool to string  *)
let string_of_sbool = function
  | Ast.True -> "true"
  | False -> "false"



  (* Convert an expression to a string representation *)
let rec string_of_expression = function
| Ast.Fstring (s, _) ->
  (* Extract variable names from the f-string *)
  let regex = Str.regexp "{\\([a-zA-Z_][a-zA-Z0-9_]*\\)}" in
  let rec extract_vars acc start =
      try
          let _ = Str.search_forward regex s start in
          let var_name = Str.matched_group 1 s in
          extract_vars (acc @ [var_name]) (Str.match_end ())
      with Not_found -> acc
  in
  let vars = extract_vars [] 0 in

  (* Replace placeholders in the f-string with C-style format specifiers *)
  let formatted_string = Str.global_replace regex "%s" s in

  (* Return the formatted string and the extracted variables *)
  "\"" ^ formatted_string ^ "\", " ^ String.concat ", " vars
 
    | Ast.Range (start, end_) ->
      let string_of_start = string_of_expression start in
      let string_of_end = string_of_expression end_ in
      "(" ^ string_of_start ^ ", " ^ string_of_end ^ ")"
  (* | Ast.NameSpace (namespace, expr) -> namespace ^ "::" ^ string_of_expression expr *)
  |Ast.Function_call (function_name, arguments) ->
    let string_of_arguments = List.map string_of_expression arguments in
    let string_of_arguments = String.concat ", " string_of_arguments in
    function_name ^ "(" ^ string_of_arguments ^ ")"
  | Ast.Identifier id -> id
  | Ast.Types (Ast.StringLiteral s) -> "\"" ^ s ^ "\""
  | Ast.Types (Ast.CharLiteral c) -> "'" ^ String.make 1 c ^ "'"
  | Ast.Types (Ast.IntLiteral i) -> string_of_int i
  | Ast.Types (Ast.FloatLiteral f) -> string_of_float f
  | Ast.Types (Ast.BoolLiteral b) -> string_of_bool b
  | Ast.Lists elements ->
      let string_of_list = List.map string_of_expression elements in
      let string_of_list = String.concat ", " string_of_list in
      "{" ^ string_of_list ^ "}"
  (*FIXME:
  Binary not sure about some DOT Arrow thing
  TODO: Analyze farther needed to be done to know the linkage conflects on the parser side  
  Possible suggestion:
  - removing them (DOT,Arrow, and maybe comma) from the parser based Binary expression.
  
  The problem casing conflict on the Matching statement on the parser side.
  
  
  *)
  | Ast.Binary (expressions, operation) ->
    let reduced_exprs = List.map string_of_expression expressions in
    let op = match operation with
    | Ast.Add -> "+"
    | Ast.Subtract -> "-"
    | Ast.Multiply -> "*"
    | Ast.Divide -> "/"
    | Ast.Equal -> "=="
    | Ast.Less_than -> "<"
    | Ast.Greater_than -> ">"
    | Ast.Less_than_or_equal -> "<="
    | Ast.Greater_than_or_equal -> ">="
    | Ast.Not_equal -> "!="
    | Ast.And -> "&&"
    | Ast.Or -> "||"
    | Ast.Modulus -> "%"
    | Ast.Bitwise_and -> "&"
    | Ast.Bitwise_or -> "|"
    | Ast.Bitwise_xor -> "^"
    | Ast.Bitwise_not -> "~"
    | Ast.Shift_left -> "<<"
    | Ast.Shift_right -> ">>"
    | Ast.Assignment -> "="
    | Ast.Add_assignment -> "+="
    | Ast.Subtract_assignment -> "-="
    | Ast.Multiply_assignment -> "*="
    | Ast.Divide_assignment -> "/="
    | Ast.Modulus_assignment -> "%="
    | Ast.Bitwise_and_assignment -> "&="
    | Ast.Bitwise_or_assignment -> "|="
    | Ast.Bitwise_xor_assignment -> "^="
    | Ast.Shift_left_assignment -> "<<="
    | Ast.Shift_right_assignment -> ">>="
    | Ast.Comma -> ","
    | Ast.Dot -> "."  
    | Ast.Arrow -> "->" 
  
      
    in
    match reduced_exprs with
    | [lhs; rhs] -> lhs ^ " " ^ op ^ " " ^ rhs
    | _ -> Error.__error__ "Invalid binary expression"




let string_of_ast_parameters (parameters : Ast.parameters) =
  let string_of_parameter (name, typ, mutability) =
    let base_type = string_of_ast_machine_types typ in
    let name_with_list_suffix =
      match typ with
      | Ast.List _ -> name ^ "[]"
      | _ -> name
    in
    (if mutability then "const " else "") ^ base_type ^ " " ^ name_with_list_suffix
  in
  String.concat ", " (List.map string_of_parameter parameters)
    (* let string_of_ast_parameters (parameters : Ast.parameters) =
      let string_of_parameter (name, typ, mutability) =
        (if mutability then "const " else "") ^ string_of_ast_machine_types typ ^ " " ^ name
      in
      String.concat ", " (List.map string_of_parameter parameters)

 *)



  


let rec string_of_statements = function

  (* | Ast.Print expr -> 
    let base_print = "printf" in
    (match expr with
    | Ast.Lists elements ->
        let string_of_list = List.map string_of_expression elements in
        let string_of_list = String.concat ", " string_of_list in
        base_print ^ "(\"%s\\n\", " ^ string_of_list ^ ");"
    | Ast.Types (Ast.StringLiteral s) ->
      
         base_print ^ "(\"" ^ s ^ "\\n\");"
    | Ast.Types (Ast.CharLiteral c) ->
        base_print^"(\"%c\\n\", '" ^ String.make 1 c ^ "');"
    | Ast.Types (Ast.IntLiteral i) ->
        base_print ^"(\"%d\\n\", " ^ string_of_expression expr ^ ");"
    | Ast.Types (Ast.FloatLiteral f) -> 
        base_print^ "(\"%f\\n\", " ^ string_of_expression expr ^ ");"
    | Ast.Types (Ast.BoolLiteral b) ->
        base_print ^ "(\"%d\\n\", " ^ string_of_expression expr ^ ");"
    | Ast.Binary _ -> 
        base_print ^ "(\"%d\\n\", " ^ string_of_expression expr ^ ");"
    | Ast.Fstring (s, _) ->
        (* Extract variable names from the f-string *)
        let regex = Str.regexp "{\\([a-zA-Z_][a-zA-Z0-9_]*\\)}" in
        let rec extract_vars acc start =
          try
            let _ = Str.search_forward regex s start in
            let var_name = Str.matched_group 1 s in
            extract_vars (acc @ [var_name]) (Str.match_end ())
          with Not_found -> acc
        in
        let vars = extract_vars [] 0 in
    
        (* Mangle the variable names *)
        let mangled_vars = List.map Id.mangle_identifier vars in
        
        (* Check each variable individually *)
        let check_var var =
          if Castle.get_var_entry_ var = None then
            let unmangled_name = Id.unmangle_identifier var in
            (* If the variable is not found, raise an error *)
            Error.__error__ "Variable %s not found" unmangled_name
        in
        List.iter check_var mangled_vars;
        
        (* Replace placeholders in the f-string with C-style format specifiers *)
        let formatted_string = Str.global_replace regex "%hhd" s in
    
        (* Generate the argument list for printf using mangled variable names *)
        let args = String.concat ", " mangled_vars in
    
        (* Generate the final C printf statement *)
        base_print ^ "(\"" ^ formatted_string ^ "\\n\", " ^ args ^ ");"
    | Ast.Identifier id ->
        let _ = Castle.get_var_entry_ id in 
        if Castle.get_var_entry_ id = None then
          let unmangled_name = Id.unmangle_identifier id in
          (* If the variable is not found, raise an error *)
          Error.__error__ "Variable %s not found" unmangled_name
        else
        
        (* Helper function to determine the format specifier based on the identifier's type *)
        let get_ident_type typ =
          match typ with
          | "char*" -> "%s"
          | "char" -> "%c"
          | "int8_t" -> "%hhd"
          | "int16_t" -> "%hd"
          | "int32_t" -> "%d"
          | "int64_t" -> "%lld"
          | "uint8_t" -> "%hhu"
          | "uint16_t" -> "%hu"
          | "uint32_t" -> "%u"
          | "uint64_t" -> "%llu"
          | "float" -> "%f"
          | "double" -> "%f"
          | "bool" -> "%d"
          | "list" 
          | _ -> Error.__error__ "Invalid type for identifier"
        in
      
        let identifier_type = 
          match Castle.get_var_entry_ id with
          | Some entry -> entry.var_type
          | None -> Error.__error__ "Variable %s not found" id
        in
        let type_string = string_of_ast_machine_types identifier_type in
        let format_specifier = get_ident_type type_string in
        "printf(\"" ^ format_specifier ^ "\\n\", " ^ string_of_expression expr ^ ");"
    | _ -> Error.__error__ "Invalid print statement"
    )     *)
  (* | Ast.Return expr -> "return " ^ string_of_expression expr ^ ";"



  | Ast.Def (scope, function_name, function_parameters, function_type, body) ->
  
   
    
    let scope_level = match scope with
      | Ast.Global _ -> GLobal
      | Ast.Local _ -> Local
    in
    let _ = Castle.helper scope_level function_name in
    let _ = Castle.set_process_entry scope_level function_name in

    (* Check if the function is already declared in the current scope *)
    let parameters_str = string_of_ast_parameters function_parameters in

    (* Initialize the declared names with function parameters *)
    let declared_names = List.map (fun (name, _, _) -> name) function_parameters in

    (* Process the body while checking for redeclarations *)
    let rec process_body stmt declared_names =
      match stmt with
      | Ast.Let_var (var_name, _, _, _) ->
          if List.mem var_name declared_names then
            Error.__error__ "Variable %s is redeclared in the same scope"
              var_name
          else
            let new_declared_names = var_name :: declared_names in
            string_of_statements stmt, new_declared_names
      | Ast.Enum (enum_name, _) ->
          if List.mem enum_name declared_names then
            Error.__error__ "Enum %s is redeclared in the same scope"
              enum_name
          else
            let new_declared_names = enum_name :: declared_names in
            string_of_statements stmt, new_declared_names
      | _ ->
          (* Process nested statements recursively *)
          let stmt_str = string_of_statements stmt in
          stmt_str, declared_names
      in
    let string_of_body, _ =
      List.fold_left
        (fun (acc_body, declared_names) stmt ->
          let stmt_str, new_declared_names = process_body stmt declared_names in
          (acc_body @ [stmt_str], new_declared_names))
        ([], declared_names)
        body
    in

    let string_of_body = String.concat "\n" string_of_body in
    let string_of_scope = string_of_scope scope in
    let function_signature = match function_type with 
      | Ast.Has_return Ast.True -> 
          string_of_scope ^ "int " ^ function_name ^ "(" ^ parameters_str ^ ")"
      | Ast.Has_return Ast.False -> 
          string_of_scope ^ "void " ^ function_name ^ "(" ^ parameters_str ^ ")"
    in
    let _ = Castle.clear_current_process () in
    (* Return the function signature and body *)
    function_signature ^ " {\n" ^ string_of_body ^ "\n}"


 *)











  (* | Ast.Import module_name -> 
        let include_directive = 
          match Import.find_import_name module_name with
          | Some lib -> "#include <" ^ lib ^ ".h>"
          | None -> let unmmangle = Id.unmangle_identifier module_name in 
          Error.__error__ "Module %s not found" unmmangle
        in
        include_directive *)
  (* | Ast.Let_var (var_name, machine_type, mutability, expr) ->
        
      let processing_now = Castle.get_current_process () in

      if processing_now = "" then 
        Castle.helper GLobal var_name
      else 
        Castle.var_helper  var_name machine_type mutability;


      


          let string_of_mutability = string_of_mutability mutability in
          let string_of_machine_type = string_of_ast_machine_types machine_type in
          let string_of_var_name =
            match machine_type with
            | Ast.List _ -> var_name ^ "[]"
            | _ -> var_name
          in
          let string_of_expr =
            match expr with
            | [] -> "" (* No initialization provided *)
            | [Ast.Expression expr_list] -> (
                match expr_list with
                | [Ast.Function_call (function_name, args)] ->
                    (* Handle function calls *)
                    let string_of_arguments = String.concat ", " (List.map string_of_expression args) in
                    function_name ^ "(" ^ string_of_arguments ^ ")"
                | [single_expr] ->
                    (* Handle single expressions *)
                    string_of_expression single_expr
                | exprs ->
                    (* Handle multiple expressions (e.g., for lists) *)
                    if match machine_type with Ast.List _ -> true | _ -> false then
                      "{" ^ (String.concat ", " (List.map string_of_expression exprs)) ^ "}"
                    else
                      String.concat ", " (List.map string_of_expression exprs)
              )
            | _ -> Error.__error__ "Invalid initialization for variable declaration"
          in
          string_of_mutability ^ string_of_machine_type ^ " " ^ string_of_var_name ^ " = " ^ string_of_expr ^ ";" *)

  | Ast.If_Else (condition, if_body, else_body) ->  
        let string_of_condition = string_of_expression condition in
        let string_of_if_body = List.map string_of_statements if_body |> String.concat "\n" in
        let string_of_else_body =
          match else_body with
          | [] -> "" (* No else block *)
          | [Ast.If_Else _ as nested_if_else] ->
              (* Handle nested if-else directly without adding an extra "else" block *)
              " else " ^ string_of_statements nested_if_else
          | _ ->
              (* Standard else block *)
              let else_body_str = List.map string_of_statements else_body |> String.concat "\n" in
              " else {\n" ^ else_body_str ^ "\n}"
        in
        "if (" ^ string_of_condition ^ ") {\n" ^ string_of_if_body ^ "\n}" ^ string_of_else_body

  | Ast.While (condition, body) ->
      let string_of_condition = string_of_expression condition in
      let string_of_body = List.map string_of_statements body in
      let string_of_body = String.concat "\n" string_of_body in
      "while (" ^ string_of_condition ^ ") {\n" ^ string_of_body ^ "\n}"
  | Ast.For (init, condition, update, body) ->
        let string_of_init, string_of_condition, string_of_update =
          match condition with
          | Ast.Range (start_expr, end_expr) ->
              (* Handle range-based loops *)
              let loop_var = match init with
                | Ast.Identifier id -> id
                | _ -> Error.__error__ "Invalid loop variable in for loop"
              in
              let start = string_of_expression start_expr in
              let end_ = string_of_expression end_expr in
              (loop_var ^ " = " ^ start ^ ";", loop_var ^ " < " ^ end_ ^ ";", loop_var ^ "++")
          | _ ->
              (* Generic for loop *)
              (string_of_expression init ^ ";", string_of_expression condition, string_of_expression update)
        in
        let string_of_body = List.map string_of_statements body |> String.concat "\n" in
        "for (" ^ string_of_init ^ " " ^ string_of_condition ^ " " ^ string_of_update ^ ") {\n" ^ string_of_body ^ "\n}"
  | Ast.Match (id, case) -> 
        let string_of_id = id in (* Directly use id as it is already a string *)
        let string_of_cases = List.map (fun (case_expr, case_body) ->
          let string_of_case_expr = string_of_expression case_expr in
          let string_of_case_body = List.map string_of_statements case_body in
          let string_of_case_body = String.concat "\n" string_of_case_body in
          if string_of_case_expr = "id_5F" ||string_of_case_expr = "id_D980" then
            "default:\n" ^ string_of_case_body ^ "\nbreak;"
          else
            "case " ^ string_of_case_expr ^ ":\n" ^ string_of_case_body ^ "\nbreak;"
        ) case in
        let string_of_cases = String.concat "\n" string_of_cases in
        "switch (" ^ string_of_id ^ ") {\n" ^ string_of_cases ^ "\n}"

    (* | Ast.Match (expr, cases) ->
          let string_of_expr = string_of_expression expr in
          let string_of_cases = List.map (fun (case_expr, case_body) ->
            let string_of_case_expr = string_of_expression case_expr in
            let string_of_case_body = List.map string_of_statements case_body in
            let string_of_case_body = String.concat "\n" string_of_case_body in
            if string_of_case_expr = "id_5F" then
              "default:\n" ^ string_of_case_body ^ "\nbreak;"
            else
              "case " ^ string_of_case_expr ^ ":\n" ^ string_of_case_body ^ "\nbreak;"
          ) cases in
          let string_of_cases = String.concat "\n" string_of_cases in
          "switch (" ^ string_of_expr ^ ") {\n" ^ string_of_cases ^ "\n}" *)
  | Ast.Enum (enum_name, enum_values) ->
          let string_of_enum_values =
            match enum_values with
            | [] -> ""
            | values ->
                let expressions = List.filter_map (function
                  | Ast.Expression expr_list -> Some expr_list
                  | _ -> None
                ) values in
                let flattened_expressions = List.flatten expressions in
                String.concat ",\n" (List.map (fun expr ->
                  match expr with
                  | Ast.Identifier name -> name
                  | _ -> string_of_expression expr
                ) flattened_expressions)
          in
          "typedef enum {\n" ^ string_of_enum_values ^ "\n} " ^ enum_name ^ ";"
  | Ast.Struct (struct_name, struct_fields) ->
      let string_of_struct_fields = List.map (fun (field_name, field_type) ->
        string_of_ast_machine_types field_type ^ " " ^ field_name ^ ";"
      ) struct_fields in
      let string_of_struct_fields = String.concat "\n" string_of_struct_fields in
      "typedef struct {\n" ^ string_of_struct_fields ^ "\n} " ^ struct_name ^ ";"








  
  
  | _ -> Error.__error__ "Invalid statement"






   let new_string_of_statements_list stmt =
    match stmt with
    | Ast.Def (_, _, _, _, _) -> Function_def.string_of_def_and_return_statment stmt
    | Ast.Import _ -> Import.string_of_import stmt
    | _ -> Error.__error__ "Invalid statement"
  
  let string_of_statements_list ast =
    String.concat "\n" (List.map new_string_of_statements_list ast)




let store_handler filename ast =
  let output = string_of_statements_list ast in
  
  (* Generate .sir file  *)
  let sir_output_filename = Filename.remove_extension filename ^ ".sir" in
  let sir_oc = open_out sir_output_filename in
  Printf.fprintf sir_oc "%s\n" output;
  close_out sir_oc;
  
  (* Generate .c file with necessary includes *)
  let c_output_filename = Filename.remove_extension filename ^ ".c" in
  let c_oc = open_out c_output_filename in

  
  (* Write the actual code *)
  Printf.fprintf c_oc "%s\n" output;
  close_out c_oc;
  
  ast

