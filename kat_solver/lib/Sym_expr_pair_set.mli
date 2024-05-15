type t 
type elt = (Sym_expr.t * Sym_expr.t)

val empty : t 

val mem : elt -> t -> bool 

val add : elt -> t -> t 
