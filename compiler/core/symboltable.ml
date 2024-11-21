(* symboltable.ml *)

module Table = Map.Make(String)

type variable_info = {
  var_type: string;
  var_value: string option;  (* Optional initial value *)
  is_mutable: bool;          (* If the variable is mutable *)
  is_not_mutable: bool;      (* If the variable is not mutable *)
  scope_level: int;          (* For scope management *)
}

type import_info = {
  import_name: string;
  scope_level: int;
}

type error_info = {
  error_message: string;
  error_line: int;
  error_column: int;
}


let type_environment = ref Table.empty
let import_environment = ref Table.empty
let error_environment = ref Table.empty

let current_namespace = ref ""  (* Track current namespace context *)
let scope_stack = ref [0]  (* Stack to manage scope levels *)






(* Helper to generate a qualified name for namespacing *)
let qualified_name name = 
  if !current_namespace = "" then name else !current_namespace ^ "::" ^ name

let add_import name scope_level =
  let qname = qualified_name name in
  if Table.mem qname !import_environment then
    failwith ("Import " ^ qname ^ " already exists in the symbol table");
  let import_info = {
    import_name = qname;
    scope_level;
  } in
  Printf.printf "Adding import: %s, scope level: %d\n" qname scope_level;
  import_environment := Table.add qname import_info !import_environment;
  (* Print entire import table for debugging *)
  Printf.printf "Current import table state:\n";
  Table.iter (fun k v ->
    Printf.printf "  Import: %s, Scope Level: %d\n"
      k v.scope_level
  ) !import_environment

let get_imports () =
  Table.fold (fun k v acc ->
    if v.scope_level = (List.hd !scope_stack) then k :: acc else acc
  ) !import_environment []

(* Function to check if a module exists in the ./libs/ directory *)
let check_module_exists module_name =
  let path = "./libs/" in
  let lib_files = Sys.readdir path in
  Array.exists (fun file ->
    Filename.check_suffix file "sn" && Filename.remove_extension file = module_name
  ) lib_files

(* Register a type in the symbol table for tracking *)
let rec register_type typ =
  if not (Table.mem typ !type_environment) then (
    let type_info = { var_type = typ; var_value = None; is_mutable = false; is_not_mutable = true; scope_level = 0 } in
    type_environment := Table.add typ type_info !type_environment;
    Printf.printf "Registered type: %s\n" typ
  );
  (* Register component types for composite types *)
  if String.starts_with ~prefix:"list<" typ then
    let inner_type = String.sub typ 5 (String.length typ - 6) in
    register_type inner_type
  else if String.starts_with ~prefix:"dict<" typ then
    let key_value = String.sub typ 5 (String.length typ - 6) in
    let parts = String.split_on_char ':' key_value in
    if List.length parts = 2 then (
      register_type (List.nth parts 0);
      register_type (List.nth parts 1)
    )
  else if String.starts_with ~prefix:"tuple<" typ then
    let elements = String.sub typ 6 (String.length typ - 7) in
    List.iter register_type (String.split_on_char ',' elements)

(* Add a variable with all its details to the symbol table, ensuring unique names in the same scope *)
let add_variable name typ value is_mutable is_not_mutable scope_level =
  let qname = qualified_name name in
  match Table.find_opt qname !type_environment with
  | Some var_info when var_info.scope_level = scope_level ->
      failwith ("Variable " ^ qname ^ " already exists in the current scope level " ^ string_of_int scope_level)
  | _ ->
      if is_not_mutable && value = None then
        failwith ("Constant " ^ name ^ " must be initialized");
      (* Register the type before adding the variable *)
      register_type typ;
      let var_info = { 
        var_type = typ; 
        var_value = value; 
        is_mutable; 
        is_not_mutable;
        scope_level 
      } in
      Printf.printf "Adding variable: %s with type: %s, value: %s, mutable: %b, not mutable: %b, scope level: %d\n" 
        qname typ (match value with Some v -> v | None -> "None") is_mutable is_not_mutable scope_level;
      type_environment := Table.add qname var_info !type_environment;
      (* Print entire symbol table for debugging *)
      Printf.printf "Current symbol table state:\n";
      Table.iter (fun k v ->
        Printf.printf "  Variable: %s, Type: %s, Value: %s, Mutable: %b, Not Mutable: %b, Scope Level: %d\n"
          k v.var_type (match v.var_value with Some v -> v | None -> "None") v.is_mutable v.is_not_mutable v.scope_level
      ) !type_environment

