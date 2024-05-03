type t 
type elt = Expr.t 

val empty : t 

val add : elt -> t -> t 

val singleton : elt -> t 