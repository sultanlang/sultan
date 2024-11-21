open Symboltable

type expression =
  | IntLiteral of int
  | FloatLiteral of float
  | StringLiteral of string
  | BoolLiteral of bool
  | Void
  | CharLiteral of char
  | Identifier of string
  | Binop of binop * expression * expression
  | Unop of unop * expression
  | ListLiteral of expression list
  | Range of expression * expression
  | ErrorExpression of string
  | DictLiteral of (expression * expression) list
  | TupleLiteral of expression list
  (* | Functioncall of string * expression list *)
  





and statement =
  | FunctionDef of string * (string * string option) list * statement list 
  | Return of expression
  | ReturnMultiple of expression list
  | PrintInput of expression
  | PrintOutputSingle of expression
  | PrintOutputDouble of expression * expression
  | If of expression * statement list
  | IfElse of expression * statement list * statement list
  | Else of statement list
  | ForLoopRange of string * expression * statement list
  | ForLoopClassic of string * expression * expression * expression * statement list
  | Import of string
  | Assignment of string * expression * expression
  | LetConstBinding of string * expression option * expression
  | LetVarBinding of string * expression option * expression
  | LetListBinding of string * expression option * expression
  | LetUninitializedBinding of string * expression option * expression
  | ErrorStatement of string
  | Functioncall of string * expression list
  | LetFunctionBinding of string * (string * string option) list * statement list
  | TryCatch of statement list * string* statement list
  | Match of expression * (expression * statement list) list
  


and binop =
  | Plus
  | Minus
  | Times
  | Div
  | Equals
  | NotEquals
  | GreaterThan
  | LessThan

and unop =
  | UMinus
  | Abs
  | Sqrt
  | Cbrt
  | Exp
  | Exp2
  | Log
  | Log10
  | Log2
  | Cos
  | Sin
  | Tan
  | Acos
  | Asin
  | Atan
  | Cosh
  | Sinh
  | Tanh
  | Acosh
  | Asinh
  | Atanh
  | Erf
  | Erfc
  | Ceil
  | Floor
  | Round
  | Trunc

  
  let rec reduce_expression_to_object_ids = function
    | IntLiteral _ | FloatLiteral _ | StringLiteral _ | BoolLiteral _ | CharLiteral _ -> []
    | Void -> []
    | Identifier id -> [id]
   
    | Binop (_, e1, e2) -> List.concat [reduce_expression_to_object_ids e1; reduce_expression_to_object_ids e2]
    | Unop (_, e) -> reduce_expression_to_object_ids e
    | ListLiteral exprs -> List.concat (List.map reduce_expression_to_object_ids exprs)
    | Range (e1, e2) -> List.concat [reduce_expression_to_object_ids e1; reduce_expression_to_object_ids e2]
    | ErrorExpression _ -> []
    | DictLiteral entries ->
      List.concat (List.map (fun (k, v) -> List.concat [reduce_expression_to_object_ids k; reduce_expression_to_object_ids v]) entries)
    | TupleLiteral exprs -> List.concat (List.map reduce_expression_to_object_ids exprs)
    (* | Functioncall (_, args) -> List.concat (List.map reduce_expression_to_object_ids args) *)
   


and reduce_statement_to_object_ids = function
  | FunctionDef (_, _, body) -> List.concat (List.map reduce_statement_to_object_ids body)
  | Return expr -> reduce_expression_to_object_ids expr
  | ReturnMultiple exprs -> List.concat (List.map reduce_expression_to_object_ids exprs)
  | LetListBinding (id, e1, e2) -> id :: (match e1 with Some e -> reduce_expression_to_object_ids e | None -> []) @ reduce_expression_to_object_ids e2
  | LetConstBinding (_, e1, e2) -> (match e1 with Some e -> reduce_expression_to_object_ids e | None -> []) @ reduce_expression_to_object_ids e2
  | LetVarBinding (_, e1, e2) -> (match e1 with Some e -> reduce_expression_to_object_ids e | None -> []) @ reduce_expression_to_object_ids e2
  | LetUninitializedBinding (_, e1, e2) -> (match e1 with Some e -> reduce_expression_to_object_ids e | None -> []) @ reduce_expression_to_object_ids e2
  | PrintInput expr -> reduce_expression_to_object_ids expr
  | PrintOutputSingle expr -> reduce_expression_to_object_ids expr
  | PrintOutputDouble (expr1, expr2) -> List.concat [reduce_expression_to_object_ids expr1; reduce_expression_to_object_ids expr2]
  | If (cond, then_exprs) -> List.concat [reduce_expression_to_object_ids cond; List.concat (List.map reduce_statement_to_object_ids then_exprs)]
  | IfElse (cond, then_exprs, else_exprs) -> List.concat [reduce_expression_to_object_ids cond; List.concat (List.map reduce_statement_to_object_ids then_exprs); List.concat (List.map reduce_statement_to_object_ids else_exprs)]
  | Else exprs -> List.concat (List.map reduce_statement_to_object_ids exprs)
  | ForLoopRange (_, start_expr, body_exprs) -> List.concat [reduce_expression_to_object_ids start_expr; List.concat (List.map reduce_statement_to_object_ids body_exprs)]
  | ForLoopClassic (_, start_expr, end_expr, step_expr, body_exprs) -> List.concat [reduce_expression_to_object_ids start_expr; reduce_expression_to_object_ids end_expr; reduce_expression_to_object_ids step_expr; List.concat (List.map reduce_statement_to_object_ids body_exprs)]
  | Assignment (_, e1, e2) -> List.concat [reduce_expression_to_object_ids e1; reduce_expression_to_object_ids e2]
  | ErrorStatement _ -> []
  | Import _ -> []
  | Functioncall (_, args) -> List.concat (List.map reduce_expression_to_object_ids args)
  | LetFunctionBinding (_, _, body) -> List.concat (List.map reduce_statement_to_object_ids body)
  | TryCatch (try_exprs, _, catch_exprs) -> List.concat [List.concat (List.map reduce_statement_to_object_ids try_exprs); List.concat (List.map reduce_statement_to_object_ids catch_exprs)]
  | Match (expr, cases) -> List.concat [reduce_expression_to_object_ids expr; List.concat (List.map (fun (k, v) -> List.concat [reduce_expression_to_object_ids k; List.concat (List.map reduce_statement_to_object_ids v)]) cases)]




