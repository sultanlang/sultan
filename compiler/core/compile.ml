let compile_files files output_name =
  let clang = "clang" in
  let clang_flags = "-o" in
  let clang_output = output_name in
  let clang_files = files in
  let clang_command = Printf.sprintf "%s %s %s %s" clang clang_flags clang_output clang_files in  
  let _ = Sys.command clang_command in
  ()
;;