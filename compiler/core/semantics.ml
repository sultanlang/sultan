



let string_of_scope = function
  | Ast.Global _ -> "extern "
  | Ast.Local _ -> ""


;;
let string_of_mutability = function
| Ast.Mutable -> ""
| Ast.Immutable -> "const "


;;
(* convert a . bool to string  *)
let string_of_sbool = function
| Ast.True -> "true"
| False -> "false"

;;

(* Convert an expression to a string representation *)
let rec string_of_expression = function
| Ast.Fstring (s, _,position) ->
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
  function_name ^ "(" ^ string_of_arguments ^ ");"
| Ast.Identifier(id,_) -> id
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
  | Ast.Equal -> "="
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
  | _ ->Errorlog.__error__position__ 0 0 "Invalid binary expression (unknown position)"

  let string_of_ast_parameters (parameters : Ast.parameters) =
    let string_of_parameter (name, typ, mutability) =
      let base_type = Types.string_of_ast_machine_types typ in
      let name_with_list_suffix =
        match typ with
        | Ast.List _ -> name ^ "[]"
        | _ -> name
      in
      (if mutability then "const " else "") ^ base_type ^ " " ^ name_with_list_suffix
    in
    String.concat ", " (List.map string_of_parameter parameters)


;;
let string_of_expression_statement = function
| Ast.Expression(expression_list,position) -> 
    let string_of_inner_expression = function
      | Ast.Function_call (function_name, args) ->
          let string_of_arguments = String.concat ", " (List.map string_of_expression args) in
          function_name ^ "(" ^ string_of_arguments ^ ");"
      | _ -> Errorlog.__error__position__ position.line position.column "Invalid inner expression in expression statement"
    in
    let string_of_outer_expression = List.map string_of_inner_expression expression_list in
    String.concat "\n" string_of_outer_expression

| _ -> Errorlog.__error__position__ 0 0 "Invalid expression statement (unknown position)"

let string_of_import = function
  | Ast.Import (module_name, position) ->
    let include_directive = 
      match Import.find_import_name module_name with
      | Some lib -> "#include <" ^ lib ^ ".h>"
      | None -> 
          let unmangle = Id.unmangle_identifier module_name in 
          let error_message = Error.__error__"Module %s not found" unmangle in
          Errorlog.__error__position__ position.line position.column error_message
    in
    include_directive

  | _ -> Errorlog.__error__position__ 0 0 "Invalid import statement (unknown position)"
;;
let string_of_print_statement = function
| Ast.Print (expr, pos) -> 
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
  | Ast.Fstring (s, expression,position) ->
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
  
      (* Check each variable individually *)
      List.iter (fun var -> let _ = Castle.get_var_entry var position in ()) vars;
      
      (* Replace placeholders in the f-string with C-style format specifiers *)
      let formatted_string = Str.global_replace regex "%hhd" s in
  
      (* Generate the argument list for printf using the variable names *)
      let args = String.concat ", " vars in
  
      (* Generate the final C printf statement *)
      base_print ^ "(\"" ^ formatted_string ^ "\\n\", " ^ args ^ ");"
  | Ast.Identifier( id, poistion) ->
      let var_entry = Castle.get_var_entry id poistion  in 

      
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
        | _ -> Errorlog.__error__position__ pos.line pos.column ("Invalid type: " ^ typ)
      in
    
      
         
   
   
      let type_string = Types.string_of_ast_machine_types var_entry.var_type  in
      (* Check if the variable is a list *)
      let format_specifier = get_ident_type type_string in
      "printf(\"" ^ format_specifier ^ "\\n\", " ^ string_of_expression expr ^ ");"
    | other_expr -> Errorlog.__error__position__ pos.line pos.column ("Invalid expression: " ^ string_of_expression other_expr)
  )  
| _ -> Errorlog.__error__position__ 0 0 "Invalid print statement (unknown position)"
 
 


;;

let string_of_return_statement = function
| Ast.Return (expression, position) ->
  
  let string_of_expression = string_of_expression expression in
  "return " ^ string_of_expression ^ ";"
| _ -> Errorlog.__error__position__ 0 0 "Invalid return statement (unknown position)"
;;


