


let rec string_of_ast_machine_types = function 
| Ast.I8 -> "int8_t"
| Ast.I16 -> "int16_t"
| Ast.I32 -> "int32_t"
| Ast.I64 -> "int64_t"
| Ast.U8 -> "uint8_t" 
| Ast.U16 -> "uint16_t"
| Ast.U32 -> "uint32_t"
| Ast.U64 -> "uint64_t"
| Ast.F32 -> "float"
| Ast.F64 -> "double"
| Ast.Bool -> "bool"
| Ast.Char -> "char"
| Ast.String -> "char*"
| Ast.List t -> string_of_ast_machine_types t 
| Ast.Any_type -> "any"
| Ast.Void -> "void"
| Ast.Unit -> "unit"
| Ast.Tuple -> "tuple"
| Ast.None -> ""


let  type_check decared expression =
  let rec type_check' decared expression = 
    match expression with
   | Ast.I8 -> Ast.I8
   | Ast.I16  -> Ast.I16
   | Ast.I32  -> Ast.I32 
    | Ast.I64  -> Ast.I64
    | Ast.U8  -> Ast.U8
    | Ast.U16  -> Ast.U16
    | Ast.U32  -> Ast.U32
    | Ast.U64  -> Ast.U64
    | Ast.F32  -> Ast.F32
    | Ast.F64  -> Ast.F64
    | Ast.Bool  -> Ast.Bool
    | Ast.Char  -> Ast.Char
    | Ast.String  -> Ast.String
    | Ast.List t -> 
        let t' = type_check' decared t in
        Ast.List t'
    | Ast.Any_type -> Ast.Any_type
    | Ast.Void -> Ast.Void
    | Ast.Unit -> Ast.Unit
    | Ast.Tuple -> Ast.Tuple
    
    | _ -> Error.__error__ "Type not found"
  in
  type_check' decared expression




  