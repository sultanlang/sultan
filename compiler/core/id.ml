(* id.ml *)

(* Cache table for mangled identifiers *)
let symbol_table = Hashtbl.create 100
let reverse_symbol_table = Hashtbl.create 100

(* Function to mangle identifiers consistently using a symbol table *)
let mangle_identifier (id: string) : string =
  match Hashtbl.find_opt symbol_table id with
  | Some mangled -> mangled   (* Use the cached mangled name *)
  | None ->
      (* Perform mangling and add to the cache *)
      let buffer = Buffer.create (String.length id * 2 + 3) in
      Buffer.add_string buffer "id_";
      String.iter (fun c ->
        Buffer.add_string buffer (Printf.sprintf "%02X" (Char.code c))
      ) id;
      let mangled = Buffer.contents buffer in
      Hashtbl.add symbol_table id mangled;  (* Cache the mangled name *)
      Hashtbl.add reverse_symbol_table mangled id;  (* Cache the reverse mapping *)
      mangled

(* Function to unmangle identifiers *)
let unmangle_identifier (mangled: string) : string =
  match Hashtbl.find_opt reverse_symbol_table mangled with
  | Some original -> original
  | None -> mangled  (* Return the mangled name if no original name is found *)