let string_of_let_statement = function
| Ast.Let_var (var_name, machine_type, mutability, expr, position) -> 
  (* let _ = Castle.get_current_process () in
  let _ = Castle.var_helper var_name machine_type mutability in *)
  

  let string_of_mutability = string_of_mutability mutability in
  let string_of_machine_type = Types.string_of_ast_machine_types machine_type in
  let string_of_var_name =
    match machine_type with
    | Ast.List _ -> var_name ^ "[]"
    | _ -> var_name
  in
  let string_of_expr =
    match expr with
    | [] -> "" (* No initialization provided *)
    | [Ast.Expression (expr_list, _)] -> (
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
    | _ -> Errorlog.__error__position__ position.line position.column "Invalid initialization for variable declaration"
  in
  string_of_mutability ^ string_of_machine_type ^ " " ^ string_of_var_name ^ " = " ^ string_of_expr ^ ";" 
| _ -> Errorlog.__error__position__ 0 0 "Invalid let statement (unknown position)"


;;
let string_of_reassign_statement = function 
| Ast.Reassign (id, expressions, position) ->
  let string_of_id = id in
  
  (* Handle the list of expressions *)
  let string_of_expressions = 
    match expressions with
    | [] -> Errorlog.__error__position__ position.line position.column "Empty expression list in reassignment"
    | [single_expr] -> string_of_expression single_expr
    | expr_list -> 
        (* Join multiple expressions with commas *)
        String.concat ", " (List.map string_of_expression expr_list)
  in
  
  (* let _ = Castle.get_var_entry id position in  *)

    string_of_id ^ " = " ^ string_of_expressions ^ ";"
| _ -> Errorlog.__error__position__ 0 0 "Invalid reassign statement (unknown position)"


  ;;
let string_of_while_statement = function
| Ast.While (condition, body, position) ->
  let string_of_condition = string_of_expression condition in
  
  let body_strings = List.map (fun stmt -> 
    match stmt with
    | Ast.Expression(exprs, _) -> string_of_expression_statement (Ast.Expression(exprs, position))
    | Ast.Let_var(name, typ, mut, exprs, _) -> 
        string_of_let_statement (Ast.Let_var(name, typ, mut, exprs, position))
    | _ -> Errorlog.__error__position__ position.line position.column "Unsupported statement in while body"
  ) body in
  
  let string_of_body = String.concat "\n" body_strings in
  "while (" ^ string_of_condition ^ ") {\n" ^ string_of_body ^ "\n}"
| _ -> Errorlog.__error__position__ 0 0 "Invalid while statement"
;;

let string_of_for_statement = function
| Ast.For (init, condition, update, body, position) ->
  let string_of_init, string_of_condition, string_of_update =
    match condition with
    | Ast.Range (start_expr, end_expr) ->
        let loop_var = match init with
          | Ast.Identifier (id,_) -> id
          | _ -> Errorlog.__error__position__ position.line position.column "Invalid loop variable"
        in
        (loop_var ^ " = " ^ string_of_expression start_expr ^ ";",
         loop_var ^ " < " ^ string_of_expression end_expr ^ ";",
         loop_var ^ "++")
    | _ ->
        (string_of_expression init ^ ";",
         string_of_expression condition,
         string_of_expression update)
  in
  
  let body_strings = List.map (fun stmt -> 
    match stmt with
    | Ast.Expression(exprs, _) -> string_of_expression_statement (Ast.Expression(exprs, position))
    | Ast.Let_var(name, typ, mut, exprs, _) -> 
        string_of_let_statement (Ast.Let_var(name, typ, mut, exprs, position))
    | _ -> Errorlog.__error__position__ position.line position.column "Unsupported statement in for loop body"
  ) body in
  
  let string_of_body = String.concat "\n" body_strings in
  "for (" ^ string_of_init ^ " " ^ string_of_condition ^ " " ^ string_of_update ^ ") {\n" ^ string_of_body ^ "\n}"
| _ -> Errorlog.__error__position__ 0 0 "Invalid for statement"
;;

let rec string_of_if_else_statement = function
| Ast.If_Else (condition, if_body, else_body, position) ->  
  let string_of_condition = string_of_expression condition in
  
  let if_body_strings = List.map (fun stmt -> 
    match stmt with
    | Ast.Expression(exprs, _) -> string_of_expression_statement (Ast.Expression(exprs, position))
    | Ast.Let_var(name, typ, mut, exprs, _) -> 
        string_of_let_statement (Ast.Let_var(name, typ, mut, exprs, position))
    | Ast.If_Else(cond, if_body, else_body, _) ->
        string_of_if_else_statement (Ast.If_Else(cond, if_body, else_body, position))
    | Ast.While(cond, body, _) ->
        string_of_while_statement (Ast.While(cond, body, position))
    | Ast.For(init, cond, update, body, _) -> 
        string_of_for_statement (Ast.For(init, cond, update, body, position))
    | Ast.Return(expr, _) ->
        string_of_return_statement (Ast.Return(expr, position))
    | _ -> Errorlog.__error__position__ position.line position.column "Unsupported statement in if body"
  ) if_body in
  
  let string_of_if_body = String.concat "\n" if_body_strings in
  
  let string_of_else_body =
    match else_body with
    | [] -> ""
    | [Ast.If_Else _ as nested_if_else] ->
        " else " ^ string_of_if_else_statement nested_if_else
    | _ ->
        let else_body_strings = List.map (fun stmt -> 
          match stmt with
          | Ast.Expression(exprs, _) -> string_of_expression_statement (Ast.Expression(exprs, position))
          | Ast.Let_var(name, typ, mut, exprs, _) -> 
              string_of_let_statement (Ast.Let_var(name, typ, mut, exprs, position))
          | Ast.If_Else(cond, if_body, else_body, _) ->
              string_of_if_else_statement (Ast.If_Else(cond, if_body, else_body, position))
          | Ast.While(cond, body, _) ->
              string_of_while_statement (Ast.While(cond, body, position))
          | Ast.For(init, cond, update, body, _) -> 
              string_of_for_statement (Ast.For(init, cond, update, body, position))
          | Ast.Return(expr, _) ->
              string_of_return_statement (Ast.Return(expr, position))
          | _ -> Errorlog.__error__position__ position.line position.column "Unsupported statement in else body"
        ) else_body in
        let else_body_str = String.concat "\n" else_body_strings in
        " else {\n" ^ else_body_str ^ "\n}"
  in
  "if (" ^ string_of_condition ^ ") {\n" ^ string_of_if_body ^ "\n}" ^ string_of_else_body
| _ -> Errorlog.__error__position__ 0 0 "Invalid if-else statement"
;;


  
let string_of_enum_statement = function
| Ast.Enum (enum_name, enum_values, position) ->
  let string_of_enum_values =
    match enum_values with
    | [] -> ""
    | values ->
        let expressions = List.filter_map (function
        | Ast.Expression(exprs, _) -> Some exprs (* Keep the expressions as they are *)
        | _ -> None
        ) values in
        let flattened_expressions = List.flatten expressions in
        String.concat ",\n" (List.map (fun expr ->
          match expr with
          | Ast.Identifier (name,_) -> name
          | _ -> string_of_expression expr
        ) flattened_expressions)
  in
  "typedef enum {\n" ^ string_of_enum_values ^ "\n} " ^ enum_name ^ ";"
| _ -> Errorlog.__error__position__ 0 0 "Invalid enum statement"

let string_of_struct_statement = function
  | Ast.Struct (struct_name, struct_fields,position) ->
    let string_of_struct_fields = List.map (fun (field_name, field_type) ->
    Types.string_of_ast_machine_types field_type ^ " " ^ field_name ^ ";"
    ) struct_fields in
    let string_of_struct_fields = String.concat "\n" string_of_struct_fields in
    "typedef struct {\n" ^ string_of_struct_fields ^ "\n} " ^ struct_name ^ ";"

  | _-> Errorlog.__error__position__ 0 0 "Invalid struct statement"

;;



let string_of_match_signature = function
| Ast.Match (id, _, _) -> 
    

  let string_of_id = id in (* Directly use id as it is already a string *)
  "switch (" ^ string_of_id ^ ")"
| _ -> Errorlog.__error__position__ 0 0 "Invalid match statement"


;;


let string_of_def_base = function
| Ast.Def (scope, function_name, function_parameters, function_type, _, position) ->

  let parameters_str = string_of_ast_parameters function_parameters in

  (* Return the function signature *)
  let function_signature = match function_type with 
    | Ast.Has_return Ast.True -> 
        string_of_scope scope ^ "int " ^ function_name ^ "(" ^ parameters_str ^ ")"
    | Ast.Has_return Ast.False -> 
        string_of_scope scope ^ "void " ^ function_name ^ "(" ^ parameters_str ^ ")"
  in
  (* Castle.set_current_process ""; *)
  (* Return the function signature *)
  function_signature
| _ -> Errorlog.__error__position__ 0 0 "Invalid def statement (unknown position)"
;;