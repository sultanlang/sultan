


module Help = struct
  let usage_message = 
    "Usage: slang [options] <input files>\n\n" ^
    "Options:\n" ^
    "  --help                 Display this help message\n" ^
    "  --version              Display the version of the compiler\n" ^
    "  -o <file>              Specify the output file name\n" ^
    "  -L <path>              Add a library search path\n" ^
    "  -l <library>           Link with the specified library\n"

  let print_usage () =
    Printf.printf "%s" usage_message

  let print_version () =
    Printf.printf "Slang Compiler version 1.0.0\n"
end