(* src/error.mli *)

(* Custom exception for errors with detailed messages *)
exception Error of string

(* Functions for colored message printing and error reporting *)
val print_message : string -> string -> string -> unit
val print_success : string -> string -> unit
val print_info : string -> string -> unit
val raise_error : string -> unit

(* Error reporting functions *)
val report_error : string -> unit
val report_position_error_with_history : string -> Lexing.position -> string list -> unit
val report_position_error : string -> Lexing.position -> unit

(* Action and completion messages *)
val print_action : string -> unit
val print_done_message : string -> unit
