open Error
(* Add Castle module import *)
open Castle

type flags 

let flagger = "-"
let output_flag = flagger^"o"
let verbose_flag = flagger^"v"
let help_flag = flagger^"h"
let version_flag = flagger^"version"
let linker_flag = flagger^"l"
(* Removed duplicate verbose_flag declaration *)
let library_flag = flagger^flagger^"lib"
let binary_flag = flagger^flagger^"bin"


type 'flags flag = 
  | Output_name 
  | Verbose of bool
  | Help of bool
  | Version of bool
  | Linker of string

type inputs_commands = 
  | Inputs of string array
  | Input_error

let input_reader inputs = function
| Inputs (input_files) -> 
  let _ = Array.iter (fun x -> inputs := !inputs@[x]) input_files in
  !inputs
| Input_error -> Error.__error__ "Invalid input"
  
let find_output_name args = 
  let rec find_output_name' = function
  | [] -> None
  | x::xs -> 
    if x = output_flag then
      match xs with
      | [] -> None
      | y::_ys -> Some y
    else
      find_output_name' xs
  in
  find_output_name' args

let find_verbose args =
  let rec find_verbose' = function
  | [] -> false
  | x::xs -> 
    if x = verbose_flag then
      true
    else
      find_verbose' xs
  in
  find_verbose' args

let is_flag str =
  String.length str > 0 && str.[0] = '-'

let is_input_file filename =
  Filename.check_suffix filename ".sn" && not (is_flag filename)

let find_input_files args = 
  let rec find_input_files' acc = function
  | [] -> List.rev acc
  | x::xs -> 
    if x = output_flag then
      (* Skip the flag and its argument *)
      (match xs with
      | [] -> find_input_files' acc []
      | _::ys -> find_input_files' acc ys)
    else if is_flag x then
      (* Skip other flags *)
      find_input_files' acc xs
    else if is_input_file x then
      (* Found an input file *)
      find_input_files' (x::acc) xs
    else
      (* Not a flag or input file, continue *)
      find_input_files' acc xs
  in
  let files = find_input_files' [] args in
  (* Debug output to see what files were found *)
  Printf.printf "Debug: Getting input files: %s\n" 
    (String.concat ", " files);
  files

let finder args =
  let output_name = find_output_name args in
  let verbose = find_verbose args in
  let input_files = find_input_files args in
  
  (* Set input files immediately *)
  Castle.set_input_file input_files;
  
  (* Set other values *)
  Castle.set_output_name output_name;
  Castle.set_verbose verbose;
  
  Printf.printf "Debug: Retrieved input files: %s\n" 
    (String.concat ", " input_files);
  
  (* Return the original tuple for backwards compatibility *)
  (output_name, input_files, verbose)
;;

let rec flags_args args flags = 
  match args with
  | [] -> flags
  | x::xs -> 
    match x with
    | "-o" -> 
      begin
        match xs with
        | [] -> flags
        | y::ys -> flags_args ys (Output_name::flags)
      end
    | "-v" -> flags_args xs (Verbose true::flags)
    | "-h" -> flags_args xs (Help true::flags)
    | "-version" -> flags_args xs (Version true::flags)
    | "-l" -> 
      begin
        match xs with
        | [] -> flags
        | y::ys -> flags_args ys (Linker y::flags)
      end
    | _ -> flags_args xs flags