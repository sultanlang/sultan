

(* Note: never pass the unmangled name else all will error out,
all the inner compiler treat names as mangle names
unmangled_name is only for logging purpose
*)


module Castle_Env = Map.Make(String);;





(* Command-line flags storage *)
let input_files_ref : string list ref = ref []
let output_file_ref : string option ref = ref None
let linker_paths_ref : string list ref = ref []
let libs_ref : string list ref = ref []
let compile_only_ref : bool ref = ref false

(* Getters *)
let get_input_files () = !input_files_ref
let get_output_file () = !output_file_ref
let get_linker_paths () = !linker_paths_ref
let get_libraries () = !libs_ref
let is_compile_only () = !compile_only_ref

(* Setters *)
let set_input_file files = input_files_ref := files
let set_output_name name = 
  match name with
  | Some file -> output_file_ref := Some file
  | None -> ()
let set_output_path path = output_file_ref := Some path
let set_linker_paths paths = linker_paths_ref := paths
let set_libraries libs = libs_ref := libs
let set_compile_only flag = compile_only_ref := flag

(* Single-item adders *)
let add_input_file file = input_files_ref := file :: !input_files_ref
let add_linker_path path = linker_paths_ref := path :: !linker_paths_ref
let add_library lib = libs_ref := lib :: !libs_ref

(* Debug printer for flags *)

let is_main_declared : bool ref = ref false;;



  
  let set_main () = 
    is_main_declared := true
  ;;
  
  let get_main () = 
    !is_main_declared
  ;;


(* Scope levels *)
type scope_level = 
  | GLobal 
  | Local 


type found =
  | IFound of bool

type declarations = 
  | Functions of found
  | Variables of found

(* Scope entry: Represents a block *)
type scope_entry = {
  block_name: string; (* Unique name for the block *)
  scope: scope_level; (* Scope level: Global or Local *)
}

(* Tables *)
let scope_table : scope_entry Castle_Env.t ref = ref Castle_Env.empty;;


let current_process : string ref = ref "";;

(* Get the current process name *)
let set_current_process  name  =
let unmangle_name = Id.unmangle_identifier !current_process in
let formatted_message = Printf.sprintf "Castle Setting current process %s" unmangle_name in
  let _info = Log.__message__ formatted_message 4 in
  current_process := name;
;;


let get_current_process () =
  let unmangle_name = Id.unmangle_identifier !current_process in
  (* Check if the current process is empty *)
  let formatted_message = Printf.sprintf "Castle Getting current process %s" unmangle_name in
  let _info = Log.__message__ formatted_message 4 in
  (* Return the current process name *)
  !current_process
;;

let clear_current_process () =
  let unmangle_name = Id.unmangle_identifier !current_process in
  let formatted_message = Printf.sprintf "Castle Clearing current process %s" unmangle_name in
  let _info = Log.__message__ formatted_message 4 in
  flush stdout;
  (* Clear the current process name *)
  
  
  current_process := ""
;;



let get_entry scope name = 
  try
    let entry = Castle_Env.find name !scope_table in
    if entry.scope = scope then
      Some entry
    else
      None
  with Not_found -> None
;;



let add_entry scope name = 
  let entry = { block_name = name; scope = scope } in
  scope_table := Castle_Env.add name entry !scope_table
;;




let add_function  scope name = 
let scope_level = match scope with
  | GLobal -> "Global"
  | Local -> "Local"
in 
let unmangled_name = Id.unmangle_identifier name in
let formatted_message = Printf.sprintf "from castle: Adding function %s to scope %s" unmangled_name scope_level in
  let _info = Log.__message__ formatted_message 3 in 
  (* Note: never pass the unmangled name else all will error out,
  all the inner compiler treat names as mangle names
  unmangled_name is only for logging purpose
  *)
  add_entry scope name
;;


let get_function scope name = 
  let scope_level = match scope with
    | GLobal -> "Global"
    | Local -> "Local"
in
let check_entry = get_entry scope name in 
match check_entry with
  | Some entry -> 
      let unmangled_name = Id.unmangle_identifier name in
      let formatted_message = Printf.sprintf "From castle Function %s already exists in scope %s" unmangled_name scope_level in
      let _info = Log.__message__ formatted_message 2 in 
      exit 1
   
  | None ->
      add_function scope name


;;


type var_entry = {
    scope_block: string;    (* Block name where the variable is declared *)
    var_name: string;       (* Variable name *)
    var_type: Ast.machine_types;
    var_mutability: Ast.mutability;
}

(* Change var_table to use composite key of scope_block and var_name *)
let var_table : (string * string, var_entry) Hashtbl.t = Hashtbl.create 256

