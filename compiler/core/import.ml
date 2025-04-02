open Id




type import 



let c_types_lib = "stdint"
let c_stdio_lib = "stdio"
let c_stdlib = "stdlib"




let import_maps =
  [
  ("id_D986D8B8D8A7D985",c_stdio_lib); (*Arabic stdio*)
  ("id_D8B1D982D985",c_types_lib); (*arabic stdint*)
  ("id_D985D983D8AAD8A8D987",c_stdlib);
  ("id_737464696E74",c_types_lib);
  ("id_737464696F",c_stdio_lib);
  ("id_7374646C6962",c_stdlib)


  ]


  let find_import_name name =
    let rec aux = function
      | [] -> None
      | (k, v) :: t ->
          if k = name then Some v else aux t
    in
    aux import_maps


let unmangle_import_name name = 
  let rec aux = function
    | [] -> None
    | (k, v) :: t ->
       Id.unmangle_identifier k |> String.equal name |> function
       | true -> Some v
       | false -> aux t
  in
  aux import_maps



let import_handler import_names =
  let rec aux = function
    | [] -> []
    | name :: t ->
        match find_import_name name with
        | Some v -> v :: aux t
        | None -> aux t
  in
  aux import_names


let unmangle_and_print_results import_name = 
  match unmangle_import_name import_name with
  | Some v -> Error.__error__ "Unmangled name: %s " v
  | None -> Error.__error__ "No unmangled name found for: %s" import_name

