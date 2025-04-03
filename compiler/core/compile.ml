

let base_compiler = "clang";;

let first_alternative_compiler = "gcc";;

let second_alternative_compiler = "g++";;


let c_compile_flag = "-c";;
let c_link_flag = "-o";;
let c_output_flag = "-o";;
let c_include_flag = "-I";;
let c_library_flag = "-l";;
let c_library_path_flag = "-L";;
let c_standard_flag = "-std=c11";;

let _x_ = "-x";;
let c = "c";;
let denote_std = "-"

let compilations_order = [base_compiler; first_alternative_compiler; second_alternative_compiler];;

let compilations_flags = [c_compile_flag; c_link_flag; c_output_flag; c_include_flag; c_library_flag; c_library_path_flag; c_standard_flag];;
let compilations_types = [c; denote_std];;

(* Function to check if a compiler is available *)










let compile_clang files_paths = 
  let compile_only = Castle.is_compile_only () in
  let output_name = Castle.get_output_file () in
  let input_files = String.concat " " files_paths in
  let command = 
    match (compile_only, output_name) with
    | (true, Some name) when String.ends_with ~suffix:".o" name -> 
        (* Compile only to generate an object file *)
        let msg = Printf.sprintf "Compiling files: %s -> Output: %s (Object File)" input_files name in
        let _ = Log.__message__ msg 4 in
        base_compiler ^ " " ^ _x_ ^ " " ^ c ^ " " ^ input_files ^ " -c -o " ^ name
    | (true, Some name) when String.ends_with ~suffix:".so" name -> 
        (* Compile only to generate a shared library *)
        let msg = Printf.sprintf "Compiling files: %s -> Output: %s (Shared Library)" input_files name in
        let _ = Log.__message__ msg 4 in
        base_compiler ^ " " ^ _x_ ^ " " ^ c ^ " " ^ input_files ^ " -shared -o " ^ name
    | (true, Some name) -> 
        (* Compile only to generate an executable *)
        let msg = Printf.sprintf "Compiling files: %s -> Output: %s (Executable)" input_files name in
        let _ = Log.__message__ msg 4 in
        base_compiler ^ " " ^ _x_ ^ " " ^ c ^ " " ^ input_files ^ " -o " ^ name
    | (true, None) -> 
        (* Compile only with no output file specified, default to .o file *)
        let default_output = Filename.chop_extension (List.hd files_paths) ^ ".o" in
        let msg = Printf.sprintf "Compiling files: %s -> Output: %s (Default Object File)" input_files default_output in
        let _ = Log.__message__ msg 4 in
        base_compiler ^ " " ^ _x_ ^ " " ^ c ^ " " ^ input_files ^ " -c -o " ^ default_output
    | (false, Some name) -> 
        (* Compile and link to create an executable *)
        let msg = Printf.sprintf "Linking files: %s -> Executable: %s" input_files name in
        let _ = Log.__message__ msg 4 in
        base_compiler ^ " " ^ _x_ ^ " " ^ c ^ " " ^ input_files ^ " -o " ^ name
    | (false, None) -> 
        (* Error: No output file specified for linking *)
        let msg = "Error: No output file specified for linking" in
        let _ = Log.__message__ msg 1 in
        exit 1
  in
  let msg = Printf.sprintf "Executing command: %s" command in
  let _ = Log.__message__ msg 4 in
  let output = Sys.command command in
  if output <> 0 then (
    Printf.printf "Error: Compilation failed with exit code %d\n" output;
    exit 1
  ) else (
    (* Compilation successful *)
    let success_msg = 
      match output_name with
      | Some name -> Printf.sprintf "Compilation successful! Output: %s" name
      | None -> 
          let default_output = Filename.chop_extension (List.hd files_paths) ^ ".o" in
          Printf.sprintf "Compilation successful! Output: %s" default_output
    in
    Log.__message__ success_msg 0;
    
  );
  output
;;

  (* let command = base_compiler ^ " " ^ _x_ ^ " " ^ c ^ " " ^ c_compile_flag ^ " " ^ c_output_flag ^ " " ^ files_path in 
  let output = Sys.command command in
  (* Check if the compilation was successful *)
  output *)
;;



(* let compile_clang files_path  =
  let clang = "clang" in
  let clang_flags = "-o" in
  let output_name = "a.out" in
  let clang_output = output_name in
  let clang_files = files_path in
  let clang_command = Printf.sprintf "%s %s %s %s" clang clang_flags clang_output clang_files in  
  let _ = Sys.command clang_command in
  () *)

(* let compile_files ast = 
  let input_files = get_files () in
  let output_file = Castle.get_output_file () in
  let compile_only = Castle.is_compile_only () in
  let linker_paths = Castle.get_linker_paths () in
  let libraries = Castle.get_libraries () in
  let compiler = if is_compiler_available base_compiler then base_compiler else
    if is_compiler_available first_alternative_compiler then first_alternative_compiler else
      if is_compiler_available second_alternative_compiler then second_alternative_compiler else
      let _ = Log.__message__ "No suitable compiler found." 1 in
      exit 1
  in
  *)



(* let compile_files () =
  let input_files = get_files () in
  let output_file = Castle.get_output_file () in
  let compile_only = Castle.is_compile_only () in
  let linker_paths = Castle.get_linker_paths () in
  let libraries = Castle.get_libraries () in

  if compile_only = true then (
    Errorlog.__message__ "Compiling files..." 3;
    let compilations_order = [base_compiler; first_alternative_compiler; second_alternative_compiler] 



  
;; *)



(* 

let compile_file files output_name =
  let compiler = get_compiler () in
  let flags = "-o" in
  let command = Printf.sprintf "%s %s %s %s" compiler flags output_name (String.concat " " files) in  
  let result = Sys.command command in
  if result = 0 then
    Printf.printf "Compilation successful: %s\n" output_name
  else (
    Printf.printf "Error: Compilation failed.\n";
    exit 1
  )
;;


let compile_file files output_name =
  let clang = "clang" in
  let clang_flags = "-o" in
  let clang_output = output_name in
  let clang_files = files in
  let clang_command = Printf.sprintf "%s %s %s %s" clang clang_flags clang_output clang_files in  
  let _ = Sys.command clang_command in
  ()
;;
 *)
