module Progress = struct
  let green = "\027[32m"
  let yellow = "\027[33m"
  let red = "\027[31m"
  let reset = "\027[0m"

  let create total_steps =
    if total_steps <= 0 then
      invalid_arg "Total steps must be greater than 0";
    let current_step = ref 0 in

    let clear_line () =
      Printf.printf "\r\027[K"; (* \027[K clears the current line *)
      flush stdout
    in

    let update step file =
      current_step := min total_steps (!current_step + step);
      let percentage = (!current_step * 100) / total_steps in

      clear_line ();
      Printf.printf "\r=> %s%s%s %s%d%%%s" green file reset yellow percentage reset;
      flush stdout;

      if !current_step = total_steps then (
        Printf.printf "\n";
        flush stdout
      )
    in

    let print_message msg =
      clear_line ();
      Printf.printf "%s\n" msg;
      flush stdout
    in

    (update, print_message)
end