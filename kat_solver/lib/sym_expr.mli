open Core 

type t = 
| Prim of char 
| Sum of (t * t)
| Prod of (t * t) 
| Star of t 
| Test of (char, bool) Bdd.t 
[@@deriving sexp] 

val sexp_of_t : t -> Sexp.t
(** Translates an expr to a sym_expr, and also normalizes while doing this. *)
val of_expr : Expr.t -> t 
