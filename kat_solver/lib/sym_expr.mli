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

val compare : t -> t -> int 
(** ACI Normalizing sum constructor. 
    Precondition: [se1] and [se2] are already ACI normalized *)
val sum : t -> t -> t

val prod : t -> t -> t 

val to_string : t -> string 
