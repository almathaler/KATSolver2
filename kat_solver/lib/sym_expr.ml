open Core 

type t = 
| Prim of char 
| Sum of (t * t)
| Prod of (t * t) 
| Star of t 
| Test of (char, bool) Bdd.t 
[@@deriving sexp]

let sexp_of_t = sexp_of_t
let rec of_expr expr = 
  match expr with 
  | Expr.Prim c -> Prim c 
  | Expr.Sum (e1, e2) -> Sum (of_expr e1, of_expr e2)
  | Expr.Prod (e1, e2) -> Prod (of_expr e1, of_expr e2)
  | Expr.Star e -> Star (of_expr e)
  | Expr.Test t -> Test (Test.to_bdd t)