(* File import_detection.mli *)

val detect_importes : bool ref
val detected_imports : string list ref
val get_detected_imports : unit -> string list