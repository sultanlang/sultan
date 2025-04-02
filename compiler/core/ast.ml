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
  | Identifier of string
  | Binary of expression list * binary_operator
  (* | NameSpace of string * expression *)
  | Function_call of string * expression list
  | Lists of expression list
  | Range of expression * expression
  | Fstring of string * expression list
  
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
| Reassign of string * expression * position
| Enum of string * statements list * position
| Struct of string * (string * machine_types) list * position

  
  
;;





let reduce_scope = function
  | Global n -> n
  | Local n -> n
;;


let rec reduce_sultanc_types = function 
  | StringLiteral s -> StringLiteral s
  | CharLiteral c -> CharLiteral c
  | IntLiteral i -> IntLiteral i
  | FloatLiteral f -> FloatLiteral f
  | BoolLiteral b -> BoolLiteral b
  (* | ListLiteral lst -> ListLiteral (List.map reduce_sultanc_types lst) *)
;;

let rec reduce_expression = function
  | Lists expressions -> Lists (List.map reduce_expression expressions)
  | Range (start, end_) ->
    Range (reduce_expression start, reduce_expression end_)
  | Identifier id -> Identifier id
  | Binary (expressions, operations) ->
    let reduced_exprs = List.map reduce_expression expressions in
    Binary (reduced_exprs, operations)
  | Types sultanc_type -> Types (reduce_sultanc_types sultanc_type)
  | Function_call (id, expressions) ->
    let reduced_exprs = List.map reduce_expression expressions in
    Function_call (id, reduced_exprs)
  | Fstring (str, expressions) ->
    let (reduced_exprs) = List.map reduce_expression expressions in
    Fstring (str, reduced_exprs)
  

;;
  
  
let  rec reduce_statements = function
  | Expression (expression, position) -> Expression (List.map reduce_expression expression, position)
  | Print (expression, position) ->
    Print (reduce_expression expression, position)
  | Return (expression, position) -> Return (reduce_expression expression, position)  
  | Let_var (id, machine_type, mutability, expressions, position) ->
    Let_var (id, machine_type, mutability, List.map reduce_statements expressions, position)
  | Import (id, position) -> Import (id, position)
  | Def (scope, id, parameters, has_return, expressions, position) ->
    Def (scope, id, parameters, has_return, List.map reduce_statements expressions, position)
  | If_Else (condition, if_body, else_body, position) ->
    If_Else (reduce_expression condition, List.map reduce_statements if_body, List.map reduce_statements else_body, position)
  | While (condition, body, position) -> While (reduce_expression condition, List.map reduce_statements body, position)
  | For (init, condition, increment, body, position) -> For (reduce_expression init, reduce_expression condition, reduce_expression increment, List.map reduce_statements body, position)
  | Match (id, cases, position) ->
    let reduced_cases = List.map (fun (expr, body) -> (reduce_expression expr, List.map reduce_statements body)) cases in
    Match (id, reduced_cases, position)
  | Reassign (id, expression, position) -> Reassign (id, reduce_expression expression, position)
  | Enum (id, variants, position) -> Enum (id, variants, position)
  | Struct (id, fields, position) -> Struct (id, fields, position)


