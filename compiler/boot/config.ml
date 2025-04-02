(* filepath: /Users/supax/supax/slang/_slang/boot/config.ml *)

let menhir = "menhir"
let menhir_version = "3.0"

let ocamlfind = "ocamlfind"
let ocamlc = "ocamlc"
let ocamlc_version = "4.14.0"

let clang = "clang"
let clang_version = "16.0.0"

(* Function to check if a command exists in the system *)
let command_exists cmd =
  try
    let path = Sys.getenv "PATH" in
    let paths = String.split_on_char ':' path in
    List.exists (fun dir ->
      Sys.file_exists (Filename.concat dir cmd)
    ) paths
  with Not_found -> false

(* Check if all required tools are installed *)
let check_tools () =
  let tools = [
    (menhir, "Menhir");
    (ocamlfind, "OCamlFind");
    (ocamlc, "OCaml Compiler");
    (clang, "Clang");
  ] in
  List.for_all (fun (cmd, name) ->
    if command_exists cmd then
      true
    else (
      Printf.printf "Error: %s is not installed.\n" name;
      false
    )
  ) tools

(* Get the current system type *)
let current_system =
  let get_current_system = Sys.os_type in
  print_endline ("Current system: " ^ get_current_system)
  
(* 
(* Run the checks *)
let () =
  current_system;
  if check_tools () then
    ()
  else
    exit 1 *)