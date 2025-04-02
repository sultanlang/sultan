open Error

module Castle_Env = Map.Make(String);;

(* Store input files in a persistent reference *)
let input_files : string list ref = ref [];;
let output_name : string option ref = ref None;;
let verbose : bool ref = ref false;;

let is_main_declared : bool ref = ref false;;

(* Set input files and ensure the reference is updated *)
let set_input_file files = 
  (* Check if files list is empty and give a warning *)
  if files = [] then
    Error.__error__ "Warning: Setting empty input files list\n"
  else
    Printf.printf "Debug: Setting input files: %s\n" (String.concat ", " files);
  
  (* Force update of the reference *)
  input_files := files
;;
  
let set_output_name name = 
  output_name := name
;;  
  
let set_verbose v = 
  verbose := v
;;
  
(* Modified to be more robust when checking input files *)
let get_input_files () = 
  let files = !input_files in
  (* Only print debug when files are actually requested *)
  Printf.printf "Debug: Getting input files: %s\n" 
    (if files = [] then "(none)" else String.concat ", " files);
  files
;;
  let get_output_name () = 
    !output_name
  ;;
  
  
  let get_verbose () = 
    !verbose
  ;;
  
  
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

(* Scope entry: Represents a block *)
type scope_entry = {
  block_name: string; (* Unique name for the block *)
  scope: scope_level; (* Scope level: Global or Local *)
}


(* Tables *)
let scope_table : scope_entry Castle_Env.t ref = ref Castle_Env.empty;;


let current_process : string ref = ref "";;

(* Get the current process name *)
let set_current_process scope name  =
  current_process := name;
  let scope_entry = { block_name = name; scope = scope } in
  scope_table := Castle_Env.add name scope_entry !scope_table
;;
let get_current_process () =
  !current_process
;;

let clear_current_process () =
  current_process := ""
;;


let set_process_entry scope name = 
  if !current_process = "" then
    set_current_process scope name
  else
    let current_process_name = Id.unmangle_identifier (get_current_process ()) in
    let unmangled_name = Id.unmangle_identifier name in
    Error.__error__ "Cannot add entry %s; current function %s is already in process" 
      unmangled_name current_process_name
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




let helper scope name = 
  let check_entry = get_entry scope name in
  match check_entry with
  | Some entry -> 
      let unmangled_name = Id.unmangle_identifier name in
      let unmangled_scope = match entry.scope with
        | GLobal -> "Global"
        | Local -> "Local"
      in
      Error.__error__ "Entry %s already exists in scope %s" unmangled_name unmangled_scope
  | None ->
      add_entry scope name
;;


type var_entry = {
   scope_block: string; (* Block name where the variable is declared *)
   var_name: string; (* Variable name *)
   var_type: Ast.machine_types; (* Variable type *)
    var_mutability: Ast.mutability; (* Variable mutability *)

}


let var_table : var_entry Castle_Env.t ref = ref Castle_Env.empty;;



let set_var_entry scope name var_type var_mutability = 
  let entry = { scope_block = !current_process; var_name = name; var_type = var_type; var_mutability = var_mutability } in
  var_table := Castle_Env.add name entry !var_table
;;


let get_var_entry_  name = 
  try
    let entry = Castle_Env.find name !var_table in
    if entry.scope_block = !current_process then
      Some entry
    else
      None
  with Not_found -> None



let var_helper  var_name var_type var_mutability = 
  let check_entry = get_var_entry_ var_name in
  match check_entry with
  | Some entry -> 
      let unmangled_name = Id.unmangle_identifier var_name in
      let unmangled_scope = entry.scope_block in
      Error.__error__ "Variable %s already exists in scope %s" unmangled_name unmangled_scope
  | None ->
      set_var_entry !current_process var_name var_type var_mutability
;;


let get_var_type name = 
  try
    let entry = Castle_Env.find name !var_table in
    if entry.scope_block = !current_process then
      Some entry.var_type
    else
      None
  with Not_found -> None