
let rec string_of_statements = function
  | Ast.Def (scope, name, params, return_type, body, position) ->
    let scope_level = match scope with
    | Ast.Global _ -> Castle.GLobal
    | Ast.Local _ -> Castle.Local
  in
   let _set_process_entry = Castle.set_process_entry scope_level name in 
    (* Adjust the call to match the expected signature of Semantics.string_of_def_base *)
    let def_base_result = Semantics.string_of_def_base (Ast.Def (scope, name, params, return_type, body, position)) in
    (* Since def_base_result is a string, use it directly *)
    let declared_names = List.map (fun (name, _, _) -> name) params in
    let rec process_body stmt declared_names =
      match stmt with
      | Ast.Let_var (var_name, types, mutability, expressions, position) -> 
        let typ = types in
        (match typ with 
        | Ast.None -> 
            (* If type is None, treat as reassignment *)
            (* Extract the first expression from the list to use with Reassign *)
            let expr = match expressions with
              | [] -> Errorlog.__error__position__ position.line position.column "Expected an expression for reassignment"
              | [Ast.Expression([single_expr], _)] -> single_expr
              | [head] -> 
                  (* Need to extract the expression from the statement *)
                  (match head with
                   | Ast.Expression([expr], _) -> expr
                   | _ -> Errorlog.__error__position__ position.line position.column "Expected an expression for reassignment")
              | _ -> Errorlog.__error__position__ position.line position.column "Expected a single expression for reassignment"
            in
            let stmt_str = Semantics.string_of_reassign_statement (Ast.Reassign (var_name, expr, position)) in
            (* Check if the variable is already declared *)
            (stmt_str, declared_names)
        | _ ->
            if List.mem var_name declared_names then
              let unmangle_name = Id.unmangle_identifier var_name in
              Errorlog.__error__position__ position.line position.column (Printf.sprintf "Variable %s is redeclared in the same scope" unmangle_name)
            else
              (* Add the variable to the declared names *)
              let new_declared_names = var_name :: declared_names in
              let stmt_str = string_of_statements (Ast.Let_var (var_name, types, mutability, expressions, position)) in
              (stmt_str, new_declared_names))              
      | Ast.Enum (enum_name, _, position) ->
          (* Check if the enum is already declared *)
          if List.mem enum_name declared_names then
            let unmangle_name = Id.unmangle_identifier enum_name in
            Errorlog.__error__position__ position.line position.column (Printf.sprintf "Enum %s is redeclared in the same scope" unmangle_name)
          else
            (* Add the enum to the declared names *)
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
    let function_body = String.concat "\n" string_of_body in
    let _ = Castle.clear_current_process() in
    Printf.sprintf "%s\n{\n%s\n}\n" def_base_result function_body



| Ast.Import (module_name, position) ->
      (* Use Semantics.string_of_import to generate the string representation *)
      let include_directive = Semantics.string_of_import (Ast.Import (module_name, position)) in
      include_directive
| Ast.Print (expression,position) -> 
    let print_ = Semantics.string_of_print_statement (Ast.Print (expression, position)) in
    print_
| Ast.If_Else (condition, if_body, else_body, position) ->
    let body_if_else = Semantics.string_of_if_else_statement (If_Else (condition, if_body, else_body, position)) in
      body_if_else

| Ast.While (condition, body, position) ->
    let body_while = Semantics.string_of_while_statement (While (condition, body, position)) in
      body_while
| Ast.For (init, condition, increment, body, position) ->
    let body_for = Semantics.string_of_for_statement (For (init, condition, increment, body, position)) in
      body_for



| Ast.Match (id, cases, position) ->
    (* Generate the match signature using Semantics.string_of_match_signature *)
    let match_signature = Semantics.string_of_match_signature (Ast.Match (id, [], position)) in
    let check_id = Castle.get_var_entry_ id in 
    if check_id = None then
      let unmangle_name = Id.unmangle_identifier id in
      (* If the variable is not declared, raise an error *)
      Errorlog.__error__position__ position.line position.column (Printf.sprintf "Variable %s is not declared" unmangle_name)
    else
     
    (* Generate the body for each case *)
    let match_cases = List.map (fun (case_expr, case_body) ->
        let string_of_case_expr = Semantics.string_of_expression case_expr in
        let string_of_case_body = List.map string_of_statements case_body in
        let string_of_case_body = String.concat "\n" string_of_case_body in
        if string_of_case_expr = "id_5F" || string_of_case_expr = "id_D980" then
          "default:\n" ^ string_of_case_body ^ "\nbreak;"
        else
          "case " ^ string_of_case_expr ^ ":\n" ^ string_of_case_body ^ "\nbreak;"
    ) cases in

    (* Combine all cases into a single string *)
    let match_cases_str = String.concat "\n" match_cases in

    (* Combine the signature and the body *)
    Printf.sprintf "%s {\n%s\n}" match_signature match_cases_str


| Ast.Expression(expressions, position) ->
      let expression_strs = List.map Semantics.string_of_expression expressions in
      String.concat "\n" expression_strs
| Ast.Return (expression, position) ->
      let return_str = Semantics.string_of_return_statement (Ast.Return (expression, position)) in
      return_str
| Ast.Let_var (id, machine_type, mutability, expressions, position) ->
      let let_var_str = Semantics.string_of_let_statement (Ast.Let_var (id, machine_type, mutability, expressions, position)) in
      let_var_str

  (* | Ast.Reassign (id, machine_type, mutability, expressions, position) ->
      let reassign_str = Semantics.string_of_reassign_statement (Ast.Reassign (id, machine_type, mutability, expressions, position)) in
      reassign_str *)
| _ ->   Errorlog.__error__position__ 0 0 "Unknown statement type"
;;
let string_of_statements_list ast =
  String.concat "\n" (List.map string_of_statements ast)




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

;;