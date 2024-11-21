open Driver

let () =
  let dylinker = ref None in
  let filenames = ref [] in
  let use_file_flag = ref false in
  let args = Array.to_list Sys.argv in
  let rec parse_args = function
    | [] -> ()
    | "--file" :: files -> use_file_flag := true; filenames := files
    | "-d" :: linker :: rest -> dylinker := Some linker; parse_args rest
    | filename :: rest when Filename.check_suffix filename ".sn" -> filenames := filename :: !filenames; parse_args rest
    | _ :: rest -> parse_args rest
  in
  parse_args (List.tl args);
  match !filenames with
  | [] -> Printf.eprintf "Usage:\n  ./sultanc --file <filenames>.sn [-d <dylinker>]\n  ./sultanc <filenames>.sn\n"; exit (-1)
  | _ -> 
    if !use_file_flag then
      compile_files !filenames true !dylinker
    else
      compile_files_output_only !filenames !dylinker