(* Add a constant to the symbol table (immutable variable) *)
let add_constant name typ value scope_level =
  add_variable name typ value false true scope_level  (* Use add_variable with is_mutable = false and is_not_mutable = true *)
  let add_namespace namespace scope_level =
    let qname = qualified_name namespace in
    if Table.mem qname !type_environment then
      failwith ("Namespace " ^ qname ^ " already exists in the symbol table");
    let namespace_info = { var_type = qname; var_value = None; is_mutable = false; is_not_mutable = true; scope_level } in
    Printf.printf "Adding namespace: %s, scope level: %d\n" qname scope_level;
    type_environment := Table.add qname namespace_info !type_environment;
    (* Print entire symbol table for debugging *)
    Printf.printf "Current symbol table state:\n";
    Table.iter (fun k v ->
      Printf.printf "  Variable: %s, Type: %s, Value: %s, Mutable: %b, Not Mutable: %b, Scope Level: %d\n"
        k v.var_type (match v.var_value with Some v -> v | None -> "None") v.is_mutable v.is_not_mutable v.scope_level
    ) !type_environment
(* Enter a new namespace *)
(* Enter a new namespace *)
let enter_namespace ns =
  current_namespace := if !current_namespace = "" then ns else !current_namespace ^ "::" ^ ns;
  Printf.printf "Entered namespace: %s\n" !current_namespace;
  (* Add the namespace to the type environment with the current scope level *)
  add_namespace !current_namespace (List.hd !scope_stack)

(* Exit the current namespace *)
let exit_namespace () =
  let parts = String.split_on_char ':' !current_namespace in
  if List.length parts > 1 then
    current_namespace := String.concat "::" (List.rev (List.tl (List.rev parts)))
  else
    current_namespace := "";
  Printf.printf "Exited to namespace: %s\n" !current_namespace
  let check_namespace_exists namespace =
    let qname = qualified_name namespace in
    Printf.printf "Checking if namespace %s exists\n" qname;
    Table.mem qname !type_environment

(* Check if a variable with the given name already exists in the current scope *)
(* Enter a new scope *)
let enter_scope () =
  let new_scope_level = (List.hd !scope_stack) + 1 in
  scope_stack := new_scope_level :: !scope_stack;
  Printf.printf "Entered scope level: %d\n" new_scope_level

(* Exit the current scope *)
let exit_scope () =
  scope_stack := List.tl !scope_stack;
  Printf.printf "Exited to scope level: %d\n" (List.hd !scope_stack)

(* Update the value of an existing mutable variable *)
let update_variable_value name new_value =
  let qname = qualified_name name in
  match Table.find_opt qname !type_environment with
  | Some var_info when var_info.is_mutable ->
      let updated_info = { var_info with var_value = Some new_value } in
      Printf.printf "Updating variable: %s with new value: %s\n" qname new_value;
      type_environment := Table.add qname updated_info !type_environment;
  | Some _ ->
      failwith ("Variable " ^ qname ^ " is a constant and cannot be updated")
  | None -> failwith ("Variable " ^ qname ^ " is not in symbol table")

