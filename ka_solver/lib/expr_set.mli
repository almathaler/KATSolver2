type t 
type elt = Expr.t 

val empty : t 

val add : elt -> t -> t 

val singleton : elt -> t 

val to_list : t -> elt list 

val of_list : elt list -> t 