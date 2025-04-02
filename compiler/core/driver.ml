let driver = 
  let args = Sys.argv in
  let files = Array.to_list (Array.sub args 1 (Array.length args - 1)) in
  List.iter (fun file ->
    let _ = Sbase.sbase_compiler [| file |] in (* Convert file to a string array *)
    ()
  ) files;

  ()
  ;;