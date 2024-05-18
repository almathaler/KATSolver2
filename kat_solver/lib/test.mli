open Core

type t = 
| Prim of char 
| Zero 
| One 
| Land of (t * t) 
| Lor of (t * t)
| Not of t 
[@@deriving sexp]

val sexp_of_t : t -> Sexp.t

val t_of_sexp : Sexp.t -> t 

val to_bdd : t -> (char, bool) Bdd.t

val to_string : t -> string 