(* Retrieve information about a variable *)
let get_variable_info name =
  let qname = qualified_name name in
  Printf.printf "Retrieving variable: %s\n" qname;
  match Table.find_opt qname !type_environment with
  | Some info ->
      Printf.printf "Found variable: %s\n" qname;
      Printf.printf "  Type: %s\n" info.var_type;
      Printf.printf "  Value: %s\n" (match info.var_value with Some v -> v | None -> "None");
      Printf.printf "  Mutable: %b\n" info.is_mutable;
      Printf.printf "  Scope Level: %d\n" info.scope_level;
      Some info
  | None ->
      Printf.printf "Variable %s not found in symbol table\n" qname;
      None

let infer_type name =
  match get_variable_info name with
  | Some info -> info.var_type
  | None -> failwith ("Variable " ^ name ^ " not found in symbol table")

(* Save the current state of the symbol table to a file *)
let save_symbol_table filename =
  let oc = open_out filename in
  Table.iter (fun k v ->
    Printf.fprintf oc "Variable: %s, Type: %s, Value: %s, Mutable: %b, Scope Level: %d\n"
      k v.var_type (match v.var_value with Some v -> v | None -> "None") v.is_mutable v.scope_level
  ) !type_environment;
  close_out oc;
  Printf.printf "Symbol table saved to %s\n" filename

(* Enhance the symbol table to track functions without explicit return types *)
type function_info = {
  func_name: string;
  has_return: bool; (* true if the function has a return value, false if it is void *)
  parameters: (string * string) list;  (* List of parameter names and their types *)
  scope_level: int;
}

let function_environment = ref Table.empty

(* Register a function in the symbol table *)
let add_function name has_return parameters scope_level =
  let qname = qualified_name name in
  if Table.mem qname !function_environment then
    failwith ("Function " ^ qname ^ " already exists in the symboltable with return type " ^ (if has_return then "true" else "false"));
  let func_info = {
    func_name = qname;
    has_return;
    parameters;
    scope_level;
  } in
  Printf.printf "Adding function: %s with return: %b, parameters: %s, scope level: %d\n"
    qname has_return (String.concat ", " (List.map (fun (n, t) -> n ^ ": " ^ t) parameters)) scope_level;
  function_environment := Table.add qname func_info !function_environment;
  (* Print entire function table for debugging *)
  Printf.printf "Current function table state:\n";
  Table.iter (fun k v ->
    Printf.printf "  Function: %s, Has Return: %b, Parameters: %s, Scope Level: %d\n"
      k v.has_return (String.concat ", " (List.map (fun (n, t) -> n ^ ": " ^ t) v.parameters)) v.scope_level
  ) !function_environment

(* Check if a function with the given name already exists *)
let function_exists name =
  let qname = qualified_name name in
  Table.mem qname !function_environment

(* Retrieve information about a function *)
let get_function_info name =
  let qname = qualified_name name in
  Printf.printf "Retrieving function: %s\n" qname;
  match Table.find_opt qname !function_environment with
  | Some info ->
      Printf.printf "Found function: %s\n" qname;
      Printf.printf "  Has Return: %b\n" info.has_return;
      Printf.printf "  Parameters: %s\n" (String.concat ", " (List.map (fun (n, t) -> n ^ ": " ^ t) info.parameters));
      Printf.printf "  Scope Level: %d\n" info.scope_level;
      Some info
  | None ->
      Printf.printf "Function %s not found in symbol table\n" qname;
      None

(* Helper functions to add functions as having a return or void *)
let add_return_function name parameters scope_level =
  add_function name true parameters scope_level

let add_void_function name parameters scope_level =
  add_function name false parameters scope_level




let add_error message line column =
  let error_info = { error_message = message; error_line = line; error_column = column } in
  error_environment := Table.add message error_info !error_environment


let get_errors () =
  Table.fold (fun k v acc ->
    (k, v.error_line, v.error_column) :: acc
  ) !error_environment []

let print_errors () =
  List.iter (fun (msg, line, col) ->
    Printf.printf "Error: %s at line %d, column %d\n" msg line col
  ) (get_errors ())  
(* Main function to handle the --fg flag and save the symbol table *)
let handle_fg_flag () =
  let filename = !current_namespace ^ ".tree" in
  save_symbol_table filename