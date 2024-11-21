open Binding
open Printf
open Lexing
open Ast
open Import_detection

let check_imports () =
  if !detect_importes then (
    let detected_imports = get_detected_imports () in
    List.iter (fun import ->
      Printf.printf "import %s;\n" import;
    ) detected_imports
  )

let save_generated_code filename files =
  let oc = open_out filename in
  List.iter (fun file ->
    let ocaml_code = string_of_statement file in
    fprintf oc "%s\n" ocaml_code;
  ) files;
  close_out oc

let compile_files_to_bytecode files output_file ~generate_ml ~dylinker =
  let temp_ml_file = "generated_code.ml" in
  save_generated_code temp_ml_file files;
  
  let command = Printf.sprintf "ocamlc -o %s %s %s" output_file (Option.value ~default:"" dylinker) temp_ml_file in
  ignore (Sys.command command);

  if not generate_ml then Sys.remove temp_ml_file

let compile_files_to_output files output_file ~dylinker =
  let temp_ml_file = "generated_code.ml" in
  save_generated_code temp_ml_file files;
  
  let command = Printf.sprintf "ocamlc -o %s %s %s" output_file (Option.value ~default:"" dylinker) temp_ml_file in
  ignore (Sys.command command);

  Sys.remove temp_ml_file

let compile_files_in_memory files output_file ~dylinker =
  let command = Printf.sprintf "ocamlc -o %s %s" output_file (Option.value ~default:"" dylinker) in
  let ocaml_code = String.concat "\n" (List.map string_of_statement files) in
  let temp_ml_file = Filename.temp_file "generated_code" ".ml" in
  let oc = open_out temp_ml_file in
  output_string oc ocaml_code;
  close_out oc;
  ignore (Sys.command (command ^ " " ^ temp_ml_file));
  Sys.remove temp_ml_file

let compiler_parser_entry_point lexbuf =
  Sparser.main Slexer.token lexbuf

let compile_files filenames generate_ml dylinker =
  let output_file = "output" in
  let all_files = List.fold_left (fun acc filename ->
    let input = Stdlib.open_in filename in
    let lexbuf = from_channel input in
    let asttree = compiler_parser_entry_point lexbuf in
    close_in input;
    acc @ asttree
  ) [] filenames in
  compile_files_to_bytecode all_files output_file ~generate_ml ~dylinker;
  Printf.printf "Compiled %s to %s\n" (String.concat ", " filenames) output_file

let compile_files_output_only filenames dylinker =
  let output_file = "output" in
  let all_files = List.fold_left (fun acc filename ->
    let input = Stdlib.open_in filename in
    let lexbuf = from_channel input in
    let asttree = compiler_parser_entry_point lexbuf in
    close_in input;
    acc @ asttree
  ) [] filenames in
  compile_files_in_memory all_files output_file ~dylinker;
  Printf.printf "Compiled to %s\n" output_file

let rec repl generate_ml =
  print_string ">>> ";
  flush stdout;
  let input = read_line () in
  let lexbuf = from_string input in
  let ast = compiler_parser_entry_point lexbuf in
  let output_file = "output" in
  compile_files_to_bytecode ast output_file ~generate_ml ~dylinker:None;
  Printf.printf "Compiled to %s\n" output_file;
  repl generate_ml
(* 


let flager_types =
let usage_msg = "Usage: sultanc [options] <file>\nOptions are:" in
let file = ref "" in
let repl_mode = ref false in
let compile_flag = ref false in
let output_file = ref "output" in
let speclist = [
  ("--file", Arg.String (fun s -> file := s), "Specify the input file");
  ("-c", Arg.Set compile_flag, "Compile to bytecode");
  ("-o", Arg.String (fun s -> output_file := s), "Specify the output file");
  ("-g", Arg.Unit (fun () -> ()), "Generate debugging information");
  ("-i", Arg.Unit (fun () -> ()), "Print inferred interface");
  ("-I", Arg.String (fun s -> ()), "Add directory to search path");
  ("-a", Arg.Unit (fun () -> ()), "Build a library");
  ("-ccopt", Arg.String (fun s -> ()), "Pass option to C compiler");
  ("-cclib", Arg.String (fun s -> ()), "Link with C library");
  ("-dtypes", Arg.Unit (fun () -> ()), "Dump type information");
  ("-for-pack", Arg.String (fun s -> ()), "Generate code for packing");
  ("-inline", Arg.Int (fun n -> ()), "Set inlining threshold");
  ("-intf", Arg.String (fun s -> ()), "Specify interface file");
  ("-intf-suffix", Arg.String (fun s -> ()), "Specify interface file suffix");
  ("-keep-locs", Arg.Unit (fun () -> ()), "Keep locations in .cmi files");
  ("-linkall", Arg.Unit (fun () -> ()), "Link all modules");
  ("-no-alias-deps", Arg.Unit (fun () -> ()), "Do not record dependencies for module aliases");
  ("-no-check-prims", Arg.Unit (fun () -> ()), "Do not check primitives");
  ("-no-keep-locs", Arg.Unit (fun () -> ()), "Do not keep locations in .cmi files");
  ("-noassert", Arg.Unit (fun () -> ()), "Remove assertion checks");
  ("-nodynlink", Arg.Unit (fun () -> ()), "Disable dynamic linking");
  ("-nostdlib", Arg.Unit (fun () -> ()), "Do not use standard library");
  ("-open", Arg.String (fun s -> ()), "Open module");
  ("-output-obj", Arg.Unit (fun () -> ()), "Output an object file");
  ("-pack", Arg.Unit (fun () -> ()), "Package modules");
  ("-pp", Arg.String (fun s -> ()), "Specify preprocessor");
  ("-ppx", Arg.String (fun s -> ()), "Specify ppx preprocessor");
  ("-principal", Arg.Unit (fun () -> ()), "Check principality");
  ("-rectypes", Arg.Unit (fun () -> ()), "Allow recursive types");
  ("-runtime-variant", Arg.String (fun s -> ()), "Specify runtime variant");
  ("-safe-string", Arg.Unit (fun () -> ()), "Use safe strings");
  ("-short-paths", Arg.Unit (fun () -> ()), "Shorten module paths");
  ("-strict-sequence", Arg.Unit (fun () -> ()), "Strict sequence evaluation");
  ("-strict-formats", Arg.Unit (fun () -> ()), "Strict format strings");
  ("-thread", Arg.Unit (fun () -> ()), "Support for system threads");
  ("-unsafe", Arg.Unit (fun () -> ()), "Do not bound-check array and string accesses");
  ("-unsafe-string", Arg.Unit (fun () -> ()), "Use unsafe strings");
  ("-use-runtime", Arg.String (fun s -> ()), "Specify runtime system");
  ("-v", Arg.Unit (fun () -> ()), "Print version and exit");
  ("-verbose", Arg.Unit (fun () -> ()), "Print verbose messages");
  ("-version", Arg.Unit (fun () -> ()), "Print version and exit");
  ("-w", Arg.String (fun s -> ()), "Specify warning list");
  ("-warn-error", Arg.String (fun s -> ()), "Treat warnings as errors");
  ("-warn-help", Arg.Unit (fun () -> ()), "Show warning options");
  ("-where", Arg.Unit (fun () -> ()), "Print standard library location and exit");
] in
Arg.parse speclist (fun s -> file := s) usage_msg;
if !repl_mode then repl true
else if !file <> "" then compile_file !file !compile_flag
else (
  Printf.eprintf "%s\n" usage_msg;
  exit (-1)
) *)
