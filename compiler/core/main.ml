
  


 let () =
 let args = Array.to_list Sys.argv in
 let flags = Flags.flag_args (List.tl args) in  (* Skip the first argument *)
 let pros = Flags.process_flag flags in 
 let _ = Driver.slang_compilations () in 
 pros
 