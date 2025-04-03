

open Id
let green = "\027[32m"
let yellow = "\027[33m"
let red = "\027[31m"
let reset = "\027[0m"



let __error__ fmt =
  Printf.ksprintf (fun s -> Printf.eprintf "%s\n" s; exit 1) fmt



let __error__with__id__ fmt = 
  Printf.ksprintf (fun s ->
    (* Check if the string contains an identifier starting with "id_" *)
    match String.index_opt s 'i' with
    | Some idx when String.sub s idx 3 = "id_" ->
        (* Extract the mangled ID *)
        let id_end = String.index_from_opt s (idx + 3) ' ' |> Option.value ~default:(String.length s) in
        let id = String.sub s idx (id_end - idx) in
        (* Unmangle the ID and replace it in the error string *)
        let unmangled_id = Id.unmangle_identifier id in
        let processed_error = String.sub s 0 idx ^ unmangled_id ^ String.sub s id_end (String.length s - id_end) in
        Printf.eprintf "%s\n" processed_error
    | _ ->
        (* If no valid ID is found, print the error as is *)
        Printf.eprintf "%s\n" s;
    exit 1
  ) fmt





  type debug 
  let debug = ref None
  
  
  
  let debug_buffer = Buffer.create 100
  
  
  
  
  
  let add_parser_debug s = 
    match !debug with
    | None -> ()
    | Some _ -> Buffer.add_string debug_buffer s
  
  let get_parser_debug () = 
    match !debug with
    | None -> ""
    | Some _ -> Buffer.contents debug_buffer
  
  
  
  let debug_handler flag str = 
    match flag with
    | true -> debug := Some true
    | false -> debug := None;
    Buffer.clear debug_buffer;
    add_parser_debug str

;;