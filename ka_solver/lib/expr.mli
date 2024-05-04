open Core

(** The AST of a Kleene Algebra Expression*)
type t = 
| Zero 
| One 
| Prim of char
| Sum of (t * t) 
| Prod of (t * t) 
| Star of t
[@@deriving sexp]

val to_string : t -> string 

(** Unintuitively, this compares exprs alphabetically. So for example, 
    a > (b + a) 
    Even though of course in KA a <= b + a. 
    This is for ease of alphabetizing subterms in ACI normalization *)
val compare : t -> t -> int

(** Returns list of chars present in expr, no dupes *)
val alphabet : t -> char list 

val sexp_of_t : t -> Sexp.t 