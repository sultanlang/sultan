open Progress


let change_directory path =
  try
    Sys.chdir path
  with
  | Sys_error msg -> Printf.printf "Failed to enter %s: %s\n" path msg; exit 1

let compile_file command file update_progress =
  let full_command = Printf.sprintf "%s %s > /dev/null 2>&1" command file in
  let status = Sys.command full_command in
  if status <> 0 then (
    Printf.printf "Failed to compile %s\n" file;
    exit 1
  );
  update_progress 1 file

let clean_files () =
  let clean_command = "rm -f *.cmo *.cmi sparser.mli sparser.ml slexer.ml ../boot/*.cmi ../boot/*.cmo ../boot/boost  > /dev/null 2>&1" in
  let status = Sys.command clean_command in
  if status <> 0 then (
    Printf.printf "Clean failed\n";
    exit 1
  );;
  

let compile_sultanc () =
  change_directory "../core/";
  Printf.printf "Building...\n";

  let total_steps = 19 in
  let (update_progress, print_message) = Progress.create total_steps in
  let step = ref 0 in

  let compile_file_with_progress command file =
    compile_file command file update_progress;
    incr step
  in

  (* Compile core files in order *)
    compile_file_with_progress "ocamlfind ocamlc -linkpkg -c" "id.ml";
    compile_file_with_progress "ocamlfind ocamlc -linkpkg -c" "log.ml";
    compile_file_with_progress "ocamlfind ocamlc -linkpkg -c" "help.ml";
    compile_file_with_progress "ocamlfind ocamlc -linkpkg -c" "error.ml";
    compile_file_with_progress "ocamlfind ocamlc -linkpkg -c" "ast.ml";
    compile_file_with_progress "ocamlfind ocamlc -linkpkg -c" "types.ml";
    compile_file_with_progress "ocamlfind ocamlc -linkpkg -c" "castle.ml";
  
    (* Compile parser files *)
    let menhir_command = "menhir --infer sparser.mly > /dev/null 2>&1" in
    let status = Sys.command menhir_command in
    if status <> 0 then (
      Printf.printf "Failed to compile sparser.mly\n";
      exit 1
    );
    incr step;
    update_progress 1 "sparser.mly";
  
    compile_file_with_progress "ocamlfind ocamlc -linkpkg -c" "sparser.mli";
    compile_file_with_progress "ocamlfind ocamlc -linkpkg -c" "sparser.ml";
  
    (* Compile lexer *)
    let ocamllex_command = "ocamllex slexer.mll > /dev/null 2>&1" in
    let status = Sys.command ocamllex_command in
    if status <> 0 then (
      Printf.printf "Failed to compile slexer.mll\n";
      exit 1
    );
    incr step;
    update_progress 1 "slexer.mll";
  
    compile_file_with_progress "ocamlfind ocamlc -linkpkg -c" "slexer.ml";
  
    (* Compile additional files in order *)
    compile_file_with_progress "ocamlfind ocamlc -linkpkg -c" "errorlog.ml";
    compile_file_with_progress "ocamlfind ocamlc -linkpkg -c" "import.ml";
    compile_file_with_progress "ocamlfind ocamlc -linkpkg -c" "semantics.ml";
    compile_file_with_progress "ocamlfind ocamlc -linkpkg -c" "codegen.ml";
    compile_file_with_progress "ocamlfind ocamlc -linkpkg -c" "hfile.ml";
    compile_file_with_progress "ocamlfind ocamlc -linkpkg -c" "compile.ml";
    compile_file_with_progress "ocamlfind ocamlc -linkpkg -c" "sbase.ml";
    compile_file_with_progress "ocamlfind ocamlc -linkpkg -c" "flags.ml";
    compile_file_with_progress "ocamlfind ocamlc -linkpkg -c" "driver.ml";
    compile_file_with_progress "ocamlfind ocamlc -linkpkg -c" "main.ml";
  
    (* Link all modules *)
    Printf.printf "\n=> Linking all modules to create sultanc\n";
    let link_command = "ocamlfind ocamlc -o ../../sultanc -package Str -linkpkg id.cmo log.cmo help.cmo error.cmo ast.cmo types.cmo castle.cmo sparser.cmo slexer.cmo errorlog.cmo import.cmo semantics.cmo codegen.cmo hfile.cmo compile.cmo sbase.cmo flags.cmo driver.cmo main.cmo > /dev/null 2>&1" in
    let status = Sys.command link_command in
    if status <> 0 then (
      Printf.printf "Linking failed\n";
      exit 1
    );
    incr step;
    update_progress 1 "linking";
  
    print_message "Build completed successfully";
  
    clean_files ()
let ()= 
compile_sultanc ();

(* let run =
  let command = if Array.length Sys.argv > 1 then Sys.argv.(1) else "" in
  match command with
  | "build" -> compile_sultanc ()
  | _ -> Printf.printf "Invalid command! Use: build\n"; exit 1 *)