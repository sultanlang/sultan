open Ast
open Symboltable
(* Helper function to determine the print format for an expression *)
let format_for_print expr_str =
  (* Check if expr_str is a quoted string (literal) *)
  if String.length expr_str >= 2 && String.get expr_str 0 = '"' && String.get expr_str (String.length expr_str - 1) = '"' then
    expr_str  (* Return as is if it's a literal *)
  else
    (* If not a literal, check if it’s a known variable in the symbol table *)
    match get_variable_info expr_str with
    | Some _ -> "!" ^ expr_str  (* Variable name found in table, add '!' *)
    | None -> expr_str  (* Not found in table, assume it’s a direct value or expression *)


let is_else_case = function
  | Else _ -> true
  | _ -> false

let needs_semicolon expr =
  match expr with
  | If _ | IfElse _ | Else _ -> false
  | _ -> true

let strip_trailing_semicolon s =
  if String.length s > 0 && String.get s (String.length s - 1) = ';' then
    String.sub s 0 (String.length s - 1)
  else
    s

let rec string_of_expr = function
| IntLiteral n -> string_of_int n
| FloatLiteral f -> string_of_float f
| StringLiteral s -> Printf.sprintf "\"%s\"" (String.escaped s)
| BoolLiteral b -> string_of_bool b
| CharLiteral c -> Printf.sprintf "'%c'" c
| Void -> "()"
| Identifier id -> id
| ErrorExpression msg -> failwith ("" ^ msg)
| Binop (op, e1, e2) ->
  let op_str = match op with
    | Plus -> "+" | Minus -> "-" | Times -> "*" | Div -> "/"
    | Equals -> "=" | NotEquals -> "<>" | GreaterThan -> ">" | LessThan -> "<"
  in
  Printf.sprintf "(%s %s %s)" (string_of_expr e1) op_str (string_of_expr e2)
| Unop (op, e) ->
  let op_str = match op with
    | UMinus -> "-" | Abs -> "abs" | Sqrt -> "sqrt" | Cbrt -> "cbrt"
    | Exp -> "exp" | Exp2 -> "exp2" | Log -> "log" | Log10 -> "log10" | Log2 -> "log2"
    | Cos -> "cos" | Sin -> "sin" | Tan -> "tan" | Acos -> "acos" | Asin -> "asin"
    | Atan -> "atan" | Cosh -> "cosh" | Sinh -> "sinh" | Tanh -> "tanh"
    | Acosh -> "acosh" | Asinh -> "asinh" | Atanh -> "atanh" | Erf -> "erf"
    | Erfc -> "erfc" | Ceil -> "ceil" | Floor -> "floor" | Round -> "round" | Trunc -> "trunc"
  in
  Printf.sprintf "(%s %s)" op_str (string_of_expr e)
| ListLiteral exprs ->
  let exprs_str = String.concat "; " (List.map string_of_expr exprs) in
  Printf.sprintf "[%s]" exprs_str
| DictLiteral entries ->
  let entries_str =
    entries
    |> List.map (fun (k, v) -> Printf.sprintf "%s: %s" (string_of_expr k) (string_of_expr v))
    |> String.concat "; "
  in
  Printf.sprintf "{%s}" entries_str
| TupleLiteral exprs ->
  let exprs_str = exprs |> List.map string_of_expr |> String.concat ", " in
  Printf.sprintf "(%s)" exprs_str
| Range (e1, e2) ->
  Printf.sprintf "[%s .. %s]" (string_of_expr e1) (string_of_expr e2)
   
      
and string_of_statement = function
  | LetConstBinding (id, _, expr) ->
    let expr_str = string_of_expr expr in
    Printf.sprintf "let %s = %s" id expr_str  (* Standalone constant *)

  | LetVarBinding (id, _, expr) ->
    let expr_str = string_of_expr expr in
    Printf.sprintf "let %s =  %s in" id expr_str  (* Mutable variable with ref *)

  | LetListBinding (id, _, expr) ->
    let expr_str = string_of_expr expr in
    Printf.sprintf "let %s = [%s]" id expr_str  (* Immutable list without in *)
    (* Or, if mutable list: *)
    (* Printf.sprintf "let %s = ref [%s];" id expr_str *)

  | LetUninitializedBinding (id, _, _) ->
    let var_info = get_variable_info id in
    begin match var_info with
    | Some { var_type; is_mutable; _ } ->
        let default_value = 
          match var_type with
          | "int" -> "0"
          | "float" -> "0.0"
          | "string" -> "\"\""
          | "bool" -> "false"
          | "list" -> "[]"
          | _ -> "None"
        in
        if is_mutable then
          Printf.sprintf "let %s = ref %s" id default_value  (* Mutable with ref, no 'in' *)
        else
          Printf.sprintf "let %s = %s;" id default_value  (* Immutable variable, no 'in' *)
    | None -> failwith ("The LetUninitializedBinding can not find  " ^ id ^ " in symbol table")
    end

  | IfElse (cond, then_stmts, else_stmts) ->
    let then_str = 
      match then_stmts with
      | [single_stmt] -> string_of_statement single_stmt
      | _ -> "begin " ^ (String.concat "; " (List.map string_of_statement then_stmts)) ^ " end"
    in
    let then_str = strip_trailing_semicolon then_str in
    let else_str = 
      match else_stmts with
      | [single_stmt] -> string_of_statement single_stmt
      | _ -> "begin " ^ (String.concat "; " (List.map string_of_statement else_stmts)) ^ " end"
    in
    Printf.sprintf "if %s then %s else %s" (string_of_expr cond) then_str else_str
  | If (cond, then_stmts) ->
    let then_str = 
      match then_stmts with
      | [single_stmt] -> string_of_statement single_stmt
      | _ -> "begin " ^ (String.concat "; " (List.map string_of_statement then_stmts)) ^ " end"
    in
    let then_str = strip_trailing_semicolon then_str in
    Printf.sprintf "if %s then %s" (string_of_expr cond) then_str
  | Else stmts ->
    let stmts_str = 
      match stmts with
      | [single_stmt] -> string_of_statement single_stmt
      | _ -> "begin " ^ (String.concat "; " (List.map string_of_statement stmts)) ^ " end"
    in
    let stmts_str = strip_trailing_semicolon stmts_str in
    Printf.sprintf "else %s" stmts_str
  | PrintInput expr ->
    Printf.sprintf "Printf.printf \"%s\"; read_line ()" (string_of_expr expr)
    | PrintOutputSingle expr ->
      (* Retrieve variable info directly from symbol table for correct type handling *)
      let expr_str = 
        match expr with
        | Identifier id -> (
            match Symboltable.get_variable_info id with
            | Some info -> (
                match info.var_type with
                | "int" -> Printf.sprintf "string_of_int %s" id
                | "float" -> Printf.sprintf "string_of_float %s" id
                | "bool" -> Printf.sprintf "string_of_bool %s" id
                | "char" -> Printf.sprintf "String.make 1 %s" id
                | "string" -> id
                | "[int]" -> Printf.sprintf "String.concat \"; \" (List.map string_of_int %s)" id
                | "[float]" -> Printf.sprintf "String.concat \"; \" (List.map string_of_float %s)" id
                | "[bool]" -> Printf.sprintf "String.concat \"; \" (List.map string_of_bool %s)" id
                | "[string]" -> Printf.sprintf "String.concat \"; \" %s" id
                | _ -> id
            )
            | None -> id
        )
        | StringLiteral s -> Printf.sprintf "\"%s\"" (String.escaped s)
        | _ -> failwith "Expected an identifier for printing" (* Error for unsupported cases *)
      in
      (* Dynamically add parentheses only if necessary *)
      if String.contains expr_str ' ' || String.contains expr_str '(' then
        Printf.sprintf "print_endline (%s);" expr_str  (* Add parentheses for complex expressions *)
      else
        Printf.sprintf "print_endline %s" expr_str  (* Omit parentheses for simple identifiers *)
  
  
  | PrintOutputDouble (expr1, expr2) ->
      (* Retrieve type information from symbol table for each expression *)
      let expr1_str = 
        match expr1 with
        | Identifier id -> (
            match Symboltable.get_variable_info id with
            | Some info -> (
                match info.var_type with
                | "int" -> Printf.sprintf "(string_of_int %s)" id
                | "float" -> Printf.sprintf "(string_of_float %s)" id
                | "bool" -> Printf.sprintf "(string_of_bool %s)" id
                | "char" -> Printf.sprintf "(String.make 1 %s)" id
                | "string" -> id
                | "[int]" -> Printf.sprintf "(String.concat \"; \" (List.map string_of_int %s))" id
                | "[float]" -> Printf.sprintf "(String.concat \"; \" (List.map string_of_float %s))" id
                | "[bool]" -> Printf.sprintf "(String.concat \"; \" (List.map string_of_bool %s))" id
                | "[string]" -> Printf.sprintf "(String.concat \"; \" %s)" id
                | _ -> id
            )
            | None -> id
        )
        | StringLiteral s -> Printf.sprintf "\"%s\"" (String.escaped s)

        | _ -> failwith "Expected an identifier for printing"
  
      in
      let expr2_str = 
        match expr2 with
        | Identifier id -> (
            match Symboltable.get_variable_info id with
            | Some info -> (
                match info.var_type with
                | "int" -> Printf.sprintf "(string_of_int %s)" id
                | "float" -> Printf.sprintf "(string_of_float %s)" id
                | "bool" -> Printf.sprintf "(string_of_bool %s)" id
                | "char" -> Printf.sprintf "(String.make 1 %s)" id
                | "string" -> id
                | "[int]" -> Printf.sprintf "(String.concat \"; \" (List.map string_of_int %s))" id
                | "[float]" -> Printf.sprintf "(String.concat \"; \" (List.map string_of_float %s))" id
                | "[bool]" -> Printf.sprintf "(String.concat \"; \" (List.map string_of_bool %s))" id
                | "[string]" -> Printf.sprintf "(String.concat \"; \" %s)" id
                | _ -> id
            )
            | None -> id
        )
        | StringLiteral s -> Printf.sprintf "\"%s\"" (String.escaped s)

        | _ -> failwith "Expected an identifier for printing"
  
      in
      Printf.sprintf "Printf.printf \"%s = %%s\\n\" %s;" expr1_str expr2_str
  
  | ForLoopRange (var, start_expr, body_stmts) ->
    let start_str = string_of_expr start_expr in
    let body_str = 
      match body_stmts with
      | [single_stmt] -> string_of_statement single_stmt
      | _ -> "begin " ^ (String.concat "; " (List.map string_of_statement body_stmts)) ^ " end"
    in
    Printf.sprintf "List.iter (fun %s -> %s) %s" var body_str start_str
  | ForLoopClassic (var, start_expr, end_expr, step_expr, body_stmts) ->
    let start_str = string_of_expr start_expr in
    let end_str = string_of_expr end_expr in
    let body_str = 
      match body_stmts with
      | [single_stmt] -> string_of_statement single_stmt
      | _ -> "begin " ^ (String.concat "; " (List.map string_of_statement body_stmts)) ^ " end"
    in
    Printf.sprintf "for %s = %s to %s do %s done" var start_str end_str body_str
    | FunctionDef (name, params, body) ->
      let params_str = 
        params 
        |> List.map (fun (param_name, param_type) -> 
            match param_type with
            | Some t -> Printf.sprintf "(%s: %s)" param_name t
            | None -> param_name)
        |> String.concat " "
      in
      let body_str = 
        match body with
        | [single_stmt] -> string_of_statement single_stmt
        | _ -> String.concat " \n  " (List.map string_of_statement body)
      in
      Printf.sprintf "let %s %s =\n  %s" name params_str body_str
  | Return expr -> string_of_expr expr
      
  | ReturnMultiple exprs -> 
    let exprs_str = List.map string_of_expr exprs |> String.concat ", " in
    Printf.sprintf "(%s)" exprs_str
  | Assignment (id, e1, e2) ->
    let e1_str = string_of_expr e1 in
    Printf.sprintf "%s:= %s;;" id e1_str
  | ErrorStatement msg -> failwith ("" ^ msg)
  | Import _ -> ""
  | Functioncall (name, args) ->  
    let args_str = List.map string_of_expr args |> String.concat " " in
    Symboltable.get_function_info name |> fun info ->
    Printf.sprintf "%s %s" name args_str
  | LetFunctionBinding (name, params, body) ->
    let body_str = 
      match body with
      | [single_stmt] -> string_of_statement single_stmt
      | _ -> String.concat " \n  " (List.map string_of_statement body)
    in
    Printf.sprintf "let %s = %s in" name body_str
    | TryCatch (try_block, exception_name, catch_block) ->
      let try_str = String.concat "\n" (List.map string_of_statement try_block) in
      let catch_str = String.concat "\n" (List.map string_of_statement catch_block) in
      Printf.sprintf "let ()=\n try \n%s\n with %s -> \n%s\n" try_str exception_name (Printf.sprintf "let %s = Printexc.to_string %s in\n%s" exception_name exception_name catch_str)
      
    
  | Match (expr, cases) ->
    let expr_str = string_of_expr expr in
    let cases_str = 
      cases
      |> List.map (fun (k, v) -> 
          match k with
          | Identifier id -> (
              match Symboltable.get_variable_info id with
              | Some _ -> Printf.sprintf "| %s -> %s" (string_of_expr k) (String.concat "\n" (List.map string_of_statement v))
              | None -> 
                  Symboltable.add_error id 0 0;
                  Printf.sprintf "| %s -> %s" (string_of_expr k) (String.concat "\n" (List.map string_of_statement v))
          )
          | _ -> Printf.sprintf "| %s -> %s" (string_of_expr k) (String.concat "\n" (List.map string_of_statement v))
        )
      |> String.concat "\n"
    in
    Printf.sprintf "match %s with\n%s| _ -> failwith \"Match failure\"" expr_str cases_str






(* In your compiler's main processing loop *)
(* let rec process_statements statements =
  match statements with
  | [] -> ()
  | stmt :: rest ->
      (try
         (* Process the statement *)
         let _ = string_of_statement stmt in
         (* Continue with the rest of the statements *)
         process_statements rest
       with
       | Failure msg ->
           (* Print the error message and stop the compiler *)
           Printf.printf "Compilation error: %s\n" msg;
           exit 1)
 *)

(* 

  | IfElse (cond, then_stmts, else_stmts) ->
    let then_str = 
      match then_stmts with
      | [single_stmt] -> string_of_statement single_stmt
      | _ -> "begin " ^ (String.concat "; " (List.map string_of_statement then_stmts)) ^ " end"
    in
    let then_str = strip_trailing_semicolon then_str in
    let else_str = 
      match else_stmts with
      | [single_stmt] -> string_of_statement single_stmt
      | _ -> "begin " ^ (String.concat "; " (List.map string_of_statement else_stmts)) ^ " end"
    in
    Printf.sprintf "if %s then %s else %s" (string_of_expr cond) then_str else_str
  | If (cond, then_stmts) ->
    let then_str = 
      match then_stmts with
      | [single_stmt] -> string_of_statement single_stmt
      | _ -> "begin " ^ (String.concat "; " (List.map string_of_statement then_stmts)) ^ " end"
    in
    let then_str = strip_trailing_semicolon then_str in
    Printf.sprintf "if %s then %s" (string_of_expr cond) then_str
  | Else stmts ->
    let stmts_str = 
      match stmts with
      | [single_stmt] -> string_of_statement single_stmt
      | _ -> "begin " ^ (String.concat "; " (List.map string_of_statement stmts)) ^ " end"
    in
    let stmts_str = strip_trailing_semicolon stmts_str in
    Printf.sprintf "else %s" stmts_str
  | PrintInput expr ->
    Printf.sprintf "Printf.printf \"%s\"; read_line ()" (string_of_expr expr)
  | PrintOutputSingle expr ->
    let expr_str = string_of_printable_expr expr in
    Printf.sprintf "print_endline (%s);" expr_str
  | PrintOutputDouble (expr1, expr2) ->
    let expr1_str = string_of_printable_expr expr1 in
    let expr2_str = string_of_printable_expr expr2 in
    Printf.sprintf "Printf.printf \"%s = %%s\\n\" %s" expr1_str expr2_str
  | ForLoopRange (var, start_expr, body_stmts) ->
    let start_str = string_of_expr start_expr in
    let body_str = 
      match body_stmts with
      | [single_stmt] -> string_of_statement single_stmt
      | _ -> "begin " ^ (String.concat "; " (List.map string_of_statement body_stmts)) ^ " end"
    in
    Printf.sprintf "List.iter (fun %s -> %s) %s" var body_str start_str
  | ForLoopClassic (var, start_expr, end_expr, step_expr, body_stmts) ->
    let start_str = string_of_expr start_expr in
    let end_str = string_of_expr end_expr in
    let body_str = 
      match body_stmts with
      | [single_stmt] -> string_of_statement single_stmt
      | _ -> "begin " ^ (String.concat "; " (List.map string_of_statement body_stmts)) ^ " end"
    in
    Printf.sprintf "for %s = %s to %s do %s done" var start_str end_str body_str
  | FunctionDef (name, params, body) ->
    let params_str = 
      params 
      |> List.map (fun (param_name, param_type) -> 
          match param_type with
          | Some t -> Printf.sprintf "%s: %s" param_name t
          | None -> param_name)
      |> String.concat ", "
    in
    let body_str = 
      match body with
      | [single_stmt] -> string_of_statement single_stmt
      | _ -> "begin " ^ (String.concat "; " (List.map string_of_statement body)) ^ " end"
    in
    Printf.sprintf "let %s (%s) = %s" name params_str body_str
  | Return expr -> string_of_expr expr
  | ReturnMultiple exprs -> 
    let exprs_str = List.map string_of_expr exprs |> String.concat ", " in
    Printf.sprintf "(%s)" exprs_str
  | Functioncall (name, args) ->  
    let args_str = List.map string_of_expr args |> String.concat ", " in
    Printf.sprintf "%s(%s)" name args_str
  | Assignment (id, e1, e2) ->
    let e1_str = string_of_expr e1 in
    Printf.sprintf "%s <- %s" id e1_str
  | ErrorStatement msg -> failwith ("" ^ msg)
 *)


