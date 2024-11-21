(* src/error.ml *)

exception Error of string

(* ANSI color codes for terminal output *)
let red = "\027[31m"
let green = "\027[32m"
let yellow = "\027[33m"
let reset = "\027[0m"

(* Prints a formatted message with a specified color and label *)
let print_message color label message =
  Printf.printf "=> %s%s:%s %s\n" color label reset message

(* Prints a success message in green *)
let print_success label message =
  print_message green label message

(* Prints an informational message in yellow *)
let print_info label message =
  print_message yellow label message

(* Raises a custom error with a message *)
let raise_error msg = raise (Error msg)

(* Reports a generic error to stderr in red *)
let report_error message =
  Printf.eprintf "%sError:%s %s\n" red reset message

(* Reports an error with position and history of recent tokens for better debugging *)
let report_position_error_with_history msg pos history =
  let line = pos.Lexing.pos_lnum in
  let col = pos.Lexing.pos_cnum - pos.Lexing.pos_bol in
  let recent_tokens = String.concat ", " history in
  Printf.eprintf
    "%sError at line %d, column %d:%s %s\nRecent tokens: [%s]\n"
    red line col reset msg recent_tokens

(* Reports an error with position information *)
let report_position_error msg pos =
  let line = pos.Lexing.pos_lnum in
  let col = pos.Lexing.pos_cnum - pos.Lexing.pos_bol in
  Printf.eprintf "%sError at line %d, column %d:%s %s\n" 
    red line col reset msg

(* Prints an action message to indicate progress in green *)
let print_action label =
  Printf.printf "=> %s%s %s\n" green label reset

(* Prints a "done" message with a green label and resets color *)
let print_done_message message =
  Printf.printf "%s=> done =>%s %s\n" green reset message
