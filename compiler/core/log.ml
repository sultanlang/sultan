




type color =
  | Black
  | Red
  | Green
  | Yellow
  | Blue
  | Magenta
  | Cyan
  | White
  | Default

let color_to_string = function
| Black -> "\027[30m"   (* Black text *)
| Red -> "\027[31m"     (* Red text *)
| Green -> "\027[32m"   (* Green text *)
| Yellow -> "\027[33m"  (* Yellow text *)
| Blue -> "\027[34m"    (* Blue text *)
| Magenta -> "\027[35m" (* Magenta text *)
| Cyan -> "\027[36m"    (* Cyan text *)
| White -> "\027[37m"   (* White text *)
| Default -> "\027[0m"  (* Reset to default *)

let colorize_text color text =
  let color_code = color_to_string color in
  let reset_code = color_to_string Default in
  color_code ^ text ^ reset_code

(* Configurable prefixes *)
let error_prefix = ref "Error: "
let warning_prefix = ref "Warning: "
let success_prefix = ref "Success: "
let info_prefix = ref "Info: "
let debug_prefix = ref "Debug: "
let note_prefix = ref "Note: "
let prompt_prefix = ref "> "

(* Tiger Mode toggle *)
let tiger_mode = ref true

let set_tiger_mode enabled =
  tiger_mode := enabled

let apply_tiger_mode prefix =
  if !tiger_mode then "=> " ^ prefix else prefix

let custom_msg color prefix msg =
  let colored_prefix = colorize_text color (apply_tiger_mode prefix) in
  colored_prefix ^ msg
;;

let __msg__logs__ fmt =
  Printf.ksprintf (fun s -> Printf.printf "%s\n" s) fmt
let __message__ msg prefix_tag =
  let prefix = prefix_tag in
  let formatted_msg = 
    match prefix with
    | 0 -> custom_msg Green !success_prefix msg
    | 1 -> custom_msg Yellow !warning_prefix msg
    | 2 -> custom_msg Red !error_prefix msg
    | 3 -> custom_msg Blue !info_prefix msg
    | 4 -> custom_msg Magenta !debug_prefix msg
    | 5 -> custom_msg Cyan !note_prefix msg
    | 6 -> custom_msg White !prompt_prefix msg
    | _ -> custom_msg Default !prompt_prefix msg
  in
  __msg__logs__ "%s" formatted_msg
;;