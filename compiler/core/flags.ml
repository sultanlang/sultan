type flag =
  | Help
  | Version
  | InputFile of string
  | OutputFile of string
  | CompileOnly  (* -c flag *)
  | LinkerPath of string  (* -L <path> *)
  | LinkLibrary of string  (* -l <library> *)
  | Unrecognized of string

type compilations_types =
  | Executable of string
  | Shared of string
  | Object of string
  | LibraryPath of string
  | Library of string




(* Function to process flags *)
let process_flag flags =
  List.iter (function
    | Help ->
        Printf.printf "Usage: compiler [options] <input files>\nOptions:\n";
        Printf.printf "  -c                   Compile only (generate object files)\n";
        (* ... other help text ... *)
    | Version ->
        Printf.printf "Compiler version 1.0.0\n"
    | InputFile file ->
        Castle.add_input_file file  (* Use Castle's adder directly *)
    | OutputFile file ->
        Castle.set_output_path file
    | CompileOnly ->
        Castle.set_compile_only true
    | LinkerPath path ->
        Castle.add_linker_path path
    | LinkLibrary lib ->
        Castle.add_library lib
    | Unrecognized flag ->
       Log.__message__ ("Unrecognized flag: " ^ flag) 2;
       exit 1

  ) flags;

  (* Debug output to verify the processed flags *)
  Printf.printf "Processed flags:\n";
  Printf.printf "  Input files: %s\n" (String.concat ", " (Castle.get_input_files ()));
  Printf.printf "  Output file: %s\n" 
    (match Castle.get_output_file () with Some f -> f | None -> "");
  Printf.printf "  Compile only: %b\n" (Castle.is_compile_only ());
  Printf.printf "  Linker paths: %s\n" (String.concat ", " (Castle.get_linker_paths ()));
  Printf.printf "  Libraries: %s\n" (String.concat ", " (Castle.get_libraries ()))
(* Function to parse arguments into flags *)


(* Function to parse arguments into flags *)
let rec flag_args' args flags =
  match args with
  | [] -> flags
  | "-c" :: tl -> flag_args' tl (CompileOnly :: flags)
  | "-o" :: file :: tl -> flag_args' tl (OutputFile file :: flags)
  | "-L" :: path :: tl -> flag_args' tl (LinkerPath path :: flags)
  | "-l" :: lib :: tl -> flag_args' tl (LinkLibrary lib :: flags)
  | "--help" :: tl -> flag_args' tl (Help :: flags)
  | "--version" :: tl -> flag_args' tl (Version :: flags)
  | arg :: tl when String.length arg > 2 && String.sub arg 0 2 = "-L" ->
      let path = String.sub arg 2 (String.length arg - 2) in
      flag_args' tl (LinkerPath path :: flags)
  | arg :: tl when String.length arg > 2 && String.sub arg 0 2 = "-l" ->
      let lib = String.sub arg 2 (String.length arg - 2) in
      flag_args' tl (LinkLibrary lib :: flags)
  | arg :: tl when String.get arg 0 <> '-' -> flag_args' tl (InputFile arg :: flags)
  | arg :: tl -> flag_args' tl (Unrecognized arg :: flags)

let flag_args args = flag_args' args []