let add_variable_entry scope_block var_name var_type var_mutability = 
  let entry = { scope_block; var_name; var_type; var_mutability } in
  Hashtbl.add var_table (scope_block, var_name) entry

;;

let get_var_entry var_name position = 
  let block_scope = get_current_process () in
  if block_scope = "" then 
    (* Search in global scope *)
    match Hashtbl.find_opt var_table ("Global", var_name) with
    | Some entry -> entry 
    | None -> 
        let formatted_message = 
          Format.sprintf "Error at line %d, column %d: Variable %s not found in global scope"
            position.Ast.line position.Ast.column var_name
        in
        let _info = Log.__message__ formatted_message 2 in 
        exit 1
  else  
    (* Search in current block scope *)
    match Hashtbl.find_opt var_table (block_scope, var_name) with
    | Some entry -> entry
    | None -> 
        let var_name = Id.unmangle_identifier var_name in
        let block_scope = Id.unmangle_identifier block_scope in
        let formatted_message = 
          Format.sprintf "Error at line %d, column %d: Variable %s not found in block %s"
            position.Ast.line position.Ast.column var_name block_scope
        in
        let _info = Log.__message__ formatted_message 2 in 
        exit 1



;;

let get_variable_scope_Global var_name = 
  
  match Hashtbl.find_opt var_table ("Global", var_name) with
  | Some entry -> Some entry (* Variable found in global scope *)
  | None -> None (* Signal that the variable was not found *)

let get_variable_scope_Local var_name = 
  let block_scope = get_current_process () in
  match Hashtbl.find_opt var_table (block_scope, var_name) with
  | Some entry -> Some entry (* Variable found in local scope *)
  | None -> None (* Signal that the variable was not found *)

;;

let declare_variable_entry var_name var_mutability var_type position = 
  let current_process = get_current_process () in
  let scope = if current_process = "" then "Global" else current_process in

  (* Check if the variable already exists in the current scope *)
  let variable_exists_in_scope =
    if scope = "Global" then
      get_variable_scope_Global var_name
    else
      get_variable_scope_Local var_name
  in

  match variable_exists_in_scope with
  | Some _ ->
      (* Variable already exists in the current scope *)
      let var_name = Id.unmangle_identifier var_name in
      let formatted_message = 
        if scope = "Global" then
          Printf.sprintf "line %d, column %d: %s already exists in global scope"
            position.Ast.line position.Ast.column var_name
        else
          let block_scope = Id.unmangle_identifier scope in
          Printf.sprintf "line %d, column %d: %s already exists in local scope %s"
            position.Ast.line position.Ast.column var_name block_scope
      in
      let _info = Log.__message__ formatted_message 2 in
      exit 1
  | None ->
      (* Variable does not exist in the current scope, add it *)
      if scope = "Global" then
        add_variable_entry "Global" var_name var_type var_mutability
      else
        add_variable_entry scope var_name var_type var_mutability;
      let var_name = Id.unmangle_identifier var_name in
      let formatted_message = 
        if scope = "Global" then
          Printf.sprintf "Adding %s to global scope"
            var_name
        else
          let block_scope = Id.unmangle_identifier scope in
          Printf.sprintf "Adding %s to local scope %s"
            var_name block_scope
      in
      let _info = Log.__message__ formatted_message 3 in
      ()

;;
type scope_entry_others = {
  block_parent_name:string;
  block_name:string;
  

}



let scope_table_others : scope_entry_others Castle_Env.t ref = ref Castle_Env.empty;;



let add_entry_others block_parent_name block_name = 
  let entry = { block_parent_name; block_name; } in
  scope_table_others := Castle_Env.add block_name entry !scope_table_others
;;

let get_entry_others block_parent_name block_name = 
  try
    let entry = Castle_Env.find block_name !scope_table_others in
    if entry.block_parent_name = block_parent_name then
      Some (entry) (* Return both the entry and its info *)
    else
      None
  with Not_found -> None
;;



let sub_function_declare block_parent_name block_name =
  let formatted_message =
    Printf.sprintf "Debug: Declaring block '%s' under parent '%s'" block_name block_parent_name
  in
  let _info = Log.__message__ formatted_message 4 in
  match get_entry_others block_parent_name block_name with
  | Some _ ->
      let formatted_message =
        Printf.sprintf "Error: Block '%s' already exists under parent '%s'" block_name block_parent_name
      in
      let _info = Log.__message__ formatted_message 2 in
      exit 1
  | None ->
      add_entry_others block_parent_name block_name;
      let formatted_message =
        Printf.sprintf "Info: Block '%s' successfully declared under parent '%s'" block_name block_parent_name
      in
      let _info = Log.__message__ formatted_message 3 in
      ()
;;