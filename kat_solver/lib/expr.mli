open Core 

type t = 
| Prim of char 
| Sum of (t * t)
| Prod of (t * t) 
| Star of t 
| Test of Test.t

val sexp_of_t : t -> Sexp.t 

(** FOR TESTING *)
val to_bdd : t -> (char, bool) Bdd.t