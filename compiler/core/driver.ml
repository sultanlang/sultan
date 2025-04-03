open Sbase 

let process_files () = 
  let _ = Log.__message__ "Starting the compiler" 3 in 
  let get_files = Castle.get_input_files () in
  if get_files = [] then (
    (* No input files provided *)
    let _ = Log.__message__ "No input files provided" 1 in
    exit 1
  );

  (* Check for missing and existing files *)
  let missing_files, existing_files = 
    List.partition (fun file -> not (Sys.file_exists file)) get_files in

  if missing_files = get_files then (
    (* All files are missing *)
    let _ = Log.__message__ "All input files are missing" 2 in
    List.iter (fun file -> Printf.printf "  - %s\n" file) missing_files;
    exit 1
  ) else if missing_files <> [] then (
    (* Some files are missing *)
    let _ = Log.__message__ "Some input files are missing:" 1 in
    List.iter (fun file -> Printf.printf "  - %s\n" file) missing_files;
    Printf.printf "  Found files:\n";
    List.iter (fun file -> Printf.printf "    - %s\n" file) existing_files
  );

  flush stdout;

  (* Process existing files and return the generated file paths *)
  if existing_files <> [] then (
    let results = List.map sbase_compiler existing_files in
    if List.for_all (fun result -> result <> []) results then (
      (* All files processed successfully *)
      
      (* Calculate paths of generated files (.c and .h) *)
      let generated_files = 
        List.flatten (
          List.map (fun file -> 
            let base = Filename.chop_extension file in
             (* This has the sir file and the h file has been removed else it will conflict the compilations 
            we need only .sir file or .c file both works *)
            [base ^".sir" ] 
          ) existing_files
        ) 
      in
      
      if missing_files <> [] then (
        (* Warning: Some files were missing, but others were successfully compiled *)
        let _ = Log.__message__ "Warning: Compilation completed for found files, but some files were missing." 1 in
        List.iter (fun file -> Printf.printf "  Compiled: %s\n" file) existing_files
      ) else (
        (* Success: All files were successfully compiled *)
        let _ = Log.__message__ "All files processed successfully" 0 in
        List.iter (fun file -> Printf.printf "  Compiled: %s\n" file) existing_files
      );
      
      (* Return the paths of generated files *)
      generated_files
    ) else (
      (* Exit silently if any file fails *)
      exit 1
    )
  ) else
    (* Return empty list if no files were processed *)
    []
;;

let slang_compilations () = 
  let sir_files = process_files () in 
  (* Pass the list of file paths directly to compile_clang *)
  let clang = Compile.compile_clang sir_files in 
  clang
;;