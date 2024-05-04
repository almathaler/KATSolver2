type t 
type elt = (Expr.t * Expr.t)

val empty : t 

val mem : elt -> t -> bool 

val add : elt -> t -> t 
