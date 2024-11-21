(* errorlog.ml *)

type error = {
  message: string;
  line: int;
  column: int;
  context: string option;
}

let error_list = ref []

let log_error message line column context =
  let err = { message; line; column; context } in
  error_list := err :: !error_list;
  Printf.printf "Error: %s at line %d, column %d\n" message line column;
  match context with
  | Some ctx -> Printf.printf "Context: %s\n" ctx
  | None -> ()

let get_errors () = List.rev !error_list

let print_errors () =
  List.iter (fun err ->
    Printf.printf "Error: %s at line %d, column %d\n" err.message err.line err.column;
    match err.context with
    | Some ctx -> Printf.printf "Context: %s\n" ctx
    | None -> ()
  ) (get_errors ())