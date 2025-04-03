type position = { line: int; column: int }
type modules =
  | Filename of string


type scope =
  | Global of int 
  | Local of int 
;;

type true_or_false =
  | True 
  | False
;;


type machine_types =
  | I8 
  | I16
  | I32
  | I64
  | U8
  | U16
  | U32
  | U64
  | F32
  | F64
  | Bool 
  | Char
  | String
  | List of machine_types
  | Any_type 
  | Void
  | Unit
  | Tuple 
  | None
;;


type mutability =
  | Mutable
  | Immutable
;;



type binary_operator =
  | Add                     (* + *)
  | Subtract                (* - *)
  | Multiply                (* * *)
  | Divide                  (* / *)
  | Equal                   (* == *)
  | Less_than               (* < *)
  | Greater_than            (* > *)
  | Less_than_or_equal      (* <= *)
  | Greater_than_or_equal   (* >= *)







  | Not_equal               (* != *)
  | And                     (* && *)
  | Or                      (* || *)
  | Modulus                 (* % *)
  | Bitwise_and             (* & *)
  | Bitwise_or              (* | *)
  | Bitwise_xor             (* ^ *)
  | Bitwise_not             (* ~ *)
  | Shift_left              (* << *)
  | Shift_right             (* >> *)
  | Assignment              (* = *)
  | Add_assignment          (* += *)
  | Subtract_assignment     (* -= *)
  | Multiply_assignment     (* *= *)
  | Divide_assignment       (* /= *)
  | Modulus_assignment      (* %= *)
  | Bitwise_and_assignment  (* &= *)
  | Bitwise_or_assignment   (* |= *)
  | Bitwise_xor_assignment  (* ^= *)
  | Shift_left_assignment   (* <<= *)
  | Shift_right_assignment  (* >>= *)
  | Comma                   (* , *)
  | Dot                     (* . *)
  | Arrow                   (* -> *)

;;
type sultanc_types = 
  | StringLiteral of string
  | CharLiteral of char
  | IntLiteral of int
  | FloatLiteral of float
  | BoolLiteral of bool
  
  
;;

type expression = 
  | Types of sultanc_types
  | Identifier of string* position
  | Binary of expression list * binary_operator
  (* | NameSpace of string * expression *)
  | Function_call of string * expression list
  | Lists of expression list
  | Range of expression * expression
  | Fstring of string * expression list * position
  
;;
  
  
type has_return =
| Has_return of true_or_false


;;
type parameters = (string * machine_types * bool) list

;;


type statements =
| Expression of expression list * position
| Print of expression * position
| Let_var of string * machine_types* mutability * statements list * position

| Return of expression * position
| Import of string * position
| Def of  scope * string * parameters * has_return* statements list * position
| If_Else of expression * statements list * statements list * position

| While of expression * statements list * position
| For of expression * expression * expression * statements list * position

| Match of string * (expression * statements list) list * position
(* | Match of string * (expression * statements list) list * position *)
| Reassign of string * expression list * position
| Enum of string * statements list * position
(* | Enum of string * (string * machine_types* mutability) option list  * position *)
| Struct of string * (string * machine_types) list * position

  
  
;;
