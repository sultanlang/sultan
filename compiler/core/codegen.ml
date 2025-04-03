
let rec string_of_statements = function
| Ast.Def (scope, name, params, return_type, body, position) ->

  let scope_level = match scope with
  | Ast.Global _ -> Castle.GLobal
  | Ast.Local _ -> Castle.Local 
in
let _ = Castle.set_current_process  name in
  (* Check if the function is already defined in the current scope *)
    let _ = Castle.get_function scope_level name in
  (* Add the function to the symbol table *)
  let _ = Castle.add_function scope_level name in

  

  
    (* Adjust the call to match the expected signature of Semantics.string_of_def_base *)
    let def_base_result = Semantics.string_of_def_base (Ast.Def (scope, name, params, return_type, body, position)) in
    (* Since def_base_result is a string, use it directly *)
    let declared_names = List.map (fun (name, _, _) -> name) params in
    let rec process_body stmt declared_names =
      match stmt with
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
    Castle.clear_current_process ();
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
    let _ = Castle.get_var_entry id position in 

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
  let _ = Castle.declare_variable_entry id mutability machine_type position in
    let let_var_str = Semantics.string_of_let_statement 
      (Ast.Let_var (id, machine_type, mutability, expressions, position)) 
    in
    let_var_str

  | Ast.Reassign (id, expressions, position) ->
    let _var_declared = Castle.get_var_entry id in 
    
      let reassign_str = Semantics.string_of_reassign_statement (Ast.Reassign (id, expressions, position)) in
      reassign_str

  | Ast.Enum (id, variants, position) ->
       let current_process = Castle.get_current_process () in
      let parent_process = 
        if current_process = "" then (
          Castle.set_current_process id; (* Set the current process to the enum ID *)
          "Global"
        ) else current_process
      in
      let _ = Castle.sub_function_declare parent_process id in 
      let enum_str = Semantics.string_of_enum_statement (Ast.Enum (id, variants, position)) in
      enum_str
| _ ->   Errorlog.__error__position__ 0 0 "Unknown statement type in Codegen"
;;
let string_of_statements_list ast =
  String.concat "\n" (List.map string_of_statements ast)



  (* let store_handler ast =
    let _output = string_of_statements_list ast in
  
    (* Optionally, here you can log or process 'output' for debugging or further processing *)
    (* For example, you might want to print it to stdout for now to see the output *)
    
  
    (* Return the AST directly for further processing *)
    ast
  ;; *)



let to_string filename ast =
  let output = string_of_statements_list ast in
  
  (* Generate .sir file  *)
  let sir_output_filename = Filename.remove_extension filename ^ ".sir" in
  let sir_oc = open_out sir_output_filename in
  Printf.fprintf sir_oc "%s\n" output;
  close_out sir_oc;
  
  (* Generate .c file with necessary includes *)
   (* let c_output_filename = Filename.remove_extension filename ^ ".c" in
  let c_oc = open_out c_output_filename in

  
  (* Write the actual code *)
  Printf.fprintf c_oc "%s\n" output;
  close_out c_oc;
   *)
  ast

;;  